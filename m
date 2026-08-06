Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D54C956A
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043689; cv=none; b=i8xJ3WWQcYUhqlUMfvtLFk+pDGxzww0ICWvy1i7fVQ8HCTyf3Ze0FK1xMTf3Z+fIY23o27YywROn2R+rMwkAP4yilgSaWJDzRXkxdiFLZi2DexJXpG+o/dcvm0wnHaQ5LWyjBmI2UgDpILULEcqhZD12x6GppVAi93BBrXjPAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043689; c=relaxed/simple;
	bh=tCTfqVhX1nGRlGhccog1xJtnyGcNY6CGAvJxgZTuSh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ReHoQ+SWfhMnDGdnFp8WMfNCfm5HLb3TtaR22Bpp4M0ZnaW2CeNLOdVSCwbl18+Lcw3kBScqkVryny4Vea3TClQwg7N88McVzxRRSTaRiIrqytl6SMoVGWsxHkflLe/Ly5vxmraPd+jGYpdZP8wIhE9jOQZ2JHDZenszcClmqOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKmn3PWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKmn3PWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFE91F000E9;
	Thu,  6 Aug 2026 19:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786043683;
	bh=hfswM2sp2OudlGYfAjbDvOSp1Bl71mj3AEbEjshOSqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NKmn3PWpCTU5RNE/OoPeOmm816nbiMXEERhybrChPqODE4vu20spVcfwEJKZ13Z2C
	 axact81v9tiFvSbI47dcMb6NHZXDuaNn7CHX9l20ov1oJvXfPz+MIw2+/ShydOyBy6
	 Q+iXjj9c2R6/j6oHi6FbccGdvNwwCbPblyBQ6Km4H/qqrCbtkXa8c5sRZtV02JO9bm
	 +dkvCvOtXX4x+Ibl+Kjs1bjK/+YbMWYCTRRzmdu2lZkEFwfFLBvjNHjUoVux5oZIi2
	 rBDSfMd2PtBeror6uHSVBsxfnwjisa4xthKzxfZJlctz95NinrBSXWWE3HY1xNiw6n
	 yZANxtkLtA3wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/cpacf: Unpoison query results
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260806190223.3292580-1-iii@linux.ibm.com>
References: <20260806190223.3292580-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 19:14:42 +0000
Message-Id: <20260806191442.AAFE91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch resolves KMSAN false positives for CPACF query instructi=
ons by unpoisoning the fixed-size query outputs, but fails to implement the=
 same fix for the primary CPACF data processing wrappers (e.g., `cpacf_km`,=
 `cpacf_kmc`, `cpacf_kmctr`, `cpacf_kma`, `cpacf_prno`). These functions ex=
ecute CPU instructions (like `.insn rre`) that write to output buffers dire=
ctly. Because the inline assembly clobbers "memory" but does not explicitly=
 bind the destination memory as an output operand (it only binds the regist=
er holding the pointer), KMSAN is unaware that the buffer is initialized. I=
f an uninitialized buffer is passed for out-of-place encryption or PRNG gen=
eration, later reads from the buffer will trigger false-positive use-of-uni=
nitialized-value warnings.
--

--- Patch [1]: [PATCH] s390/cpacf: Unpoison query results ---
commit a5de23eacfba57cb30b8dc14f4c7ed05cf2e259d
Author: Ilya Leoshkevich <iii@linux.ibm.com>

s390/cpacf: Unpoison query results

Stop KMSAN from complaining about query results being uninitialized.

> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
> index a83683169d98d..d4128d3fd5138 100644
> --- a/arch/s390/include/asm/cpacf.h
> +++ b/arch/s390/include/asm/cpacf.h
[ ... ]
> @@ -370,6 +371,7 @@ static __always_inline int cpacf_query_func(unsigned =
int opcode,
>  static __always_inline void __cpacf_qai(unsigned int opcode, cpacf_qai_t=
 *qai)
>  {
>  	__cpacf_query_insn(opcode, qai, CPACF_FC_QUERY_AUTH_INFO);
> +	kmsan_unpoison_memory(qai, sizeof(*qai));
>  }

[Severity: High]
This is a pre-existing issue, but should we also unpoison the buffers in the
other CPACF data processing wrappers?

The primary CPACF data processing wrappers (such as cpacf_km(), cpacf_kmc(),
cpacf_kmctr(), cpacf_kma(), and cpacf_prno()) execute CPU instructions that
write to output buffers directly. Because the inline assembly clobbers memo=
ry
but does not explicitly bind the destination memory as an output operand, K=
MSAN
remains unaware that the buffer was initialized.

If an uninitialized buffer is passed for out-of-place encryption or PRNG
generation, later reads from the buffer might trigger false-positive
use-of-uninitialized-value warnings.

Would it be helpful to add kmsan_unpoison_memory() to these functions as we=
ll
to prevent further false positives?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806190223.3292=
580-1-iii@linux.ibm.com?part=3D1
