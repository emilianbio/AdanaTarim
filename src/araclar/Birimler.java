package araclar;

public enum Birimler {

	ATTA("Arazi Toplula�t�rma ve Tar�msal Altyap�"), BITKI_KORUMA("Bitkisel �retim ve Bitki Sa�l���"), BALIKCILIK(
			"Bal�k��l�k ve Su �r�nleri"), CAYIR_MERA("�ay�r Mera ve Yem Bitkileri"), GIDA(
					"G�da ve Yem"), HAYVAN_SAGLIGI("Hayvan Sa�l��� ve Yeti�tiricili�i"), IMI(
							"�dari ve Mali ��ler"), KIRSAL_KALKINMA("K�rsal Kalk�nma ve �rg�tlenme");

	private final String birim;

	private Birimler(String birim) {
		this.birim = birim;
	}

	public String getBirim() {
		return birim;
	}

}
