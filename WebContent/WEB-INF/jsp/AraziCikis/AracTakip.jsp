<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link rel="stylesheet"
	href="<c:url value="/assets/css/dataTables.css"/>" type="text/css">

<script src="<c:url value="/assets/script/dataTables.js"/>"
	type="text/javascript"></script>

<script src="<c:url value="/assets/script/datatables.min.js"/>"
	type="text/javascript"></script>


<script src="<c:url value="/assets/script/pdfmake.min.js"/>"
	type="text/javascript"></script>


<script src="<c:url value="/assets/script/vfs_fonts.js"/>"
	type="text/javascript"></script>
<style>
input {
	width: 100px;
}

select {
	outline: none !important;
}

#date {
	width: 10em;
}

.alert1 {
	outline-color: red;
	border-color: red;
	display: none;
}

.uyariYazisi {
	font: bold;
	color: red;
}

.pic_ina {
	height: 90px;
	width: 30%;
	float: left;
}

/* .con_ina {
	height: 100px;
	width: 67%;
	margin-left: 3%;
	float: left;
} */
.btn_inr {
	float: right;
	margine-top: 25px;
}
</style>

<c:if test="${!empty errorMessage }">

	<script>
	//	alert("Aynı göreveden zaten var...");
	</script>

</c:if>

<c:if test="${!empty errorMessage2 }">
	<c:out value="sdasdasdsa"></c:out>
	<script>
		alert("Kayıt bulunamadı...");
	</script>

</c:if>

<script type="text/javascript">

jq(document).ready( function () {
    jq('#aracListesi').DataTable();
} );
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth() + 1; //January is 0!
	var yyyy = today.getFullYear();
	
	jq(document).ready(function() {
		if (dd < 10) {
			dd = '0' + dd
		}
		if (mm < 10) {
			mm = '0' + mm
		}

		today = yyyy + '-' + mm + '-' + dd;
		document.getElementById("date").setAttribute("max", today);
		document.getElementById("date2").setAttribute("max", today);
	});

	jq(document).ready(function() {
		jq('#ozelPlaka').keypress(function(e) {
			var regex = new RegExp("^[a-zA-Z0-9-]+$");
			var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
			if (regex.test(str)) {
				return true;
			}

			e.preventDefault();
			return false;
		});

	})

	function buyukHarf() {
		jq('input[type=text]').val(function() {
			/* this.value.replace(" ", ""); */

			return this.value.toUpperCase().replace(" ", "");
		})

	};

	function formControl(deger) {

		console.log("tarih: " + jq('#date').val());
		console.log("ilceID" + jq('#slctMarka').val());
		if (jq('#slctMarka').val() == null || jq('#slctMarka').val() == ""
				|| jq('#slctMarka').val() == 0 || jq('#date').val() == ""
				|| jq('#kullaniciList').val() == 0
				|| jq('#kullaniciList').val() == ""
				|| jq('#aciklama').val() == "" || jq('#aciklama').val() == null) {
			if (jq('#kullaniciList').val() == 0
					|| jq('#kullaniciList').val() == "") {
				jq('.personel').addClass('alert1');
				jq('.personel>.uyariYazisi').text(
						"En az '1' en fazla '5' personel seçebilirsiniz");
				jq('.alert1').show();
			} else {

				jq('.personel').removeClass('alert1');
				jq('.personel>.uyariYazisi').remove();

			}

			if (jq('#slctMarka').val() == null) {
				jq('.mahalle').addClass('alert1');
				jq('.mahalle>.uyariYazisi').text("Mahalle seçiniz");
				jq('.alert1').show();
			} else {
				jq('.mahalle>.uyariYazisi').remove();
				jq('.mahalle').removeClass('alert1');
			}

			if (jq('#date').val() == "") {
				jq('.tarih').addClass('alert1');
				jq('.tarih>.uyariYazisi').text(
						"Eksik yada yanlış tarih girdiniz!");
				jq('.alert1').show();
			} else {
				jq('.tarih>.uyariYazisi').remove();
				jq('.tarih').removeClass('alert1');

			}

			if (jq('#aciklama').val() == "") {
				jq('.aciklama').addClass('alert1');
				jq('.aciklama>.uyariYazisi').text("Lütfen açıklama giriniz..");
				jq('.alert1').show();
			} else {

				jq('.aciklama>.uyariYazisi').remove();
				jq('.aciklama').removeClass('alert1');
			}

			//jq('.uyariYazisi').text("asdasdad");
			//alert1("Eksik Bilgileri Tamamlayınız....");

			return true;
		} else {

			arac.submit();
		}
	};

	/* jq(document).ready(function() {
		jq(".personelGoster").hide();

	}); */
	
	

	jq(document).ready(function() {
		
		
		 jq('[data-toggle="tooltip"]').tooltip();   
		//jq('table').css({"opacity":".0"}); 
	/*	jq("#aracListesi").css({
			"height" : "307px",//find("tr:gt(6)")
			"overflow-y" : "auto",
			"display" : "block"
		});*/
		
		jq(' .personelGoster').click(function() {
			jq(this).toggle(1000);

		});
	});

	jq(document).ready(function() {

		var guncellenecekID = parseInt('${arac.id}');
		var ilceID = parseInt('${arac.ilce.id}');
		var mahalleID = parseInt('${arac.mahalle.id}');
		var mahalleIsim ='${secilenMahalleIsim}';
		
		
		/*alert1(!isNaN(guncellenecekID))*/
		if (!isNaN(guncellenecekID)) {
			
			/* ikisibiradamarkala(ilceID); */

			jq("#slctMarka").attr("itemValue", mahalleID);
			jq("#slctMarka").attr("itemLable", '${arac.mahalle.isim}');
		}

		jq(".chosen-select").chosen({
			max_selected_options : 5,
			no_results_text : "Kayıt Yok!",
			width : "200px"
		}

		);

		jq("#slctAltTip,.donem").chosen({
			no_results_text : "Kayıt Yok!",
			width : "100px"
		}

		);
	
		jq("#btnRaporAl").attr("disabled", true);	
		
		
		
		jq('#btnRaporAl').tooltip({
			  trigger: 'click',
			  placement: 'bottom'
			});
	});
	
	
	function buttonActivate() {
		
		if (jq("#personelIsim").has('option').length > 0  && jq("#donemYil").has('option').length > 0){
			
			jq("#btnRaporAl").attr("disabled", false);
		};
		
	}
</script>

<c:if test="${arac.id ne 0 or arac.id ne null }">
	<script>
jq(document).ready(function() {
	
	ikisibiradamarkala('${arac.ilce.id}');

		//jq("#slctMarka").val('${requestScope.secilenMahalle}').prop('selected',true);
	//alert('${requestScope.secilenMahalle}');
});


</script>
</c:if>
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<c:if test="${empty errors}">
				<button type="button" class="btn btn-info btn-sm"
					data-toggle="collapse" data-target="#gorevBulma-raporAlma">
					<span class="fa fa-search"></span>Görev
					Ara&nbsp;&nbsp;||&nbsp;&nbsp;<span class="fa fa-file-o"></span>Rapor
					Al
				</button>
				<div id="gorevBulma-raporAlma" class="collapse">
					<div class="col-xs-5">
						<h3 class="sub-header">
							Görev Bulma <span class="fa fa-search-plus"></span>
						</h3>
						<div class="table">
							<table class="table table-striped bg-info">
								<form:form action="gorevBul" method="get" class="form">
									<thead>
										<tr>
											<th>Tarih</th>
											<th>Plaka</th>
										</tr>
									</thead>
									<tr>
										<td><input name="tarih" type="date" id="date2"
											onkeydown="return false" /></td>
										<td><input name="plaka" type="text" id="ozelPlaka"
											onkeyup="buyukHarf();" /></td>
									</tr>
									<tr>
										<td colspan="2"><button type="submit" value="Görev Getir"
												class="btn btn-info btn-block btn-md">
												<span class="fa fa-search"></span>Görev Getir
											</button></td>
								</form:form>
							</table>
						</div>
					</div>
					<div class="col-xs-7">
						<h3 class="sub-header">
							Rapor Alma &nbsp; <span class="fa fa-file-o"></span>
						</h3>
						<div class="table">
							<table class="table table-striped bg-info">
								<form:form action="donemeGoreGetir" method="get">
									<thead>
										<tr>
											<th>Yıl</th>
											<th>Ay</th>
											<th>Personel</th>
										</tr>
									</thead>
									<tr>
										<td><select data-placeholder="Yıl Seç."
											style="border: none;" name="donemYil" id="donemYil"
											class="donem">

												<c:forEach items="${yillar }" var="yil">
													<option value="${yil}" label="">${yil }</option>
												</c:forEach>
										</select></td>
										<td><select data-placeholder="Ay Seç."
											style="border: none;" name="donemAy" id="donemAy"
											class="donem">
												<option value="" label="--- Seçiniz ---" />
												<c:forEach items="${aylar }" var="ay">
													<option value="${ay}" label="">${ay}.&nbsp;Ay</option>
												</c:forEach>
										</select></td>
										<td><select data-placeholder="Personel Seç." name="id"
											id="personelIsim" class="chosen-select"
											onchange="buttonActivate();">
												<option value=""></option>
												<c:if test="${!empty kullaniciListesi}">
													<c:forEach items="${kullaniciListesi}" var="kullanici"
														varStatus="sira">
														<option value="${kullanici[0]}">${kullanici[1]}</option>
													</c:forEach>
												</c:if>
												<c:if test="${!empty kullaniciListesi2}">
													<c:forEach items="${kullaniciListesi2}" var="kullanici"
														varStatus="sira">
														<option value="${kullanici.id}">${kullanici.adi}</option>
													</c:forEach>
												</c:if>
										</select></td>
									</tr>
									<tr>
										<td colspan="3"><input type="submit" value="Rapor Al"
											id="btnRaporAl" class="btn btn-info btn-block btn-md "></td>
									</tr>
								</form:form>
							</table>
						</div>
					</div>
				</div>
			</c:if>

		</div>
	</div>
	<c:if test="${empty errors}">
		<div class="row">
			<div class="col-lg-12">
				<h3>Görev Ekle</h3>
				<div class="table bg-info">
					<table class="table table-striped bg-info"
						style="text-align: center;">
						<thead style="text-align: center; height: 300px;">
							<tr>
								<th rowspan="2">PERSONEL</th>
								<th rowspan="2">ARAÇ PLAKASI</th>
								<th rowspan="2">ÖZEL ARAÇ</th>
								<th colspan="2" style="text-align: center;">GİDİLEN YER</th>
								<th rowspan="2" style="text-align: center;">TARİH</th>
								<th rowspan="2">ÇIKIŞ SAATİ</th>
								<th rowspan="2">GİRİŞ SAATİ</th>
								<th rowspan="2">İŞİN ÖZETİ</th>
							</tr>
							<tr>
								<th style="text-align: center;">İLÇE</th>
								<th style="text-align: center;">MAHALLE</th>
							</tr>
						</thead>
						<form:form commandName="arac" method="post"
							action="araziCikisEkle">
							<form:hidden path="id" />
							<tr>
								<td style=""><div class="personel">
										<form:select data-placeholder="Personel Seç." multiple="true"
											path="kullaniciList" name="kullaniciList"
											class="chosen-select chosen-ltr ">
											<c:set var="i" value=""></c:set>
											<c:forEach items="${kullanici }" var="x" varStatus="j">

												<c:set var="i" value="${j.index }"></c:set>
											</c:forEach>
											<c:forEach items="${girisYapanKullanici}" var="k"
												varStatus="">
												<option value="${k.id}"
													${kullanici[0].id == k.id ? 'selected' : ''}
													${kullanici[1].id == k.id ? 'selected' : ''}
													${kullanici[2].id == k.id ? 'selected' : ''}
													${kullanici[3].id == k.id ? 'selected' : ''}
													${kullanici[4].id == k.id ? 'selected' : ''}>
													${k.adi}</option>
											</c:forEach>
										</form:select>
										<span class="uyariYazisi"></span>
									</div></td>
								<td><form:select path="resmiPlaka" id="resmiPlaka">
										<form:option value="01R9533">01 R 9532</form:option>
										<form:option value="01R9533">01 R 9533</form:option>
										<form:option value="01EAY77">01 EAY 77</form:option>
										<form:option value="01R9249">01 R 9249</form:option>
										<form:option value="01R9404">01 R 9404</form:option>
										<form:option value="01CAD12">01 CAD 12</form:option>
										<form:option value="01ASL28">01 ASL 28</form:option>
										<form:option value="01ASL29">01 ASL 29</form:option>
										<form:option value="01AZJ18">01 AZJ 18</form:option>
									</form:select></td>
								<td><form:input path="ozelPlaka" type="text" id="ozelPlaka"
										style="text-transform: uppercase;" onkeyup="buyukHarf();" /></td>
								<!--ilce-->
								<td>
									<div class="ilce">
										<form:select path="ilce.id" id="slctAltTip" class=""
											onChange="ikisibiradamarkala(this.value)">
											<form:option value=""></form:option>
											<form:options items="${ilceListesi}" itemValue="id"
												itemLabel="isim" />

										</form:select>
									</div>


								</td>
								<td>

									<div class="mahalle">
										<form:select path="mahalle.id" id="slctMarka"
											class="mahalleSec">
											<c:forEach items="${markaListesi}" var="marka">
												<option value="${marka.id }"
													${marka.id ==  secilenMahalleID? 'selected' : ''}>${marka.isim }</option>
											</c:forEach>
										</form:select>

										<span class="uyariYazisi">{arac.mahalle.isim}</span>
									</div>
								</td>

								<td><div class="tarih">

										<form:input path="tarih" type="date" onkeydown="return false"
											id="date" />
										<span class="uyariYazisi"></span>
									</div></td>
								<td><form:select path="cikisSaati" items="${saatler}">

									</form:select></td>
								<td><form:select path="girisSaati" items="${saatler}">
									</form:select></td>
								<td><div class="aciklama">
										<form:input path="aciklama" type="text" id="aciklama" />
										<span class="uyariYazisi"></span>
									</div></td>
							</tr>

							<tr>
								<c:if test="${tusYazisi=='Kaydet' }">
									<td colspan="9" align="right"><input type="button"
										onclick="formControl();"
										class="btn btn-primary pull-right btn-lg" value="${tusYazisi}" /></td>
								</c:if>
								<c:if test="${tusYazisi=='Güncelle' }">
									<td colspan="5" align="right"><input type="button"
										onclick="formControl();" class="btn btn-primary btn-block"
										value="${tusYazisi}" /></td>
									<td colspan="4"><input type="button"
										class="btn btn-danger btn-block"
										onclick="javascript:location.href='./vazgec' " value="Vazgeç"></td>

								</c:if>
							</tr>
						</form:form>
					</table>
				</div>
			</div>
		</div>
	</c:if>
	<div class="row">
		<div class="col-sm-9 col-md-6 col-lg-12">
			<c:if test="${!empty errors}">


				<div class="alert alert-danger " role="alert">
					<strong>${errors }</strong>
				</div>



			</c:if>
			<h3 class="sub-header">Araç Çıkış Listesi</h3>
			<div class="">
				<table class="table table-striped bg-info" id="aracListesi"
					style="text-align: center">

					<thead>
						<tr>
							<th>Sil</th>
							<th>Edit</th>
							<th>#</th>
							<th width="150px">Personel</th>
							<th>Plaka</th>
							<th>Gidilen Yer</th>
							<th>Çıkış Tarihi</th>
							<th>Çıkış Saati</th>
							<th>Giriş Saati</th>
							<th>İşin Özeti</th>
							<th>Kaydeden</th>
							<th>Kayıt Zamani</th>
							<th>Görev Raporu</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${aracCikisListesi}" var="cikis"
							varStatus="sira">
							<c:if test="${!empty cikis.kullaniciList }">
								<tr class="satirno${cikis.id}">

									<td><a onclick="tipsil(${cikis.id})"
										class="btn btn-danger btn-xs"> Sil</a> <%-- <img
									src="<c:url value="/assets/images/Delete-32.png" />"
									width="21px" onclick="tipsil(${cikis.id})"
									title="Silmek İçin Tıklayın" /> --%></td>



									<td><a href="./duzenle/${cikis.id}"
										class="btn btn-success btn-xs"> Düzenle</a> <%-- <img
										src="<c:url value="/assets/images/duzenle.png" />"
										width="21px" title="Değiştirmek İçin Tıklayın" />
										 --%></td>
									<td>${sira.count }</td>

									<td width="150px"><span id="goster"><button
												type="button" class="btn btn-info btn-xs"
												data-toggle="modal" data-target="#myModal${cikis.id}">Personel
												Listesi</button></span> <!-- Modal -->
										<div class="modal fade" id="myModal${cikis.id}" role="dialog">
											<div class="modal-dialog">

												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">&times;</button>
														<h4 class="modal-title">${cikis.ilce.isim}-${cikis.mahalle.isim}&nbsp;${cikis.tarih}&nbsp;Tarihli
															Görev Listesi</h4>
													</div>
													<div class="modal-body">
														<c:forEach items="${cikis.kullaniciList}" var="kullanici"
															varStatus="index">
															<span class="personelGoster"></span>

															<p>${index.count}-${kullanici.adi}</p>
														</c:forEach>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-default"
															data-dismiss="modal">Kapat</button>
													</div>
												</div>

											</div>
										</div></td>


									<c:if test="${!empty cikis.ozelPlaka}">
										<td>Ö-${cikis.ozelPlaka }</td>
									</c:if>
									<c:if test="${!empty cikis.resmiPlaka }">
										<td>R-${cikis.resmiPlaka }</td>
									</c:if>
									<td>${cikis.ilce.isim}-${cikis.mahalle.isim}</td>
									<td>${cikis.tarih}</td>
									<td>${cikis.cikisSaati}</td>
									<td>${cikis.girisSaati}</td>
									<td>${cikis.aciklama}</td>
									<td>${cikis.islemyapan.adi}</td>
									<td>${cikis.islemZamani}</td>
									<td><a href="./gorevDonusRaporuYazdir?id=${cikis.id}"
										class="btn btn-xs btn-primary">Rapor Görüntüle</a></td>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<%-- <div class="page-header">&nbsp;</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">DENEME</h3>
		</div>
		<div class="panel-body">
			<div style="overflow-x: auto;">
				<c:set var="toplam" value="${0}"></c:set>
				<table class="table table-hover table-border">
					<tr>
						<td></td>
						<c:forEach items="${kategoriListesi}" var="kategori">
							<td>${kategori.isim}</td>
						</c:forEach>
					</tr>

					<c:forEach items="${ilceListesi}" var="ilce">

						<tr>
							<td>${ilce.isim}</td>
							<c:forEach items="${kategoriListesi}" var="kategori"
								varStatus="x">


								<c:if test="${ilce.id eq mahalle.tip.id }">

									<!-- <script type="text/javascript">
													ilceyeVeKategoriyeGoreKayitSayisi('${mahalle.id}','${kategori.id}','${mahalle.tip.id}');
													</script> -->
									<c:set var="toplam" value="${toplam+1 }"></c:set>


								</c:if>

								<td><span>${x.last}-${toplam}</span></td>
							</c:forEach>
						</tr>
					</c:forEach>


				</table>

			</div>
		</div>
	</div> --%>
</div>

