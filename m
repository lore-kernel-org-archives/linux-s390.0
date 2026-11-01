Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793556473;
	b=daMcR2QVZfzA2otkqwHUQlpy8IP+LrRyKfpoQ5TwjudA38/Zs3/NO+VIZrzomrNqW8N5
	 qfPKn5+3jEGzgT+Jvlz8nRU78bxpFiSdiXtDGci5Mup9IL3hO3oyfrdpxrt8qp2zxuqA8
	 Mr2oR010StICPiq88m34XIv1RDlxoNf+Z1lNZpFp9qqTn6mje1USMcUujX6lOltQ5kHM+
	 SN185vHzTaQ+DUnELimtHkDIRUueN8B1tePxQPbaDlycBnxFx3pHJT2Ksj54w0CJ6jJW5
	 WPWoBe90awIgvX98Iz3G3ffcdkwEW66mJ7vDVa0O48KxfvqNCqYuX6SO14Dsh9CR33g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793556473;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=utXpdvBeYezp5FgmSIGWppvxjJMJgzFzF+wVCdidZ/M=;
	b=tGM3cU+WvYMtSOdGogDC7j4AbCoNECfNB+LtI47tF+nMaRYVwBiNyEsaM0GvgxD7KOtX
	 1znWrULNvVhpok/MH2dDnhyQka/wBJjlPwaQXbxUFJpi8hWclDRm6ovxkuesZ8T9dwZWL
	 jFB/LVO2pxYMy2w6ynEXGW27+H+fZyjF/e6OB1tVvxIP6RrfLVTVgl5WkJcggtoytYqKk
	 c+8htu20NssgZ6b6UvN1yKjPbnT5wTFiN/hHZ1imaBkqPDHMzVuJYBSa0UYkLpMF/Mbr9
	 3LtIZcYZ1N6cno+2Qw9RUkGRFjJzHiY9+HU0BBikP2zm8D96Z+TczFDMaQ2o+h9n4nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XbtOXHOn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD6606A324;
	Sun,  1 Nov 2026 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XbtOXHOn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02CA1F00919;
	Sun,  1 Nov 2026 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793556473;
	bh=utXpdvBeYezp5FgmSIGWppvxjJMJgzFzF+wVCdidZ/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XbtOXHOnXGxcXD6yRQhDsHUNuGQKexIFKRX2cfCNgZo2m+iSqOtMKoP3Yq0996akL
	 rHZ3MUJ3kIte9dcbAYNO4mzLZkjW9H/3GUCGdzOFlMCndErdbPxAVannJHVClRB8Dh
	 4lDQHnaR575LyAsRPo6w4w2FIVEMJkhs2tjoPCi4q6NrSSNawlhG5wBhJ7Ph/Vah6N
	 Vcnw7Dporl87IOZCN8vIGJY72I3up5Cy9mvizto6WI3lOKGG6SDHmv4t6Dz4bFaVNf
	 hTJpVp9KbU+hLAfmzc2XXaYFOn31dXfaETFZjOWqJ7/LjErVcXeK87KmN02n8wmakA
	 eJk/rbjwUsJvA==
Message-ID: <sashiko-outbox-192559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2] x86/entry: Fix ptrace regression
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Gleixner" <tglx@kernel.org>
Cc: linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <87ecd4xwlr.ffs@fw13>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13> <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
 <871p9g1s3w.ffs@fw13> <87y0boze95.ffs@fw13>
 <C6D7BF04-4CF7-48D1-93B5-E80D52C2617D@zytor.com> <87se1wyvs8.ffs@fw13>
 <87mrrvxaty.ffs@fw13> <87ecd4xwlr.ffs@fw13>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 18:07:52 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/entry: unmatched opening brace in do_syscall_32_irqs_on() brea=
ks build
--

commit b8945a5f45d9b3a8ab21f8b9c553fa0b34f2a69f
Author: Thomas Gleixner <tglx@kernel.org>

x86/entry: Fix ptrace regression

This commit restores the historic syscall entry behavior where syscall
number -1L keeps tracer modifications to regs->ax while other invalid
syscall numbers overwrite regs->ax with -ENOSYS.

> diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> index a59509bb460ab..e409de28445f9 100644
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -77,6 +77,10 @@ static __always_inline void do_syscall_32_irqs_on(stru=
ct pt_regs *regs, unsigned
>  	if (likely(nr < IA32_NR_syscalls)) {
>  		nr =3D array_index_nospec(nr, IA32_NR_syscalls);
>  		regs->ax =3D ia32_sys_call(regs, (unsigned int)nr);
> +	} else {
> +		/* See comment in do_syscall_64() */
> +		if (nr !=3D -1UL) {
> +			regs->ax =3D -ENOSYS;
>  	}
>  }

[Severity: High]
Does the inner if (nr !=3D -1UL) statement in do_syscall_32_irqs_on() have =
an
unmatched opening brace that leaves the function unclosed and breaks the
build when CONFIG_X86_32 or CONFIG_IA32_EMULATION is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/87ecd4xwlr.ffs@fw13=
?part=3D1
