Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445287;
	b=Z7CHlyukcMxwQu5XXm4IiXx3VOh1ND6eG/x2uhAI7FXSjTos7mK4D0X3hSwtKlZ586ff
	 ZEb0zuxJ0l3fTFct2nVJWs+l50DKD7giOGbSSlAdUrsCBdTktN4FhyHls69YRTAYMZX8Z
	 A5X24uA+ddy3CJX0/XwV4dcLiF+j/fUqKcb8gy5N0urYdPRcWUAQJYENVV1XJyt9/W7fv
	 tXg5Hxg8kxECdHdFtmygT4XU1xtTKsKXDoQ9jDqVWLh9r9368G1ep4zBAtzGIDM3ewcLk
	 8XEtXkkghZt1zTZoPI5YJ3wvqNhFbzS2/j0FmzgENgthJFBoheykKFKLYoNPwCJZusQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445287;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HkpXxiSZTlh7fXkCO3+RuI4CwD2Bzrm1kYxAB6nCR5E=;
	b=AVh5+eJqO+PKXP4FjaCsmhOIoplNaCQB2+68E6BU8DcnTtPGOdUvAQz4TQZtIqJeV+qi
	 0hB353CWYHw1InjDZYtQWcHDQXq/v262rGjGcwjyytF8yigjFAgznPdz5j2GTSFBs53q+
	 OHsmyCPlYLDIPyWrbiw3n8HmhL72IUYJtUmNMISd4H6OdVyhouQmMqBDN9lbc0gBDR55n
	 GQxDbbajUEOs2PKzVv8e1n40DF8mFBzbe13JNmS2SdIh5L5x7uOMpwc1N1B0bk4vTISG0
	 eNbAm2cCaMlLIp0CUJEJDHfZXHggR3e4QrU934dAw7I5lsIF2//GKojDi8TBlSN0ApQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=qkSPYaBq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=b4XgKy4U;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C08606A33F
	for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2026 14:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69C08606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=qkSPYaBq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=b4XgKy4U
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 81BC77A061B
	for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2026 09:48:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 09:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795445283;
	 x=1795531683; bh=HkpXxiSZTlh7fXkCO3+RuI4CwD2Bzrm1kYxAB6nCR5E=; b=
	qkSPYaBqJFjIIFDsP01k1LpMzE8/KTsvRDRm+jjMwxQJJihplhuQ7IlFJWB6+C/A
	iqe13I1ROWll+tdL69vKf9hszxl3qbHTC6YUX5+pmCB0kbfNqEhhfeSu2BUlR2B/
	QSvyBYUUKVxpNl5bcmeQ5u+aImB4eS5LYnjyQrviNIl2I/XYEoX82ty5CFQ7GtDI
	8pajH0DPnFTW56gEm+QDYCO7ytdX7p+hXAsN0M9NP7FX4ppu3gmYB6+mADwsdwaR
	EnnTo2i7ahjcHQUTfx6CxDxAcXFNAQtKJlSigQ6XgHkffPw8i96EhN/kzP4EYeex
	nwoLASciezxWwobVdP5Q1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795445283; x=
	1795531683; bh=HkpXxiSZTlh7fXkCO3+RuI4CwD2Bzrm1kYxAB6nCR5E=; b=b
	4XgKy4Uz6dz/v4nAqcvjDF6eAgVCuE1pDLoWFnS7DPBEl3BA7WRufLD5OHjVDSxT
	QpURJKKHWwb6jvnhGaQAV3avB95QRc7BKX4ezVkBq6xQ/OtxWq8qFn3ZObwcjndd
	4uA1ZX+05kzRLA8kl59RNECOeZ6WPbmzy48Iv/4RfKVm+yum4o4hmSWunKScc+nE
	QICd6NCada8BWPoNJyBno1RzqiaksZf6HpyXljuiBTe3mj4RLtibOZUqJOdpJfrZ
	1k1+TMcCZDnnydaIVhxyVG2JSEmPe8b8eByGUjysMVrl6A81hkMICwJ7nfND75vY
	D2qyIIfQIzj0At/2r3M8g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795445283; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXMzOTBAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:NcbdAcN/kQ7sf7+zbgClhgyOktUn/WFEC+KLMEL8WWVgprb
	CzfkmhnT6ACyiQVBsBAUWlXRVKALYFZUIvPzh585TtsuAwgt/a0yfOeA98JFyMtv
	zIeKiH/ilXIYkTBEbST+QpMTG5TC0wjwG6IfKwVmv4sB8+7Yia4K3gV3bO1mLekE
	Gw0Hr5NKQMcAeMLnrrZYqkwHrW0TKaSC1BAX2jc4xfIYvryT0MsCES1QUN49NYO/
	lRQdI3MVcmhkU+Of6mDb8ipB3isEssEYnG0l7P9z6Afpm6Npm9Dnyj5fGc3oTSRY
	PBd23KTZ75sfeNdXTWQYtk8T3dwPHkkGYJnV9AQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dojbfzme1AoW9VoW1dPx6BoUKYHAYgWJs/IIdJHobNk=:LsHb1YBarwKSV7rYcVK2uOD1gJv9ja2ZNhrovA1YbBY=;
X-ME-Sender: <xms:I1IEa-yJOUqblV9oglbVtWESH0X99MKml2AIEkFAuEsBP9rg_eyhKg>
    <xme:I1IEaxMf3S5IqMbRldp9FNROxFOfD9TkZhFJVqlOT-HUnMgtwPC0_ti46J4wKddcK
    Xym5_ZznplFnM2ejLKd7zjAVKF9t1VD1H-qsUpRyohpy7s7ujfmcA>
X-ME-Received: <xmr:I1IEa1afhG_qfIxDcus3u_TSypHVlEd8E86IRC1hP4MXjhNmsDe8HcT-1MtZ1Q>
X-ME-Proxy-Cause: dmFkZTFWqpNLlzsnjyPjTVEowX2xW9//fqSJRj/9+HAUHYO63uC5rP7ltoSIxqyH6J+Nke
    /GS2vKVgs/JlQN7su7PeoeY89FyLEkYlp2Tj6O+LYbZox1tB2ITqyP6PHQJkLxIWhwHwpk
    PkDxtSvDyudfQoUCluF33K1szH9WXdlFFBwEOV+VPx5DbjqC0tKj4Vuxx/HyfEI5EMSZWj
    v2s9hsAoz4hUpMD3Dewxn/anKu3EbX6FmXxTMlbd7s8qBy9RWzPcT7OS/yGDCMmFNB32EE
    CZbXpRGSTIdI8yLzteQWL8qyNoWLFvMZeHXdmacFwVsVCCiCLmYzZA41zKC1KTDMuVy2GQ
    WlUW6Kkb/qQOf/YVrGW5iR72G76fbjeU71KCrWC/A3oLMTHGrH3cDGveCrwcDlimiajss3
    XLrThSJovkxIVR+7L4MN/5w/8XJgZZJq6ziPkXfNbw0SEdwxOOo1D4gbCNwxfYYvq8THoV
    JTYRqoixoHHXMhYxpqmyzaAh1XhBor5LlH6sw3IQ3bXQ+v5P+wARjvRIUo6EdF/19SDCyy
    XnJiiElZGUsObi97Y343pxOUHuLvbP+UzrP9RngRXdLnxTuXVARQDME1OtkMY5xqm69NKZ
    UW6+Qd3b571rMKge5cToqv+Dz6ByQ8FYUq771V41f9c5Kean5Wz3R2ExIaAA
X-ME-Proxy: <xmx:I1IEa7pTnT5HsNSrvr_WsdgFyd1O6D2dV8sZ5MctaxRJ0xdmRZGenQ>
    <xmx:I1IEa6y2DJhGWQuHxj0REjneUAnoiF02X8VvUuBgHPvNcnAZ3sbJGA>
    <xmx:I1IEa7Im6jSO6mw0WbqhHXXkmaVMZkXk3pn-fu2qSriyFSeEYqDWIA>
    <xmx:I1IEa06u2iGZWOUaeaeSBcXsH2ggErAb72I887fw5wdNMRn9neV2Vw>
    <xmx:I1IEa0lJVXHlmLcizkGgHTLOQtIhjHVR3PaB44EXs9t0kf20s_3LqlBa>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 09:48:01 -0500 (EST)
Date: Mon, 23 Nov 2026 07:48:00 -0700
From: Alex Williamson <alex@shazbot.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Tony
 Krowiak <akrowiak@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Holger Dengler <dengler@linux.ibm.com>, Vineeth Vijayan
 <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v2 04/10] s390/vfio: Allow untainted use of
 driver_override
Message-ID: <20261123074800.3b8904a6@shazbot.org>
In-Reply-To: <7ff78d9a05bbec91fd494938508c1567@linux.ibm.com>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
	<a53e12ad841fb18e45b3cf7a4580846943ed0c6d.1795171088.git.u.kleine-koenig@baylibre.com>
	<7ff78d9a05bbec91fd494938508c1567@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Nov 2026 14:55:36 +0100
Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 2026-11-20 12:11, Uwe Kleine-K=C3=B6nig wrote:
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
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > ---
> >  drivers/s390/cio/vfio_ccw_drv.c   | 1 +
> >  drivers/s390/crypto/vfio_ap_drv.c | 1 +
> >  2 files changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/s390/cio/vfio_ccw_drv.c=20
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
> >  static void vfio_ap_matrix_dev_release(struct device *dev) =20
>=20
> Please add the s390 zcrypt device driver ("cex4queue") to this patch:
>=20
> diff --git a/drivers/s390/crypto/zcrypt_cex4.c=20
> b/drivers/s390/crypto/zcrypt_cex4.c
> index 43871cd89b04..2765f82f32d6 100644
> --- a/drivers/s390/crypto/zcrypt_cex4.c
> +++ b/drivers/s390/crypto/zcrypt_cex4.c
> @@ -746,6 +746,7 @@ static void zcrypt_cex4_queue_remove(struct=20
> ap_device *ap_dev)
>   }
>=20
>   static struct ap_driver zcrypt_cex4_queue_driver =3D {
> +       .driver.support_driver_override =3D true,
>          .probe =3D zcrypt_cex4_queue_probe,
>          .remove =3D zcrypt_cex4_queue_remove,
>          .ids =3D zcrypt_cex4_queue_ids,
>=20
> and when done add
> Acked-by: Harald Freudenberger <freude@linux.ibm.com>

That's not a vfio driver, it needs to make its own case for why it
needs to support driver_override.  Thanks,

Alex
