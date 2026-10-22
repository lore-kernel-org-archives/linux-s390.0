Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696563;
	b=HfAyZa+alXaQN+LNDIUfFeD++cMlKDv0VoR7Y6nc7yOtsQRUB0Zt92AZ2JPUrLxebeQ4
	 tfQxwZO8TdK3C7R3tVuyTEmdkghq/MweXyOK1kq9kwpwdTcomaOlskGMylmFpKC3Vck3h
	 z7VtBm4AzcI3ETrdeVk45lCqc78yAgJwsKB12vpyB4oipuOetEw7UPUveuJVnp0nYwvqY
	 pn6iflOxu9mOkNlbT8npwKzGhI7lsQ3FL6LuaYicgIC8uZdFZ2krzZ1i522d5hDkalPfs
	 ezoxAUE7hOVhKWgLkh7SFFZt+ZRDWvpnp4YHvmoNbg7cihyg3H6JSSzgNMoCPLnmggQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696563;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zfF/h5yN+JN0JXoERjM1UOmD6YL51qlegqbjQ5IjJaw=;
	b=yisF+d1m+E7vIaljbDjCjb0bCmnmDMdBaP77FAtYOJI5F4AW59kGTAfzdgUZyttgnngP
	 UWsXOnMn1hev1UdKAVdfYsp2V81KRKVqzJA363Aaa0jZggJynSp8bEijV3RulrzC6Gcr5
	 MtObWINWwc2qwa83rAWXzqmjoa/BGUDrRQkqrAzaGdAjz5bfefKxm80EUOixHrWqHVakj
	 9fwoj+5ad03k1egP2xLmuS5Hab+GF6cXb85K4fi4QBGYltjTTmkDEZboU1b7YZnMAaWjY
	 H38MR8iPMSHWjiptHGGp3k2YRVghrQBzRPbNVqTh/rMpoB+DwBTJ4zaJjAdZ6KNMSKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5BvSZtD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C86606A31A;
	Thu, 22 Oct 2026 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5BvSZtD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE1F1F01825;
	Thu, 22 Oct 2026 19:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696563;
	bh=zfF/h5yN+JN0JXoERjM1UOmD6YL51qlegqbjQ5IjJaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=N5BvSZtDsOnevI6N7z+hpnuDFwgb+Za20bBfcyPl1zdZ/RUM/vhVGgooCl8EukmyB
	 v951DfxEQIGKmPlqDa47vEV9oOJpjd3jTdFHzFJ8cGbv5Ec+77S428dvBazQLk752d
	 8oijRTx04uvdE5t0WJ3hFRzAydPhPUU1uC5jEb9/jBb3UCG/5+2vXEPMQ0qv3aaJy/
	 fDrmEd5ydsQk2Juig/QI4K6qM7Xm060UN2bTZPYYJFIjTdDkBvnz/aEeUGpDN6dDMG
	 QYnQUY/lk7t3H2ZOK5q9Ex67PolYwOb50JpOTpWf5Zn6NIH8OuYBLaiHmJRlGX+jMg
	 L4eC2BtuFHQ4g==
From: Thomas Gleixner <tglx@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
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
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
In-Reply-To: <20261022142425.3Wx-RrU5@linutronix.de>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de>
Date: Thu, 22 Oct 2026 21:15:59 +0200
Message-ID: <87fqxx1r80.ffs@fw13>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22 2026 at 16:24, Sebastian Andrzej Siewior wrote:
> On 2026-07-07 21:07:01 [+0200], Thomas Gleixner wrote:
>> Invoking sys_ni_syscall() from a code path, which already knows that the
>> syscall number is invalid just to assign -ENOSYS to regs->ax is a pointl=
ess
>> exercise. It's even redundant as the low level entry code already has set
>> regs->ax to -ENOSYS on entry.
>>=20
>> Remove the extra conditionals and the function calls.
>
> Since this patch, tools/testing/selftests/x86/syscall_numbering_64
> throws in this:
> |[RUN]   Running tests under ptrace: modifying the default return
> |[RUN]       Checking system calls with msb =3D 0 (0x0)
> |[RUN]           Checking some common syscalls as 64 bit
> |[OK]                x64 syscall 0:0 returned 0 as expected
> |[OK]                x64 syscall 0:1 returned 0 as expected
> |[RUN]           Checking some 64-bit only syscalls as 64 bit
> |[OK]                x64 syscall 0:19 returned 0 as expected
> |[OK]                x64 syscall 0:20 returned 0 as expected
> |[RUN]           Checking out of range system calls
> |[FAIL]                  x32 syscall 0:-64 returned -9999, but it should =
have returned -ENOSYS
> =E2=80=A6
> |[FAIL]                  x32 syscall 0:-2 returned -9999, but it should h=
ave returned -ENOSYS
> |[FAIL]              x32 syscalls 0:-64..-2 had 63 failure
> |[OK]                x32 syscall 0:-1 returned MODIFIED_BY_PTRACE as expe=
cted
> |[FAIL]                  x64 syscall 0:1073741760 returned -9999, but it =
should have returned -ENOSYS
> =E2=80=A6
> |[FAIL]                  x64 syscall 0:1073741823 returned -9999, but it =
should have returned -ENOSYS
> |[FAIL]              x64 syscalls 0:1073741760..1073741823 had 64 failure
> |[FAIL]                  x64 syscall 0:-64 returned -9999, but it should =
have returned -ENOSYS
> =E2=80=A6
> |[FAIL]                  x64 syscall 0:547 returned -9999, but it should =
have returned -ENOSYS
> |[FAIL]              x64 syscalls 0:512..547 had 36 failure
> |[RUN]           Checking some common syscalls as x32
> |[OK]                x32 syscall 0:0 returned 0 as expected
> =E2=80=A6
> |[RUN]           Checking out of range system calls
> |[FAIL]                  x32 syscall 1:-64 returned -9999, but it should =
have returned -ENOSYS
> |[FAIL]              x32 syscalls 1:-64..-2 had 63 failure
> |[OK]                x32 syscall 1:-1 returned MODIFIED_BY_PTRACE as expe=
cted
> |[FAIL]                  x64 syscall 1:1073741760 returned -9999, but it =
should have returned -ENOSYS
> =E2=80=A6
>
> and so on=E2=80=A6 The test has
>
> | #define MODIFIED_BY_PTRACE      -9999
>
> and the ptracer modifies the return code. However not always. Not sure
> if this was indeed a pointless exercise or not.

Hrmm. That's weird. Let me have a look.
