{add_css file="components/calendar/css/calendar.css"}
{add_css file="components/calendar/js/fancybox/jquery.fancybox-1.3.4.css"}

{add_js file="components/calendar/js/fancybox/jquery.fancybox-1.3.4.js"}
{add_js file="components/calendar/js/fancybox/jquery.easing-1.3.pack.js"}

{if $parent}
  {add_js file="components/calendar/js/jquery-ui-1.8.23.custom.min.js"}
  {add_css file="components/calendar/css/fullcalendar.css"}
  {add_js file="components/calendar/js/fullcalendar.js"}
  <script type='text/javascript'>
  {literal}
    $(document).ready(function() {
      $('#calendar').fullCalendar({
	header: {
	  left: 'prev,next today',
	  center: 'title',
	  right: 'month,agendaWeek,agendaDay'
	},
	editable: false,
	buttonText: {
	  today:    'сегодня',
	  month:    'месяц',
	  week:     'неделя',
	  day:      'день'
	},
	year: {/literal}{$year}{literal},
	month: {/literal}{$month}{literal},
	date: {/literal}{$day}{literal},
	monthNamesShort: ['Янв', 'Февр', 'Март', 'Апр', 'Май', 'Июнь', 'Июль', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'],
	monthNames: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
	dayNamesShort: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
	dayNames:['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'],
	allDayText: 'весь день',
	axisFormat: 'H:mm',
	defaultView: '{/literal}{$calendar_view}{literal}',
	firstDay: '1',
	timeFormat: 'H:mm',
	events:[
	  {/literal}{$events_string}{literal}
	  ]
	});
      });
    {/literal}
  </script>
{/if}

{literal}
<script type="text/javascript">
  window.onload = function ()
  { 
    $("a.inline").fancybox({
        'autoScale'     	: 'true' ,
        'transitionIn'		: 'none',
	'transitionOut'		: 'none',
	'type'			: 'inline',
	'opacity'		: 'true',
	'centerOnScroll'	: 'true',
	'padding'		: 0,
	'scrolling'		: 'no'
    });
  }
 </script>
{/literal}

<h1 class="con_heading">{$event.title}</h1>
<table class="club_full_entry" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top" class="left">
      <div class="members_list">
	<div class="title">
	  Организатор:
	</div>
	<div class="list" style="text-align: center;">
	  <a href="/users/{$event.login}">
	    <img src="/images/users/avatars/{$event.imageurl}"><br/>
	    {$event.nickname}
	  </a>
	</div>
      </div>
      {if $event.type == "public" and $status != "Прошедшее событие"}
	{if $issngnup}
	  <div class="signup"><a href="/calendar/signup{$event.id}.html">Отказаться</a></div>
	{else}
	  <div class="signup"><a href="/calendar/signup{$event.id}.html">Присоединиться</a></div>
	{/if}
      {/if}
      {if $singups_user}
	<div class="members_list">
	  <div class="title">Участники встречи:</div>
	  <div class="list singups">
	    {foreach key=id item=user from=$singups_user}
	      <a href="/users/{$user.login}">
		<img src="/images/users/avatars/small/{$user.imageurl}"><br/>
		{$user.nickname}
	      </a>
	    {/foreach}
	  </div>
	</div>
      {/if}
      {if $admin}
	<ul>
	  <li><a href="/calendar/delete{$event.id}.html">удалить</a></li>
	  <li><a href="/calendar/edit{$event.id}.html">редактировать</a></li>
	  <li><a href="/calendar/add_parent{$event.id}.html">Добавить волженое событие</a></li>
	</ul>
      {/if}
    </td>
    <td valign="top">
      <div class="data">
	<div class="details">
	  <span class="date">{$status}</span>
	</div>
	<div class="description">
	  {if $content}
	    {$content}
	    <br /><br />
	  {/if}
	  <ul>
	    <li>Начало: {$start_time}</li>
	    <li>Окончание: {$end_time}</li>
	    {if $event.category_name}
	      <li>Категория: <a href="/calendar/category{$event.category_id}.html">{$event.category_name}</a></li>
	    {else}
	      {if $event.type == "private"}
		<li>Это приватное сообщение и видно только Вам.</li>
	      {else}
		<li>Без категории.</li>
	      {/if}
	    {/if}
	  </ul>
	</div>
      </div>
      	<div class="clubcontent">
	  <div class="album">
	    <div class="title"><a>Фотографии</a></div>
	  </div>
	  <div class="content">
	  <!-- FOTOLIB -->
	    {if $images or $allow_add_foto}
	      <div class="arround" id="fotolib_img">
	    {/if}
	    <!-- Сами фото -->
	    {if $images}
	      <ul class="fotolib">
		{foreach key=id item=image from=$images}
		  <li>
		    <a href="#{$image.name}" rel="group1" class="inline">
		      <img src="/images/fotolib/L_{$image.name}.jpg">
		    </a>
		    <div style="display:none" class="fbinline">
		      <div id="{$image.name}">
			<img src="/images/fotolib/S_{$image.name}.jpg" class="mainimage">
			<div id="fancybox-title" class="fancybox-title-over" style="width: 100%; display: block; ">
			{if $image.user_id == $user.id or $admin}
			  <span id="fancybox-title-over">
			    <div align="center">
			      <a href="/calendar/rotate/left/{$image.id}.html"><img src="/components/calendar/images/object-rotate-left.png"></a>
			      <a href="/calendar/imagedelete/{$image.id}.html"><img src="/components/calendar/images/window-close.png"></a>
			      <a href="/calendar/rotate/right/{$image.id}.html"><img src="/components/calendar/images/object-rotate-right.png"></a>
			    </div>
			  </span>
			{/if}
		      </div>
		    </div>
		  </div>
		</li>
	      {/foreach}
	    </ul>
	  {/if}
	  <!-- Форма добавления -->
	  {if $allow_add_foto or $admin}
	    <form action="" method="POST" enctype="multipart/form-data">
	      <legend>Загрузить изображение</legend>
	      <div id="inputs">
		<input type="file" name="file_0"><br />
	      </div>
	      <a onClick="addFile()">[+]</a><br/>
	      <input type="submit" value="Отправить">
	    </form>
	  {/if}
	  {if $images or $allow_add_foto}
	    </div>
	  {/if}
	</div>
	<br />
	{if $parent}
	  <div class="album">
	    <div class="title"><a>Календарь мероприятия</a></div>
	  </div>
	  <div class="content">
	    <div id="calendar"></div>
	  </div>
	{/if}
      </div>
    </td>
  </tr>
</table>

{if $parent}
  <h1>Календарь мероприятия:</h1>
  {add_js file="components/calendar/js/jquery-ui-1.8.23.custom.min.js"}
  {add_css file="components/calendar/css/fullcalendar.css"}
  {add_js file="components/calendar/js/fullcalendar.js"}
  <script type='text/javascript'>
  {literal}
    $(document).ready(function() {
		
		$('#calendar').fullCalendar({
			header: {
			  left: 'prev,next today',
			  center: 'title',
			  right: 'month,agendaWeek,agendaDay'
			},
			editable: false,
						buttonText: {
			today:    'сегодня',
			month:    'месяц',
			week:     'неделя',
			day:      'день'
			},
			year: {/literal}{$year}{literal},
			month: {/literal}{$month}{literal},
			date: {/literal}{$day}{literal},
			monthNamesShort: ['Янв', 'Февр', 'Март', 'Апр', 'Май', 'Июнь', 'Июль', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'],
			monthNames: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
			dayNamesShort: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
			dayNames:['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'],
			allDayText: 'весь день',
			axisFormat: 'H:mm',
			defaultView: '{/literal}{$calendar_view}{literal}',
			firstDay: '1',
			timeFormat: 'H:mm',
			events:[
			  {/literal}{$events_string}{literal}
			]
		      });
		   });
  {/literal}
  </script>
  
{/if}
