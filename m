Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239826;
	b=eOls6/4YBg6Pbq1vb/rYeHvKKlvSfJkLCRhkTEHEe8EHSz8SuIskoK264qmPeiERF9jG
	 lUeGAe/SvvRS4RT4CmJKd7CVO52v3sqWGbqWPjjxepVkLtLG9hc+SUOZ3/dhQmvd2ZiLm
	 HLRZxdTCsi7KiYePA1+tBs7sFaXHsR+xgbNpy09jIqWZy2rBmgBN0iORjOgyhVm/8xORD
	 cui+8vJ3z+j1GFQa3J/tjiPHyj8qGBehAB/okJi798rGwSJ6vdmtaAmfGUFz8r+b8+klt
	 uusL8gzp0OyhOUczialvbloVk44is8UMqS3LwxXMUQZhkfgZH43+4F282GT6QW46psw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pmUFbIi5ELXaVKVermTkfc30pmQFDxvmo4N0D8U5m1Y=;
	b=sBZ/9Mrh9Uy2iCV+aHsJnLmohz+Qm5ujkOzakVdJQI9RmAIVk7AgV4ICpPpNGRkShYZX
	 BDQwHsupHtvigXdCBVEKNh+4KIuc0d1K3aJY6sCTBfqgDIPV7JYsseNqjDOQvBwxDl2jZ
	 4mA+nRBDnXlU7IPJZZYZLIwl11mh5X4zMlDozfYjHzjSVDLtvdSbbxYhuVMWcisuzKjkY
	 8fLLSCDp6TAloK/16Z/CNW+CdG4Ce4sOnUtDlyK4RMSMFUPioOHbWW0usAoK1vEGeseoW
	 X8X4OuD0drcPZrLINfwG8Xfj3HeooEu1lUI8YSQDZwxvQunafo0II0TtKrSyCjfLBSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UDLqnf7m;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0109606A330
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 15:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0109606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UDLqnf7m
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4918c2d727fso527279f8f.3
        for <linux-s390@vger.kernel.org>; Mon, 09 Nov 2026 07:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794239823; x=1794844623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pmUFbIi5ELXaVKVermTkfc30pmQFDxvmo4N0D8U5m1Y=;
        b=UDLqnf7m6MP9XOON1P2yBuMNdHBpOeVN/b/jwE+XxoD9ltNnxMyJaaDEvydhmAeuc7
         Ew3AxhkfHo16dffHcSjkn7Ewb7ud3PaWGROInw6JmvcvzTv404/kLL4aT3eMRB/CEhFh
         zFK9sb6aegQMNog2cSasODE4i2b0HMVvrGn6Bu10dAB4GmcXzFoX4eurOH7im3Ke97rI
         BGiPujPpPJNP7Pu8wSH4XtKW63VLENynHyaT1XsAF1lazfNaj6LvXquLCjsX5RbnI0Xd
         ZAk9lrnPVigkCW9DjLcDJr3ntOwx3VRNrvu0eltOAeWUU8RGJfk7aqjaEm3hcHNeJJZb
         nMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239823; x=1794844623;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmUFbIi5ELXaVKVermTkfc30pmQFDxvmo4N0D8U5m1Y=;
        b=wd4oLR+JC6ZUgDwCRevnyVp6kRDFyqIn0kmmiuBWP7ycBmZisEpqx7FO8sGl3mKlbz
         jk/+z0wvK8jmjYyL/HjzDJV0tBMQGX2HDJIBVSDG5031uD6YqChgwwljixg7NFxNcQ6S
         OKdQwspqIjUTYsM+PHYLg2fZyDbOLfszUu3TDTv2h+3c1hj71qk9TJfh32tWxPPbFdAe
         vc0xpDa8dXj0Wp077yexbrYeeKJg92ixxx3ez8kfyyYBSK8zdm8f4bg/D2cTNqCQX5vu
         YrT3gipox237l6Fm88itc40aZ1DlGOac3QgwVTOnhKK+1P7lC6JovmidVT29ZrV8RKrT
         lwVw==
X-Forwarded-Encrypted: i=1; AL+hErF+ha+mUSTkY3xwjqeLeCwPLPyBkpHaM0ZtSv/CqgT0AgNXgObcvyL9J8s7+LdtLemNM7WC4mc3f6oI@vger.kernel.org
X-Gm-Message-State: APuU4Z89fg4euHrg39knSErVUr8gQAgGYNDEexBAVA8Se8D+Rrab5hSh
	fy+7mfjRdAzOgOru1m9Q1zSc/UIsnwcaMlGKkTog1Cz9pQQOfzVYU+K7a+Ko+2C8yiM=
X-Gm-Gg: AYBFou1GY1zLN7rH68jjJj2SabOtVer8ugIukUM5kTvw+uvd8mGfYoy3wHP6xPxekeK
	NS8Fq20uZVyp8lrPOKGRcLWQk+v6M8ZAyImUOop54vCr1hhr6B90b7OjVnnCmNyM2FxtI4tfF8e
	JLd7e3Z4Q1TZpR19g7c3iRADlzh1WGrTEKYA+3N4kBRSr0jYbSXZujGX/hPQwXaMZhtelyiNn/9
	QVCNWA7fAoM9M0CACBde2gUPTAOaYpwx7HlqQx9MNLxPiL2A5jxhczhJEg+n7AQiY1Esow0l5S2
	K+p1in3ph+UlttfrEboa1UT3t1W6IEeVhsD7nl3cjvSCgzcSFZzl9PoR1mUCDhoAQXfMAzfk+4K
	zXH1RvLJjrSsoQcST2IBIx31ATPuLj9hgMTSm1d6Ua0ShjEx6GA/qX93SXUNXFxPmyD4wvofT6R
	q4ClTAw97sCqxD0ZsA4rFzyvQ6oP0Ni6wDQjPc/MyQoKkLlIMyD5wjRs7PCQoS2HI2GZ9yEbhh5
	HBvdvxzrEOXKlarUCJrdNY9K2gdsjRXyZQklkrUrW1KfrMrYwQ/v//YEiFKajWjvZv4EPjncG8x
	BbABKoF/IL9fgYGasPHjUneXWhxX4t5n+DDlvxJ6BsWCZKSPIWRBUt3b2aA/+o3qkmrLCdDsgYD
	fbs6JspqR1P2jXg==
X-Received: by 2002:a05:6000:2913:b0:48f:bc05:76fc with SMTP id ffacd0b85a97d-4958871da7cmr8465559f8f.11.1794239823132;
        Mon, 09 Nov 2026 07:57:03 -0800 (PST)
Received: from localhost (p200300f65f19a90407b2ef73b14b6bb2.dip0.t-ipconnect.de. [2003:f6:5f19:a904:7b2:ef73:b14b:6bb2])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-496150c6e90sm9293515f8f.2.2026.11.09.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:57:02 -0800 (PST)
Date: Mon, 9 Nov 2026 16:57:01 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Harald Freudenberger <freude@linux.ibm.com>, Holger Dengler <dengler@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-kbuild@vger.kernel.org, linux-s390@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH 2/2] devicetable-offsets: Get struct cpu_feature from a
 device-id header
Message-ID: <avHrnT-rUMynqyeh@monoceros>
References: <cover.1792144769.git.u.kleine-koenig@baylibre.com>
 <179416565740.60865.16102443399828949110.b4-review@b4>
 <66e4ee9c7f9b4bc48fcee92a94b6bb6d92fe1ad2.1794233316.git.sashal@kernel.org>
 <f610c07f39df15f3e7ebdc63bfcd759ca7a687a8.1794233316.git.sashal@kernel.org>
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
	protocol="application/pgp-signature"; boundary="2fgrweo6pewwby7y"
Content-Disposition: inline
In-Reply-To: <f610c07f39df15f3e7ebdc63bfcd759ca7a687a8.1794233316.git.sashal@kernel.org>


--2fgrweo6pewwby7y
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] devicetable-offsets: Get struct cpu_feature from a
 device-id header
MIME-Version: 1.0

On Mon, Nov 09, 2026 at 09:14:41AM -0500, Sasha Levin wrote:
> Since commit cdfdbc11552b ("Move struct cpu_feature to
> <linux/cpufeature.h>"), devicetable-offsets.c includes
> <linux/cpufeature.h>, which includes <asm/cpufeature.h> on architectures
> that select GENERIC_CPU_AUTOPROBE. On loongarch and mips that header
> pulls in <asm/elf.h>, and from there <linux/fs.h> and <linux/mmzone.h>,
> which need <generated/bounds.h>. devicetable-offsets.c is built before
> that header is generated, so even defconfig fails on both:
>=20
>   include/linux/page-flags-layout.h:6:10: fatal error: generated/bounds.h=
: No such file or directory
>=20
> Move struct cpu_feature to <linux/device-id/cpu_feature.h>, next to the
> other device id types, and include that from <linux/cpufeature.h>,
> devicetable-offsets.c and file2alias.c.

I didn't do that before because I didn't have the impression that struct
cpu_feature is a device id type. Seems a bit like a misuse to me, but
=F0=9F=A4=B7.

Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--2fgrweo6pewwby7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrx7UsACgkQj4D7WH0S
/k61Rwf+LVoPzWsK/woGLLlyviU+6CbjuXgKqChzk+2WLkEBD+PwtIXB8AH9dbPn
M6002PBuVjZim21ciWzb4KrFg+A7r8v7VwgqC0guYCC0fmT5saCufWs+mD3K0UNm
v99+XG+Beb0pbOot1KBVbwhXV+bC3Me9emG+M/tnXXHJCQKspmNpEZveIk7dSlWF
YkDj52lX/LcDMa7bDOfNfbEbMOZOoyzvXhBdLN5vonShXeWbBTvbIHDhIBXYUiXe
TPKI4T+X/rK0qjc0N33xYdbPFPxC6JtA0bY19P+H9qXRHfDET9c4m1tBDYI/f4GF
TRJz+4C8sNz42lbj0xNszq4D4wu9LA==
=wmA7
-----END PGP SIGNATURE-----

--2fgrweo6pewwby7y--
