Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BFA3EB0E5
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963969; cv=none; b=VU8WLpnD0ehHRRSV2R9Vyb/gQQCNGOwI4NQwBGB980Uz/9jQYcIyOboFQxXFc/w7Wx1kaj6RniBA2le8/zc1BiaRbET6aflx2P6BNybAsrLAijXuiFMq5IJlXKitFOi4t2/8KFYxN0Z5WMtaWHdAJnnz86DH4e1RvuMzNMOal10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963969; c=relaxed/simple;
	bh=AJg1+K9qUOfyClwxLySfsSa3SsK49movdGDDw2z+9+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qAOALJyQxsTYss8n0Rt9Mvwx+6KKv5pJ3oPzN0ffGdsOprRFOkRDTBcTlYN6H3Se2AgJJyRcEUOq+HrrsR3vcuEHA8TcGFQiVJKcq8t71iCFsttFpdOzZ7Cf1Wc+aCCJNyoIepf6958loYDqtJLgv+D45Mr4AOyrNsXfzfgIJqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot481abK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot481abK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599641F000E9;
	Mon, 17 Aug 2026 10:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786963964;
	bh=Fp/YKBv6TlHFU5wUqmDRRpvtpTQUHjunMYHQcVXjPRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ot481abKjXVr/+ukXv33j8YOXykD5kjgLKx+XRW2dxls34D0MSNsAUu2UgIdEonmf
	 LIxxOHuIjZ+7ifQafgTDGujKPQaTw/r6eaz3hf54GrpKQ0F/vOP0ykyH0FdoUuWwJW
	 13TtsGTbdHnpqF07m+11T39kXOaSK+0rQyuCiUqHH+BnPkGC2JgE3Ol62UWToo5IFI
	 5uk2ALTOyXmFyLc8Z7piXTUaV8Eu87Y0oQDU6Xhn+xl8pMN53n8a7gjrC71Mh6wZjG
	 1DE0nUftIpELyEuciswHN7HAJrM0WwN26xoTbYS6H/SfBwTv/SP9RwSCiv+WYRVFOu
	 ty6Cdsge8Zqfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] s390/crypto: Fix missing scrub of temp buffers
 with PAES algorithm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260817104203.74033-3-freude@linux.ibm.com>
References: <20260817104203.74033-1-freude@linux.ibm.com>
 <20260817104203.74033-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 10:52:43 +0000
Message-Id: <20260817105244.599641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing memory scrub on stack temporary bounce buffer in `ctr_ae=
s_crypt()`.
- [Medium] Missing memory scrub on stack bounce buffers in `gcm_aes_crypt()=
`.
--

--- Patch [2]: [PATCH v2 2/6] s390/crypto: Fix missing scrub of temp buffer=
s with PAES algorithm ---
commit 517f415eda900d45f7871a3da2f51b851e06642f
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix missing scrub of temp buffers with PAES algorithm

This patch explicitly scrubs the stack bounce buffer used for partial block
processing in ctr_paes_do_crypt(). It also updates __xts_2keys_prep_param()
to scrub the entire pcc_param structure rather than just the key field,
preventing inadvertent exposure of sensitive cryptographic material.

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index ccc7da106c3a0..d075b0241f1f5 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
> @@ -1044,6 +1044,7 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *=
ctx,
>  	}
> =20
>  out:
> +	memzero_explicit(buf, sizeof(buf));

[Severity: Medium]
This is a pre-existing issue, but does ctr_aes_crypt() in
arch/s390/crypto/aes_s390.c have the same missing scrub on its temporary
bounce buffer?

Like the PAES algorithm fixed here, intermediate cryptographic data
appears to be left on the kernel stack when an AES-CTR operation
processes a final partial block that is not a multiple of AES_BLOCK_SIZE:

arch/s390/crypto/aes_s390.c:ctr_aes_crypt() {
    ...
	if (nbytes) {
		memset(buf, 0, AES_BLOCK_SIZE);
		memcpy(buf, walk.src.virt.addr, nbytes);
		cpacf_kmctr(sctx->fc, sctx->key, buf, buf,
			    AES_BLOCK_SIZE, walk.iv);
		memcpy(walk.dst.virt.addr, buf, nbytes);
		crypto_inc(walk.iv, AES_BLOCK_SIZE);
		ret =3D skcipher_walk_done(&walk, 0);
	}

	return ret;
}

>  	pr_debug("rc=3D%d\n", rc);
>  	return rc;
>  }
> @@ -1377,7 +1378,7 @@ static inline int __xts_2keys_prep_param(struct s39=
0_pxts_ctx *ctx,
>  		memcpy(param->init, pcc_param.xts, 16);
>  	}
> =20
> -	memzero_explicit(pcc_param.key, sizeof(pcc_param.key));
> +	memzero_explicit(&pcc_param, sizeof(pcc_param));

[Severity: Medium]
This is also a pre-existing issue, but does gcm_aes_crypt() in
arch/s390/crypto/aes_s390.c also need its stack bounce buffers scrubbed?

It explicitly scrubs the param structure, but seems to omit scrubbing
gw_in and gw_out. This leaves intermediate cryptographic data on the stack
when an AES-GCM operation with scattered or unaligned data uses the internal
bounce buffers:

arch/s390/crypto/aes_s390.c:gcm_aes_crypt() {
    ...
	struct gcm_sg_walk gw_in, gw_out;
    ...
	memzero_explicit(&param, sizeof(param));
	return ret;
}

>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817104203.7403=
3-1-freude@linux.ibm.com?part=3D2
