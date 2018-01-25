$("#estado").change(function() { //mudei o estado de Estado
	var estado_id = $(this).val(); //cria a requisição ajax com isso

	$.ajax({ 
	  type:"PATCH",
	  url:"/buscacidades",
	  dataType:"json",
	  data: {estado: estado_id},
	  success:function(result){ //se tá td ok acontece essa funcaoo
	    //adicionar opções ao dropdown e habilitar o mesmo
	    $('#cidade').html('');
	    var i = 0;
	    for (i = 0; i < result.length; i++) {
		    $('#cidade').append('<option value="' + result[i].id + '">' + result[i].nome + '</option>');
		  }
		  $('#cidade').prop('disabled', false);

		  if (result.length == 0) {
		  	$('#cidade').prop('disabled', true);
		  }
	  }
	});
	
});