Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75734425878;
	Sat, 29 Aug 2026 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788037971; cv=none; b=vFO02VJrX73hskSfX0KFumFJorLdqlQhkH74Vff9anStk5zWBuu6YpAAd3XpHjhRsKb0la1cPKe+Ywun/OKzVavIpUmeBNw/n8B+0LZNXqWXQe9CvRkRjJrHSNQmq6tI0Nrh7bXfQcSE3bY5HdVg6UF2tdizn7YsALAObSxGvh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788037971; c=relaxed/simple;
	bh=RtxV5GtLCFd5Nxwwhw4byzarzWlVmnm61EaGDtON7B4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EeYqcJerSpvnXmb/PJIHuefuHGf0Yhfyb8DAtomtaj+b96HijEqzIlWLSBq8RrAJ1Akf35xkEFQ9Qsfq8jdOjmi9wiigV+GXHmdS6o0AGuqru6lfeS4xnQSmMfaCV9OhZ/UnbBkT9XpQIdaOvofR25fwMuQnAsCc4SyU4HEu5HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1seToYo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1seToYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649AD1F000E9;
	Sat, 29 Aug 2026 21:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788037970;
	bh=Dtc/3TiWrxvKp0avjjHTAnH0zP9eaKC6iJzs8wdLbVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=n1seToYoBBT3aH6XYy57AvAYoTN8Sa1DDhmW2pGm9sBs8rkBWyAhcowrHekDBroX/
	 LQ9shz0t6AxoS/RQDPShfDSc0m9IWLcU9cIQJq3FkW1jzrInW5+Iv/KAuW8URYVB2n
	 2vCrp2pcnJfrchIq4fTPd7v9FJeK1MDe0dV9wrUv3zK9IWSwAUoaPxvg0yAGixhM4c
	 Z9dwi/DUpv4kJC8uG3byshQrVjTrnzKYKROHUXMRnPyH/qBRKuo9hNfxOcn7FEeewO
	 jvzQ+uh7MKEZRseKSgUEU40CtjsBO3Ee/xgR+WN5+SACHRv8m1z/ulKCStwZ7OqVFK
	 esh+04RW4xs+A==
From: Thomas Gleixner <tglx@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland
 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
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
Subject: Re: [patch 03/18] entry: Provide
 [syscall_]enter_from_user_mode_randomize_stack()
In-Reply-To: <995a61ef-ce8c-4c8b-bea8-77f375076a39@zytor.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.816918647@kernel.org>
 <995a61ef-ce8c-4c8b-bea8-77f375076a39@zytor.com>
Date: Sat, 29 Aug 2026 23:12:47 +0200
Message-ID: <87bjakeils.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 27 2026 at 15:46, H. Peter Anvin wrote:
> Can anyone *please* find out what the actual security requirements are for the
> syscall randomization offset?
>
> The original checkin, 39218ff4c625 ("stack: Optionally randomize kernel stack
> offset each syscall") indicates that it is fundamental that the stack offset
> is applied *after* pt_regs pushing, but that isn't documented anywhere in the
> kernel sources as far as I can tell.

> However, I have also come to understand that there are further, undocumented
> constraints; at least at one point I was told that "the offset should not be
> stored in memory while running in the kernel", which seems more than a bit odd.

This thread has the initial discussions about it with more explanations:

  https://lore.kernel.org/kernel-hardening/2236FBA76BA1254E88B949DDB74E612BA4BC57C1@IRSMSX102.ger.corp.intel.com/

Thanks,

        tglx
