Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:36612 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728161AbgE1JXX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 May 2020 05:23:23 -0400
Date: Thu, 28 May 2020 11:08:13 +0200
From: Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH 1/1] s390/pci: Log new handle in clp_disable_fh()
Message-ID: <20200528110813.7eb1fc1f@ezekiel.suse.cz>
In-Reply-To: <20200522183922.5253-1-ptesarik@suse.com>
References: <20200522183922.5253-1-ptesarik@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        boundary="Sig_/CQYNDMfSK8dU_Z=bSKKA6eJ";
        protocol="application/pgp-signature"
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org

--Sig_/CQYNDMfSK8dU_Z=bSKKA6eJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

just a gentle ping.

If the current behaviour (logging the original handle) was intended,
then it was worth mentioning in the commit message for 17cdec960cf77,
which made the change, but since that's no longer an option, I'd be
happy with an explanation in email.

Petr T

On Fri, 22 May 2020 20:39:22 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> After disabling a function, the original handle is logged instead of
> the disabled handle.
>=20
> Fixes: 17cdec960cf77 (s390/pci: Recover handle in clp_set_pci_fn())
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  arch/s390/pci/pci_clp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
> index ea794ae755ae..179bcecefdee 100644
> --- a/arch/s390/pci/pci_clp.c
> +++ b/arch/s390/pci/pci_clp.c
> @@ -309,14 +309,13 @@ int clp_enable_fh(struct zpci_dev *zdev, u8 nr_dma_=
as)
> =20
>  int clp_disable_fh(struct zpci_dev *zdev)
>  {
> -	u32 fh =3D zdev->fh;
>  	int rc;
> =20
>  	if (!zdev_enabled(zdev))
>  		return 0;
> =20
>  	rc =3D clp_set_pci_fn(zdev, 0, CLP_SET_DISABLE_PCI_FN);
> -	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, fh, rc);
> +	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, zdev->fh, rc);
>  	return rc;
>  }
> =20


--Sig_/CQYNDMfSK8dU_Z=bSKKA6eJ
Content-Type: application/pgp-signature
Content-Description: =?unknown-8bit?q?Digit=C3=A1ln=C3=AD?= podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHl2YIZkIo5VO2MxYqlA7ya4PR6cFAl7Pf30ACgkQqlA7ya4P
R6edXgf/SOTHcC+zEGL/Nw3PDeNRDhU7NJ22hTmyULZtqgAOGCBF5z1/6NtMD+wm
yIfS83Y687EmSkHSGj/w9WQ48F75dUxXGVVjyGcKMaAbe1e3gjqTnsQ5mI0zHU0O
786+7AI+sviai9UeM+5xCaXriExgaMnSjhT98udUZSxXOsYC1WhtBctvVJvLjFog
TsmDdNytv74TgBEN2e2HZmxyrHUSk6lPVF3YNpvxg33WUo2s435tP+He7ePYfKY2
BdxJcweVTPyffg5RFAaij9JbCXga2aologtPCAb1DX5rtRMZt7rorj/XV0DZho7j
fEvIUMezalXdzQrtt31pq2kB/3ni3w==
=71b3
-----END PGP SIGNATURE-----

--Sig_/CQYNDMfSK8dU_Z=bSKKA6eJ--
