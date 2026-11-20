Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183529;
	b=aNJwYV2OrjtUNMi8Kw+iivkxCPRlEkXqFbKs0GT+SoqBJCRF4u6hY1FHRJt7PzqisLdk
	 w/c8LW2pgi+G4gbLUnAp3m6zSokRNU4bsqjv4AVvjVY2nNtwmZQedtBaJGGJ1zyD6yek7
	 GN+Ow5tV7hFJyctUdNuQXSyeFI4dSapODDEdK0GcJLlqULvLeZx4T/keuyNWU5kNAa6k0
	 IfOD9q9AuWp4Lt3IpDpd+XVPUXuMDuEAzzIOKwcybSWQi2mBBkrd40914HxclbqxuvFRO
	 NqQs3rdDs93jiVHM7yyJ9DKd4wVjC8E6t8srOJr3akmNs5vUCQzKi8dvLhdfpACSrdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fKhA2P1ewRK9WeXDzZdZmZPm69l3JUWOOFfVIt+9Bkc=;
	b=eBQNhtuyYqe41qvKNaJLP3/VpRNgFIJ1AC/Y4K6oZSmiQWJPDtq6JMg43GrTFiYVAbvL
	 yqY9fOjbegLjkaykqJt7z1jrCVzVh8G7GsfJsf5UdOKKbpW7a3xBWmJj7NHuRvB2tMSOX
	 fr6uuG5I/HELzEHrW91MG901Zzs7iz+QetxrU8ZP4tbICJCOfKoCy5+puGQMyS+9ycb+j
	 ENgkBLSjXrpR239wkT5dBK43KlXzauZAqjRC3dGXHJs3kDeGP+lnfU29jKgrhaIKBFYfx
	 /awgYiyxtviQfmE3CFDamJz4Siptiy/jrIj9sNqh23Zf9jyI1hssgDMz16J7NvSq9Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mgy+KYAs;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49616606A325
	for <linux-s390@vger.kernel.org>; Fri, 20 Nov 2026 14:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49616606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mgy+KYAs
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a358881793so468527f8f.0
        for <linux-s390@vger.kernel.org>; Fri, 20 Nov 2026 06:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795183526; x=1795788326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fKhA2P1ewRK9WeXDzZdZmZPm69l3JUWOOFfVIt+9Bkc=;
        b=mgy+KYAsx2ff/GlyARPQpLRhQzn1hTsj8RK0oyJ0U8IDIi3i2Ekd/L1lS57GTgj9F9
         z6lwEGryBnNdQameZM/LfHBIk/8jIxMAWWq2Z+S+4TpaPKBlrEQ2lY/YnyTEGI6asLeB
         23h1laoP9T4eKxyOErBq0FM+calCa3sB+SuGSJRnbuuGTX+OGqUSWrREi2K77ziAI7f7
         ujfivtk4m6rgNgAVjwUzkCg2MU2wljjLiJ3W2QR3xZnenxfm5X81ksIwkI9yo/AKO1I8
         n46Yb7BUZWimfV5xlZsukbZUxn54wPvDowc7uFuc4mA80QcPmJqX62E1xThV33+zJ39h
         m2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183526; x=1795788326;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKhA2P1ewRK9WeXDzZdZmZPm69l3JUWOOFfVIt+9Bkc=;
        b=aVKJ7xhqA1JziHZVIxF8rgsKZGDn3/gjRycZOVy3QMf7lfGaqkzITAQ3SyOlRsrypD
         pmgJD1o188Vq9jE1ODAJeQFUaquEM/DTX6Q/FLY6PYkd6OGb7/EWUBg8Fwe++yljfDEp
         q2eNLs472JEL9FvdfRMK9+AvPiCrd13l6fBPm/bU1feIzfVcRNb7rDtAkP3q8CPsi8na
         kA6CZI9zGszT2ffbjygQIMRTjUiJAriAflnh0gIiJmh9RgoeEFGLMwDTcuJQyGCebViT
         Y7F6hB6JJq7/xICxq6hA0ou0n2MgZFfUKoU4Msg8KZyrlMdXeop/FWN9tGJOi2oibe5N
         uxrw==
X-Forwarded-Encrypted: i=1; AL+hErEaMVEcYtJgMREw7oDCvdfUerjsLueotxrzCjqtWtwaJ+LGD96f6OXJ5OAvZiU2ebFQ/mCe+s9kD8We@vger.kernel.org
X-Gm-Message-State: APuU4Z8q5CajG/y1NhWB9VvRFV4NoL42h/sla6R1ehdPWtIgXbQpoJUE
	3/WvlS+VPDmh+th0s/KkcwrFk5WJbA/SfqjghzuM08bMSKCg7Gu0OKIWObCjbt7/ufg=
X-Gm-Gg: AZFdTZdCNAM6IqWLbH7Ql+lyrllpGYvZdgbbIlS/d+o596D9ow3WUVqz/KeeCNQtcPy
	VnAq0Avz0z2+gfRlLrL5C5gXET0pEAxsUljYmIVZVBaW0e875clVPBKuw/nPqMJC21re6Se1+Hl
	VuhVQOTb7P4KyovVu9wngqvIZ0O4L/CSBmoEdlRG12xm1FYHFlW0lg927xEtG76k1Fjahdngvhl
	Sd6W58bjvXSx94kvfHMgasWgTM7YvclM/IA1xRHznxsTwjQHwlA6ovqFMtFXR/E7CfGuB4PyT5J
	z5z1KZUlh6lZJBqs4/kO7oXVmKSF4QyOelCwDAfzv81syU+UGEhg3OyZ1P6uOmLkTmD9/owmgWg
	Dn6VLnmNBgAiLCxP3IcID30JKOOO5Gj1WRSYKR73Czp2cQHH1jhsUPmPj7PnREk4R5+kujtffc2
	JxgsiAcWYQK9c10QJOyjJcSUg5gTKnOz1nhbei8Q11w0ZxMCuQMC8vGiWWxwDlTySgVXRdYyAv3
	Uw6E41+DbxBexIZQpH+KgdZ/JBSAyQdNK8iY5P0SL51e6Qx9GIOghcXKKaP879vscQlNjt2s+Ti
	emxR8EIaNs7Rt2+tX8igAoTrMNhvuae8sMqNV8SezBQm1aDX8nfa6rhmwnL6cFaUR2+Nr5Tb2sD
	mH03I/nrvOWL7SgFI+Li1FcQ+QFdVDJ2VAIBmHac=
X-Received: by 2002:a05:6000:29d2:b0:4aa:831a:d0eb with SMTP id ffacd0b85a97d-4abb3c37a50mr4536615f8f.9.1795183526458;
        Fri, 20 Nov 2026 06:05:26 -0800 (PST)
Received: from localhost (p200300f65f19a9041d3eb07d772156f3.dip0.t-ipconnect.de. [2003:f6:5f19:a904:1d3e:b07d:7721:56f3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6c4353d6sm5825284f8f.56.2026.11.20.06.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:05:25 -0800 (PST)
Date: Fri, 20 Nov 2026 15:05:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Tony Krowiak <akrowiak@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
	Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 04/10] s390/vfio: Allow untainted use of
 driver_override
Message-ID: <awBSb7VOGyCCBDv2@monoceros>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <a53e12ad841fb18e45b3cf7a4580846943ed0c6d.1795171088.git.u.kleine-koenig@baylibre.com>
 <8548e9504ec70bec02c6f2cebf69ea91@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5kdjss4jszejxnb"
Content-Disposition: inline
In-Reply-To: <8548e9504ec70bec02c6f2cebf69ea91@linux.ibm.com>


--z5kdjss4jszejxnb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 04/10] s390/vfio: Allow untainted use of
 driver_override
MIME-Version: 1.0

On Fri, Nov 20, 2026 at 12:58:52PM +0100, Harald Freudenberger wrote:
> On 2026-11-20 12:11, Uwe Kleine-K=F6nig wrote:
> > From: Alex Williamson <alex@shazbot.org>
> >=20
> > The vfio_ap and vfio_ccw drivers bind devices through driver_override.
> > With the introduction of the support_driver_override flag in the core
> > driver struct, it's now required for drivers to declare themselves as
> > driver_override compatible, otherwise driver_override bindings will be
> > denied or generate a kernel taint.
> >=20
> > Set the support_driver_override flag on the vfio_ap and vfio_ccw driver
> > structs.
> >=20
> > Signed-off-by: Alex Williamson <alex@shazbot.org>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
> >  drivers/s390/cio/vfio_ccw_drv.c   | 1 +
> >  drivers/s390/crypto/vfio_ap_drv.c | 1 +
> >  2 files changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/s390/cio/vfio_ccw_drv.c
> > b/drivers/s390/cio/vfio_ccw_drv.c
> > index 7546bd137e4e..77765cde87f7 100644
> > --- a/drivers/s390/cio/vfio_ccw_drv.c
> > +++ b/drivers/s390/cio/vfio_ccw_drv.c
> > @@ -375,6 +375,7 @@ static struct css_driver vfio_ccw_sch_driver =3D {
> >  	.drv =3D {
> >  		.name =3D "vfio_ccw",
> >  		.owner =3D THIS_MODULE,
> > +		.support_driver_override =3D true,
> >  	},
> >  	.subchannel_type =3D vfio_ccw_sch_ids,
> >  	.irq =3D vfio_ccw_sch_irq,
> > diff --git a/drivers/s390/crypto/vfio_ap_drv.c
> > b/drivers/s390/crypto/vfio_ap_drv.c
> > index 8e69ed286bb9..2d47dc643269 100644
> > --- a/drivers/s390/crypto/vfio_ap_drv.c
> > +++ b/drivers/s390/crypto/vfio_ap_drv.c
> > @@ -62,6 +62,7 @@ static struct ap_driver vfio_ap_drv =3D {
> >  	.on_config_changed =3D vfio_ap_on_cfg_changed,
> >  	.on_scan_complete =3D vfio_ap_on_scan_complete,
> >  	.ids =3D ap_queue_ids,
> > +	.driver.support_driver_override =3D true,
> >  };
> >=20
> >  static void vfio_ap_matrix_dev_release(struct device *dev)
>=20
> Hm, honestly I don' get this...
> The driver_override is a bus thing. So the AP bus has support for
> driver_override.

Yes, and ap_device_probe() calls device_match_driver_override() which
requires .driver.support_driver_override to be true to make the override
work.

> The sysfs functions are in drivers/s390/crypto/ap_queue.c. There exist
> currently
> two drivers which shall be bound to an AP queue: vfio_ap and the default
> driver
> which is the zcrypt driver "cex4queue". It sounds like the driver needs t=
he
> tagging about driver_override support and then similar to the vfio_ap_drv=
=2Ec
> the static struct ap_driver initialization may also need a
> .driver.support_driver_override =3D true line.

Can you please talk in form of a patch? I have difficulties following
your words. (Hint: "the driver" is ambigous if you just talked about two
different ones. Also what is "the static struct ap_driver
initialization"?)

Alternatively something like: "I tested you changes and the xyz driver
fails to bind, this is the respective kernel output: ..." would be
welcome, too.

Best regards
Uwe

--z5kdjss4jszejxnb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsAU6IACgkQj4D7WH0S
/k6tMAf8CzB6okqp49LE9R3aOA1LqPPI2LOhdKWbHnK474C/TId/TESJtb6NeK9a
/TiJzbw0cMmiZBWFX98POZtuxPs/p7E267I4HIiVSkJZbXIMTQLgRtNAwzQ2XHSG
hGC6bCl/mo8FvF7Wgh4UDmKJf0ouYsnKSngydVHdAMge9AWdPLAwV/Mt22qoUPuf
zTO+MmKjQ5gYxdV5B/bA6zHB3m9WhdotEJsK3fJqNr4Ey2gMKsfBSPhfX++rkr2K
rLeBF3pOWEtGt96JPSOKF9uBsbrRdGNL/hRINeFMxcqFG2dqs07zOz+X5FKWSzH3
Ba2MDNVrii6e5LmWPrJUf6CRttkdJw==
=kxW2
-----END PGP SIGNATURE-----

--z5kdjss4jszejxnb--
