<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>


<style type="text/css">
/* .table-fixed tbody {
	height: 75px;
}

.table-fixed {
	overflow-y: auto;
	display: block;
	height: 250px;
	width: 100%;
}
 */
#collapse1 {
	overflow-y: scroll;
	height: 500px;
	width: 190%;
}

.baslik td {
	text-decoration: bold;
}
</style>
<script type="text/javascript">
	var jq = jQuery.noConflict();
	var tableToExcel = (function() {

		var uri = 'data:application/vnd.ms-excel;base64,', template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8"><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>', base64 = function(
				s) {
			return window.btoa(unescape(encodeURIComponent(s)))
		}, format = function(s, c) {
			return s.replace(/{(\w+)}/g, function(m, p) {
				return c[p];
			})
		}
		return function(table, name) {
			if (!table.nodeType)
				table = document.getElementById(table)
			var ctx = {
				worksheet : name || 'Worksheet',
				table : table.innerHTML
			}
			window.location.href = uri + base64(format(template, ctx))
		}
	})();
	function etapNoDegistir(etapNo) {
		console.log("etapNO: " + etapNo)

		if (etapNo != "") {
			window.location.href = "./etapNoyaGoreGetir?etapNo=" + etapNo;
		} else {

			window.location.href = "./ekonomik-yatirimlar";
		}
	};
</script>
</head>
<body>
	<div class="container-fluid">
		<c:if test="${!empty errorMessage }">
			<div class="col-sm-11">


				<div class="alert alert-warning ">
					<h4>${requestScope.ekonomikYatirim.etapNo}.Etap'ta
						${requestScope.ekonomikYatirim.yatirimciAdi} isimli kayıt zaten
						mevcut.<br>Bilgileri kontrol ederek tekrar girmeyi deneyiniz!
					</h4>
				</div>
			</div>
		</c:if>
		<div id="container" class="col-sm-6">

			<h3>Ekonomik Yatırımlar</h3>

			<form:form action="ekle" method="post" commandName="ekonomikYatirim">
				<form:hidden path="id" />
				<table
					class="table table-xs table-striped bg-danger  table-responsive "
					style="text-align: center; width: 50%;">
					<tr align="center" style="text-align: center">
						<td colspan="12">EKONOMİK YATIRIMLAR</td>
					</tr>
					<tr>
						<td>İLÇE</td>
						<td>YATIRIM NİTELİĞİ</td>
						<td>ETAP NO</td>
						<td>YATIRIMCI ADI</td>
						<td>PROJE ADI</td>
						<td>PROJE KONUSU</td>
						<td>PROJE BEDELİ</td>
						<td>HİBE TUTARI</td>
						<td>KAPASİTE</td>
						<td>BİRİM</td>
						<td>İSTİHDAM</td>
						<td>DURUM</td>
					</tr>
					<tr>
						<td><form:select path="ilce.id">
								<form:options items="${ ilceListesi}" itemLabel="isim"
									itemValue="id" />
							</form:select></td>

						<td><form:select path="kategori.id">
								<form:option value="">-Seçiniz------</form:option>
								<c:forEach items="${kategoriListesi}" var="kat" begin="0"
									end="0">

									<optgroup label="${kat.ustKategori.adi}" dir="ltr">

										<c:forEach items="${kategoriListesi}" var="kat">
											<c:if test="${kat.ustKategori.adi eq 'Ekonomik Yatırımlar'}">

												<form:option value="${kat.id }">${kat.kategoriAdi }</form:option>
											</c:if>
										</c:forEach>


									</optgroup>

								</c:forEach>
								<c:forEach items="${kategoriListesi}" var="kat" begin="3"
									end="3">

									<optgroup label="${kat.ustKategori.adi}" dir="ltr">

										<c:forEach items="${kategoriListesi}" var="kat">
											<c:if test="${kat.ustKategori.adi eq 'Altyapı Yatırımları'}">

												<form:option value="${kat.id }">${kat.kategoriAdi }</form:option>
											</c:if>
										</c:forEach>
									</optgroup>
								</c:forEach>
							</form:select></td>
						<td><form:select path="etapNo">
								<form:option value="2">2. Etap</form:option>
								<form:option value="3">3. Etap</form:option>
								<form:option value="4">4. Etap</form:option>
								<form:option value="5">5. Etap</form:option>
								<form:option value="6">6. Etap</form:option>
								<form:option value="7">7. Etap</form:option>
								<form:option value="8">8. Etap</form:option>
								<form:option value="9">9. Etap</form:option>
								<form:option value="10">10. Etap</form:option>
								<form:option value="11">11. Etap</form:option>
								<form:option value="12">12. Etap</form:option>
							</form:select></td>
						<td><form:input path="yatirimciAdi" /> <%-- <form:select path="yatirimciSayisi">
								<form:option value="1">1</form:option>
								<form:option value="2">2</form:option>
								<form:option value="3">3</form:option>
								<form:option value="4">4</form:option>
								<form:option value="5">5</form:option>
								<form:option value="6">6</form:option>
								<form:option value="7">7</form:option>
								<form:option value="8">8</form:option>
								<form:option value="9">9</form:option>
								<form:option value="10">10</form:option>
								<form:option value="11">11</form:option>
								<form:option value="12">12</form:option>
								<form:option value="13">13</form:option>
								<form:option value="14">14</form:option>
								<form:option value="15">15</form:option>
								<form:option value="16">16</form:option>
								<form:option value="17">17</form:option>
								<form:option value="18">18</form:option>
								<form:option value="19">19</form:option>
								<form:option value="20">20</form:option>
							</form:select> --%></td>
						<td><form:input path="projeAdi" /></td>
						<td><form:input path="projeKonusu" /></td>
						<td><form:input path="projeBedeli" class="money" /></td>
						<td><form:input path="hibeTutari" class="money" /></td>
						<td><form:input path="kapasite" /></td>
						<td><form:select path="kapasiteBirim">
								<form:option value="0">Seçiniz</form:option>
								<form:option value="lt">Litre</form:option>
								<form:option value="da">Dekar</form:option>
								<form:option value="buyukbas">Büyük Baş</form:option>
								<form:option value="kucukbas">Küçük Baş</form:option>
								<form:option value="ton">Ton</form:option>
								<form:option value="adet/yıl">Adet/Yıl</form:option>
								<form:option value="kw/h">kw/h</form:option>
								<form:option value="kg">kg</form:option>
								<form:option value="kg/Yıl">kg/Yıl</form:option>
								<form:option value="Ton/Yıl">Ton/Yıl</form:option>
								<form:option value="m&sup2;">m&sup2;
										</form:option>

							</form:select></td>
						<td><form:input path="istihdam" /></td>
						<td><form:select path="durum.id" items="${durumListesi }"
								itemLabel="durumAdi" itemValue="id">
							</form:select></td>
					</tr>
					<tr>
						<c:if test="${tusYazisi == 'Kaydet'}">
							<td colspan="11"><input id="kaydetBtn" type="submit"
								class="btn btn-info  btn-md pull-right" value="${tusYazisi }"></td>
						</c:if>
						<c:if test="${tusYazisi == 'Guncelle'}">
							<td colspan="11"><input type="submit"
								class="btn btn-info  btn-md pull-right" value="Güncelle">
								<input type="button" class="btn btn-danger btn-md pull-right"
								value="Vazgeç"
								onclick="javascript:location.href='./ekonomikYatirimVazgec'">
							</td>
						</c:if>
					</tr>
				</table>
				<c:if test="${empty errorMessage }">
					<div>
						<select name="etapNo" onchange="etapNoDegistir(this.value);">
							<option value="">Seç</option>
							<option value="2" ${param.etapNo==2 ? 'selected':''}>2.
								Etap</option>
							<option value="3" ${param.etapNo==3 ? 'selected':''}>3.
								Etap</option>
							<option value="4" ${param.etapNo==4 ? 'selected':''}>4.
								Etap</option>
							<option value="5" ${param.etapNo==5 ? 'selected':''}>5.
								Etap</option>
							<option value="6" ${param.etapNo==6 ? 'selected':''}>6.
								Etap</option>
							<option value="7" ${param.etapNo==7 ? 'selected':''}>7.
								Etap</option>
							<option value="8" ${param.etapNo==8 ? 'selected':''}>8.
								Etap</option>
							<option value="9" ${param.etapNo==9 ? 'selected':''}>9.
								Etap</option>
							<option value="10" ${param.etapNo==10 ? 'selected':''}>10.
								Etap</option>
							<option value="11" ${param.etapNo==11 ? 'selected':''}>11.
								Etap</option>
							<option value="12" ${param.etapNo==12 ? 'selected':''}>12.
								Etap</option>

						</select>

					</div>

					<div id="collapse1" class="panel-collapse ">
						<table class="table table-sm table-striped bg-info table-fixed "
							style="text-align: center; width: 100%;">
							<c:set var="list" value="${tumListe}" />
							<c:set var="listSize" value="${fn:length(list)}" />

							<tr>
								<td align="left"><b>${listSize}&nbsp;adet&nbsp;kayıt</b></td>
								<td align="left" colspan="12"><a href="#"
									class="float-left btn" id="dlink"
									onclick="tableToExcel('xxx', 'Kategori ve İlçeye Göre Rapor')"><img
										alt="Excel Report" class="rounded" width="15px"
										src="<c:url value='/assets/images/copy-file.png'/>">
										${empty param.etapNo   ? 'Tüm Tabloyu':param.etapNo += '.Etabı' }
										Excel'e Aktarmak İçin Tıklayınız..</a></td>
							</tr>
							<tbody class="govde" id="xxx">
								<tr class="baslik">

									<td align="center">İLÇE</td>
									<td align="center">YATIRIM NİTELİĞİ</td>
									<td align="center">ETAP NO</td>
									<td align="center">YATIRIMCI ADI</td>
									<td align="center">PROJE ADI</td>
									<td align="center">PROJE KONUSU</td>
									<td align="center">PROJE BEDELİ</td>
									<td align="center">HİBE TUTARI</td>
									<td align="center">KAPASİTE</td>
									<td align="center">İSTİHDAM</td>
									<td align="center">DURUM</td>
									<td></td>
									<td></td>

								</tr>

								<c:forEach items="${tumListe }" var="yatirim"
									varStatus="sira">
									<tr id="siraNo${sira.count }">
										<td align="center">${yatirim.ilce.isim}</td>
										<td align="center">${yatirim.kategori.kategoriAdi}</td>
										<td align="center">${yatirim.etapNo}</td>
										<td align="center" id="${yatirim.id }">${yatirim.yatirimciAdi}</td>
										<td align="center">${yatirim.projeAdi}</td>
											<td align="center">${yatirim.projeKonusu}</td>
										<td align="center"><fmt:formatNumber pattern="#,##0.00"
												type="currency" value="${yatirim.projeBedeli}"
												var="projeBedeli"></fmt:formatNumber>${projeBedeli }</td>
										<td align="center"><fmt:formatNumber pattern="#,##0.00"
												type="currency" value="${yatirim.hibeTutari}"
												var="projeBedeli"></fmt:formatNumber>${projeBedeli }</td>
										<td align="center">${yatirim.kapasite}&nbsp;${yatirim.kapasiteBirim}</td>
										<td align="center">${yatirim.istihdam}</td>
										<td align="center">${yatirim.durum.durumAdi}</td>
										<td><a
											href="${pageContext.request.contextPath }/kirsal-kalkinma/ekonomikYatirimSil?id=${yatirim.id}"
											onclick="javascript:return confirm('${yatirim.etapNo}. etap ${yatirim.yatirimciAdi} isimli kaydı : \n Silmek İstediğinize Emin misiniz?');"
											class="btn btn-danger btn-sm">Sil</a></td>
										<td><a
											href="${pageContext.request.contextPath }/kirsal-kalkinma/ekonomikYatirimGuncelle/${yatirim.id}"
											class="btn btn-success btn-sm">Güncelle</a></td>
									</tr>
								</c:forEach>
								<tr>
									<td colspan="5" align="right">GENEL TOPLAM:</td>

									<td><fmt:formatNumber pattern="#,##0.00" type="currency"
											value="${tumListe.stream().map(yatirim -> yatirim.projeBedeli).sum()}"
											var="projeBedeli"></fmt:formatNumber>${projeBedeli }</td>
									<td><fmt:formatNumber pattern="#,##0.00 TL"
											type="currency"
											value="${tumListe.stream().map(yatirim -> yatirim.hibeTutari).sum()}"
											var="hibeTutari"></fmt:formatNumber>${hibeTutari }</td>
									<td><fmt:formatNumber pattern="#,##0" type="number"
											value="${tumListe.stream().map(yatirim -> yatirim.kapasite).sum()}"
											var="kapasite"></fmt:formatNumber>${kapasite }</td>
									<td><fmt:formatNumber pattern="#,##0" type="number"
											value="${tumListe.stream().map(yatirim -> yatirim.istihdam).sum()}"
											var="istihdam"></fmt:formatNumber>${istihdam }</td>

									<td colspan="3"></td>
								</tr>
							</tbody>
						</table>
					</div>
				</c:if>
			</form:form>
		</div>
	</div>
</body>
</html>