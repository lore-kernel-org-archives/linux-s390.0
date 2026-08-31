Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6BC3D8128
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167124; cv=none; b=aCEtPQuRbxVFu3BTTxDMdXSlybI6V61+M7uTNLL7QvE1/APxM4YNAEEAmKa/eoWq5xHEXc97xfHoGcTOKxtobL2s7R9DI3X5PhYWSVG+1O+KXX2oYtd5UuKr6xrY1VmU+9xW57jm3cWk6Z9OLTjrtGrTN19fsKVFK1UbapYnNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167124; c=relaxed/simple;
	bh=oTec12/aU8S29HUCVhzjVW4gwzrvmBTh+SqY1ayOVjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ddZWjbTIt3wfYXdwjwvakp0zT2yUt9HBPRpVavIir7Z6uPwyOgqzrBo3Lyo8Te91eu2qpVkT9tjrn3juyqH1npJxSyAaHfNEG0BsYdSx+QxncfDE6gUTcSTNVKCH8rLQplRJM/Rd6tvUcT/Jj/SfCU0Ppkjg7gqg/4pVqZDBLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFIZBXUV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFIZBXUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230C11F000E9;
	Mon, 31 Aug 2026 09:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788167123;
	bh=Z2JJGMRa9CbOJOiICXtqLCmm+iP3NpNDWLjGrWcgukI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dFIZBXUVebEvt9b72ghOfde2CNY3EPxypIOIIsg+0gAoWDu6LToJ10KsslLMYaK2K
	 B9JBTzqcJds4B2ZN6h4H7L2IjiFRqw3n5lbVVkjYU+VaT+SZegjuUKcoQsvYyzuCs3
	 3eDs8DR/Y71cwr3yJuyRTCczbPl9jDBgG1Ppf3RvXIXmLbwlstDy45fkVSC9M1K8dV
	 /6baozzmsmOL2etCdmbIKxMkSutSU3QoELvldTeJzw4gHfmUkmCoVlDQHSJrDqQCX6
	 dvWTV1SBpDP0f8VUc4SGzzvKNBMPzbY8BDe0bGNUglJT35/wmHsiZTdZyhT5Mexol5
	 upmxTjHSLorbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] s390/crypto: Fix missing scrub of temp buffers
 with AES ctr and gcm algorithm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831083735.3625-4-freude@linux.ibm.com>
References: <20260831083735.3625-1-freude@linux.ibm.com>
 <20260831083735.3625-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:05:22 +0000
Message-Id: <20260831090523.230C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The temporary stack buffer `buf` in `ctr_paes_do_crypt()` is not e=
xplicitly scrubbed before the function returns, leaving sensitive plaintext=
 and/or ciphertext data exposed on the kernel stack. This is identical to t=
he issue fixed in `ctr_aes_crypt()` by this patchset, which missed the Prot=
ected AES counterpart implementation.
--

commit 5028b97eb1d91a81a384b0480662106643fa02f9
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix missing scrub of temp buffers with AES ctr and gcm algorit=
hm

This commit fixes missing explicit scrubs of temporary stack buffers and
CPACF parameter blocks in the s390 AES CTR and GCM implementations. It
ensures sensitive data is cleared before the functions return.

> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
> index 366ce22d36237..10561aa687c78 100644
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c
> @@ -604,6 +604,7 @@ static int ctr_aes_crypt(struct skcipher_request *req)
>  		memcpy(walk.dst.virt.addr, buf, nbytes);
>  		crypto_inc(walk.iv, AES_BLOCK_SIZE);
>  		ret =3D skcipher_walk_done(&walk, 0);
> +		memzero_explicit(buf, sizeof(buf));

[Severity: High]
This is a pre-existing issue, but does the Protected AES counterpart need
this identical fix?

Looking at ctr_paes_do_crypt() in arch/s390/crypto/paes_s390.c, there is a
similar temporary stack buffer used for partial block processing that does
not appear to be scrubbed before returning:

arch/s390/crypto/paes_s390.c:ctr_paes_do_crypt() {
    ...
		memcpy(walk->dst.virt.addr, buf, nbytes);
		crypto_inc(walk->iv, AES_BLOCK_SIZE);
		rc =3D skcipher_walk_done(walk, 0);
	}

out:
	pr_debug("rc=3D%d\n", rc);
	return rc;
}

Can executing a cryptographic operation in Protected AES CTR mode with a da=
ta
length that is not a multiple of AES_BLOCK_SIZE expose sensitive plaintext =
or
ciphertext bytes on the kernel stack when this buffer goes out of scope?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831083735.3625=
-1-freude@linux.ibm.com?part=3D2
