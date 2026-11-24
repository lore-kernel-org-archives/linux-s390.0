Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513766;
	b=GDMImeh0Y04ljsgnGd8qUJ+yq4WAuxpUiL9e6orE4oL9f/cgVuZT2jiFgo6meHaOEnkO
	 5cufup0qAPxp7uYUk4ayUpChvZRNiPVDVG5o5DimWPT8zSs7nUkPZ81giWB2Tho+mfe+i
	 PNxK6COGJFscUN7l3vJ9FMJACQtJ/FbJVEIx0l19QOVIcjZN/L27hWs6fKWhYURAmvT8F
	 hhJB50MZzQBzgOySQ/fJ+9Ru8g7MVUpPkQa/eegGiodSvjBm2hfHkFN8+IEnmLePE340U
	 djxjWQO7g693FHmn7qNtZdeDutsdnptPj5ahkfO4Nfmdo8vz9cLxmBmhsy4BguExRXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513766;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gxDJEG4ECCixBI+jObWBIWZPiO5kbGYkrtOcQ6MxwLI=;
	b=fIEkU7UeV1Rs1ZYGaITeQxvS405m+glWCo0TkRWX08xq9rPcxvkb9X+/sOCxyKTW+mRX
	 cYd1nMHfWPjFLHf9YLs8zlh1vH4GI0EaC6sjyxgEXakErdt9U8s208QgEWU4sJl0OeQ5B
	 vSB2+WS2eqlihovNF0bU6yg6sE4Ftpz7KdDLPH0sTb75J/VctpfD5wDtR/DLfa2NU8R8R
	 oEOmiIcIXDIs0Tk6gLKQDTtZbofkpikzBSK4JXoVbltWLErJog//+bAM9/2JnO/uveHSu
	 hi59rAm1f3E0n11IIw8bGg6y/Z3urYmUhet6xWCIsGSkseOuMSab6FzzUdxoNc6ArFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjmfLr4t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C5F606B783;
	Tue, 24 Nov 2026 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjmfLr4t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366391F0157F;
	Tue, 24 Nov 2026 09:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513765;
	bh=gxDJEG4ECCixBI+jObWBIWZPiO5kbGYkrtOcQ6MxwLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WjmfLr4tnmrKSf0NqOeWbj+53Bvnv/aL+2cFDYxM4CZIYPcO5dhScA1yJgTasE+As
	 ukLcFid27f++zEm28fU+dum5jpdyhnMNfTanDA7FzGC2yZm3EDJzsVSgyGVjo6jVHi
	 uSUKdTzCWcq6rFkdYN2ZISkvDsO5H0SVcreJPr2c8vhrNUXHxMMdzcLoBnRisQBZwD
	 01tlaW7U/tzqYP9SGAu/yxmMOhdDgktvgVTuYEIkmipJyBYNWk6HKi3p+FK5Iz9ffw
	 VOwPZVy5/slRDMTPx0nch+Tp27YnrLQ4x+q7BN9ss8JDeyUEPwRvUHVnTwvKcVXXUk
	 ccTokDzHnVu8A==
Message-ID: <sashiko-outbox-230870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/15] asm-generic: add an in-kernel auxvec.h header
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>, "Kees
 Cook" <kees@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261123-at-vector-size-arch-v3-3-d342dae9e843@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
 <20261123-at-vector-size-arch-v3-3-d342dae9e843@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 09:49:24 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] asm-generic: auxvec.h unconditionally redefines
  AT_VECTOR_SIZE_ARCH to 0
--

commit 0c922d7a496b0d1a5af6ec9787042de6d54ad285
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

asm-generic: add an in-kernel auxvec.h header

This commit adds an asm-generic/auxvec.h fallback header as mandatory-y
and includes uapi/asm/auxvec.h and asm/auxvec.h from linux/auxvec.h.

> diff --git a/include/asm-generic/auxvec.h b/include/asm-generic/auxvec.h
> new file mode 100644
> index 0000000000000..b5f73f35e21ce
> --- /dev/null
> +++ b/include/asm-generic/auxvec.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_GENERIC_AUXVEC_H__
> +#define __ASM_GENERIC_AUXVEC_H__
> +
> +#define AT_VECTOR_SIZE_ARCH 0
> +
> +#endif /* __ASM_GENERIC_AUXVEC_H__ */
> diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
> index 4b364e639f080..de1c33c4a2560 100644
> --- a/include/linux/auxvec.h
> +++ b/include/linux/auxvec.h
> @@ -2,7 +2,9 @@
>  #ifndef _LINUX_AUXVEC_H
>  #define _LINUX_AUXVEC_H
> =20
> +#include <uapi/asm/auxvec.h>
>  #include <uapi/linux/auxvec.h>
> +#include <asm/auxvec.h>
> =20
>  #define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table=
 */
>    /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTE=
LF} */

[Severity: High]
Does defining AT_VECTOR_SIZE_ARCH unconditionally in asm-generic/auxvec.h
redefine and clobber AT_VECTOR_SIZE_ARCH on architectures that still
define it in uapi/asm/auxvec.h?

For any architecture that does not yet provide its own asm/auxvec.h
(such as x86, arm64, riscv, powerpc, s390, mips, loongarch, sparc, sh,
and alpha at this point in the series), mandatory-y generates an
asm/auxvec.h wrapper around asm-generic/auxvec.h.  When linux/auxvec.h
includes uapi/asm/auxvec.h followed by asm/auxvec.h, AT_VECTOR_SIZE_ARCH
is redefined to 0, breaking the build under CONFIG_WERROR=3Dy and shrinking
AT_VECTOR_SIZE and mm->saved_auxv[] when built with CONFIG_WERROR=3Dn
(which causes create_elf_tables() to write past the end of
mm->saved_auxv).

Later patches in the series migrate those architectures out of
uapi/asm/auxvec.h one by one, leaving intermediate commits broken for
bisection.  Since linux/auxvec.h already provides an #ifndef
AT_VECTOR_SIZE_ARCH fallback to 0, could asm-generic/auxvec.h omit the
AT_VECTOR_SIZE_ARCH definition or guard it with #ifndef
AT_VECTOR_SIZE_ARCH?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-at-vector-=
size-arch-v3-0-d342dae9e843@linutronix.de?part=3D3
