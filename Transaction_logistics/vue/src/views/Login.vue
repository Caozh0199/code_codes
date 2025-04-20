<template>
  <div class="container" >
    <div style="flex: 1; background: radial-gradient(circle,#FFF1EB 9.96%,#FFFFFF 28.1%,#FFFFFF 10.29%,#395C6C 100%); ">
      <div style="height: 50px; display: flex; align-items: center; background-color: white; padding-left: 20px">
        <span style="font-size: 24px; margin-left: 5px">二手交易物流管理平台</span>
      </div>
      <div style="height: calc(100vh - 50px); display: flex; align-items: center; justify-content: center">
        <div style="width: 400px; padding: 40px; background-color: white; border-radius: 5px;">
          <div style="display: flex; margin-bottom: 50px; font-size: 24px">
            <div style="border-bottom: 2px solid orangered; padding-bottom: 10px">登录</div>
            <a style="color: #333" href="/register"><div style="margin-left: 10px;">注册</div></a>
          </div>
          <el-form :model="form" :rules="rules" ref="formRef">
            <el-form-item prop="username">
              <el-input size="medium" prefix-icon="el-icon-user" placeholder="请输入账号" v-model="form.username"></el-input>
            </el-form-item>
            <el-form-item prop="password">
              <el-input size="medium" prefix-icon="el-icon-lock" placeholder="请输入密码" show-password  v-model="form.password"></el-input>
            </el-form-item>
            <el-form-item prop="role">
              <el-select v-model="form.role" style="width: 100%">
                <el-option label="管理员" value="ADMIN"></el-option>
                <el-option label="用户" value="USER"></el-option>
                <el-option label="仓库" value="WAREHOUSEADMIN"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button size="medium" style="width: 100%; background-color: orangered; border-color: orangered; color: white" @click="login">登 录</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "Login",
  data() {
    return {
      form: { role: 'ADMIN' },
      rules: {
        username: [
          { required: true, message: '请输入账号', trigger: 'blur' },
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
        ]
      }
    }
  },
  created() {
  },
  methods: {
    login() {
      this.$refs['formRef'].validate((valid) => {
        console.log(valid)
        if (valid) {
          // 验证通过
          console.log(this.form)
          this.$request.post('/login', this.form).then(res => {
            if (res.code === '200') {
              localStorage.setItem("xm-user", JSON.stringify(res.data))  // 存储用户数据
              console.log(res.data)
              if (res.data.role === 'USER') {
                this.$router.push('/front/home')  // 跳转主页

              } else  {
                this.$router.push('/home')  // 跳转主页

              }
              this.$message.success('登录成功')
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    }
  }
}
</script>
<style scoped>
.container {
  height: 100vh;
  overflow: hidden;
  display: flex;
}
a {
  color: #2a60c9;
}
</style>