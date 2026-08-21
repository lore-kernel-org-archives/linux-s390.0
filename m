Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE36448393
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302723; cv=none; b=eP0ZcLeeDJAA6YCQ+w3AYr8pXZYOWVrBxw0NMY7MFX+va37Fb6hrOf5sm1ntKAPqAtUURkvWXdJvkZuqEQKYB3zR1PL4wTRyWypJfWlkC28FGDVsxZmtncdIZ0rqQWAiLfgcx4F7fOi4oSgyhd/+Wto+g4MCUVlrY1odksfTiA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302723; c=relaxed/simple;
	bh=AUGvTsoxe0nuxdM3LpsZgvMa8R1Erb6NDo1Wlrj6Wq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nj3941526wnuhUQFJxVZtJmnOxMqWHbXtbbbO303g9tL1kbY9ZroKobTgtXsSKrbT11a5/V7ybK2FH02fKv8IsY+MFWpXyi7MvadHaCIP/QVqbWxCjL8EAPLFCVBlG5oMWsWNSwY6XilJymhJ6+esA0Wb6mrYcsLs9uNvtiBAEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsfwNjX3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsfwNjX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BF31F000E9;
	Fri, 21 Aug 2026 08:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787302718;
	bh=DVn8Wg1ut0JmToUB9CtGTRvC1Prdky7l/qO5DxwudFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UsfwNjX3Ut4wvYyB4Bx8qcAwGuNa2NuDOUYGOgysTc7ZqvKq+TXG2K6yJ7qZvK7vI
	 Bh9qoKKwmSFLb9+TFsfAQTUiROp45Od3DE87KRvV5kOoFAjJqEsPJjVgYJh/A5PPBh
	 Y6Yb9Q7gG4uRebQx7O+4+cCApcaXXB1+T2a/wWq2wZq25nju2LDJv4ev+AAeCSBGvo
	 LXKVL2cW98HPrEBx5t/lmSCy1g4pSg3y40p/bGOycsyCO0iBh6YjB671Qwt0F+5o9i
	 xPry200o9j6o53RX+kqTrKJYnkTbJy6dXQ8iXSQRHPn38GWYbddOX+8rviu6PbNq54
	 881rdWFA313BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/9] s390/crypto: Fix missing scrub of temp buffers
 with PAES algorithm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821084648.23222-3-freude@linux.ibm.com>
References: <20260821084648.23222-1-freude@linux.ibm.com>
 <20260821084648.23222-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 08:58:38 +0000
Message-Id: <20260821085838.72BF31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing explicit scrub of local stack buffer `buf` in `ctr_aes_cry=
pt()` (standard AES algorithm).
- [High] Missing explicit scrub of temp buffers in `gcm_sg_walk` structures=
 and AES keys in `gcm_aes_crypt()`.
--

--- Patch [2]: [PATCH v6 2/9] s390/crypto: Fix missing scrub of temp buffer=
s with PAES algorithm ---
commit 0f77835bffb943e6b87472b41b755be562bb23c4
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix missing scrub of temp buffers with PAES algorithm

This commit explicitly zeroizes temporary stack buffers used for partial
block processing in the paes algorithm. It also updates the scrubbing
logic in the xts parameter preparation function to clear the entire
parameter block rather than just the key field.

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

[Severity: High]
This isn't a bug introduced by this patch, but while you are fixing the mis=
sing
scrub of buf here, there appears to be an identical pre-existing issue in t=
he
standard aes implementation.

In arch/s390/crypto/aes_s390.c:ctr_aes_crypt(), the local stack buffer buf
is populated with cryptographic data when processing a final partial block,
but it returns without scrubbing the buffer:

		ret =3D skcipher_walk_done(&walk, 0);
	}

	return ret;
}

Since this path is reachable by unprivileged users invoking the ctr(aes)
algorithm with unaligned lengths, does ctr_aes_crypt() need a similar
memzero_explicit() call before returning to avoid leaving sensitive data on
the kernel stack?

[Severity: High]
This is another pre-existing issue in the same subsystem, but looking at
gcm_aes_crypt() in arch/s390/crypto/aes_s390.c, there are error paths that
bypass the existing memzero_explicit() cleanup completely:

			return -ENOMEM;
		if (gcm_out_walk_done(&gw_out, n) !=3D n)
			return -ENOMEM;

If these error paths are taken when processing fragmented input data, does =
this
leave the aes key and hash subkey on the kernel stack?

Additionally, the normal exit path cleans the param block but doesn't appear
to clean the buf fields in the gcm_sg_walk structures (gw_in and gw_out):

	memzero_explicit(&param, sizeof(param));
	return ret;
}

Should these temporary buffers and early return paths also be scrubbed?

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
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821084648.2322=
2-1-freude@linux.ibm.com?part=3D2
