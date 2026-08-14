Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA2411F96
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710478; cv=none; b=MBerDT90/G6FyLDwSUR9Mw1DnA6RG6ds7tGySOp5sT3b2ae7tmoqJ0JinHqaRi+SzH2XKJUbHiTF4g1nG3lzjyPAi1kwRY0dEgD93gfcdtOM1SeWdH8Wr0kh6rcaE8bJbB3Uc/V+uNnKNCkKmkBXS3icbHr2nbEjSLfRYxx5QM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710478; c=relaxed/simple;
	bh=Yl2q4Bvlhxqq38XtGit1SR6j+JvDpk+kPQjdE3tOKGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hMgETQCCR14s6N/s1keVSq5EP4AvBGy6c5M8OZU/C5UygZ+5vvfwu6UHdSOdRpKYhCz4yoIurTmKXj7ecuOyHQx2rYaOhUPthQou55PQEK+IN3KgMxqrg+tVkwoxApoJvqbdZVIYzvTLvBejdc1CnSdU4/F26n0OzXlis6iKTpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjellaok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjellaok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6096B1F000E9;
	Fri, 14 Aug 2026 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786710476;
	bh=yB9qc+nbZXKbSaKWcwk/FyGCboOUY4QgVIeivbMo/KU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wjellaokzm48f6jyxdPTkpAxNvL+vehMKbR3GGaOUrm/xJXw58vKvAC7kPTYP5q4I
	 BOqXTa+VSweM4sKlDfNiakABYfIoXjd3I0vNK+/x0my/PO6iwCGB4YoR1AGxFpL5iW
	 20llcWhvpJBgeU3s3+qlFq8Cn1M02NVllqE2dTIKNCBOXvRUJlfbn+zxxLU2z52FKI
	 tqDx2k3VIpfCu+j6U75zHoJxwkZV8xU8d6QlaWM4kQY1WcCI7can/AiMglDgMChiCu
	 CFtm+ukWUN3uqkySuanxnVP3GQCK/6azRxzybG/5mUjXddmkmMMGzutKTet3drk2YO
	 4y/72DKSOuPZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] s390/cpacf: Unpoison instruction results
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260814121559.1240939-1-iii@linux.ibm.com>
References: <20260814121559.1240939-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 12:27:55 +0000
Message-Id: <20260814122756.6096B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unconditional KMSAN unpoisoning masks partial completions and info=
rmation leaks.

Pre-existing issues:
- [Critical] Silent ignoring of PRNO and TRNG partial completions causes cr=
itical information leaks.
- [High] Silent ignoring of KMA operation failures causes cryptographic pro=
tocol violations.
--

--- Patch [1]: [PATCH v3] s390/cpacf: Unpoison instruction results ---
commit c65c87d6cf548eaef4bd0b06821cb0e68caaa4c3
Author: Ilya Leoshkevich <iii@linux.ibm.com>

s390/cpacf: Unpoison instruction results

This commit suppresses KMSAN uninitialized memory warnings for CPACF
outputs by adding kmsan_unpoison_memory() calls to multiple wrappers.
It intentionally avoids modifying variable-length parameter blocks and
the cpacf_kma() wrapper.

> Also do not touch cpacf_kma(): this wrapper does not handle cc 1 and
> cc2 at the moment and has to be reworked.

[Severity: High]
This is a pre-existing issue, but does silently falling through on Condition
Code 1 and 2 in cpacf_kma() cause callers (like gcm_aes_crypt) to accept
cryptographic errors?

By returning void when the KMA instruction encounters an error (such as
incorrect AAD/plaintext lengths or a hardware abort), callers have no way
of knowing the operation failed. This could result in partially written or
completely uninitialized ciphertext, plaintext, and tags being processed as
valid data.


> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
> index a83683169d98d..6174552d856dc 100644
> --- a/arch/s390/include/asm/cpacf.h
> +++ b/arch/s390/include/asm/cpacf.h

[ ... ]

> @@ -619,6 +624,7 @@ static inline void cpacf_prno(unsigned long func, voi=
d *param,
>  		: [fc] "d" (func), [pba] "d" ((unsigned long)param),
>  		  [seed] "d" (s.pair), [opc] "i" (CPACF_PRNO)
>  		: "cc", "memory", "0", "1");
> +	kmsan_unpoison_memory(dest, dest_len);

[Severity: High]
Does unpoisoning the requested length (dest_len) instead of the written len=
gth
(dest_len - d.odd) mask partial completions?

When cpacf_prno() terminates early (e.g., returning Condition Code 1 due to
entropy exhaustion), the hardware only partially fills the destination buff=
er.
Unconditionally unpoisoning the requested length blinds KMSAN to the
uninitialized tail of the buffer, potentially hiding active kernel memory
information leaks.=20

It appears the pre-existing cpacf_trng() wrapper suffers from the same
issue, unpoisoning ucbuf_len and cbuf_len unconditionally.


[Severity: Critical]
This is a pre-existing issue, but does the silent exit on Condition Code 1
in cpacf_trng() cause uninitialized kernel memory to be copied to userspace?

Looking at cpacf_trng() in arch/s390/include/asm/cpacf.h, the assembly only
loops on Condition Code 3:

	asm volatile (
		"	lghi	0,%[fc]\n"
		"0:	.insn	rre,%[opc] << 16,%[ucbuf],%[cbuf]\n"
		"	brc	1,0b"	  /* handle partial completion */
		: [ucbuf] "+&d" (u.pair), [cbuf] "+&d" (c.pair)
		: [fc] "K" (CPACF_PRNO_TRNG), [opc] "i" (CPACF_PRNO)
		: "cc", "memory", "0");

If hardware TRNG entropy is exhausted, it returns CC 1 and falls through,
discarding the unwritten byte counters (c.odd) and returning void.

Because the wrapper returns void, trng_read() in
drivers/char/hw_random/s390-trng.c falsely assumes the entire buffer alloca=
ted
with kmalloc(..., GFP_KERNEL) was filled:

	cpacf_trng(NULL, 0, p, n);
	atomic64_add(n, &trng_dev_counter);
	if (copy_to_user(ubuf, p, n)) {

Can this sequence leak uninitialized kernel heap memory to any unprivileged
local user reading from /dev/trng until entropy runs out?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814121559.1240=
939-1-iii@linux.ibm.com?part=3D1
