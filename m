Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB43DCDBF
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167413; cv=none; b=jDvF+iT0DHIVFO9Ig+26MJOluB9yzDyxdR88hvNElIMie1evjq9PZ0l3QeiruwI5dCA6SbPVZPWDN/YuXvwkKXUaKfM4GUEihJbQk5zO3Z+aiy/ZNKfyv+khXpuY32d0fpeE4ob+w3jgbrt6UVl45jLfH8Ov2JaaRRT1rvOcIQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167413; c=relaxed/simple;
	bh=gSJdtIfJS2tPnBp3J0bfSyVipkd6/HK4WzoFvpFd7ww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lGNq9dgFAL16rl2RqAnLMzakfC0jBNE/5oVHQngo5/NduSzeXt5NqEmNl+pAGp7IQRPIZw3gkKeszLQhSyYNXFoYNrZoGosx7JXc1sImvijIx1StAQJPQtu7FWG2+IBepYiSsIsTB4dxfKWe8M3mPe6LByibhlecg4H0xPhwTM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZesOpY3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZesOpY3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02E51F000E9;
	Mon, 31 Aug 2026 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788167411;
	bh=1LSt2I12pBVUGROkuQiUmpbVR1IF8jsoGW1IMINjWHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZesOpY3UtPVAGwwZNcM+EPNzayk00aD0Kn8+JHP3jwZDzOVDU4fGH9nEKwI+bcEJX
	 DFTNQiFhboOlpGgL1W0+fqu2Hc2Mi+MHXUi60z5esUWWUM4g4i/V+rPLzfRhGjCe8q
	 ZqACWfq3ARDGKLJ+2VWYGb/xLqyjjfYtRTCjZF/wCalLdc1RUDZ2BL9t3qTf3Gk1Il
	 ueAscVILwNrTnxLW37jILgy4A3i7LTFvZIiPxSTLctGToGajEA3edpUiQzUoItoc+p
	 jxI5CQAeNGxW6kOph1hJJ4Oj4kgcrd6j5PKTYV1ofznlZv706+mW6086fXSUDQ4EX8
	 1FDXXBIn3adMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/9] s390/crypto: Fix missing scrub of temp buffers
 with PAES algorithm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260831083838.3703-3-freude@linux.ibm.com>
References: <20260831083838.3703-1-freude@linux.ibm.com>
 <20260831083838.3703-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:10:10 +0000
Message-Id: <20260831091010.F02E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Incomplete Fix / Data Exposure: The patch fixes a missing scrub =
of the `buf` temporary buffer in `ctr_paes_do_crypt()` to prevent data expo=
sure, but misses the exact same vulnerability in `ctr_aes_crypt()` within `=
arch/s390/crypto/aes_s390.c`.
--

commit 40d179d4c1cbb2f9d3b0a3104c9a0096f37f307f
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix missing scrub of temp buffers with PAES algorithm

This commit addresses a missing scrub of temporary buffers in the PAES cryp=
to=20
algorithm. It zeroes out the processing buffer in ctr_paes_do_crypt() and=20
ensures the entire parameter block is scrubbed in __xts_2keys_prep_param() =
to=20
avoid exposing sensitive data.

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
>  	pr_debug("rc=3D%d\n", rc);
>  	return rc;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but while fixing the missing scr=
ub
for PAES here, does the exact same vulnerability exist for standard AES in
arch/s390/crypto/aes_s390.c?

Looking at ctr_aes_crypt() in that file, it similarly uses a local stack=20
buffer buf to process partial CTR blocks:

arch/s390/crypto/aes_s390.c:ctr_aes_crypt() {
        ...
        u8 buf[AES_BLOCK_SIZE], *ctrptr;
        ...
        if (nbytes) {
                memset(buf, 0, AES_BLOCK_SIZE);
                memcpy(buf, walk.src.virt.addr, nbytes);
                cpacf_kmctr(sctx->fc, sctx->key, buf, buf,
                            AES_BLOCK_SIZE, walk.iv);
                memcpy(walk.dst.virt.addr, buf, nbytes);
                ...
        }

        return ret;
}

This buffer holds sensitive payload data but returns without being scrubbed=
 via
memzero_explicit(). Could this leave cryptographic data on the kernel stack
where it could be exposed if stack memory is later leaked? Should this same=
 fix
be applied to standard AES as well?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831083838.3703=
-1-freude@linux.ibm.com?part=3D2
