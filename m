Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE192FD675;
	Thu,  9 Jul 2026 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783562640; cv=none; b=powbn4MihbM9ODt0Avz+lwIBoOc4ccPwowKcHnf1wkeDYlKFQ0ODJ+YBIbJAUONef73UtM3xT50xui0mD07PFOwrO5/Yiraug2/lxzhlaWjjUsr6v6sYPP2YXHKb2O20HDn9Yam9u6tE73q81EQ9p2RFeDmd2tlQEA1jQTg7TPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783562640; c=relaxed/simple;
	bh=A8uKffNVQt9rhMONccpVOoTFhw1tjloY/FT5kLhs89A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qLnvoWLwREIfaoaw44TWfljbHGFKCi/oM55NXWcr7Alp8gxz0gXzG0v2r/eiAhQrO8zu7swBvsnQggN2hN4KYbxxW9KhyMPHdeSApPOpKwCsQkkayFdnY1mWsN9WLFAOyn+SbxL238yWAbYh1ZXtY6ntDbqrDkvZfhTDxosnFrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AWDuAsAD; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AWDuAsAD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SbMumxZtxbvkP/ieepXLg1JhrafzB20Wq2MZPkH/Sw0=;
	b=AWDuAsADSwEvEL71EYfZ0NigOV6Nm/EE0o+eCaP1xQFlxhq8DY4cyFSYwdUDcA872iUYRmCcL
	fgkqFmw2f6REMuKThf5T1j9G/cENjZayXtYg+Tp2Kdo8RhfXnSpSgOVUD3wzxl53MN4FlPjvW4S
	5jTBmgoFDxvMSl13ULhIb7E=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gwdLg6g1HzKmWh;
	Thu,  9 Jul 2026 09:54:35 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id D94DC40578;
	Thu,  9 Jul 2026 10:03:52 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jul 2026 10:03:50 +0800
Message-ID: <cb27984f-bb8e-4deb-90f2-c3c9965b3017@huawei.com>
Date: Thu, 9 Jul 2026 10:03:49 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
	<mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	<linuxppc-dev@lists.ozlabs.org>, Kees Cook <kees@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, <loongarch@lists.linux.dev>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	<linux-riscv@lists.infradead.org>, Sven Schnelle <svens@linux.ibm.com>,
	<linux-s390@vger.kernel.org>, <x86@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Andy Lutomirski <luto@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Russell
 King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
	<richard@nod.at>, Chris Zankel <chris@zankel.net>,
	<linux-arm-kernel@lists.infradead.org>, <linux-alpha@vger.kernel.org>,
	<linux-csky@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <linux-um@lists.infradead.org>, Arnd Bergmann
	<arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
	<will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
	<monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
	<linux-snps-arc@lists.infradead.org>, <linux-hexagon@vger.kernel.org>,
	<linux-openrisc@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, =?UTF-8?Q?Michal_Such=C3=A1nek?=
	<msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260707190254.493733289@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 7/8/2026 3:07 AM, Thomas Gleixner wrote:
> Invoking sys_ni_syscall() from a code path, which already knows that the
> syscall number is invalid just to assign -ENOSYS to regs->ax is a pointless
> exercise. It's even redundant as the low level entry code already has set
> regs->ax to -ENOSYS on entry.

Makes sense, the all reltaed entry has already initialized
regs->ax to -ENOSYS.

This makes the code very concise.

LGTM
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

> 
> Remove the extra conditionals and the function calls.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  arch/x86/entry/syscall_32.c |    2 --
>  arch/x86/entry/syscall_64.c |   10 +++-------
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -81,8 +81,6 @@ static __always_inline void do_syscall_3
>  	if (likely(unr < IA32_NR_syscalls)) {
>  		unr = array_index_nospec(unr, IA32_NR_syscalls);
>  		regs->ax = ia32_sys_call(regs, unr);
> -	} else if (nr != -1) {
> -		regs->ax = __ia32_sys_ni_syscall(regs);
>  	}
>  }
>  
> --- a/arch/x86/entry/syscall_64.c
> +++ b/arch/x86/entry/syscall_64.c
> @@ -68,7 +68,7 @@ static __always_inline bool do_syscall_x
>  	return false;
>  }
>  
> -static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
> +static __always_inline void do_syscall_x32(struct pt_regs *regs, int nr)
>  {
>  	/*
>  	 * Adjust the starting offset of the table, and convert numbers
> @@ -80,9 +80,7 @@ static __always_inline bool do_syscall_x
>  	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
>  		xnr = array_index_nospec(xnr, X32_NR_syscalls);
>  		regs->ax = x32_sys_call(regs, xnr);
> -		return true;
>  	}
> -	return false;
>  }
>  
>  /* Returns true to return using SYSRET, or false to use IRET */
> @@ -92,10 +90,8 @@ static __always_inline bool do_syscall_x
>  
>  	instrumentation_begin();
>  
> -	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
> -		/* Invalid system call, but still a system call. */
> -		regs->ax = __x64_sys_ni_syscall(regs);
> -	}
> +	if (!do_syscall_x64(regs, nr))
> +		do_syscall_x32(regs, nr);
>  
>  	instrumentation_end();
>  	syscall_exit_to_user_mode(regs);
> 

