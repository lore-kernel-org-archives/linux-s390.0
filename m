Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3946985B
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934243; cv=none; b=cx9z10m58NBM2GkWJBF38ispBAA+D2h5Al76DG4QgbCr3DgLqLLO1w/rw0y7Xq0IcCpVlz8FgwWsgPGG0B8Mv9ceA8T5Ph1owEMKtooIGy6+UCUItWX2cSo7EqwvT35YakaqqPFjGT7KXXnf83oSVBom+eAJsl0HL3SgIYtcoxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934243; c=relaxed/simple;
	bh=Q0RbWNjRcp9r2zQMakjPTduhuSZK+Po+L0J3cpD1diA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IRZrQRNbn+AuhopEp2lT5Mo84zdUSK5Uecwqn5+2sf57LgYfUBgLAtpj681apBSVbaq+02c9bnJuPpKpqKaNAkTj8PE+SkW+ZDKHvjPJ4J4nGrJ9Z86ggY1A3PWbqnoZmTI7RA01eXMFpAgwxROB+m377iePBCIKdB034Rwv7Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQaKOReT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQaKOReT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43751F000E9;
	Wed,  5 Aug 2026 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785934242;
	bh=7lZUD/Cu9TJlQWgIFyHJrtL00rzgLiICjL7mweW57LA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NQaKOReTTz8Xu5tiYp7hEtjdpkKG8WioRUOgJka4ClVS8tslfyogGvgjdTJqoVL6D
	 D/dARs3/JyZI0FMwgkwpaqp1BEKgnoRkasGgQfpuVFVhKghIypF1gimGwX4OSiwq1q
	 fc2fSFIQuNafsoNSkhngE0l8AWwdmB4kf8dC5lBGak8dWCtzo7NxW8ujqFrGxzPU6i
	 fQLmJPe4syEQOmd9olz9Xg+eDTCeby0VGvBJwcGIOJD0HZRu/T7Go2RpcTc0WVilgw
	 gIQ6WXGsmXde4R72BYKkAGDozmha7pvr3MD9KC4ddpgkZXN5ceMwq1MSROaZri7tJU
	 1RnYLpg7phETw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] s390/crypto: Fix return code handling at
 skcipher_walk_done in PAES algorithms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260805122853.9677-2-freude@linux.ibm.com>
References: <20260805122853.9677-1-freude@linux.ibm.com>
 <20260805122853.9677-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:50:41 +0000
Message-Id: <20260805125041.C43751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch introduces a guaranteed double free of skcipher_walk=
 resources when skcipher_walk_done() returns an error, due to redundant cle=
anup in the subsystem's wrapper functions.
- [High] The local stack buffer `buf` is not cleared before returning, pote=
ntially leaking plaintext or AES-CTR keystream bytes to the kernel stack.
--

--- Patch [1]: [PATCH v1 1/1] s390/crypto: Fix return code handling at skci=
pher_walk_done in PAES algorithms ---
commit cbb88540726dcff1286760a1df99934f56760f60
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix return code handling at skcipher_walk_done in PAES algorit=
hms

This commit adds immediate error checks after skcipher_walk_done in the
PAES cipher processing loops (ECB, CBC, CTR, XTS modes). It ensures walk
errors are properly propagated and not masked by subsequent operations.

Cc: stable@vger.kernel.org # 6.16+

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
> @@ -432,8 +432,11 @@ static int ecb_paes_do_crypt(struct s390_paes_ctx *c=
tx,
>  		n =3D nbytes & ~(AES_BLOCK_SIZE - 1);
>  		k =3D cpacf_km(ctx->fc | req_ctx->modifier, param,
>  			     walk->dst.virt.addr, walk->src.virt.addr, n);
> -		if (k)
> +		if (k) {
>  			rc =3D skcipher_walk_done(walk, nbytes - k);
> +			if (rc)
> +				goto out;
> +		}

[Severity: Critical]
This isn't a bug introduced by this patch, but does returning this error
directly to the caller result in a double free?

Looking at the wrapper function ecb_paes_crypt (and similar wrappers in this
file), if skcipher_walk_done fails and we jump to out, the wrapper will see
the error and unconditionally call skcipher_walk_done again:

ecb_paes_crypt() {
    ...
    rc =3D ecb_paes_do_crypt(ctx, req_ctx, false, maysleep);
    ...
    if (rc !=3D -EINPROGRESS)
        skcipher_walk_done(walk, rc);
}

Because skcipher_walk_done frees walk->buffer and walk->page on failure
but does not set them to NULL, won't this second call attempt to free the
same dangling pointers again?

[ ... ]

> @@ -986,6 +991,11 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *c=
tx,
>  				       AES_BLOCK_SIZE);
>  			crypto_inc(walk->iv, AES_BLOCK_SIZE);
>  			rc =3D skcipher_walk_done(walk, nbytes - k);
> +			if (rc) {
> +				if (locked)
> +					mutex_unlock(&ctrblk_lock);
> +				goto out;
> +			}
>  		}

[Severity: High]
This is a pre-existing issue, but does this function leak plaintext or
keystream bytes to the kernel stack?

At the end of ctr_paes_do_crypt, the final partial block is handled using
a local stack buffer buf:

ctr_paes_do_crypt() {
    ...
    if (nbytes) {
        memset(buf, 0, AES_BLOCK_SIZE);
        memcpy(buf, walk->src.virt.addr, nbytes);
        ...
        memcpy(walk->dst.virt.addr, buf, nbytes);
        crypto_inc(walk->iv, AES_BLOCK_SIZE);
        rc =3D skcipher_walk_done(walk, 0);
    }

out:
    pr_debug("rc=3D%d\n", rc);
    return rc;
}

Because buf is abandoned on the stack without being cleared via
memzero_explicit, could subsequent unrelated syscalls leak these=20
leftover bytes to user space?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805122853.9677=
-2-freude@linux.ibm.com?part=3D1
