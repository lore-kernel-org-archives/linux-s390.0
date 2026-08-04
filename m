Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E02360ECE
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844023; cv=none; b=TSimZQ1JPTWA9AImCyrVrN00jb0uSLvvp7hbciuGzO3MBatf4DnK22NYBExA7gVFgsVbjfK4nLBMk1T4XfAaNRfeo3EEr8eGmwovofEbkLZ4Pm1dQVVo/myjrmm40Yzc4Tq+a938FZH1SVJqZirBwKAZpFEoBQDT2cvU2/hBIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844023; c=relaxed/simple;
	bh=V+wSZwt5Urpu9k/biTpg6m3O6DSzZpZ88bwRVtBfKhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gqrLLJb8qlgsLRJuPvjBNFr++pAeK8eFaw8LYucOGBOBhN+ViLW27P1mqrLEQUiUnY7sZeWsH4OhjXOsCMpFAC5LHtLdOcR6k1PYNkppoVIhX7XNjfmsosPvn1kXxflFx+ta0RSsiLJi1ydz7Avyn0tByQ/evns2oz8cM/W62FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfblwY91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfblwY91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ADE1F000E9;
	Tue,  4 Aug 2026 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785844021;
	bh=TuDY98K83cQzBTcuCFDvL2mZMyH+SqCRrP9yUvd/NTk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KfblwY91hFceDjVWmv8hXtiSBxU0NoH9ow6TMTzwJ5Obs/iT2GR/TfK25r+skEdBs
	 Ms6y8F7lDjY7HK9rks6I+VVcGsbogJ8KZ4MW3gqPLxouk+hcFmaqCHRXzVVEsGneZ+
	 iSK6csQ0t+R3tUd3ZHBIP0Mbvb5QhlIj0ITMB9l3GB1wpwOSGhdCLs/oXKSifCbXad
	 94fJFWwY/twUQQmvygeyIW8JfwAekVjlydbDdET3YtscAWbIdy4TzeMpD4UAOh2l4t
	 dDpf4mxmbCI7DjIOOrZx/AvRI5MWn9p/rC6ZMSYRZ5+pYO1lwLejrcbU/4eQ9VaX8x
	 XZ8ERbjGlzGmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] s390/crypto: Rework ctr_paes_do_crypt() to remove
 conditional locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260804113736.1423667-3-hca@linux.ibm.com>
References: <20260804113736.1423667-1-hca@linux.ibm.com>
 <20260804113736.1423667-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 11:47:00 +0000
Message-Id: <20260804114701.54ADE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Silent data corruption when skcipher_walk_done() mapping errors ar=
e overwritten by paes_convert_key() false success.
--

--- Patch [2]: [PATCH 2/3] s390/crypto: Rework ctr_paes_do_crypt() to remov=
e conditional locking ---
commit fd135aacfa5dd1086ab5711e4513f6e0edede1dc
Author: Heiko Carstens <hca@linux.ibm.com>

s390/crypto: Rework ctr_paes_do_crypt() to remove conditional locking

This commit extracts the core loop of ctr_paes_do_crypt() into a new
helper function, __ctr_paes_do_crypt(), to avoid conditionally taken locks
that trip up Clang's static analysis.

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index 8cfe6166c193c..d4a9108d39f5f 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c

[ ... ]

> @@ -981,34 +955,76 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *=
ctx,
>  		k =3D cpacf_kmctr(ctx->fc, param, walk->dst.virt.addr,
>  				walk->src.virt.addr, n, ctrptr);
>  		if (k) {
> -			if (ctrptr =3D=3D ctrblk)
> +			if (ctrptr =3D=3D ctrblk) {
>  				memcpy(walk->iv, ctrptr + k - AES_BLOCK_SIZE,
>  				       AES_BLOCK_SIZE);
> +			}
>  			crypto_inc(walk->iv, AES_BLOCK_SIZE);
>  			rc =3D skcipher_walk_done(walk, nbytes - k);
>  		}
>  		if (k < n) {
>  			if (!maysleep) {
> -				if (locked)
> -					mutex_unlock(&ctrblk_lock);
>  				rc =3D -EKEYEXPIRED;
>  				goto out;
>  			}
>  			rc =3D paes_convert_key(ctx, tested);

[Severity: High]
This is a pre-existing issue, but does this sequence overwrite an error
from skcipher_walk_done()?

If the hardware stops processing early (k < n) and skcipher_walk_done() fai=
ls
to map the next scatterlist chunk, it can return a negative error code
like -ENOMEM into rc.

However, execution then immediately enters the if (k < n) block where rc is
unconditionally overwritten. If !maysleep, rc becomes -EKEYEXPIRED. If
paes_convert_key() is called and succeeds, rc becomes 0.

Could this result in silent data corruption where an incomplete encryption =
is
treated as a success (rc =3D 0) by the caller?

> -			if (rc) {
> -				if (locked)
> -					mutex_unlock(&ctrblk_lock);
> +			if (rc)
>  				goto out;
> -			}
>  			spin_lock_bh(&ctx->pk_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804113736.1423=
667-1-hca@linux.ibm.com?part=3D2
