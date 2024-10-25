<template>
  <div style="width: 60%; margin: 10px auto">
    <div style="display: flex; grid-gap: 20px">
      <div style="flex: 1">
        <div style="margin: 10px 0">
          <el-tag style="margin-right: 10px" v-for="item in JSON.parse(logistics.tags || '[]')" :key="item">{{ item }}</el-tag>
        </div>
        <div style="margin: 10px 0; color: #ffa400; font-size: 18px; font-weight: bold">{{ logistics.trackingNumber }}</div>
        <div style="margin: 10px 0; color: #ffa400; font-size: 18px; font-weight: bold">{{ logistics.sender }}</div>
        <div style="margin: 10px 0; color: #ffa400; font-size: 18px; font-weight: bold">{{ logistics.userName }}</div>
        <div style="margin: 10px 0; color: #ffa400; font-size: 18px; font-weight: bold">{{ logistics.coordinates }}</div>
        <div style="margin: 10px 0; color: #ffa400; font-size: 18px; font-weight: bold">{{ logistics.status }}</div>
        <div style="margin: 10px 0; color: #ffa400; font-size: 18px; font-weight: bold">{{ logistics.shippingTime }}</div>
      </div>
    </div>

    <div style="margin: 30px 0">
      <div style="font-weight: bold; font-size: 22px; text-align: center; margin-bottom: 30px">详细信息</div>
      <div id="container" style="height: 400px; margin-bottom: 30px"></div>

    </div>

<!--    <div style="margin: 30px 0">-->
<!--      <div style="font-weight: bold; font-size: 22px; text-align: center; margin-bottom: 30px">详细信息</div>-->

<!--      <div style="margin: 20px 0">-->
<!--        <div id="container" style="height: 400px; margin-bottom: 30px"></div>-->
<!--      </div>-->

<!--      <div style="line-height: 26px" class="w-e-text">-->
<!--        <div v-html="logistics.content"></div>-->
<!--      </div>-->
<!--    </div>-->
  </div>
</template>

<script>
export default {
  name: "Location",
  data() {
    return {
      trackingNumber: this.$route.query.trackingNumber,
      logistics: {},
    }
  },
  created() {
    // this.$request.put('/logistics/updateCount/' + this.id).then(res => {
      this.load()
    // })
  },
  methods: {
    load() {
      this.$request.get('/logistics/selectByIds/' + this.trackingNumber).then(res => {
        this.logistics = res.data || {}
        console.log(this.logistics.longitude);
        var map = new BMapGL.Map('container'); // 创建Map实例
        map.centerAndZoom(new BMapGL.Point(this.logistics.longitude, this.logistics.latitude), 16); // 初始化地图,设置中心点坐标和地图级别
        map.enableScrollWheelZoom(true); // 开启鼠标滚轮缩放
        let point = new BMapGL.Point(this.logistics.longitude, this.logistics.latitude)
        let marker = new BMapGL.Marker(point); // 创建标注
        map.addOverlay(marker);
        let opts = {
          width : 300, // 信息窗口宽度
          height: 100, // 信息窗口高度
          title : this.logistics.name , // 信息窗口标题
        }
        let infoWindow = new BMapGL.InfoWindow(
            "<b>地址</b>：" + this.logistics.address + "<br/>",
            opts); // 创建信息窗口对象

        marker.addEventListener("click", function(){
          map.openInfoWindow(infoWindow,point); //开启信息窗口
        });
      })
    }
  }
}
</script>

<style scoped>

</style>