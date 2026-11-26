Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795687293;
	b=5aehLJpvZzBfEaJ4rGxUO+Z3kGKrtsclMMUM6bIuML7VPubaYt3WBe/YPMPrP9q/8GIm
	 G3UkX3rRUgXsAi2xfsPz8D0pasyXAhVB6hVwUV1xu8wqgxpnl4KMkHTpSCtKJueKGBDM7
	 UvZSsiC1rEvX9ODFO5t64ZzE3HyznNghqcuGtNVF+aEdPP7n+gyzCg2l4ao8bRims5V7Y
	 hIlTFMUjZK0G9k1pt3q8M2IcirBYX2nsgkF3J78Nc22K1owNQMw3xfCCJFHFkLEFNYVhA
	 yi56ebBLgb9wk1lDx8HBbNmghzYsihDTmI9B1HO+Zj60wi6KuhO8sVmSboXP87LOUeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=IE4vJNtDrjSOx42gXrRhxBPgcFtTEsu/EfpzX8MjBBA=;
	b=vDPZZdcwO6LphVSef1WDImwCnjFkFN7oG6P2RJKObfGdBtYLerPs4Pa9KNXlFG893zRi
	 43IPw4qV+tDzPhrY1OiDmdfwTse/Unx6ilvX2v5zf6ilXheKPADxJzYfbjl/ZtvJ2XgjB
	 mfUtg/l/b8AFBzm3aiA21sjltHfew3gXdqywYWkD6WqsgayCsjFWCxCuJjIwkoq+TMWvo
	 FT64k2JunxRPEWiHg+H7wy09MjM50ubKnxwVXqWI69DZ+Wuog0dv7CPMs5ByFir1eDkRh
	 Anu+c19KTOfpydDtiPA4bki5C5Kzbp/F8tANTRF8vnUiGDbS0ebLoyHxU1dVjWDJJBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=O2WjR9Lq;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F72606A68E
	for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 10:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38F72606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=O2WjR9Lq
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so72365715e9.0
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 02:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795687290; x=1796292090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IE4vJNtDrjSOx42gXrRhxBPgcFtTEsu/EfpzX8MjBBA=;
        b=O2WjR9LqHTmBY4T78LYhY10aGLlSBHjqe8vQObQpmsK1yWvivvEsw/2T8FTQXuog1i
         4XY1mHx2N0QxEFliXP6nF0pLi4UITY73RoCzKpB41Lf3e8pUl9R/F2HInFEJ08NAsQSQ
         kHewxC1jAfqqRe4pEPMGqYl+JLYMVNdvnkP1yXe4gBY4uMK2bDaFGtd+Sg3macbnY1hB
         Ttk0rT2sQpJ9Cz72Oh5Q6oHwCY1wcWrGcVzQHHAzgrZwIvje5jWA3xKKS6JD2Uu7F1n3
         H1s7kg541B3zGzMpw4s6WAksbkAiiwePY5Se4ofT29WdHfEWe2Nr56KXsA8E/pF3up87
         ffAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795687290; x=1796292090;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IE4vJNtDrjSOx42gXrRhxBPgcFtTEsu/EfpzX8MjBBA=;
        b=YjA/PvFTaC5E8XT9FTBlUi464YxNCkPAFSCdzO3c+gTW7JuJDaNehUDEJO8y/6cBJj
         f+nYLMUYRM19rv1ZVOLIvZ9ymQ7X4LRHc/gkXo3pM5cpU0VTUMfhKC1f9K8j6fmr9nbw
         DQGcYwtAYI2uuwEYpZ3VNAq8++0DCjkbKiPUfx6XMUHxgDuNaDtSXxoWHsnkQ66/7dSi
         WcwLG4559XKJQ6+XOgOguEBPAqPVUBnox6PrcilWe3He++38sOsudfxeGZwepBH9gzwv
         oP+Xd9Htsz70epdPYKxCBd8jDn1V4aYQOuUwlQkyJhQzZ9mxxb1qrfQ95BmXiE8CkqCE
         5xag==
X-Forwarded-Encrypted: i=1; AL+hErGaZuAB/u9+FziuYfEyJXh2H/thu031I4ENUiZczbinuK3Nv6YZY2BZDRd+HYAbcx7A2BgU1CQqmrO3@vger.kernel.org
X-Gm-Message-State: APuU4Z8P6ocbuG1V3a3yyas6Zk9XWXjStiMIkrwXE/z155KZKuqE9wmJ
	T2wZUi9OhASGvzwWOT/gDmHYQd5kjL7Scigp8SMW4OThgnkbpjliLxSPeLKR55G5j3A=
X-Gm-Gg: AZFdTZetOQw2IWcqq1sFK1OHFyWu1Q+vPsJudTTTaLaBV/ooPi4A6aM7DxmM+RhXBb1
	tQCCw0HTGNeCWbr9Ey0jeAJ9WpymkWfGRxb3KuTJJC3toRaDUBkaZVizHXdlpfVaHH+9FzUVm4j
	MVr8Y9N1YkSRukIS83x42k0Rng7OqL8Xs057Yxpg24VZ+wmdFMNYtMkrH0zBQ3zuZl9DJN6h9am
	8He6lSYe+XaWGF06K5pVCTAvF12NtsgDbXRoAq3YPou0c8cU+sFtW2VRz/+P0L7ANbXAUsif2wM
	1W+4zB/fywnyq0WvPKUivLcz6Jayste+ed4gjs7RDlQWCsGEnmvzEmJv/GBCuwMHmPW1K4KnDfW
	hrSXgzsDed4TvOosNNAOwLU9u7yzAHDRQn2f+kGM3SJZEkUCNb7nnSSqbY8wuUFeGzarx1ywO2b
	Pls5rgmnJWjXEod5EmdDX9qWc82WAPZLa4OjuYWRvHTxJe0ahUalQVqj2qwnZ+mtjwDTuNE6MuX
	1fUIasiWep4mc1Sj36KL+6lR/65CitWBf1ydmH+nxUnk+ti2MpBcFbVIZx5uM56XwJb/t7rAt4x
	Iv6R1aqWgfkFJATMuqP/quFfpKO7vkQTDi1hNIhgb9Fjv0LjEtH5/yXij22/x8Zd3W0ORTPPLM/
	Nih+yPzZf8gqadyDD
X-Received: by 2002:a05:600c:674b:b0:4b2:61e5:b2f4 with SMTP id 5b1f17b1804b1-4bb8880f25cmr392255985e9.11.1795687289896;
        Thu, 26 Nov 2026 02:01:29 -0800 (PST)
Received: from localhost (p200300f65f19a904c63bf6e24e86c251.dip0.t-ipconnect.de. [2003:f6:5f19:a904:c63b:f6e2:4e86:c251])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb85399d52sm571521595e9.6.2026.11.26.02.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:01:29 -0800 (PST)
Date: Thu, 26 Nov 2026 11:01:28 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Farman <farman@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, 
	Jason Herne <jjherne@linux.ibm.com>, Holger Dengler <dengler@linux.ibm.com>, 
	Alex Williamson <alex@shazbot.org>, Vineeth Vijayan <vneethv@linux.ibm.com>, 
	Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 04/10] s390/vfio: Allow untainted use of
 driver_override
Message-ID: <awgBZ4vKmsLzU2qo@monoceros>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <a53e12ad841fb18e45b3cf7a4580846943ed0c6d.1795171088.git.u.kleine-koenig@baylibre.com>
 <8548e9504ec70bec02c6f2cebf69ea91@linux.ibm.com>
 <awBSb7VOGyCCBDv2@monoceros>
 <7008c5ea-58fd-4452-a70a-2162cc3d562b@linux.ibm.com>
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
	protocol="application/pgp-signature"; boundary="smgcc6baxzd5hjo2"
Content-Disposition: inline
In-Reply-To: <7008c5ea-58fd-4452-a70a-2162cc3d562b@linux.ibm.com>


--smgcc6baxzd5hjo2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 04/10] s390/vfio: Allow untainted use of
 driver_override
MIME-Version: 1.0

On Mon, Nov 23, 2026 at 05:31:42PM +0100, Christian Borntraeger wrote:
> Am 20.11.26 um 15:05 schrieb Uwe Kleine-K=F6nig:
> > On Fri, Nov 20, 2026 at 12:58:52PM +0100, Harald Freudenberger wrote:
> > > On 2026-11-20 12:11, Uwe Kleine-K=F6nig wrote:
> > > > From: Alex Williamson <alex@shazbot.org>
> > > >=20
> > > > The vfio_ap and vfio_ccw drivers bind devices through driver_overri=
de.
> > > > With the introduction of the support_driver_override flag in the co=
re
> > > > driver struct, it's now required for drivers to declare themselves =
as
> > > > driver_override compatible, otherwise driver_override bindings will=
 be
> > > > denied or generate a kernel taint.
> > > >=20
> > > > Set the support_driver_override flag on the vfio_ap and vfio_ccw dr=
iver
> > > > structs.
> > > >=20
> > > > Signed-off-by: Alex Williamson <alex@shazbot.org>
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > > > ---
> > > >   drivers/s390/cio/vfio_ccw_drv.c   | 1 +
> > > >   drivers/s390/crypto/vfio_ap_drv.c | 1 +
> > > >   2 files changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/drivers/s390/cio/vfio_ccw_drv.c
> > > > b/drivers/s390/cio/vfio_ccw_drv.c
> > > > index 7546bd137e4e..77765cde87f7 100644
> > > > --- a/drivers/s390/cio/vfio_ccw_drv.c
> > > > +++ b/drivers/s390/cio/vfio_ccw_drv.c
> > > > @@ -375,6 +375,7 @@ static struct css_driver vfio_ccw_sch_driver =
=3D {
> > > >   	.drv =3D {
> > > >   		.name =3D "vfio_ccw",
> > > >   		.owner =3D THIS_MODULE,
> > > > +		.support_driver_override =3D true,
> > > >   	},
> > > >   	.subchannel_type =3D vfio_ccw_sch_ids,
> > > >   	.irq =3D vfio_ccw_sch_irq,
> > > > diff --git a/drivers/s390/crypto/vfio_ap_drv.c
> > > > b/drivers/s390/crypto/vfio_ap_drv.c
> > > > index 8e69ed286bb9..2d47dc643269 100644
> > > > --- a/drivers/s390/crypto/vfio_ap_drv.c
> > > > +++ b/drivers/s390/crypto/vfio_ap_drv.c
> > > > @@ -62,6 +62,7 @@ static struct ap_driver vfio_ap_drv =3D {
> > > >   	.on_config_changed =3D vfio_ap_on_cfg_changed,
> > > >   	.on_scan_complete =3D vfio_ap_on_scan_complete,
> > > >   	.ids =3D ap_queue_ids,
> > > > +	.driver.support_driver_override =3D true,
> > > >   };
> > > >=20
> > > >   static void vfio_ap_matrix_dev_release(struct device *dev)
> > >=20
> > > Hm, honestly I don' get this...
> > > The driver_override is a bus thing. So the AP bus has support for
> > > driver_override.
> >=20
> > Yes, and ap_device_probe() calls device_match_driver_override() which
> > requires .driver.support_driver_override to be true to make the override
> > work.
> >=20
> > > The sysfs functions are in drivers/s390/crypto/ap_queue.c. There exist
> > > currently
> > > two drivers which shall be bound to an AP queue: vfio_ap and the defa=
ult
> > > driver
> > > which is the zcrypt driver "cex4queue". It sounds like the driver nee=
ds the
> > > tagging about driver_override support and then similar to the vfio_ap=
_drv.c
> > > the static struct ap_driver initialization may also need a
> > > .driver.support_driver_override =3D true line.
> >=20
> > Can you please talk in form of a patch? I have difficulties following
> > your words. (Hint: "the driver" is ambigous if you just talked about two
> > different ones. Also what is "the static struct ap_driver
> > initialization"?)
> >=20
> > Alternatively something like: "I tested you changes and the xyz driver
> > fails to bind, this is the respective kernel output: ..." would be
> > welcome, too.
> So let me try to translate
> On s390, driver_override is how a device moves
> between the host and a guest, in both directions:
>=20
>   driverctl -b css set-override 0.0.0004 vfio_ccw        # to the guest
>   driverctl -b css set-override 0.0.0004 io_subchannel   # back to the ho=
st
>=20
>   driverctl -b ap set-override 17.0005 vfio_ap           # to the guest
>   driverctl -b ap set-override 17.0005 cex4queue         # back to the ho=
st
>=20
> Your series keeps the first direction working but breaks the second
> one, because io_subchannel_driver and zcrypt_cex4_queue_driver do not
> set support_driver_override. On the AP bus this is unwanted:
> driver_override and apmask/aqmask are mutually exclusive
> (46030379f13c "s390/ap: Restrict driver_override versus apmask and
> aqmask use"), so once overrides are in use there is no other way to
> assign a queue to zcrypt.
>=20
> We want to keep the way back working, and there is no reason not to.
> The problem patch 1 addresses, i.e. a driver being forced onto a
> device it was never written for, cannot happen on these two buses:
>=20
> - css_bus_match() still requires the driver's subchannel_type to match
>   after the override matched. This was a deliberate design decision
>   when driver_override was added for css (ebc3d17915034 "s390/cio:
>   introduce driver_override on the css bus": "unlike pci we still
>   require a driver override to match the subchannel type")
>=20
> - ap_bus_match() always does the device type match. driver_override
>   only decides in ap_device_probe() which of the matching drivers
>   gets the queue, and the AP bus handles an override to the default
>   driver explicitly (ap_owned_by_def_drv()).
>=20
> So on css and AP, driver_override never force binds anything. It only
> selects between drivers that already match the device, and
> io_subchannel and cex4queue are the regular drivers for exactly these
> devices. They are unbound and rebound every time a device moves to
> vfio and back.

Ah, understood better now. Feels like a misuse of driver_override to me
and because the ap_bus's usecase doesn't match the intention of
driver_override, keeping the bus working is strange as it exposes this
difference.

Without having checked all the details, I wonder if something like that
would be the more robust change then:

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index efd3df3e90ba..2d07bca149cc 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -1398,6 +1398,15 @@ static const struct bus_type css_bus_type =3D {
 int css_driver_register(struct css_driver *cdrv)
 {
 	cdrv->drv.bus =3D &css_bus_type;
+
+	/*
+	 * The driver_override mechanism provided via sysfs is used in a
+	 * non-common way for the AP bus: There might be more than one regular
+	 * driver per device and using driver_override the right one is
+	 * selected. Wrong drivers cannot be forced on a devices as the
+	 * subchannel type still has to match.
+	 */
+	cdrv->drv.support_driver_override =3D true;
 	return driver_register(&cdrv->drv);
 }
 EXPORT_SYMBOL_GPL(css_driver_register);

(plus the respective change for the AP bus).

> I am not aware of a single bug report caused by driver_override on these
> buses, so tainting or denying here would only break working setups
> without fixing anything.
>=20
> As these two are not vfio drivers, this should not be folded into
> 04/10.
>=20
> We (s390 team) should probably send two followup patches, simple oneliners
>=20
>   s390/cio: Allow untainted use of driver_override for io_subchannel
>     sets .support_driver_override in io_subchannel_driver.drv
>     (drivers/s390/cio/device.c)
>=20
>   s390/zcrypt: Allow untainted use of driver_override for cex4queue
>     sets .driver.support_driver_override in zcrypt_cex4_queue_driver
>     (drivers/s390/crypto/zcrypt_cex4.c)
>=20
>=20
> Peter/Vineeth for cio and Harald for zcrypt: could you provide such
> changes as additional patches?
>=20
> Uwe, would you be willing to take those in your series?

If you don't like the above change, that would be fine for me.

Best regards
Uwe

--smgcc6baxzd5hjo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsIA3UACgkQj4D7WH0S
/k7mpQf9HsvZtb/ejZf9J0OaGNQG288ziIyX2gETkN0FV1cKexwcxogNrAGj1DIm
cU5OBeG1faHc95aO/Whrvdey4eZruyGeac8lESkWvtE1UFsFojpTeVxlMiOFoKzv
urFOQfCnwLnBz6tHHBAvVU4amp2BoGwwKPao1MSk/aaYdqZqBiSajpxhZvy5viwS
N15FHXBdo/wub5AydtfbIYP12+4jeaFkrDly+Ia/PddlPtyKldpzIdPZnlDcXTRR
CF4MmTP/tF44D6s8yI/A3xTHF9Zcl/TpxtBRDE/qtWJgNbOIsSrZSj4bX9pjhM1L
xcPPThMUA6FD/3KSbnqNVmzbrThWEQ==
=CCYU
-----END PGP SIGNATURE-----

--smgcc6baxzd5hjo2--
