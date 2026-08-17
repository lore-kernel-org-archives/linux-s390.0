Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353554B04A7
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976614; cv=none; b=C8qDCIg5AW208j67/x4DVeKQZVN8PkeNUEkiFZcpEkETzBGGDQGm9oSkaGaUPIiSF8ezvYHV5AhGBJQ06LefzADBR7Tb8fpzPslOPt/Da/u+zaRamzl/3rxNxppVq0vk4DMIiMaawo8hXgPZzwKOJqXCRKRfiiJHcGLqKq5ZWw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976614; c=relaxed/simple;
	bh=q6lehoYU6QBqX5DmwpyCKn9/A2h0wOqHNe2EiYpkxu0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dN0mzWdmTl5RrlxDOJxrkzrpUcny6rWbtimK+gxFFNg85YB7DtELlj0M0djilbJAk0+kFWjPMVcwmQY0hIgdEhYZ5uIN8n0jv8cPDTAScxgO3v2EWFnNLQausPtdkinriG+tdwieG+pn4qg4wQScff0at6P9V5tjSiGH9AFMetY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOmUPE38; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOmUPE38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81951F00A3A;
	Mon, 17 Aug 2026 14:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786976613;
	bh=hR1Rez5Z7lNaxAbyI0z9qryU+5YH7gSt15W0C9wzD+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mOmUPE38BdVqczuI9y4835CwhdyqX88COLc+u34PK9OMdapIFS5ItI+jzYcafiz5w
	 Jw9EdlGovjban74utjHOnvfDn7FPNhv45218Bvkx/wnp696rhgKSQyNYh3ddvFg8T1
	 Atg4uKBydfLlqZboYP6QQchoeFs9S7FNUk1JGsxap4mUSEuqklmDpmklggcxczUYaH
	 fXA9GK1qtlGjMir67ngzzHx8dD8C6H74dd011JMaAsbRtMW7yk04wqCZvEMM0J6b05
	 vID/7nSzgboW037jRRz7FRB9DlHkWBipu2pUlkj4pNq7R5gAcI8qhOeNMNzQzNmI4r
	 0t3y/Q0MLw5Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] s390/crypto: Fix missing scrub of temp buffers
 with PAES algorithm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260817141654.77940-3-freude@linux.ibm.com>
References: <20260817141654.77940-1-freude@linux.ibm.com>
 <20260817141654.77940-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:23:32 +0000
Message-Id: <20260817142332.A81951F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The unprotected AES implementation (`aes_s390.c`) suffers from the=
 same missing stack buffer scrub issue that this patch fixes in `paes_s390.=
c`, leading to potential leakage of plaintext, ciphertext, and AES-CTR keys=
tream bytes.
--

--- Patch [2]: [PATCH v3 2/6] s390/crypto: Fix missing scrub of temp buffer=
s with PAES algorithm ---
commit 35a0f4315bfc23077f4581853ff227c37d38d817
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix missing scrub of temp buffers with PAES algorithm

In function ctr_paes_do_crypt() there is a buffer used to process
remaining bytes < AES_BLOCK_SIZE. This buffer was not scrubbed and
thus could lead to expose of unwanted data. Rework the code to
explicitly scrub the buffer at the end of the function to avoid
exposure of maybe sensitive data.

In function __xts_2keys_prep_param() change the existing scrub to
clean the whole param block instead of just the key field.

Cc: stable@vger.kernel.org # 6.16+

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
This isn't a bug introduced by this patch, but does the unprotected aes
implementation in arch/s390/crypto/aes_s390.c suffer from the same missing
stack buffer scrub issue?

Looking at ctr_aes_crypt() and gcm_aes_crypt() in aes_s390.c, there are sta=
ck
buffers used for partial blocks that appear to be left unscrubbed:

arch/s390/crypto/aes_s390.c:ctr_aes_crypt() {
    ...
		ret =3D skcipher_walk_done(&walk, 0);
	}

	return ret;
}

arch/s390/crypto/aes_s390.c:gcm_aes_crypt() {
    ...
	memzero_explicit(&param, sizeof(param));
	return ret;
}

The 16-byte stack buffer buf in ctr_aes_crypt() holds plaintext, ciphertext,
and aes keystream bytes from the zero-padding xored with the ctr keystream.
Similarly, the gw_in and gw_out stack structures in gcm_aes_crypt() contain
16-byte buf arrays that buffer partial plaintext and ciphertext blocks.

Since any userspace process (via af_alg) utilizing s390 hardware aes-ctr
for partial block lengths, or aes-gcm for unaligned data, could trigger
this, could this lead to a potential information leak of sensitive data?

Since this patch explicitly addresses this regression in the sibling
protected aes driver (paes_s390.c), should the unprotected aes driver be
patched as well?

>  	pr_debug("rc=3D%d\n", rc);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817141654.7794=
0-1-freude@linux.ibm.com?part=3D2
