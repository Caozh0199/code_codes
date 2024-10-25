<template >
  <div style="margin: 50px">
    <div class="search" style="margin-left: 450px">
      <el-input placeholder="请输入标题查询" style="width: 400px" v-model="trackingNumber"></el-input>
      <el-button type="info" plain style="margin-left: 10px" @click="load(1)">查询</el-button>
      <el-button type="warning" plain style="margin-left: 10px" @click="reset">重置</el-button>
    </div>
    <div class="table" style="width: 1100px;margin-left: 150px">
      <el-table :data="tableData" stripe @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center"></el-table-column>

        <el-table-column prop="id" label="序号" width="80" align="center" sortable></el-table-column>
        <el-table-column prop="sender" label="发货人" width="100"></el-table-column>
        <el-table-column prop="trackingNumber" label="快递单号" width="160"></el-table-column>
        <el-table-column prop="userName" label="收货人" width="180"></el-table-column>
        <!-- <el-table-column prop="coordinates" label="经纬度坐标" width="180"></el-table-column>-->

        <el-table-column prop="shippingTime" label="发货时间" width="220"></el-table-column>
        <el-table-column prop="status" label="状态" width="180">
        </el-table-column>

        <el-table-column label="操作" width="180" align="center">
          <template v-slot="scope">
            <el-button plain type="primary" @click="$router.push('/front/location?trackingNumber=' + trackingNumber)" size="mini">编辑</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination">
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


    <el-dialog title="信息" :visible.sync="fromVisible" width="40%" :close-on-click-modal="false" destroy-on-close>
      <el-form label-width="100px" style="padding-right: 50px" :model="form" :rules="rules" ref="formRef">
        <el-form-item prop="sender" label="标题">
          <el-input v-model="form.sender" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="content" label="内容">
          <el-input type="textarea" :rows="5" v-model="form.content" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="fromVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>


  </div>
</template>

<script>
export default {
  name: "Logistics",
  data() {
    return {
      tableData: [], // 所有的数据
      pageNum: 1, // 当前的页码
      pageSize: 10, // 每页显示的个数
      total: 0,
      trackingNumber: null,

      fromVisible: false,
      form: {},
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      rules: {
        title: [
          {required: true, message: '请输入标题', trigger: 'blur'},
        ],
        content: [
          {required: true, message: '请输入内容', trigger: 'blur'},
        ]
      },
      ids: []
    }
  },
  created() {
    this.load(1)
  },
  methods: {
    handleAdd() { // 新增数据
      this.form = {} // 新增数据的时候清空数据
      this.fromVisible = true // 打开弹窗
    },
    handleEdit(row) { // 编辑数据
      this.form = JSON.parse(JSON.stringify(row)) // 给form对象赋值 注意要深拷贝数据
      this.fromVisible = true // 打开弹窗
    },
    save() { // 保存按钮触发的逻辑 它会触发新增或者更新
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.$request({
            url: this.form.id ? '/logistics/update' : '/logistics/add',
            method: this.form.id ? 'PUT' : 'POST',
            data: this.form
          }).then(res => {
            if (res.code === '200') { // 表示成功保存
              this.$message.success('保存成功')
              this.load(1)
              this.fromVisible = false
            } else {
              this.$message.error(res.msg) // 弹出错误的信息
            }
          })
        }
      })
    },
    handleSelectionChange(rows) { // 当前选中的所有的行数据
      this.ids = rows.map(v => v.id) // [1,2]
    },
    delBatch() { // 批量删除
      if (!this.ids.length) {
        this.$message.warning('请选择数据')
        return
      }
      this.$confirm('您确定批量删除这些数据吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/logistics/delete/batch', {data: this.ids}).then(res => {
          if (res.code === '200') { // 表示操作成功
            this.$message.success('操作成功')
            this.load(1)
          } else {
            this.$message.error(res.msg) // 弹出错误的信息
          }
        })
      }).catch(() => {
      })
    },
    load(pageNum) { // 分页查询
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/logistics/selectPage1', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          trackingNumber: this.trackingNumber,
        }
      }).then(res => {
        this.tableData = res.data?.list
        this.total = res.data?.total
      })
    },
    reset() {
      this.title = null
      this.load(1)
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
  }
}
</script>

<style scoped>

</style>
