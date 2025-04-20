<template>
  <div style="min-height: 100vh">
    <!-- 公告横条 -->
    <div v-if="notice" class="notice-bar">
      <div class="notice-content">
        <strong>{{ notice.title }}</strong>: {{ notice.content }}
      </div>
    </div>

    <!-- 搜索栏 -->
    <div class="bg">
      <div style="width: 600px">
        <div style="display: flex">
          <el-input v-model="name" size="medium" prefix-icon="el-icon-search" placeholder="请输入商品名称关键字搜索"></el-input>
          <el-button @click="$router.push({ path: '/front/search', query: { name: name } })" size="medium" type="primary" style="margin-left: 5px; background-color: #409EFF">
            <i class="el-icon-search"></i>
          </el-button>
        </div>
      </div>
    </div>

    <!-- 商品展示区域 -->
    <div style="width: 70%; background-color: #fff; margin: 10px auto; padding: 20px; border-radius: 5px; position: relative">
      <el-button @click="$router.push('/front/addGoods')" style="position: absolute; top: 20px; right: -150px" size="medium" type="primary" plain>发布商品</el-button>
      <el-button @click="$router.push('/front/userHelp')" style="position: absolute; top: 70px; right: -150px" size="medium" type="primary" plain>发布求购</el-button>

      <div style="margin-bottom: 20px">
        <el-select v-model="category" size="medium" style="width: 200px" @change="loadGoods(1)">
          <el-option value="全部"></el-option>
          <el-option v-for="item in categoryList" :key="item.id" :value="item.name"></el-option>
        </el-select>

        <el-select v-model="sort" size="medium" style="width: 200px; margin-left: 10px" @change="loadGoods(1)">
          <el-option value="最新"></el-option>
          <el-option value="最热"></el-option>
        </el-select>
      </div>

      <div>
        <el-row :gutter="15">
          <el-col :span="6" v-for="item in goodsList" :key="item.id">
            <div style="margin-bottom: 20px" class="goods-item" @click="$router.push('/front/goodsDetail?id=' + item.id)">
              <img :src="item.img" alt="" style="width: 100%; display: block; height: 260px; margin-bottom: 10px; border-radius: 5px">
              <div style="font-size: 16px; height: 40px; color: #555; margin-bottom: 10px" class="line2 goods-name">{{ item.name }}</div>
              <div style="display: flex; align-items: baseline">
                <strong style="color: red; font-size: 24px">￥{{ item.price }}</strong>
                <span style="margin-left: 20px; color: #666">{{ item.readCount }}人浏览</span>
                <span style="margin-left: 20px; color: #666">{{ item.likesCount }}人点赞</span>
              </div>
            </div>
          </el-col>
        </el-row>

        <div style="margin: 15px auto">
          <el-pagination
              background
              @current-change="handleCurrentChange"
              :current-page="pageNum"
              :page-sizes="[5, 10, 20]"
              :page-size="pageSize"
              layout="total, prev, pager, next"
              :total="total">
          </el-pagination>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      categoryList: [],
      goodsList: [],  // 所有的商品数据
      pageNum: 1,     // 当前的页码
      pageSize: 12,   // 每页显示的个数
      total: 0,
      category: '全部',
      sort: '最新',
      name: '',
      notice: null    // 公告信息
    }
  },
  mounted() {
    this.loadCategory();
    this.loadGoods(1);
    this.checkPendingOrders(); // 初始化页面时检查未发货订单
    this.loadNotice();         // 加载公告信息
  },
  methods: {
    // 加载分类列表
    loadCategory() {
      this.$request.get('/category/selectAll').then(res => {
        this.categoryList = res.data || [];
      });
    },
    // 分页查询商品
    loadGoods(pageNum) {
      if (pageNum) this.pageNum = pageNum;
      this.$request.get('/goods/selectFrontPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          category: this.category === '全部' ? null : this.category,
          sort: this.sort
        }
      }).then(res => {
        if (res.code === '200') {
          this.goodsList = res.data?.list;
          this.total = res.data?.total;
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    // 处理分页变化
    handleCurrentChange(pageNum) {
      this.loadGoods(pageNum);
    },
    // 检查未发货订单
    checkPendingOrders() {
      this.$request.get('/orders/selectSalePage').then(res => {
        if (res.code === '200') {
          const orders = res.data.list || [];
          const hasPendingOrder = orders.some(order => order.status === '待发货');
          if (hasPendingOrder) {
            this.$alert('您有未发货订单，请到我的订单中处理', '提示', {
              confirmButtonText: '确定',
              type: 'warning'
            });
          }
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    // 加载公告信息
    loadNotice() {
      this.$request.get('/notice/selectPage', {
        params: {
          pageNum: 1,
          pageSize: 1 // 只取第一条公告
        }
      }).then(res => {
        if (res.code === '200') {
          const notices = res.data.list || [];
          this.notice = notices.length > 0 ? notices[0] : null; // 取第一条公告
        } else {
          this.$message.error(res.msg);
        }
      });
    }
  }
}
</script>

<style scoped>
/* 公告横条样式 */
.notice-bar {
  background-color: #f0f9eb;
  color: #67c23a;
  padding: 10px 20px;
  text-align: center;
  font-size: 14px;
  border-bottom: 1px solid #ebeef5;
}

.notice-content {
  max-width: 80%;
  margin: 0 auto;
}

.bg {
  background-size: 100%;
  background-position-y: center;
  display: flex;
  align-items: center;
  justify-content: center;
}

.goods-item {
  cursor: pointer;
}

.goods-item img, .goods-name {
  transition: all .2s;
}

.goods-item:hover img {
  scale: 1.03;
}

.goods-item:hover .goods-name {
  color: #ec3d3d !important;
}
</style>