Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D035F609
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718897; cv=none; b=ilIVGd8q2Ff00fkc03h3C5aradwh0OHyxWYFx7xuFCSy4b549UhpSuinIld7/EOJca4Of0Cdr51BspuTDUX7D86FRXheRRGubY3MBOX3KQ0G4UqEbO53PyRLf/qOmTrPGGvJFKxTtbKWZWU+riu8CpcnfIpM+sIMr3jtVUYcYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718897; c=relaxed/simple;
	bh=NHpzd1eEbHC6znhVU6HK4bQKQhTSZ6Mg8XTDfvVoge0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DTQHn4D0X3beV866yF5/MpMhguStpvl6nSbjnVLuBgdu8Aq4Y00leS7eS04LtQYW0HkwX4PdtIt6OiZ7Xk9GfBX3bGgXmYN9oXWsv2GDX6z7iTK9gmBf63LNWUnsl1wBb/B+c948FjoUcJ1HYm+G62jXIYIekZd0UT5VaUGUBZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naEcuCq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naEcuCq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C4C1F00ADB;
	Fri, 14 Aug 2026 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786718896;
	bh=HRkYA1S1k0Acycey0HhV5ab7uSoWenN/UqrwvFE2ivo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=naEcuCq3+bU8Gy/Cyv86XSJIKy4pomkecj70uibLYL0cDjyM0lW7KHDiJ5rKLTIFr
	 OjXD6MK31yjt/Q94rip9CNQYAFoxrIolfyUveIm6h6m/mHFDZC/wtZ3k4lMb4xKjtN
	 9cPWYOI3xoweUEAUT6kGIcB16GsIEfQ1cTAcrLpokw3cOSxvchG/faHJguh+y92zNz
	 L2Ru24jI1Dg5Bo3FJywtq72gopsNO6N8B/93LxLoQYdTpe+kXXcM6mbLwVR15CsOF6
	 J5xiTIB+Q7vQC2K+/njo2X33pVVX5tFXMRqm7mhJbI1TXNdUuMnC4MR8XGbkuYljiR
	 i/AxHZ0OuHkHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] s390/crypto: Fix return code handling at
 skcipher_walk_done in PAES algorithms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260814142200.65821-2-freude@linux.ibm.com>
References: <20260814142200.65821-1-freude@linux.ibm.com>
 <20260814142200.65821-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:48:15 +0000
Message-Id: <20260814144815.B5C4C1F00ADB@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The crypto engine async callback functions (e.g., ecb_paes_do_one_=
request, cbc_paes_do_one_request) double-complete requests upon failure.
--

--- Patch [1]: [PATCH v1 1/3] s390/crypto: Fix return code handling at skci=
pher_walk_done in PAES algorithms ---
commit 9fb1966e4b16413a77ebe1ccd447f231c3b30ec4
Author: Harald Freudenberger <freude@linux.ibm.com>
Subject: s390/crypto: Fix return code handling at skcipher_walk_done in PAE=
S algorithms

This commit adds immediate error checks after skcipher_walk_done in the
main processing loops for PAES algorithms. It ensures walk errors are
propagated properly instead of being masked, and checks walk->nbytes to
avoid double de-allocation.

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
[ ... ]
> @@ -558,7 +561,7 @@ static int ecb_paes_do_one_request(struct crypto_engi=
ne *engine, void *areq)
>  		cond_resched();
>  		pr_debug("rescheduling request\n");
>  		return -ENOSPC;
> -	} else if (rc) {
> +	} else if (rc && walk->nbytes) {
>  		skcipher_walk_done(walk, rc);
>  	}
> =20
>  	memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
>  	pr_debug("request complete with rc=3D%d\n", rc);
>  	local_bh_disable();
>  	atomic_dec(&ctx->via_engine_ctr);
>  	crypto_finalize_skcipher_request(engine, req, rc);
>  	local_bh_enable();
>  	return rc;

[Severity: High]
This is a pre-existing issue, but can returning a negative rc here cause a
double-completion of the request?

If an error occurs during cryptographic processing (for example, if
paes_convert_key() fails and returns a negative rc), the code calls
crypto_finalize_skcipher_request() which completes the request once.

It then returns that same negative rc to the caller. Does the crypto engine
core (in crypto_pump_requests) see this negative return value and execute i=
ts
own error path, completing the exact same request a second time?

Could this result in a use-after-free or double-free, since callers might
drop references multiple times when a request is completed twice? This
identical pattern appears to exist across all the PAES cipher modes
(ecb_paes_do_one_request, cbc_paes_do_one_request, ctr_paes_do_one_request,
and xts_paes_do_one_request).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814142200.6582=
1-1-freude@linux.ibm.com?part=3D1
