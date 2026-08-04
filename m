Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6396C37DEA3
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843929; cv=none; b=P8Cu5JbXjOnCv5UPWWWU5+GXYe3jt2OM6z+rKhNHxaseeQ2f9ruhW4p/KDCmgI2OVhGWVfuLFdQVYdrw/OdOKgk1tQuA0Rb36xNBZRpp4cxTaDhJZiH5x/zHfxpwNA9/z396pP4NOoqp/b3q0iQDHhVgc2WXISjX1XirOHBm9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843929; c=relaxed/simple;
	bh=mFcgEge6XwEvQ0hnTdbwMXnAkzTt8cBgcit0tQgjC/Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vBx1IgDac37MY3kybstxPB5YjvftM9m3w+6SLoLdCKkmVoRAK698z8whUJWmxkIb0jiA+q7NN+JYlc2zQDbHUsh3fwpbuL9wNz1qesjgr3tHPsFk1hDgDiqV4Qu2un8VpapT5OUHSBg9p1WCNECbv8WS3xscbZwdm/XoppeyW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDneHsia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDneHsia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414C01F000E9;
	Tue,  4 Aug 2026 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785843928;
	bh=bEp3fgnvvYopY9XE0DqmvqLn2zmyEEU+ig9mR2AwugE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eDneHsiadkvIgz7K/jAaxtmRMNgIB4aA9Rp5XnacoMezKPp6xyC5Dw9Whmvuv84tE
	 67hWxN9kSGVaVdmvXb7wqVV48ZLxp4glbeSBJ8O2vZps+b6zwf/2f7Vi1JPELTz4Bn
	 gp55+lNP45O9EdcijF4gQ2y00LB166mVkq2syg1fOjdKGYg9aITWdgph8P4lQRXSID
	 sFzWpv1IuDfX6Ur0LGSAatRB1EGkgLVv3IT/h0doUKU5x0hiKAQr8Qs6P7GIr2mfGr
	 V5Q4CClMinWrcwVIi5XJ5oHgBx28/3ch86ssNCkOAuTCO8W7/3gw4kynfui7F23bFu
	 06/vrXEoHdS8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] s390/crypto: Enable CONTEXT_ANALYSIS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260804113736.1423667-4-hca@linux.ibm.com>
References: <20260804113736.1423667-1-hca@linux.ibm.com>
 <20260804113736.1423667-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 11:45:26 +0000
Message-Id: <20260804114527.414C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing error check for `skcipher_walk_virt()` in `ctr_aes_crypt()=
` causes errors to be silently swallowed.
--

--- Patch [3]: [PATCH 3/3] s390/crypto: Enable CONTEXT_ANALYSIS ---
commit 2232f8277d7ab7cfce4ac97a8923bcf8c4ed60e3
Author: Heiko Carstens <hca@linux.ibm.com>

s390/crypto: Enable CONTEXT_ANALYSIS

Enable CONTEXT_ANALYSIS since s390's crypto code compiles now without
warnings.

> diff --git a/arch/s390/crypto/Makefile b/arch/s390/crypto/Makefile
> index 48aeb0c0ffbd6..1d64208139357 100644
> --- a/arch/s390/crypto/Makefile
> +++ b/arch/s390/crypto/Makefile
> @@ -3,6 +3,8 @@
>  # Cryptographic API
>  #
> =20
> +CONTEXT_ANALYSIS :=3D y
> +

[Severity: High]
Does this code silently swallow errors from skcipher_walk_virt()?

In arch/s390/crypto/aes_s390.c:ctr_aes_crypt():

	ret =3D skcipher_walk_virt(&walk, req, false);

	if (mutex_trylock(&ctrblk_lock)) {
		ret =3D __ctr_aes_crypt(sctx, &walk, true);
		mutex_unlock(&ctrblk_lock);
	} else {
		ret =3D __ctr_aes_crypt(sctx, &walk, false);
	}

If memory allocation or scatterlist setup fails during skcipher_walk_virt(),
it returns an error code (such as -ENOMEM or -EINVAL). Because ret is
immediately overwritten by __ctr_aes_crypt() without being checked, the
caller may incorrectly receive 0 (success).

This causes a silent failure where unencrypted or undecrypted data may be
consumed by the caller.

Could we add an error check before calling __ctr_aes_crypt()?

>  obj-$(CONFIG_CRYPTO_AES_S390) +=3D aes_s390.o

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804113736.1423=
667-1-hca@linux.ibm.com?part=3D3
