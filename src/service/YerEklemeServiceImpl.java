/**
 * 
 */
package service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.YerEklemeDAO;
import forms.Yerler;

/**
 * @author Emrah Denizer
 *
 */
@Service
public class YerEklemeServiceImpl implements YerEklemeService {
	@Autowired
	YerEklemeDAO yerEklemeDao;

	@Override
	@Transactional
	public void ekle(Yerler yerler) {
		yerEklemeDao.ekle(yerler);
	}

	@Override
	@Transactional
	public List<Yerler> tipGetir() {
		return yerEklemeDao.tipGetir();
	}

	@Override
	@Transactional
	public List<Yerler> altTipGetir(Long Id, Boolean durum) {
		return yerEklemeDao.altTipGetir(Id, durum);
	}

	@Override
	@Transactional
	public Yerler tipsGetir(Long id) {
		return yerEklemeDao.tipsGetir(id);
	}

	@Override
	@Transactional
	public void tipsil(Long id) {
		yerEklemeDao.tipsil(id);
	}

	@Override
	@Transactional
	public void kaydet(Object nesne) {
		yerEklemeDao.kaydet(nesne);
	}

	@Override
	@Transactional
	public Integer calistir(String sorgu) {
		return yerEklemeDao.calistir(sorgu);
	}

	@Override
	@Transactional
	public Object getir(Long id, @SuppressWarnings("rawtypes") Class sinif) {
		return yerEklemeDao.getir(id, sinif);
	}

	// @Transactional
	// public boolean katidVarMi(Long katId) {
	// return sabitTipsDAO.katidVarMi( katId);
	// }

	@Override
	@Transactional
	public boolean isimVarMi(String isim) {
		return yerEklemeDao.isimVarMi(isim);
	}

}
