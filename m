Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A74734FF
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717906; cv=none; b=qEAU+2RI4uqYRl8QSu3EV3yLOqNeyEONFpQC2yEYf59T5bg98eqDA5SRTW2NA7nUB7uvBC/oI1vih4F5PPFmc57oOsj6ronIrkv1vChtxvJ62rKt6jBfolE/1888yHx5v6DN6vYUh7uco9B+XqwxrCKcYR3dsE6H24ar9HoWGVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717906; c=relaxed/simple;
	bh=ct/5DURS0UnoHij1pbuRFcaz/uavBbtci+FzZamdbYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yam8lSAdrGJqDl0oVSUAmrrrs69TxVi5+d0LaXbMMzWJ9rWOhp5zRdWY2BfX9VSyuql5bWVqa0aS08TVlYYDP56VBZlecwc3m7skmOm6pYCZvsMi0z+EG+c5Udp/JU02r2ZS2YEJGUGVTQPVKWStAlwyRAjAUcakq1pNur+r4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7f3wFGD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7f3wFGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14B71F000E9;
	Fri, 14 Aug 2026 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786717903;
	bh=oF+TEV+X4YHeqeES4KCELVx+2Sk5pgwVQcXEltFAtLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e7f3wFGDaesdfGPttwKFuLxiFi+iYaAufguEZE3dEsprYhivooKLpzIaqN0pj8Fgj
	 m/M1HJFOa/3uByQld5dmAWh1SxwDnCEMUQ+pyPPL5XUN1cLNs/mupqaFcsRzXAp852
	 Xho2wAvdKDRbMVKXEgtZg3ELRS3MHTkKYcf+m7ZWqAub5PCHTIq6cWzvhbmPPNyBtw
	 l1J25wKOqhdFPAln4+MHckLWXQ0G7oh/ZdvZ9NqOMDl6SzAcO97ELCxlj9nqXp86I5
	 tfpbr6/1n5tPimN497NPiYIZLxEPCm6mGzPlv2p79qbPhNIEQ9slnCVAbhYYq9Kse9
	 ZaWC3ciSVqnqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] s390/crypto: Fix missing scrub of temp buffers
 with PAES algorithm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260814142200.65821-3-freude@linux.ibm.com>
References: <20260814142200.65821-1-freude@linux.ibm.com>
 <20260814142200.65821-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:31:42 +0000
Message-Id: <20260814143142.A14B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch adds a stack buffer scrub for `buf` in `ctr_paes_do_cryp=
t()`, but misses the error paths, leaving sensitive cryptographic data expo=
sed on the kernel stack.
- [High] Identical temporary stack buffer vulnerabilities exist in unprotec=
ted `aes_s390.c` functions (`ctr_aes_crypt` and `gcm_aes_crypt`), including=
 raw AES key leaks on error paths.
--

--- Patch [2]: [PATCH v1 2/3] s390/crypto: Fix missing scrub of temp buffer=
s with PAES algorithm ---
commit d69919771b30f447650b0115c573c98b74a7ef91
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix missing scrub of temp buffers with PAES algorithm

This commit explicitly zeros out the buffer used for remaining bytes in
ctr_paes_do_crypt() to avoid exposing sensitive data. It also changes the
existing scrub in __xts_2keys_prep_param() to clean the entire parameter
block.

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index ccc7da106c3a0..5a7dc46518854 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
> @@ -1041,6 +1041,7 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *=
ctx,
>  		memcpy(walk->dst.virt.addr, buf, nbytes);
>  		crypto_inc(walk->iv, AES_BLOCK_SIZE);
>  		rc =3D skcipher_walk_done(walk, 0);
> +		memzero_explicit(buf, sizeof(buf));
>  	}
> =20
>  out:

[Severity: High]
This isn't a bug introduced by this patch, but doesn't this fix still leave
sensitive cryptographic data exposed on the kernel stack during error paths?

In ctr_paes_do_crypt(), trailing partial bytes are copied into the stack
allocated buf array. Inside the subsequent while loop, if cpacf_kmctr() fai=
ls
and !maysleep is true, or if paes_convert_key() fails, the code executes a
goto out:

		while (1) {
			if (cpacf_kmctr(ctx->fc, param, buf,
					buf, AES_BLOCK_SIZE,
					walk->iv) =3D=3D AES_BLOCK_SIZE)
				break;
			if (!maysleep) {
				rc =3D -EKEYEXPIRED;
				goto out;
			}
			rc =3D paes_convert_key(ctx, tested);
			if (rc)
				goto out;

Since the newly added memzero_explicit(buf, sizeof(buf)) is placed at the e=
nd
of the if (nbytes) block, the goto out jump bypasses the scrub entirely.
Would it be better to move the memzero_explicit() after the out label to
ensure the stack buffer is scrubbed even when returning an error?

[Severity: High]
This is a pre-existing issue, but there are similar temporary stack buffer
vulnerabilities in the unprotected aes_s390.c functions.

In ctr_aes_crypt(), a local buf array is used to process trailing partial
bytes but is never scrubbed before the function returns:

	if (nbytes) {
		memset(buf, 0, AES_BLOCK_SIZE);
		...
		ret =3D skcipher_walk_done(&walk, 0);
	}

	return ret;

Additionally, in gcm_aes_crypt(), a param struct containing the raw AES key
(param.k) is constructed on the stack. During the scatterlist walk loop, if
either gcm_in_walk_done() or gcm_out_walk_done() fail, the function
immediately executes return -ENOMEM:

	if (gcm_in_walk_done(&gw_in, n) !=3D n)
		return -ENOMEM;
	if (gcm_out_walk_done(&gw_out, n) !=3D n)
		return -ENOMEM;

This early return bypasses the memzero_explicit(&param, sizeof(param))
cleanup at the end of the function, leaking the AES key on the stack.=20
Could these similar cases in aes_s390.c be addressed as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814142200.6582=
1-1-freude@linux.ibm.com?part=3D2
