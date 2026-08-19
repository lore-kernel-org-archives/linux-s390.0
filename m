Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B93F329A
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131858; cv=none; b=oBNSh52JPaXgzKqcYEZJDbw4wJgagl97fOBHqsjejWQe5N4XB644zCIbJWkjVevD2CxrYz3I0p452aBYEcii+lrkCZTShNEc2tYRf6AyMtVEmxYzOEClK30Co8XAuZKAkiopnoLKPdwwW15rHxbOqoJygUiNgYUwnROJbK3gnmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131858; c=relaxed/simple;
	bh=AB1qfCnbE85xwfWZkPWn5ZUFLpGwPcXmbOY9spr5QfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tj1YO1a4GYqLJXJFxojm7hfPszjwgGOI2e0O/KMarb/Gs3ivPp+Es/UQQdQ0ERSlUJdfTsE0nk/1cyNKgR4m1eEIT1ewghFya6DnC6ow5ayPdpnSx7BAFYWIwuxOSm8xlQnIQOXED7M8HuR7C3/SkjpmCp2tly9Yg8Qy0gWSOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEYX+COe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEYX+COe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F411F000E9;
	Wed, 19 Aug 2026 09:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787131852;
	bh=nbP7u9OkfrqjYI/l/n2+zRnnG5vBfXi/uSzCmyOd1U0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TEYX+COeMUqcI4K66M4epeXBiJETjo3qq9yHrgLXem6HXh4sicrKKbS+zJShSvfIr
	 jSORgYAop6fFIKGFGc9niHmSH7dgoZ2jI3bRR1fHEG2S1WZG8Av/zSWuPaPc6EObIb
	 aVGsW1ZeorMnH+f5av3HiNgX4DpZwGslyKDGHVCprtlJ8s+il00BV6K/Gn6OJ328IM
	 WLZsGimbWIoNHoFWg+rAZLyccyC/A5OI3H+zlW4wqXSMclI/56Uejmv/OLyIdiExr/
	 /C4BMiCVYVa4Kno1PvBOLtKo5zoTLeuyqDZs9RIVGXEn80a4S1E12SQd6QY3/XBUXv
	 btoJSWLoEyKAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] s390/crypto: Fix missing scrub of temp buffers
 with PAES algorithm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260819091734.7331-3-freude@linux.ibm.com>
References: <20260819091734.7331-1-freude@linux.ibm.com>
 <20260819091734.7331-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:30:51 +0000
Message-Id: <20260819093052.22F411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: stack buffers containing sensitive user plaintext/=
ciphertext are left unscrubbed in standard AES functions, identical to the =
pattern fixed in the PAES functions.
--

--- Patch [2]: [PATCH v4 2/7] s390/crypto: Fix missing scrub of temp buffer=
s with PAES algorithm ---
commit 4d897eecbd2aa1ba90d2105c4cb807323e706e6b
Author: Harald Freudenberger <freude@linux.ibm.com>
s390/crypto: Fix missing scrub of temp buffers with PAES algorithm

This commit explicitly scrubs a stack buffer used to process remaining bytes
in ctr_paes_do_crypt(), and broadens a scrub in __xts_2keys_prep_param() to
clear the entire parameter block. This prevents potentially sensitive data
from being left exposed.

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
This isn't a bug introduced by this patch, but does this missing scrub patt=
ern
also need to be fixed in the standard AES functions?

In arch/s390/crypto/aes_s390.c:ctr_aes_crypt(), the buf stack array
is used to process the final block data, but it doesn't appear to be
explicitly zeroed before the function returns:

arch/s390/crypto/aes_s390.c:ctr_aes_crypt() {
    ...
        ret =3D skcipher_walk_done(&walk, 0);
    }

    return ret;
}

Similarly, in arch/s390/crypto/aes_s390.c:gcm_aes_crypt(), the gw_in
and gw_out structs contain local buf arrays that store block data
and seem to remain on the stack without being scrubbed:

arch/s390/crypto/aes_s390.c:gcm_aes_crypt() {
    ...
    memzero_explicit(&param, sizeof(param));
    return ret;
}

Could cryptographic operations using ctr(aes) or gcm(aes) with data lengths
not aligned to block boundaries leave unscrubbed plaintext or ciphertext on
the stack, similar to the vulnerability fixed here for PAES?

>  	pr_debug("rc=3D%d\n", rc);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819091734.7331=
-1-freude@linux.ibm.com?part=3D2
