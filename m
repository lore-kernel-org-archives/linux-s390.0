Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E232B3BC680;
	Tue, 30 Jun 2026 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837476; cv=none; b=ppDjQinKcDrKIbdKPZ5sN3IeolcQ5GvGpN2oox6S5iIw6WLY4Gy5TzJztCPrXg6XDx3lid1xElnv1yFY6NEp6fxYbn45gCHCAF9HJYB1PGUYy1bgPL5m4ooiLG+Zs0HVwXhtYNe5t3gYg8FGPq0ktEbFhRI3n3eCK/2pDWBO/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837476; c=relaxed/simple;
	bh=g58E1RgBOT17YggIpVtjm4i/yrYpROSWqIGglQToKUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=bEuBkn96I4GnmW7ZbggJeZ5EeLGIjwjwnoaaHc0eAiZY1PbYdckCSVgw6C3FT+1JKfsQzOnmFEv2n2AA0yGij9lWISbJnovIJGNhns847JooOV4FN6jd3lsfD6Yv9BZWRCMZ/q9+zZn6XGkdmoJrwm9i8NKvnTJ8MTjV0duSf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IGK2WudX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IGK2WudX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87ECB2ED2;
	Tue, 30 Jun 2026 09:37:47 -0700 (PDT)
Received: from [10.2.213.21] (e137867.arm.com [10.2.213.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B88B3F85F;
	Tue, 30 Jun 2026 09:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782837471; bh=g58E1RgBOT17YggIpVtjm4i/yrYpROSWqIGglQToKUc=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=IGK2WudX+PJaEpGGXXw64zx0sjng8/eaN/Rh3Y+MvJrSMyCQKQtzGmNp6HkLRKA59
	 UH+tXBYKY5mFl0tT6enV58lfXSTXvmDvSwWLrhGO+5GYcT+gQbhYP07y57q7fZhefg
	 NWM6IkC2lsMLKtWLWUb174guV8D8FtaPJLeizbpQ=
Message-ID: <b8f3b5cd-8d8a-4396-ba0c-011a83234dd9@arm.com>
Date: Tue, 30 Jun 2026 17:37:39 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/18] seccomp: Convert __secure_computing() to return
 boolean
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-2-ruanjinjie@huawei.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>, oleg@redhat.com,
 richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
 linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
 kees@kernel.org, guoren@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, geert@linux-m68k.org, tsbogend@alpha.franken.de,
 James.Bottomley@HansenPartnership.com, deller@gmx.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
 glaubitz@physik.fu-berlin.de, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, luto@kernel.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, peterz@infradead.org, wad@chromium.org,
 thuth@redhat.com, mark.rutland@arm.com, kevin.brodsky@arm.com,
 linusw@kernel.org, yeoreum.yun@arm.com, song@kernel.org,
 james.morse@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
 liqiang01@kylinos.cn, pengcan@kylinos.cn, ryan.roberts@arm.com,
 yangtiezhu@loongson.cn, sshegde@linux.ibm.com, mchauras@linux.ibm.com,
 austin.kim@lge.com, jchrist@linux.ibm.com, arnd@arndb.de,
 thomas.weissschuh@linutronix.de, sohil.mehta@intel.com,
 andrew.cooper3@citrix.com, jgross@suse.com, kas@kernel.org, x86@kernel.org,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
Content-Language: en-US, en-GB, fr
Organization: Arm Ltd.
In-Reply-To: <20260629130616.642022-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jinjie,

On 29/06/2026 14:05, Jinjie Ruan wrote:
> The return value of __secure_computing() currently uses 0 to indicate
> that a system call should be allowed, and -1 to indicate that it should
> be blocked/killed. This 0/-1 pattern is non-intuitive for a security
> check function and makes the control flow at the call sites less readable.
>
> Furthermore, any potential future changes to these return values would
> require a high-risk, error-prone audit of all its users across different
> architectures.
>
> Sanitize this logic by converting the return type of __secure_computing()
> to a proper boolean, where 'true' explicitly means 'allow' and 'false'
> means 'fail/deny'.
>
> Update all the two dozen or so call sites across the tree to align with
> this new boolean semantic. No functional changes are intended, as the
> callers still return -1 to the lower-level assembly entry code upon
> seccomp denial.
Would it be relevant to mention that this fixes the unsound return value of
`syscall_trace_enter()` in generic entry, which motivated the patch 
initially[0] ?
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   arch/alpha/kernel/ptrace.c            |  2 +-
>   arch/arm/kernel/ptrace.c              |  2 +-
>   arch/arm64/kernel/ptrace.c            |  2 +-
>   arch/csky/kernel/ptrace.c             |  2 +-
>   arch/m68k/kernel/ptrace.c             |  2 +-
>   arch/mips/kernel/ptrace.c             |  2 +-
>   arch/parisc/kernel/ptrace.c           |  2 +-
>   arch/sh/kernel/ptrace_32.c            |  2 +-
>   arch/um/kernel/skas/syscall.c         |  2 +-
>   arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
>   arch/xtensa/kernel/ptrace.c           |  3 +--
>   include/linux/entry-common.h          |  7 +++---
>   include/linux/seccomp.h               | 10 ++++----
>   kernel/seccomp.c                      | 34 +++++++++++++--------------
>   14 files changed, 36 insertions(+), 38 deletions(-)

This is missing an update to the Kconfig documentation, a possible
suggestion :

diff --git a/arch/Kconfig b/arch/Kconfig
index fa7507ac8e13..9e3d40088afb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -637,7 +637,7 @@ config HAVE_ARCH_SECCOMP_FILTER
           - syscall_set_return_value()
           - SIGSYS siginfo_t support
           - secure_computing is called from a ptrace_event()-safe context
-         - secure_computing return value is checked and a return value of -1
+         - secure_computing return value is checked and if false
             results in the system call being skipped immediately.
           - seccomp syscall wired up
           - if !HAVE_SPARSE_SYSCALL_NR, have SECCOMP_ARCH_NATIVE,

> [...]
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 416a3352261f..3f66320e46d3 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -100,9 +100,8 @@ static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned l
>   
>   	/* Do seccomp after ptrace, to catch any tracer changes. */
>   	if (work & SYSCALL_WORK_SECCOMP) {
> -		ret = __secure_computing();
> -		if (ret == -1L)
> -			return ret;
> +		if (!__secure_computing())
> +			return -1L;
>   	}
>   
>   	/* Either of the above might have changed the syscall number */
> @@ -113,7 +112,7 @@ static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned l
>   
>   	syscall_enter_audit(regs, syscall);
>   
> -	return ret ? : syscall;
> +	return syscall;
>   }
> [...]

Otherwise this feels like a more appropriate change with regards to
"safeguarding against new `secure_computing()` return value" !

With the updated Kconfig :
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>

Thanks,
Ada

[0]: 
https://lore.kernel.org/r/20260511092103.1974980-2-ruanjinjie@huawei.com

