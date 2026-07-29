Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B89C46C4D2
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322862; cv=none; b=h6FGw8mmN5xIv0yOS/7CUexKcha8Vb13VXlN6zU12xNn2AJqXssO++TlQQEfaz+higGXZVWJJQjsNpUfYVv5x4jy1MYUhyXrGLd8t/IZjkEDEYgyI0eMp3FlQSNplLTUeglYnF8G7U/34gQloF6a7HfAn6AmU4fgJwDP2S9A+hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322862; c=relaxed/simple;
	bh=4SZ4rbH9sRTMWn7DIJH/AhTl9jqFmXslsqgP6bZ0KrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mYBYSaB0bY3xWJ7veiI1S6ELWnPfBvKdAS/3Khae8MciLFsVcurfJKvMzJuuFHb9sezX/oCuhxFvaIxs7Gacc5XrB7OomdW0bPjwtppJqLHng99HWk7hU3TOtG2luOla1yLWC0DH379eICkdhOkUioPjCdMJ1c2IRbLc7Xr/Npo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwMSRSxH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwMSRSxH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D70C1F00A3D;
	Wed, 29 Jul 2026 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785322861;
	bh=Ta8XHLzxNWUu0tbe+M1Jec8B7C2QDeEr0aQjtyw12fU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PwMSRSxH1lK4bT0Mbg4ABAdZV5pwX8QrrEYSUE3nTFW4mRfc75Ex0YLHuEqf/1xEf
	 XkFSFtVKX347zCfzvnZQ2wakMPpQUP+2tNPz1R42CjfK+N02dwjym0X3PZIByJEf0Z
	 Hb5qfoo8o272GmHIQsAxyVZCV/vAMtGPU2QgZ0qs5lod40Y5rFg1USPATkNQeeiHpk
	 JWSDuc+raWXYO2Dvf0eig0zQvmZAaa+P7MLNFTE4YJdrqqBmpy/if0nnJ6EsZX0uKK
	 1zCsszHKlR304NW/Lu9AgvrE7okClty7F21+PNwYJALZehLt2d/docRAD6Ulbawn19
	 VQlxsMmxXNL3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/5] s390/zcrypt: Improve EP11 CPRB domain handling
 with ASN.1 parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260729095318.184141-5-freude@linux.ibm.com>
References: <20260729095318.184141-1-freude@linux.ibm.com>
 <20260729095318.184141-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 11:01:00 +0000
Message-Id: <20260729110101.1D70C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The zcrypt_msgtype6_send_ep11_cprb() function uses fragile struct
> overlays to access and modify the domain field in the EP11 CPRB
> payload, creating maintainability and security concerns:
> 1. Struct overlay approach (pld_hdr) assumes fixed payload structure
>    and doesn't validate the actual ASN.1 encoding.
> 2. Complex length format detection logic is error-prone and doesn't
>    properly validate bounds at each parsing step.
> 3. Direct struct member access bypasses proper ASN.1 validation.
>=20
> Fix by replacing struct overlays with explicit ASN.1 parsing that
> validates each field (payload tag/length, function tag/length/value,
> optional domain tag/length/value) with proper bounds checking at every
> step. Add asn1_int_encode() helper function to safely write integer
> values with correct endianness conversion. This makes the code
> consistent with the validation pattern introduced with the rework of
> the xcrb_msg_to_type6_ep11cprb_msgx() function.
>=20
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729095318.1841=
41-1-freude@linux.ibm.com?part=3D4

