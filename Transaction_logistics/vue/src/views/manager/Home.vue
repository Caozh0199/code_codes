<template>
  <div>
    <!-- 欢迎信息 -->
    <div class="card" style="padding: 15px">
      您好，{{ user?.name }}！欢迎使用本系统
    </div>

    <!-- 公告列表和订单状态图表 -->
    <div style="display: flex; margin: 10px 0">
      <!-- 公告列表 -->
      <div style="width: 50%;" class="card">
        <div style="margin-bottom: 30px; font-size: 20px; font-weight: bold">公告列表</div>
        <div>
          <el-timeline reverse slot="reference">
            <el-timeline-item v-for="item in notices" :key="item.id" :timestamp="item.time">
              <el-popover
                  placement="right"
                  width="200"
                  trigger="hover"
                  :content="item.content">
                <span slot="reference">{{ item.title }}</span>
              </el-popover>
            </el-timeline-item>
          </el-timeline>
        </div>
      </div>

      <!-- 订单状态图表 -->
      <div style="width: 50%; padding-left: 20px;" class="card">
        <div style="margin-bottom: 30px; font-size: 20px; font-weight: bold">订单状态统计</div>
        <div ref="chart" style="width: 100%; height: 400px;"></div>
      </div>
    </div>
  </div>
</template>

<script>
import * as echarts from 'echarts';

export default {
  name: 'Home',
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      notices: [],
      orders: [] // 存储订单数据
    };
  },
  created() {
    // 获取公告数据
    this.$request.get('/notice/selectAll').then(res => {
      this.notices = res.data || [];
    });

    // 获取订单数据
    this.$request.get('/orders/selectAll').then(res => {
      if (res.code === '200' && Array.isArray(res.data)) {
        this.orders = res.data;
        this.initChart(); // 初始化图表
      } else {
        console.error('获取订单数据失败:', res.msg);
      }
    });
  },
  methods: {
    initChart() {
      // 统计订单状态数量
      const statusCount = {
        待支付: 0,
        待发货: 0,
        待揽收: 0,
        待收货: 0,
        已完成: 0
      };

      this.orders.forEach(order => {
        switch (order.status) {
          case '待支付':
            statusCount['待支付']++;
            break;
          case '待发货':
            statusCount['待发货']++;
            break;
          case '待揽收':
            statusCount['待揽收']++;
            break;
          case '待收货':
            statusCount['待收货']++;
            break;
          case '已完成':
            statusCount['已完成']++;
            break;
          default:
            break;
        }
      });

      // 提取状态名称和对应的数量
      const statusNames = Object.keys(statusCount);
      const statusValues = Object.values(statusCount);

      // 初始化 ECharts 图表
      const chartDom = this.$refs.chart;
      const myChart = echarts.init(chartDom);

      const option = {
        title: {
          text: '订单状态统计',
          left: 'center'
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'shadow'
          }
        },
        xAxis: {
          type: 'category',
          data: statusNames
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            data: statusValues,
            type: 'bar',
            barWidth: '60%',
            itemStyle: {
              color: function (params) {
                const colors = ['#5470c6', '#91cc75', '#fac858', '#ee6666', '#73c0de'];
                return colors[params.dataIndex];
              }
            }
          }
        ]
      };

      myChart.setOption(option);
    }
  }
};
</script>

<style scoped>
.card {
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 15px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
</style>