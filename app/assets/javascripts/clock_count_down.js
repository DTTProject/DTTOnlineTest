$(document).on('turbolinks:load', function(){
  Count_Down = function(){
    this.hour =  parseInt($('#data_clock_init').data('hour'))
    this.minute = parseInt($('#data_clock_init').data('minute'))
    this.second = parseInt($('#data_clock_init').data('second'))
  }
  Count_Down.prototype.count = function(){
    if(this.second <= 0 && this.minute > 0) {
      this.minute = this.minute - 1
      this.second =  58
    }
    if(this.second <= 0 && this.minute <= 0 && this.hour > 0){
      this.hour = this.hour - 1
      this.minute = 59
      this.second = 59
    }
    this.second = this.second - 1
    $('.clock_count_down').find('.hour').html(this.hour)
    $('.clock_count_down').find('.minute').html(this.minute)
    $('.clock_count_down').find('.second').html(this.second)
    if(this.second <= 0 && this.minute <= 0 && this.hour <= 0){
      $('.finish_exam').trigger('click')
      $('.clock_count_down').remove()
    }
  };
  timer = new Count_Down;
  setInterval(function(){timer.count()}, 1000);
})

