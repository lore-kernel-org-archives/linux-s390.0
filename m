Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5CE416859
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011573; cv=none; b=mDMWmp+s8ko2fjmdG8JMsPUaYVYGduLjf2HbTTd/z10IJ4UQzcr5P2AbDFwCentixa2xLZk2Aar8x4sKxCADk6Btmk5dJ2wpToq+eNuDFezGa3hvu5iUDYRxCaqzvDyqY58Guj+1aeqmaCLHWD11s4c6A7nc3yz1M3tLInO65F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011573; c=relaxed/simple;
	bh=XJS9tc3VUmMiFDyL1UIfYhQyvHWypkLp+8qtOmaYltU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uWRCT1BqiikQ/G3/PT/AkWZbIzGzExD03SrN+ruStcFGJ/aXasQdzJQPOBKE7dRyxjNVrWpsrsHHkYNDN5VmXb9TCrfgwLlPUcXkEJ/wvcC93IImpvKlYzmHbiZLzu/lDzp6E/iTdRidL7VZuqolyjepu7kt1219iom47YhQi7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaL5+HkY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaL5+HkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AC31F000E9;
	Thu,  6 Aug 2026 10:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786011571;
	bh=mt1kC2nOFFeZ6QZMjrlZgkhWzWOC0IbtrLFEFTqbJuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZaL5+HkYE6jO5PNWUIArxKStJjYqwebMA7qKpu3hdoKOrCHhIKatSNqEP7P6bmyFU
	 8d+bPt1kaGh0wBwn67c86xMgrpSrxGu1c4RUFXNORZAJzXGwzWagj1rsTY6kqq8LCJ
	 +wLGyLw2oH/6qs9acLk3SsYnVMU1zZGPWMJBEJ86ySy3mwJ/PCIjz5TQ0rUNaMtJHS
	 ++fiUKrOwaq6pl8LSlweJ39Wcs34Qwl9ul5QCap+wbO1q/uJxG5Bpy9W+L54Lzmu/u
	 3zfWsMevysqJoI5zzl9Ozgmw/41y57cMgMZeeLYmqIjq6j/5YRmDy1TLVbdRh20HXW
	 MfvaeIghFHWpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/irqflags: add out-of-line definitions of
 arch_local_irq_*() for KMSAN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260806100038.3163298-1-iii@linux.ibm.com>
References: <20260806100038.3163298-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 10:19:30 +0000
Message-Id: <20260806101931.53AC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing KMSAN attributes on the `extern` declarations of `arch_loc=
al_save_flags` and `arch_local_irq_save` will cause spurious use-of-uniniti=
alized-value reports.
--

--- Patch [1]: [PATCH] s390/irqflags: add out-of-line definitions of arch_l=
ocal_irq_*() for KMSAN ---
commit 75ac5ab83800e65155075aeee91b3fd23aa6274d
Author: Ilya Leoshkevich <iii@linux.ibm.com>

s390/irqflags: add out-of-line definitions of arch_local_irq_*() for KMSAN

This commit moves KMSAN arch_local_irq_*() definitions out-of-line to avoid
warnings about static functions in inline functions. Uninstrumented
decompressor code keeps the inline definitions, while non-GPL modules see
the out-of-line versions.

Closes: https://lore.kernel.org/oe-kbuild-all/202607131219.euJHPSJ5-lkp@int=
el.com/

> diff --git a/arch/s390/include/asm/irqflags.h b/arch/s390/include/asm/irq=
flags.h
> index bcab456dfb803..44d158f7831e6 100644
> --- a/arch/s390/include/asm/irqflags.h
> +++ b/arch/s390/include/asm/irqflags.h
> @@ -37,18 +37,24 @@ static __always_inline void __arch_local_irq_ssm(unsi=
gned long flags)
>  	asm volatile("ssm   %0" : : "Q" (flags) : "memory");
>  }
> =20
> -#ifdef CONFIG_KMSAN
> -#define arch_local_irq_attributes noinline notrace __no_sanitize_memory =
__maybe_unused
> +#if defined(CONFIG_KMSAN) && !defined(__DECOMPRESSOR)
> +extern unsigned long arch_local_save_flags(void);
> +extern unsigned long arch_local_irq_save(void);

[Severity: High]
Since these extern declarations lack KMSAN attributes, will instrumented
callers expect a populated return value shadow in __msan_retval_tls?

When arch_local_save_flags() and arch_local_irq_save() are called from
instrumented code, the caller reads __msan_retval_tls. However, because the
corresponding definitions are marked noinstr:

arch/s390/kernel/irqflags.c:
noinstr unsigned long arch_local_save_flags(void)
{
	return __arch_local_save_flags();
}

instrumentation is skipped, and __msan_retval_tls is never populated before
returning to the caller.=20

Could this result in spurious use-of-uninitialized-value reports on every
IRQ state check or lock operation (like spin_lock_irqsave) when the kernel
is built with CONFIG_KMSAN?

> +extern void arch_local_irq_enable_external(void);
> +extern void arch_local_irq_enable(void);
>  #else
> -#define arch_local_irq_attributes __always_inline
> +#define arch_local_save_flags __arch_local_save_flags
> +#define arch_local_irq_save __arch_local_irq_save

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806100038.3163=
298-1-iii@linux.ibm.com?part=3D1
