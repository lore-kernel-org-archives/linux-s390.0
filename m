Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760951;
	b=KZfH0gx3msl/Bn7qRvB8RQW2seTqh9Bp0QLnqi787oj/4YukKaH9vS3g7ut4P7IBNdpQ
	 EhgudNDSXZEHJA5wzPbZDGXyH9tpxx9SjPV93qk1fDFCs3oIX5iStaRADLv0jZUeLXukR
	 zxZEb4ftIFOjGeEbDp98O/+Qf8fLqG2Mph8tkKRC1BVIhH+BSAuafvTFHJdGFtw02P970
	 cXMSjn1CQdvF91A67TIFQUJY6wKOjeVuQyzWuza7LT++gZUWVtue5UI3gpqsW/OETOAZ0
	 yfKn2qnzarNyQvoTcW/iITKbHKcYbrrIvBqXioTim+AMtNTGCx7ci68FUW3TH+LVV1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=nlznPFw9V2Gc6GAfgQKy3QilQuYPxjyao4Hf2pcvcDM=;
	b=s6KSrQF+WQc8RKQaqEzaenXXv1VNp+aIixnzryolWCvOntYBEc1JptESt3LXaid6bzct
	 FCy745YM/+cn84xvdvdH5lHdkJIu8ENJOUqjMNIHhFSPbGAurB/kCT/+bld9rjOJWyuuZ
	 b02aMjHAPyFKn2zhmLADYeAdPon1a7VyMf6Sw5jX4dn80fqdzt4GNNwGkcnZRh4T094Au
	 vvkWubCv9dftr3BvCmjeNUQILsQXGbeyShElsKRZuxCTHC4PzYaQliX2JGczQxSs8e3x2
	 QStNpcTxmip+WrFxhzvhSwRFYoE0w3/Ob/YD8p+sOB/CVzy0gtPa3e4wqTq6jtM41ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m7RG/5lG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24012606A31A;
	Fri, 23 Oct 2026 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7RG/5lG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFE51F01825;
	Fri, 23 Oct 2026 13:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760950;
	bh=nlznPFw9V2Gc6GAfgQKy3QilQuYPxjyao4Hf2pcvcDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=m7RG/5lGWSbIc838b0jmvSS290uWfurhu3YNfo5bVNzSTvTPTC7ghSWC8leVP3nQ+
	 b1I3jDHg/InxLf552w5eGHsTrs/J6pcIRU/3j2o4lXMu8kdY2pE31lXQZ6mDuOD9a9
	 /bZSvE9+INNA1eyAemAPUHtpahZxa52CO1uiN/pTg/xq6n5EpQE55LyKwMgvscOovl
	 vpke1gUvPTZai31N3aWvQD3q3fnksvGf8uxqyvKnNdAccPdM5DjsmOgJhH0dNQrOqX
	 DgjQebBUKnbd01GrrL7MPL69Sel1P4/LLNB/kJOWZzm+JYUNtbLukoPTq27kTGyxJT
	 /kgHrVGsqnwng==
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
In-Reply-To: <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13> <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
Date: Fri, 23 Oct 2026 15:09:07 +0200
Message-ID: <871p9g1s3w.ffs@fw13>
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

On Thu, Oct 22 2026 at 17:22, H. Peter Anvin wrote:
> On October 22, 2026 2:34:08 PM PDT, Thomas Gleixner <tglx@kernel.org> wrote:
>>-static __always_inline void do_syscall_x32(struct pt_regs *regs, unsigned long nr)
>>+static __always_inline bool do_syscall_x32(struct pt_regs *regs, unsigned long nr)
>> {
>>+	if (!IS_ENABLED(CONFIG_X86_X32_ABI))
>>+		return false;
>>+
>>+	/* Preserve the historic insanity of treating -1 special on x32 */
>>+	if (nr == ULONG_MAX)
>>+		return true;
>
> It was never limited to x32...

Tired brain misread the test output:

[RUN]   Running tests under ptrace: modifying the default return
[RUN]       Checking system calls with msb = 0 (0x0)
[OK]                x32 syscalls 0:-64..-2 returned -ENOSYS as expected
[OK]                x32 syscall 0:-1 returned MODIFIED_BY_PTRACE as expected
[OK]                x64 syscalls 0:-64..-1 returned -ENOSYS as expected

But that's because the "-1" on x32 is actually 0xFFFFFFFF while on x64
it's 0x7FFFFFFF.

The whole mess comes from using -1 as indicator for syscall abort which
is undistinguishable from a syscall(nr=-1).

Bah. Let me restore this nonsense.

Thanks,

        tglx



