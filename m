Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795111396;
	b=ZkbMZXczqQ477GNTAbTs+dAM6Ln3dQe3XpMAt+1J2pU8OKoELMGOAhVRn1UB5wgVlaII
	 R30DBDcGOjlYmZjN0KhTSg2tnWM5W0ipEwPfataoMBpwPmm+wrej7HJQX9i174Hj/C4IR
	 eGmSRpb9YuP5EkcdOPNj85n6AqiCrWHLlExBVil4ER/rAhyeSmAJZuo5QpCZa65YZlTYG
	 TkDlP/Pn82jpushPTp7mSIRhmvLDse5Zclcmve2mZmEWPTZmgvcyhPpdeB9cMHFCcer9s
	 Ot126QXamouGpSIYXKJiNTIKPQ9Sc0Hx1NXpKFuECLq4Yos7t5pyMm8H7uNGs0+hOKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=M3aTvEzquBrOiSj2mlzWhSxH+izz4607hFK76/YmCDk=;
	b=nfwZwpZ0DrA3Z1fWEGz0FzrLOB7UpITgujOr9dSPWiqX2RSc8zKUgqBGv4jVdlNnt7Px
	 Hq/cLUrbS50geuGYQZZCW6j0Tw2BwVChN6UXBZ9p/xPQ4wLoBh68N2jGCzvE8EYsLtn+B
	 4OkFcZCbcl/UZl8OirjmOFvs3YJjMsKnJ5dppMpndCuPiYAbIgXJIcGDwJtEmo9TVxP5t
	 UV/c/v6Dps+amuBV444r9IGEcHlxxOwNRmeXRl4BhPlIWcsErYpaHwSClJp/1q71adrGi
	 oXL+uipU5tMYIVyLoxZa3GRqAsbE65lUbXbaRa3dnNG4OYgDXJaznAK+cRBLiZvtyag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MqSC4DAg;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656E60A2605
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 18:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4656E60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MqSC4DAg
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-497614c95f0so1714816f8f.1
        for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 10:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795111394; x=1795716194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M3aTvEzquBrOiSj2mlzWhSxH+izz4607hFK76/YmCDk=;
        b=MqSC4DAgywaLe4KR5xqH3of1cfPM/uiKIncJ6UtFG1Rz3EzgT0FwejXVHVXEB5ci/O
         TftKKjryaTOwn85SS2I+3aFA9HTGAdgvHGmGojzllNvS7zjClZgeo0806BhgRvBvccVj
         pvl8czaOEK+PvuDXD4lsl6dfvtzVKyaDgWW4eIHExXeBqxXaS5ZfSyOBf42VLPt+H7dr
         Xpy5nSgnEB+M+TzN25HAV+Ni3O55mUW8zFDnAALpU7+wX1zMSmRkAVqxlKqmk9SpGxvJ
         1LNGqpYHPMZ+Lx24Wg53TNzDWPAcMgGZEccrcDhpAnYU6Mji9Wo8fqGAcbKjCa0G/VWx
         4V8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795111394; x=1795716194;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3aTvEzquBrOiSj2mlzWhSxH+izz4607hFK76/YmCDk=;
        b=bytGvHtV5TuBNaMX35gz0KOEtaQfDP2rRWE/HY54fqGuxQDYSuHQZ8Njk1Q+YeDh3o
         gaLxW/cQuVx+XDfBjSySisTvVYgCI/Nhrlg9yoT/zT8f5Yzc1UjqlDH481QqhsJEJcKo
         +ybhmdldsO7gC+kjD8QOKE5c5mDoVQRfOR2M5MFEd26CCVWi5puVvBCJvvlwNfUQzikS
         jKdRoj5Ab1/uBIml8I58UVUHpHkE1GIv3T1E5lcpuVdKkhQWS9iYhK4J5wF7r7qU+FiD
         7yXWrv+AXZ3AWjEhzVR9o8DhEdQPclGcGYXDAYyiPIEl47TtZuNGJpfJZvpRMdwFNrC7
         OhnA==
X-Forwarded-Encrypted: i=1; AL+hErGcbwBqootjTtxvtdagIYVbbh8cF8I/MbpyJuFQHIIzjZYyTB/Mx3SmC0AmMJwB0ENm6z7Fb6S1NhU3@vger.kernel.org
X-Gm-Message-State: APuU4Z8y2CmLx4GUlpGR31OKs9B2gegxXKJUAptOUhVHuZIpzQIZk1fj
	slhWbQOSc6yeMnCu4SAwwNQM6sNbycnmVm1/oO1rz6zIHchR2NOPaGYC33Vt1Q8kpU0=
X-Gm-Gg: AYBFou0cuSh9+1ha5W3rCVvRuwVyhcthiwq3fBOCxiVDnwfcyn6HMtChbkQ5Kticdtr
	sGJPcmLicd5ezmVqQUejNefYzGVNlgn3G2O7r78XBwPoZIY6Roh22y1OjEtS31EVNisjxFNCs5j
	+9/hywqUPXp6DX8aJfCSdKbchMce9VhywbFl5PM6ksTvdUAoUOgfEe6I8T8nXdPDwlJrL5sJbgQ
	n8gsPXdLFympPht8O2JncQi1loHrNrjZKafcqfl8owkJ6yvxDyYynwBTDRHHnhDiJhgc0Gr195+
	HjkhMkCGKkSNHYHBblH+i2mdp3EH7Qda/pCKC1BoautAV/KvDTioZ19KRCtFQaZp8LoV33/Zpjm
	NbnDJNAPOm+pnIUZPSkK4IzDuXJjOT32qMLAp/K7ECvOzhwbK3wGLMi8PsN7Birq4i1+DPRBSFt
	oTZ3fIt2itfmun8QfGAWn47T4+F1woKyrTiTq46xFbvvdnshjaDmRqMdsFh8yOU8wpaJ5aQ7wH3
	8txPzgEPrDyVF6h5dEXbsU3dV+VBjGLwcaI947stfjD7MhKj0pr3HwYZmA6om95dZUgPkid1lzW
	gJMflQ0EJXhnJ3yJo3R5un9yIUrtm7BQA1JhZV9+S5cLgh12ThDjYKICO9TQZ53qaxnIwfWW3od
	NPqB0+nNJICGjoQ==
X-Received: by 2002:a05:600c:3b9e:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4bb88820687mr7335575e9.29.1795111393609;
        Thu, 19 Nov 2026 10:03:13 -0800 (PST)
Received: from localhost (p200300f65f19a904994d80f004b20d71.dip0.t-ipconnect.de. [2003:f6:5f19:a904:994d:80f0:4b2:d71])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6c340df4sm1143252f8f.55.2026.11.19.10.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 10:03:12 -0800 (PST)
Date: Thu, 19 Nov 2026 19:03:11 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>, 
	Thierry Reding <thierry.reding@kernel.org>, Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Karl Mehltretter <kmehltretter@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Marco Elver <elver@google.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Bradley Morgan <brads@mainlining.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Pnina Feder <pnina.feder@mobileye.com>, Mete Durlu <meted@linux.ibm.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Rio <rioo.tsukatsukii@gmail.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/vfio: Allow untainted use of driver_override
Message-ID: <av84kUIYQ_Idt889@monoceros>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
 <20261119051507.3306075-1-alex@shazbot.org>
 <aca4e70b-3a8a-475b-b2fb-ad9d1a44f254@linux.ibm.com>
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
	protocol="application/pgp-signature"; boundary="rnhi7e7twhetgmlw"
Content-Disposition: inline
In-Reply-To: <aca4e70b-3a8a-475b-b2fb-ad9d1a44f254@linux.ibm.com>


--rnhi7e7twhetgmlw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] s390/vfio: Allow untainted use of driver_override
MIME-Version: 1.0

Hello,

On Thu, Nov 19, 2026 at 07:14:47AM -0500, Anthony Krowiak wrote:
> On 11/19/26 12:15 AM, Alex Williamson wrote:
> > diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vf=
io_ap_drv.c
> > index 8e69ed286bb9..2d47dc643269 100644
> > --- a/drivers/s390/crypto/vfio_ap_drv.c
> > +++ b/drivers/s390/crypto/vfio_ap_drv.c
> > @@ -62,6 +62,7 @@ static struct ap_driver vfio_ap_drv =3D {
> >   	.on_config_changed =3D vfio_ap_on_cfg_changed,
> >   	.on_scan_complete =3D vfio_ap_on_scan_complete,
> >   	.ids =3D ap_queue_ids,
> > +	.driver.support_driver_override =3D true,
>=20
> Does this really belong here? Shouldn't it be in struct ap_driver
> since driver_override is supported in the AP bus?

ap_device_probe() calls device_match_driver_override with
drv=3D&ap_drv->driver. So I think the assignment is fine.

Best regards
Uwe

--rnhi7e7twhetgmlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr/OdwACgkQj4D7WH0S
/k7x+gf9FZVgAr7FFBlDRjq6odYeaqNCOaCFNVlsdz+mmeuvFoiyhQGlFuLA5fBI
RI+cAKOjVw6JQLaNWU56WyXOjyMbZ9rX1X2wiPj4dx6oWxUQ0G4oyTpMx5M9e7yX
JKEEMhBjk2hmDBDO8qTnVhrPzy+7pp0orXoElqEDT46+aZRSeBMRcSLzripwP5P2
0GBczvM7k943oKVhZ/4VuYKxowT7ALpC+OTDKy3ALqIuhhIvTY0LGjWdrDU7XBx1
NWAf33X/vh9oQSepjVMFnBaOEpOdIayc4ILJCCVuX6stvlriJCTtFBVtzja/AGZ6
BrG53U8a5eWfIY/nnztu6uaaw9royQ==
=LHa2
-----END PGP SIGNATURE-----

--rnhi7e7twhetgmlw--
