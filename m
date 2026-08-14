Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC621474262
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718646; cv=none; b=aTvKwt+DBZKq5tVrMTmtJOiBVSV2pMoQDa3uf4CBUS6x2sVVnxcP4yXWr3WcTYbKpnX+3rdVD4BdzGBsiQMV+XRpt7tRpu2tni0M3OZJkrquZYeeqWyTIwnv6Q7V/e9Pmuz68d2aoIw1F4IqsVi15rpNzXA1HfLSEWr7l2p2yNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718646; c=relaxed/simple;
	bh=uoEbTcU6zq78GVkKHEmb9/j2RYKm/+JvIeHqQL2sDbQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ed5TYPqLzUFTE0PJiWWLnlhXmzbrLUF2xRi9KZmdsIL+k6qIqcYNa3EkLa2AljFerZmGpwscrk3uq3sBR2qOPTOoSClnluRDcCFg8vOBghdeUPmAPE50V7uk0P+N71r+DkjG5XlOhUIHmhxUyNTpSGsePm3QldKxUGoUi1oeVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWSQOR4X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWSQOR4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91B71F000E9;
	Fri, 14 Aug 2026 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786718645;
	bh=FAXOBMY/ThXi2JuFqPQPQICl8kCOXebHaUGCN6K+diU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VWSQOR4XpRSZ7FkNBEFlIjczTMUlNK5VuMe9n7C6yi4fC9VZvAB+zir5SC5TQpDru
	 wy/Q5SMyHFHcoJ6Be/NWTaGTcJxaEljGNmZtOu0JGHHsaMpj56wnQbnEwlumCwu8Gj
	 EWPm7pHSaIW0IN3b43hpijdo1vqMuL4n54V9Tx3G0DNn6coulXz8m/zkPQLIB0Hvyh
	 5vpHyxu2EDw06X4dbGmUIUUJr8yATpWX1hStPXZEHZMSmI+H4FyMPrvs7LHao97/tl
	 SHnotE6gpqfRUPgis5ObTTJzSTxhmxYD+iFHA12bI+KI8cLXBNZgZyGn3JyEjvE2Nw
	 if8qqZcGDGuxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] s390/crypto: Fix use of mutex in atomic context
 in PAES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260814142200.65821-4-freude@linux.ibm.com>
References: <20260814142200.65821-1-freude@linux.ibm.com>
 <20260814142200.65821-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:44:04 +0000
Message-Id: <20260814144404.E91B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes a mutex used in atomic context for PAES, but leave=
s the exact same buggy pattern unfixed in the standard AES implementation.
- [High] Cryptographic keys, plaintext, and ciphertext leak onto the kernel=
 stack due to missing zeroization on error paths and tail-block processing.
--

--- Patch [3]: [PATCH v1 3/3] s390/crypto: Fix use of mutex in atomic conte=
xt in PAES ---
commit 80f788f92a13c083509e6350703c357c6460863b
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix use of mutex in atomic context in PAES

This commit replaces a mutex with a binary semaphore for the PAES CTR
implementation. This resolves an issue where the mutex was unsafe to use in
atomic or interrupt contexts.

Cc: stable@vger.kernel.org # 6.16+

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index 5a7dc46518854..4f65469d35fcd 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c

[Severity: High]
This is a pre-existing issue, but does the standard AES implementation need
the same fix?

The commit message notes that the mutex is not safe to use in atomic or
interrupt contexts. Looking at ctr_aes_crypt() in
arch/s390/crypto/aes_s390.c, it continues to use mutex_trylock(&ctrblk_lock)
in contexts where it may be called from softirq. Does that leave standard
AES CTR broken in atomic environments in the exact same way?

[ ... ]

> @@ -1016,7 +1017,7 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *=
ctx,
>  		}
>  	}
>  	if (locked)
> -		mutex_unlock(&ctrblk_lock);
> +		up(&ctrblk_sem);
> =20
>  	/* final block may be < AES_BLOCK_SIZE, copy only nbytes */
>  	if (nbytes) {
>  		memset(buf, 0, AES_BLOCK_SIZE);
>  		memcpy(buf, walk->src.virt.addr, nbytes);
>  		while (1) {
>  			if (cpacf_kmctr(ctx->fc, param, buf,
>  					buf, AES_BLOCK_SIZE,
>  					walk->iv) =3D=3D AES_BLOCK_SIZE)
>  				break;
>  			if (!maysleep) {
>  				rc =3D -EKEYEXPIRED;
>  				goto out;
>  			}
>  			rc =3D paes_convert_key(ctx, tested);
>  			if (rc)
>  				goto out;

[Severity: High]
This isn't a bug introduced by this patch, but does this error path bypass
the scrubbing of sensitive stack buffers?

In ctr_paes_do_crypt(), if paes_convert_key() fails in the final block
processing loop, the code jumps to the out label, completely bypassing
memzero_explicit(buf, sizeof(buf)). Can this leave cryptographic material
exposed on the kernel stack?

There appear to be similar unscrubbed buffers in arch/s390/crypto/aes_s390.=
c,
such as ctr_aes_crypt() missing a memset on return entirely, and
gcm_aes_crypt() returning -ENOMEM directly when a scatterlist mapping fails,
which bypasses the zeroization of the master AES key.

>  			spin_lock_bh(&ctx->pk_lock);
>  			memcpy(param->key, ctx->pk.protkey, sizeof(param->key));
>  			spin_unlock_bh(&ctx->pk_lock);
>  		}
>  		memcpy(walk->dst.virt.addr, buf, nbytes);
>  		crypto_inc(walk->iv, AES_BLOCK_SIZE);
>  		rc =3D skcipher_walk_done(walk, 0);
>  		memzero_explicit(buf, sizeof(buf));
>  	}
>=20
> out:
>  	pr_debug("rc=3D%d\n", rc);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814142200.6582=
1-1-freude@linux.ibm.com?part=3D3
