Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765465;
	b=h5Xf2Cl+pRGtPtBAj5JBEs/h/JvvUUbi76++5mfyI14hQ71DQ8I8SnNpYSsxHQX8zkgf
	 uMXhawSeD+jw5KTdxKtANSwl/dY9f6h7amuhjD4rGY3PYkoDEM7y9VWy1bMI1I3CGcnt6
	 AlIrEyT0ERwMyXxRRi7unUejL1yGtuW9OtxcaksNQIJSq3kPCkje/c92RRWLz9X/03TKa
	 t+CqQnsUuQI9RyM4wrlikqtOqKK8ueb1km3Lnhr1uMztNc+g3nqEKovtOaBxKpob4w/Ur
	 zQkrFxPxedQfTiZnxe83KhxEeaCJGiwBP8UD4vCinhF9CJ7nhyeFkVZE7VQNgW0rPGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765465;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=5dVR3TN7s3BdKhx2Ut/LouYZioYZObIc2PPzWKi4iy0=;
	b=IVzLLUvgti0enXxjDX4CLenjk8H6H8by6pynvCIB5QwXXRaAA6Zot2Bw0K7kKeTxRktJ
	 kF4B5r5gwJOmDaxnooT0IgGcpyB6s0BuUkbK10HfJF0KJy+qIOMIchqo3ZCAzpxM3RNqq
	 PHSnq3Oj1Vnif2TvIznLVjQ4Ie7mMbIgrQ7d75Wn1JZ66WLRkwFKUnMYtNYSXiCvEt583
	 XHnpdrXSW2dSxGnVR27AI+BrDU1AJwKeCmCN+YtW4NZ22cmEsXveVIZYdV9Ol/VmZRxvK
	 iwOUhnHkWXA2llKRgSVwLXsxmZrKAsXhAc5G0fXvnV6QHJiCKiplgVc9oPoIWfud4gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGNPKBGI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573FA606A31A;
	Fri, 23 Oct 2026 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGNPKBGI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0661F01825;
	Fri, 23 Oct 2026 14:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792765465;
	bh=5dVR3TN7s3BdKhx2Ut/LouYZioYZObIc2PPzWKi4iy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=QGNPKBGIM2nRqkKIph4PyfYBLDWc+lEnWMiWgVtxwooARZZ9SksPaTdnwkXyuu1hL
	 nk1UY5lGPBZ7kPogJATkcg91O10/O55644Zn6yf5rahNDQfePsiARGjnGgHZ/RRNvM
	 v2USrBHYe7FDy0YLLvQD6DXcJ/ItGULufyA+LwI+iOZPVLkyOrC+syuFQm9J2T/eLf
	 4v3jT2c7tUqv4XJJd9a/ogzIpSbdMeU3iXMmcWRG3nOZGarZFTww/6QGrIblnPKTZ1
	 ikA1j2sJ/lw2/ZIqvDAR0r9qjofZYtRynG/e/2di/XcOimoeGFqQqzI0vjpx4iDGhR
	 hMbtJWz0jUwQw==
From: Thomas Gleixner <tglx@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Shrikanth
 Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
In-Reply-To: <871p9g1s3w.ffs@fw13>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13> <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
 <871p9g1s3w.ffs@fw13>
Date: Fri, 23 Oct 2026 16:24:22 +0200
Message-ID: <87y0boze95.ffs@fw13>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 23 2026 at 15:09, Thomas Gleixner wrote:
> On Thu, Oct 22 2026 at 17:22, H. Peter Anvin wrote:
> Tired brain misread the test output:
>
> [RUN]   Running tests under ptrace: modifying the default return
> [RUN]       Checking system calls with msb = 0 (0x0)
> [OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
> [OK]                x32 syscall 0:-1 returned MODIFIED_BY_PTRACE as expected
> [OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected
>
> But that's because the "-1" on x32 is actually 0xFFFFFFFF while on x64
> it's 0x7FFFFFFF.
>
> The whole mess comes from using -1 as indicator for syscall abort which
> is undistinguishable from a syscall(nr=-1).
>
> Bah. Let me restore this nonsense.

The real question is how we ended up there. By design or as an
implementation detail which got later set in stone and the selftest was
written to test the implementation instead of testing against a
specification.

I went back in history and in 2.6.12 the behavior was for both i386 and
x86_64:

  regs->ax = -ENOSYS;
  syscall_trace_enter();
  if (syscall_nr < MAX)
  	do_syscall();
  ....

IOW, a tracer modification of regs->ax is not overwritten when the
syscall number is out of range.

Between 2.6.19-rc2 and -rc3 x86_64 was changed to _always_ overwrite
regs->ax when the syscall number is out of range.

In the 3.8 merge window seccomp introduced the -1 == skip bogosity which
got fixed up and made "consistent" in several changes afterwards. Just
that it never reached a state of consistency due to the overloading.

So are we stuck with this behavior or do we sit down and define what the
correct behavior should be?

Thanks,

        tglx


