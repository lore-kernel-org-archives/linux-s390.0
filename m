Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257D40861C;
	Wed,  8 Jul 2026 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502115; cv=none; b=jXckOTx/4QqondwWvg3sOpmukA0lehJEAdlVVGktku2/cDmmbcjrRMd5h4B3UI9ocpgVXtI2UEmjbsGKL6oXoh7NpcTdJzOqENJymYdCRze7irleLdO+4wS2E9sJxcrhyftL1oGuBGWbuRAZqQP+jMgEizFknpwtVLr0I4xun1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502115; c=relaxed/simple;
	bh=SRkB/8NeU7bs34ctpapaBV36fJTXyPj0DgisaqC60Yo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZtyWwbW0qDsOBt3OP5ruG5q+T1ilUK6BS3SCUDH5R3mglPTauZDs8ghqXcuQzJJ0Lilo0LT8yKlxfwgFuUvb2HrwRA3pcizqbYgsV0lVZBGrkKkZSC7uVvGG0pLt6KEinimw2A4Lx6EOlsOdmwmAVC8/gOdojltrhq3c0kLwAPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFMxLuEi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFMxLuEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D697D1F00A3A;
	Wed,  8 Jul 2026 09:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783502113;
	bh=QXKIkU3dsIb83LaNl9YeImi7A85K1dyuGPQma33N644=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DFMxLuEi7KbiLxKOKr7+5tYyHQCk3JpHfb6tuRzE2WRkuMx1mPUf9jIugzEHb8/5x
	 LO8Xyowg5mKltHMmbDOr+gi5tZvNMk+K5CLlhuwiVeBNQv3EKRcMCXRbA9wKg3qjXN
	 yktK4sMH/4XosacPFHJ3cmJotsn19Buu9FUV++AMzk2yr3c1ztSf7A6xr+F2FPufYH
	 7C4ovIQAnZoRC6G/Qa1C+7b0RWd5ohzlBHkaLFo1vS55Av8D6fJzCv3nFP2MI70JYw
	 B1ItdudtjTbPFz/5q4TbBg2sVxB0g3L5dtrLprFMkBcrpN5g+UQIf8TbjYMP31tAm2
	 nw7+qD9T59MIw==
From: Thomas Gleixner <tglx@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Mark Rutland
 <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>, Andy Lutomirski
 <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>,
 Catalin
 Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Chris
 Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org,
 linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian
 Cain <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>, Dinh Nguyen
 <dinguyen@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andreas
 Larsson <andreas@gaisler.com>, linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Michal
 =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: Re: [patch 11/18] seccomp, treewide: Rename and convert
 __secure_computing() to return boolean
In-Reply-To: <2e6ed364-ce8f-4b4b-8675-acd07f140f4f@huawei.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.230735780@kernel.org>
 <2e6ed364-ce8f-4b4b-8675-acd07f140f4f@huawei.com>
Date: Wed, 08 Jul 2026 11:15:10 +0200
Message-ID: <871pddsuzl.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 08 2026 at 09:43, Jinjie Ruan wrote:
> On 7/8/2026 3:06 AM, Thomas Gleixner wrote:
> As Ada pointed out, the description of secure_computing in arch/Kconfig
> need to be updated, a possible suggestion:
>
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -636,8 +636,8 @@ config HAVE_ARCH_SECCOMP_FILTER
>           - syscall_rollback()
>           - syscall_set_return_value()
>           - SIGSYS siginfo_t support
> -         - secure_computing is called from a ptrace_event()-safe context
> -         - secure_computing return value is checked and a return value
> of -1
> +         - seccomp_permits_syscall is called from a ptrace_event()-safe
> context
> +         - seccomp_permits_syscall return value is checked and if false

Makes sense.
>>  		if (__seccomp_filter(this_syscall, true))
>> -			return -1;
>> +			return false;
>
> The return value of __seccomp_filter is checked in the wrong way, check
> -1 should be replaced with check false, maybe:
>
> -               if (__seccomp_filter(this_syscall, true))
> -                       return -1;
> +               if (!__seccomp_filter(this_syscall, true))
> +                       return false;

Ooops.
