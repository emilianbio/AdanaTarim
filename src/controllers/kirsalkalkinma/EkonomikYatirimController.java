package controllers.kirsalkalkinma;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JDialog;
import javax.swing.JOptionPane;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import araclar.Genel;
import forms.Kullanici;
import forms.kirsalkalkinma.ekonomikyatirim.EkonomikYatirim;
import service.YerEklemeService;
import service.kirsalkalkinma.EkonomikYatirimDurumuService;
import service.kirsalkalkinma.EkonomikYatirimKategoriService;
import service.kirsalkalkinma.EkonomikYatirimService;

@Controller
@RequestMapping(value = "/kirsal-kalkinma")
public class EkonomikYatirimController {

	@Autowired
	private EkonomikYatirimService ekonomikYatirimService;
	@Autowired
	private EkonomikYatirimDurumuService ekonomikDurumService;
	@Autowired
	private EkonomikYatirimKategoriService ekonomikYatirimKategoriService;
	@Autowired
	private YerEklemeService yerEklemeService;
	private EkonomikYatirim yatirim;
	private String tusYazisi = "Kaydet";

	@RequestMapping(value = "/ekonomik-yatirimlar")
	public String ekonomikYatirimlar(@CookieValue(value = "id", required = false) Long id, ModelMap model,
			@ModelAttribute("ekonomikYatirim") EkonomikYatirim ekonomikYatirim) {

		if (id == null) {

			System.out.println("ekonomikYatirim ID bo�");
			return "redirect:/anasayfa";
		}
		if (yatirim == null) {

			yatirim = new EkonomikYatirim();
		}

		try {
			model.put("ekonomikYatirim", yatirim);
		} catch (Exception e) {

			model.put("errors", e.getMessage());
			return "error";
		}
		model.put("title", "K�rsal Kalk�nma");
		model.put("tumListe", ekonomikYatirimService.tumYatirimListesi());
		model.put("ilceListesi", yerEklemeService.altTipGetir(2l, true));
		model.put("kategoriListesi", ekonomikYatirimKategoriService.tumEkonomikYatirimKategoriListesi());
		model.put("durumListesi", ekonomikDurumService.tumDurumListesi());
		model.put("tusYazisi", tusYazisi);
		tusYazisi = "Kaydet";
		yatirim = null;

		return "KirsalKalkinma/EkonomikYatirimlar";

	}

	@RequestMapping(value = "/ekle", method = RequestMethod.POST)
	public String ekonomikYatirimKaydet(@CookieValue(value = "id", required = true) Long id,
			@ModelAttribute("ekonomikYatirim") EkonomikYatirim ekonomikYatirim, BindingResult result, ModelMap model) {
		System.out.println("ekonomik yat�r�m ekle : " + ekonomikYatirim);

		if (result.hasErrors()) {

			System.out.println("Hatalar : " + result.getAllErrors());
		}

		if (ekonomikYatirim.getIstihdam() == null) {

			ekonomikYatirim.setIstihdam(0);
		}
		Kullanici kullanici = new Kullanici();

		kullanici.setId(id);
		ekonomikYatirim.setIslemYapan(kullanici);
		ekonomikYatirim.setIslemZamani(new Date());
		try {

			if (Long.valueOf(ekonomikYatirim.getId()) == 0 && ekonomikYatirimService
					.kayitVarmi(ekonomikYatirim.getEtapNo(), ekonomikYatirim.getYatirimciAdi())) {

				model.put("title", "K�rsal Kalk�nma");
				model.put("ilceListesi", yerEklemeService.altTipGetir(2l, true));
				model.put("kategoriListesi", ekonomikYatirimKategoriService.tumEkonomikYatirimKategoriListesi());
				model.put("durumListesi", ekonomikDurumService.tumDurumListesi());
				model.put("tusYazisi", tusYazisi);
				tusYazisi = "Kaydet";

				model.put("errorMessage", "M�kerrer kayit....");
				return "KirsalKalkinma/EkonomikYatirimlar";
			} else {
				ekonomikYatirimService.save(ekonomikYatirim);
			}

		} catch (Exception e) {

			model.put("errors", e.getMessage());
			System.out.println("girilen de�erler : " + ekonomikYatirim.toString());
			return "error";
		}
		return "redirect:/kirsal-kalkinma/ekonomik-yatirimlar";
	}

	@RequestMapping(value = "/ekonomikYatirimGuncelle/{id}")
	public String ekonomikYatirimGuncelle(@PathVariable("id") Long id) {

		yatirim = ekonomikYatirimService.ekonomikYatirimGetir(id);

		tusYazisi = "Guncelle";
		return "redirect:/kirsal-kalkinma/ekonomik-yatirimlar";
	}

	@RequestMapping(value = "/ekonomikYatirimSil")
	public String ekonomikYatirimSil(@RequestParam("id") Long id) {

		ekonomikYatirimService.delete(id);

		return "redirect:/kirsal-kalkinma/ekonomik-yatirimlar";
	}

	@RequestMapping(value = "/ekonomikYatirimVazgec")
	public String ekonomikYatirimVazgec() {
		yatirim = null;
		return "redirect:/kirsal-kalkinma/ekonomik-yatirimlar";
	}

	@RequestMapping(value = "/ekonomikYatirimRapor")
	public String ekonomikYatirimRapor(@CookieValue(value = "id", required = false) Long id, ModelMap model) {

		if (id == null) {

			// JOptionPane.showMessageDialog(null, "Mesaj");
			// JOptionPane optionPane = new JOptionPane("L�tfen giri� yap�n�z...");
			// JDialog dialog = optionPane.createDialog("Uyar�");
			// dialog.setAlwaysOnTop(true); //
			// dialog.setVisible(true);
			return "redirect:/anasayfa";
		}

		model.addAttribute("title", "Ekonomik Rapor");
		model.put("tumListe", ekonomikYatirimService.tumYatirimListesi());
		model.put("ilceler", ekonomikYatirimService.ilceListesi());
		model.put("kategoriListesi", ekonomikYatirimService.kategoriLisetsi());
		model.put("etapNoListesi", ekonomikYatirimService.etapNoLisetsi());
		model.put("projeAdListesi", ekonomikYatirimService.projeAdListesi());
		return "KirsalKalkinma/EkonomikYatirimRapor";
	}

	@RequestMapping(value = "/xlsxExport", method = { RequestMethod.GET })
	public ModelAndView xlsxViewExport(HttpServletResponse response,
			@RequestParam(value = "etapNo", required = false) Integer a,
			@RequestParam(value = "ilce", required = false) String ilce) throws UnsupportedEncodingException {
		response.setContentType("application/vnd.ms-excel");
		if (null != a) {
			Genel.raporTuru = "etapNo'ya G�re Rapor";
			response.setHeader("Content-disposition",
					"attachment; filename=" + a + ".Etap_" + "Yatirimlar_Listesi" + ".xlsx");
		} else if (null != ilce) {
			String fileName = URLEncoder.encode(ilce + "_�lcesi_" + "Yatirimlar_Listesi", "UTF-8");
			response.setHeader("Content-disposition", "attachment; filename=" + fileName + ".xlsx");
		}

		else {

			response.setHeader("Content-disposition",
					"attachment; filename=" + "Ekonomik_Yatirimlar_Listesi" + ".xlsx");

		}
		return new ModelAndView("xlsxView", "yatirimlar", yatirimListeleri(a, ilce));
	}

	public List<EkonomikYatirim> yatirimListeleri(@RequestParam(value = "etapNo", required = false) Integer etapNo,
			@RequestParam(value = "ilce", required = false) String ilce) {

		if (etapNo != null) {

			return ekonomikYatirimService.etapNoyaGoreListe(etapNo);

		} else if (ilce != null) {

			return ekonomikYatirimService.ilceyeGoreListe(ilce);
		}

		else {

			return ekonomikYatirimService.tumYatirimListesi();
		}
	}

	@RequestMapping(value = "/ilcelereGoreListele", method = RequestMethod.GET)

	public @ResponseBody String doView(ModelMap model, Map<String, Object> map,
			@RequestParam(value = "ilce", required = true) String ilce, HttpServletRequest request,
			HttpServletResponse response) {

		Gson gson = new Gson();

		return gson.toJson(ekonomikYatirimService.ilceyeGoreJSON(ilce));

	}

	@RequestMapping(value = "/etapNoyaGoreGetir")
	public String etapNoyaGoreListesle(@RequestParam(value = "etapNo") Integer etapNo, ModelMap model) {
		if (yatirim == null) {

			yatirim = new EkonomikYatirim();
		}

		try {
			model.put("ekonomikYatirim", yatirim);
		} catch (Exception e) {

			model.put("errors", e.getMessage());
			return "error";
		}

		model.put("title", "K�rsal Kalk�nma");
		model.put("tumListe", ekonomikYatirimService.etapNoyaGoreGetir(etapNo));
		model.put("ilceListesi", yerEklemeService.altTipGetir(2l, true));
		model.put("kategoriListesi", ekonomikYatirimKategoriService.tumEkonomikYatirimKategoriListesi());
		model.put("durumListesi", ekonomikDurumService.tumDurumListesi());
		model.put("tusYazisi", tusYazisi);
		tusYazisi = "Kaydet";
		yatirim = null;

		return "KirsalKalkinma/EkonomikYatirimlar";
	}
}
