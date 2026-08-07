Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC238AC78
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112795; cv=none; b=Te4ofA17aQAlITv6jykjWJlRNECEvFp6xBt+ekzeoFyFviNCx0cqKl/FvkjgyRPIgohgvL0r1Dev6YDcD6U/EIIwEK9npvGv1VyNlZUXzzOVixmugQGNdSp+IcDFljZPiw5I1d8MIvMYUjEoiLYPkfpFNWS/fOpqIJoA58wa6es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112795; c=relaxed/simple;
	bh=ZMdzHD4KZqfUsQTkLMQGq//EX4v/82XhYITcUHHGJkM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RJ2bbfaohYek3nOLCPy925k5XaSUxViXugmmphuuaBP/HblYsI5OiujEYaG+X6pLUKPl25qJxXlcZYwjHu/eIctNuPEwQFwmmGR+d1hbhBuHMRm1U1T4tB/R8Z0kFadlYWlDfGqwUXXdyIHyHDbnDmSlMIbkIa0wY1UMAcOBMuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um+g3Rdd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um+g3Rdd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B368F1F000E9;
	Fri,  7 Aug 2026 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786112791;
	bh=H7l66qFyTq6cw7kfagwrV3T+PygSTxhZvEiNQ7JKp9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Um+g3RddC/AyZulZF7gC5ir8IdnXK9yktzRi8UO+T8m15Cyd31Ufro9ZFKANqAV1t
	 iB73GJ5+8IOPJAqBnU8pV13t2pzKgXG9BQFJZ655ZW9FERYgEe1WCBazqOo4fU+K5Q
	 7piF9OolpgUrPybTJ67tu73gtFqkLdDq8xYaTMiWfx+4/ZEA6jx3hR37UtY/ZFXsCm
	 x0mABs5f2iiEL4afqFVaH37HXA7bWZXVvKhh2kMg70mPRb5NcS2wFw8QbYv4iwAbYC
	 uzbErwvgqRhA93umUV7GPGI4SBN89AYBr+8CiZF/8tfSQylkv+1MQc6HMQoTqFBln+
	 d07HLCz0qJy2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] s390/crypto: Fix missing scrub of temp buffers
 with AES ctr and gcm algorithm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260807135440.35888-3-freude@linux.ibm.com>
References: <20260807135440.35888-1-freude@linux.ibm.com>
 <20260807135440.35888-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:26:30 +0000
Message-Id: <20260807142630.B368F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to scrub the temporary stack buffers `gw_in` and `=
gw_out` in `gcm_aes_crypt()`, leaving plaintext or ciphertext fragments on =
the kernel stack.
- [High] The `ctr_aes_crypt` function acquires a mutex (`ctrblk_lock`) usin=
g `mutex_trylock()`, which is illegal in atomic or softirq context.
--

--- Patch [2]: [PATCH v3 2/3] s390/crypto: Fix missing scrub of temp buffer=
s with AES ctr and gcm algorithm ---
commit 13cf8c423603f630fdd6d78e2084476a4308ed55
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix missing scrub of temp buffers with AES ctr and gcm algorit=
hm

This commit fixes missing scrubbing of temporary buffers in AES CTR and GCM
modes. It scrubs the buf array in ctr_aes_crypt() and uses an explicit error
path in gcm_aes_crypt() to ensure param is scrubbed before returning.

> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
> index 366ce22d36237..976f6f7257d51 100644
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c
> @@ -604,6 +604,7 @@ static int ctr_aes_crypt(struct skcipher_request *req)

[Severity: High]
This is a pre-existing issue, but is it safe to use mutex_trylock() and
mutex_unlock() in this function?

arch/s390/crypto/aes_s390.c:ctr_aes_crypt() {
    ...
	if (mutex_trylock(&ctrblk_lock)) {
		ret =3D __ctr_aes_crypt(sctx, &walk, true);
		mutex_unlock(&ctrblk_lock);
	} else {
    ...
}

The ctr(aes) skcipher algorithm can be invoked from softirq context, such as
via the IPsec network stack in NET_RX_SOFTIRQ.

Calling mutex_trylock() and mutex_unlock() from softirq context is generally
prohibited as it causes lock context violations. On PREEMPT_RT kernels, it
triggers WARN_ON_ONCE(!in_task()), and mutex_unlock() may acquire the
wait_lock raw spinlock without disabling softirqs, potentially creating
a deadlock.

>  		memcpy(walk.dst.virt.addr, buf, nbytes);
>  		crypto_inc(walk.iv, AES_BLOCK_SIZE);
>  		ret =3D skcipher_walk_done(&walk, 0);
> +		memzero_explicit(buf, sizeof(buf));
>  	}
> =20
>  	return ret;

[ ... ]

> @@ -895,10 +896,14 @@ static int gcm_aes_crypt(struct aead_request *req, =
unsigned int flags)
>  			  gw_in.ptr, aad_bytes);
> =20
>  		n =3D aad_bytes + pc_bytes;
> -		if (gcm_in_walk_done(&gw_in, n) !=3D n)
> -			return -ENOMEM;
> -		if (gcm_out_walk_done(&gw_out, n) !=3D n)
> -			return -ENOMEM;
> +		if (gcm_in_walk_done(&gw_in, n) !=3D n) {
> +			ret =3D -ENOMEM;
> +			goto out;
> +		}
> +		if (gcm_out_walk_done(&gw_out, n) !=3D n) {
> +			ret =3D -ENOMEM;
> +			goto out;
> +		}
>  		aadlen -=3D aad_bytes;
>  		pclen -=3D pc_bytes;
>  	} while (aadlen + pclen > 0);
> @@ -910,6 +915,7 @@ static int gcm_aes_crypt(struct aead_request *req, un=
signed int flags)
>  	} else
>  		scatterwalk_map_and_copy(param.t, req->dst, len, taglen, 1);
> =20
> +out:
>  	memzero_explicit(&param, sizeof(param));

[Severity: High]
This isn't a bug introduced by this patch, but since the goal is to prevent
exposure of sensitive data on the stack by scrubbing temporary buffers,
shouldn't gw_in and gw_out also be scrubbed?

The gcm_sg_walk structures contain a u8 buf[AES_BLOCK_SIZE] that is allocat=
ed
on the stack:

arch/s390/crypto/aes_s390.c:gcm_aes_crypt() {
    ...
    struct gcm_sg_walk gw_in, gw_out;
    ...
}

Any AEAD encryption/decryption with fragmented input scatterlists will use
gw_in.buf and gw_out.buf to bounce-buffer data, which will be left on the
kernel stack upon return.

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807135440.3588=
8-1-freude@linux.ibm.com?part=3D2
