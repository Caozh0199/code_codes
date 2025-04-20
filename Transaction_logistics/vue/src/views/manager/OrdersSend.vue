<template>
  <div>
    <div class="table">
      <el-table :data="tableData" strip @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center"></el-table-column>
        <el-table-column prop="goodsName" label="商品名称" show-overflow-tooltip></el-table-column>
        <el-table-column prop="goodsImg" label="商品图片">
          <template v-slot="scope">
            <el-image v-if="scope.row.goodsImg" style="width: 50px" :src="scope.row.goodsImg" :preview-src-list="[scope.row.goodsImg]"></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="orderNo" label="订单编号" width="120"></el-table-column>
        <el-table-column prop="user" label="下单人名称" show-overflow-tooltip></el-table-column>
        <el-table-column prop="address" label="收货地址" show-overflow-tooltip></el-table-column>
        <el-table-column prop="phone" label="联系方式" show-overflow-tooltip></el-table-column>
        <el-table-column prop="userName" label="收货人名称"></el-table-column>
        <el-table-column prop="status" label="订单状态">
          <template v-slot="scope">
            <el-tag type="danger" v-if="scope.row.status === '已取消'">已取消</el-tag>
            <el-tag type="danger" v-if="scope.row.status === '待支付'">待支付</el-tag>
            <el-tag type="primary" v-if="scope.row.status === '待发货'">待发货</el-tag>
            <el-tag type="info" v-if="scope.row.status === '待收货'">待收货</el-tag>
            <el-tag type="success" v-if="scope.row.status === '已完成'">已完成</el-tag>
            <el-tag type="success" v-if="scope.row.status === '待揽收'">待揽收</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="saleName" label="卖家名称"></el-table-column>
        <el-table-column label="操作" align="center" width="100">
          <template v-slot="scope">
            <el-button size="mini" plain type="primary" @click="sendOrder(scope.row)">发货</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div style="margin: 15px 0">
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
</template>

<script>
export default {
  name: "Orders",
  data() {
    return {
      tableData: [],  // 所有的数据
      pageNum: 1,   // 当前的页码
      pageSize: 10,  // 每页显示的个数
      total: 0,
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      ids: [],
      orderNo: null,
      status: null
    }
  },
  created() {
    this.load(1)
  },
  methods: {
    sendOrder(row) {
      this.$confirm('确认要发货吗？', '确认发货', {type: "warning"}).then(() => {
        // 复制订单数据并更新状态为"待揽收"
        const orderData = JSON.parse(JSON.stringify(row))
        orderData.status = '待揽收'

        this.$request.put('/orders/updateSend', orderData).then(res => {
          if (res.code === '200') {
            this.$message.success('发货成功')
            this.load(1)
          } else {
            this.$message.error(res.msg)
          }
        })
      }).catch(() => {
        // 用户取消操作
      })
    },
    handleSelectionChange(rows) {
      this.ids = rows.map(v => v.id)
    },
    delBatch() {
      if (!this.ids.length) {
        this.$message.warning('请选择数据')
        return
      }
      this.$confirm('您确定批量删除这些数据吗？', '确认删除', {type: "warning"}).then(() => {
        this.$request.delete('/orders/delete/batch', {data: this.ids}).then(res => {
          if (res.code === '200') {
            this.$message.success('操作成功')
            this.load(1)
          } else {
            this.$message.error(res.msg)
          }
        })
      }).catch(() => {})
    },
    load(pageNum) {
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/orders/selectPageSend', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          status: this.status,
          orderNo: this.orderNo,
        }
      }).then(res => {
        if (res.code === '200') {
          this.tableData = res.data?.list
          this.total = res.data?.total
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    reset() {
      this.orderNo = null
      this.status = null
      this.load(1)
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
  }
}
</script>

<style scoped>
.table {
  padding: 10px;
}
</style>