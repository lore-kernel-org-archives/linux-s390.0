Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213C3D47BF
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787926190; cv=none; b=dOxezEZcWZYRz1h3D6rRKNAXmTcJ8rkyQxyNW+fT7vXJwWAT1zdiiTaaOBOoNBOTTYwoqWmwyzH9vAa+6QXsAlx8PmW9A8b/FWo8YmFp4fHMjV7UT8dI/xXfp0Ser5cxp9k/7I0cg0Os1dIDcEF9dBaRM9nUApzruHymcyx5Aqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787926190; c=relaxed/simple;
	bh=L66mB1iOsDSIsxABInx2meEqu+7LSgtVPpashgx4EIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PIDSyKEHxAu3nkdNMlGjtZF1oPaOJf+7qRdLapCDSByZtbsauMliUqi7zoDVaD5mKYANPwVuB46oKSyijJRAArHgBbfUbre0YTnKH8VYPrU7AranGdaEKwUMFyAH5BCPUmeQYuQdvBRJSI+eoAZoOo49Sdqti1TXbniGlS2FZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M34DPIT7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M34DPIT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA981F000E9;
	Fri, 28 Aug 2026 14:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787926186;
	bh=Lx3ddJiozPyjAEV0RGl8OGx7FVC7kwGrUaPBbFOgNyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M34DPIT77y10SYNMtQ/jsqTnYc/LVmEqHnW2Z1kGjwk7heHMRbggNVuwlHmUFt/WO
	 Kyzf8BbT1gs4a338EZqymVRa9D7s+dpBr3fELFnGmLH2JJmOt9VF5Rqh5PmXl4LHeN
	 t0bK/pXMNePExdscZ+8r26ohKGUJJFmtnl3kwgavpv5GfYI4+FzYraPpO/mr0RGhuz
	 yqRVvrTPaLNwSgjvDPMnZSubS9uA1vL5DliWYA5aMDTfHQ1694LFroRxJCsQppYBaJ
	 AxaMPDSlBExZ2xZbevxOhSv3yhUYIM+APX1amrFtTv3oH71+sgNg1xPE7tja2VFWrX
	 JxcryEOfYE50g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] s390/ebcdic: Add character classes for the
 invariant subset of EBCDIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260828140057.1728173-2-iii@linux.ibm.com>
References: <20260828140057.1728173-1-iii@linux.ibm.com>
 <20260828140057.1728173-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:09:45 +0000
Message-Id: <20260828140945.EAA981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `_ebctype_inv` maps variant EBCDIC characters as invariant punct=
uation, violating the definition of the invariant subset.
--

commit 4c4158381dc4e63b906d199cf0d49673aee1a203
Author: Ilya Leoshkevich <iii@linux.ibm.com>

s390/ebcdic: Add character classes for the invariant subset of EBCDIC
   =20
Add _ctypes-like array for the invariant subset of EBCDIC, which
consists of characters that should have the same assignments on all
EBCDIC code pages that use the Latin alphabet [1].

> diff --git a/arch/s390/kernel/ebcdic.c b/arch/s390/kernel/ebcdic.c
> index 0e51fa537262b..15cbb0b42aa6e 100644
> --- a/arch/s390/kernel/ebcdic.c
> +++ b/arch/s390/kernel/ebcdic.c
> @@ -392,10 +392,48 @@ __u8 _ebc_toupper[256] =3D
[ ... ]
> +/*
> + * EBCDIC -> character classes
> + */
> +const __u8 _ebctype_inv[256] =3D {
> +	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x00-0x07 */
> +	_C,     _C,    _C,    _C|_S, _C|_S, _C|_S, _C,    _C,	/* 0x08-0x0f */
> +	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x10-0x17 */
> +	_C,     _C,    _C,    _C,    _C,    _C,    _C,    _C,	/* 0x18-0x1f */
> +	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x20-0x27 */
> +	_C,     _C,    _C,    _C,    _C,    _C,    _C,    _C,	/* 0x28-0x2f */
> +	0,      0,     _C,    _C,    _C,    _C,    _C,    _C,	/* 0x30-0x37 */
> +	_C,     _C,    _C,    _C,    _C,    _C,    0,     _C,	/* 0x38-0x3f */
> +	_S|_SP, 0,     0,     0,     0,     0,     0,     0,	/* 0x40-0x47 */
> +	0,      0,     _P,    _P,    _P,    _P,    _P,    _P,	/* 0x48-0x4f */

[Severity: Medium]
Does this array incorrectly include variant EBCDIC characters?

0x4A is mapped as _P (invariant punctuation) here, but isn't it a variant
character (e.g., '=C2=A2' in US 037, '[' in German 273)?

If a kernel command line contains these bytes, they might be incorrectly
accepted as valid invariant EBCDIC.

> +	_P,     0,     0,     0,     0,     0,     0,     0,	/* 0x50-0x57 */
> +	0,      0,     _P,    _P,    _P,    _P,    _P,    _P,	/* 0x58-0x5f */
> +	_P,     _P,    0,     0,     0,     0,     0,     0,	/* 0x60-0x67 */
> +	0,      0,     _P,    _P,    _P,    _P,    _P,    _P,	/* 0x68-0x6f */
> +	0,      0,     0,     0,     0,     0,     0,     0,	/* 0x70-0x77 */
> +	0,      _P,    _P,    _P,    _P,    _P,    _P,    _P,	/* 0x78-0x7f */
> +	0,      _L|_X, _L|_X, _L|_X, _L|_X, _L|_X, _L|_X, _L,	/* 0x80-0x87 */
> +	_L,     _L,    0,     0,     0,     0,     0,     _P,	/* 0x88-0x8f */
> +	0,      _L,    _L,    _L,    _L,    _L,    _L,    _L,	/* 0x90-0x97 */
> +	_L,     _L,    0,     0,     0,     0,     0,     0,	/* 0x98-0x9f */
> +	0,      _P,    _L,    _L,    _L,    _L,    _L,    _L,	/* 0xa0-0xa7 */
> +	_L,     _L,    0,     0,     0,     0,     0,     0,	/* 0xa8-0xaf */
> +	_P,     0,     0,     0,     0,     0,     0,     0,	/* 0xb0-0xb7 */
> +	0,      0,     _P,    _P,    0,     0,     0,     0,	/* 0xb8-0xbf */
> +	_P,     _U|_X, _U|_X, _U|_X, _U|_X, _U|_X, _U|_X, _U,	/* 0xc0-0xc7 */

[Severity: Medium]
Is 0xC0 also a variant character?

It is classified as _P here, but it can represent '{' in US 037 or '=C3=84'
in German 273.

This seems to violate the definition of the invariant subset and could lead
to missed warnings for garbled boot parameters.

> +	_U,     _U,    0,     0,     0,     0,     0,     0,	/* 0xc8-0xcf */
> +	_P,     _U,    _U,    _U,    _U,    _U,    _U,    _U,	/* 0xd0-0xd7 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828140057.1728=
173-1-iii@linux.ibm.com?part=3D1
