package dao.kirsalkalkinma.gencciftci;

import java.util.List;

import org.json.simple.JSONArray;

import forms.kirsalkalkinma.gencciftci.GencCiftci;

public interface GencCiftciDAO {
	public void save(GencCiftci gencCiftci);

	public void delete(Long id);

	public GencCiftci gencCiftciGetir(Long id);

	public List<GencCiftci> tumGencCiftciler();

	public List<GencCiftci> ilceyeGoreListe(String ilce);

	public List<GencCiftci> kategoriyeGoreListe(Integer kategori);

	public List<GencCiftci> ilceListesi();

	public List<GencCiftci> kategoriListesi();

	public List<GencCiftci> yilListesi();

	public JSONArray ilceyeGoreJSON(String ilce);

	public Long ilceyeVeYillaraGoreKayitSayisi(Integer yil, String ilce);

	public List<GencCiftci> yillaraGoreListe(Integer yil);

	public List<GencCiftci> mahalleListesi();

	public Long kayitSayisi(Long kategori, String ilce, Integer yil, Integer sayfano);

	public List<GencCiftci> ilceVeKategoriyeGoreListe(Long kategori, String ilce, Integer yil, Integer sayfano);

	public Long ilceyeVeKategoriyeGoreKayitSayisi(Long kategori, String ilce);

	public List<GencCiftci> yaralaniciyaGoreBul(String yaralaniAdi);
}
