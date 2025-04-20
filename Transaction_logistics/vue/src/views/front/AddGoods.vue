<template>
  <div style="width: 50%; margin: 10px auto">
    <div style="margin-bottom: 10px">
      <el-button @click="$router.back()"><< 返回</el-button>
    </div>

    <div class="card">
      <el-form :model="form" label-width="120px" style="padding-right: 50px" :rules="rules" ref="formRef">
        <div style="text-align: center; font-size: 24px; margin: 30px 0">发布商品</div>
        <el-form-item label="名称" prop="name">
          <el-input v-model="form.name" placeholder="名称"></el-input>
        </el-form-item>
        <el-form-item label="价格" prop="price">
          <el-input v-model="form.price" placeholder="价格"></el-input>
        </el-form-item>
        <el-form-item label="分类" prop="category">
          <!-- 修改：增加 popper-class 和 popper-append-to-body 属性 -->
          <el-select
              v-model="form.category"
              style="width: 100%"
              popper-class="custom-select-dropdown"
              :popper-append-to-body="false"
          >
            <el-option v-for="item in categoryList" :key="item.id" :value="item.name"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="图片" prop="img">
          <el-upload
              :action="$baseUrl + '/files/upload'"
              :headers="{ token: user.token }"
              list-type="picture"
              :on-success="handleImgSuccess"
          >
            <el-button type="primary">上传图片</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="发货地址" prop="address">
          <el-input v-model="form.address" placeholder="发货地址"></el-input>
        </el-form-item>
        <el-form-item label="上架状态" prop="saleStatus">
          <el-radio-group v-model="form.saleStatus">
            <el-radio label="上架"></el-radio>
            <el-radio label="下架"></el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="详情" prop="content">
          <div id="editor"></div>
        </el-form-item>
        <div style="text-align: center; margin-bottom: 20px">
          <el-button size="medium" type="primary" @click="save">确认发布</el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script>
import E from "wangeditor"

export default {
  name: "AddGoods",
  data() {
    return {
      id: this.$route.query.id,
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      categoryList: [],
      form: {
        saleStatus: '下架'
      },
      rules: {
        name: [
          { required: true, message: '请输入商品名称', trigger: 'blur' }
        ],
        price: [
          { required: true, message: '请输入商品价格', trigger: 'blur' }
        ],
        category: [
          { required: true, message: '请选择商品分类', trigger: 'blur' }
        ],
        address: [
          { required: true, message: '请输入发货地址', trigger: 'blur' }
        ]
      },
      editor: null,
    }
  },
  mounted() {
    this.loadCategory()
    this.loadGoods()
  },
  methods: {
    loadGoods() {
      if (this.id) {   // 编辑的情况下
        this.$request.get('/goods/selectById/' + this.id).then(res => {
          this.form = res.data || {}
          this.setRichText(this.form.content)
        })
      } else {
        this.setRichText('')
      }
    },
    loadCategory() {
      this.$request.get('/category/selectAll').then(res => {
        this.categoryList = res.data || []
      })
    },
    save() {   // 保存按钮触发的逻辑  它会触发新增或者更新
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.form.content = this.editor.txt.html()
          this.$request({
            url: this.form.id ? '/goods/update' : '/goods/add',
            method: this.form.id ? 'PUT' : 'POST',
            data: this.form
          }).then(res => {
            if (res.code === '200') {  // 表示成功保存
              this.$message.success('发布成功')
            } else {
              this.$message.error(res.msg)  // 弹出错误的信息
            }
          })
        }
      })
    },
    handleImgSuccess(response, file, fileList) {
      this.form.img = response.data
    },
    setRichText(html) {
      this.$nextTick(() => {
        this.editor = new E(`#editor`)
        this.editor.config.uploadImgServer = this.$baseUrl + '/files/editor/upload'
        this.editor.config.uploadFileName = 'file'
        this.editor.config.uploadImgHeaders = {
          token: this.user.token
        }
        this.editor.config.uploadImgParams = {
          type: 'img',
        }
        this.editor.create()  // 创建
        this.editor.txt.html(html)
      })
    },
  }
}
</script>

<style>
/* 移除 scoped，确保样式可以作用于 el-select 的下拉框 */
.card {
  background-color: #fff;
  border-radius: 5px;
  padding: 20px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

/* 自定义下拉框样式 */
.custom-select-dropdown {
  max-height: 200px !important; /* 设置最大高度 */
  overflow-y: auto !important; /* 滚动条 */
  z-index: 9999 !important; /* 确保下拉框在最上层 */
}

/* 覆盖 Element Plus 默认样式 */
.el-select-dropdown__item {
  padding: 0 20px !important;
}

.el-select-dropdown {
  margin-top: 5px !important;
  border-radius: 5px !important;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1) !important;
}
</style>