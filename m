Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079238889B;
	Mon,  6 Jul 2026 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306722; cv=none; b=gI+Y1r1i9jXzYIRw1vt4GqHPMJ5l0sDvMzEvgGvmQO/L2qqQbfdoBVtHYnLUIqXW/6UpJ5dwRLJuJ5pNy6F0PIcJiVOWu9mqpYydEuQHRfOcN6wNUeNqdW5X41Mwf181psOe0s+eYWJshixPsPSFc/BbWybTSSrhmb/QLOEZ7tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306722; c=relaxed/simple;
	bh=zWMLAltis/gGzTCBAkuWo6mi2BsY773R0tgyf3USLhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SNxjgpxhWnd2LNWSi7+vNvcV0evl7SVASMOuC+w8aLEObFgaynVEYdMsJ2Q3Y0abeRfomtEwSlpsN0K6/4ocaC5pQ61eFLxImxdGbonlCJ1O4VMonADc7t7botXnHTBScPG0uqfgzZ2A63xsBqY59C/2lKINif3CbcEjxIuJ7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6kW0tTks; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6kW0tTks; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6kW0tTks";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6kW0tTks"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tLzU64zcWCpCqtKqdJfi72+8jOLqHwm6rAX9TlEnpBE=;
	b=6kW0tTks7I4JJHDfBVjF8dEaDL2J766PtNvpdA6LbQQFpMfTqMznvyBNQeh9wxbc/IYSzn3ZU
	f2djYQecToR3moTosPPfqQapkuoiHKQieMFK0sbmqWZPM62GXgOZ9REO2UonKr5TBLANxucel3h
	3onSIAA/PUlP2PaW4QIuLbU=
Received: from canpmsgout05.his.huawei.com (unknown [172.19.92.145])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4gtpWs5S8Wz126M0b;
	Mon,  6 Jul 2026 10:41:13 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tLzU64zcWCpCqtKqdJfi72+8jOLqHwm6rAX9TlEnpBE=;
	b=6kW0tTks7I4JJHDfBVjF8dEaDL2J766PtNvpdA6LbQQFpMfTqMznvyBNQeh9wxbc/IYSzn3ZU
	f2djYQecToR3moTosPPfqQapkuoiHKQieMFK0sbmqWZPM62GXgOZ9REO2UonKr5TBLANxucel3h
	3onSIAA/PUlP2PaW4QIuLbU=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gtpL20K7Pz12LHv;
	Mon,  6 Jul 2026 10:32:42 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 836134057A;
	Mon,  6 Jul 2026 10:41:22 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jul 2026 10:41:17 +0800
Message-ID: <e53b3d1f-c9fe-428c-bf1c-6505b3bcb894@huawei.com>
Date: Mon, 6 Jul 2026 10:41:16 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/18] seccomp: Convert __secure_computing() to return
 boolean
To: Ada Couprie Diaz <ada.coupriediaz@arm.com>
CC: <oleg@redhat.com>, <richard.henderson@linaro.org>, <mattst88@gmail.com>,
	<linmag7@gmail.com>, <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <kees@kernel.org>, <guoren@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <geert@linux-m68k.org>,
	<tsbogend@alpha.franken.de>, <James.Bottomley@HansenPartnership.com>,
	<deller@gmx.de>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
	<luto@kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <chris@zankel.net>,
	<jcmvbkbc@gmail.com>, <peterz@infradead.org>, <wad@chromium.org>,
	<thuth@redhat.com>, <mark.rutland@arm.com>, <kevin.brodsky@arm.com>,
	<linusw@kernel.org>, <yeoreum.yun@arm.com>, <song@kernel.org>,
	<james.morse@arm.com>, <anshuman.khandual@arm.com>, <broonie@kernel.org>,
	<liqiang01@kylinos.cn>, <pengcan@kylinos.cn>, <ryan.roberts@arm.com>,
	<yangtiezhu@loongson.cn>, <sshegde@linux.ibm.com>, <mchauras@linux.ibm.com>,
	<austin.kim@lge.com>, <jchrist@linux.ibm.com>, <arnd@arndb.de>,
	<thomas.weissschuh@linutronix.de>, <sohil.mehta@intel.com>,
	<andrew.cooper3@citrix.com>, <jgross@suse.com>, <kas@kernel.org>,
	<x86@kernel.org>, <linux-alpha@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-csky@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-m68k@lists.linux-m68k.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-um@lists.infradead.org>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-2-ruanjinjie@huawei.com>
 <b8f3b5cd-8d8a-4396-ba0c-011a83234dd9@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <b8f3b5cd-8d8a-4396-ba0c-011a83234dd9@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 7/1/2026 12:37 AM, Ada Couprie Diaz wrote:
> Hi Jinjie,
> 
> On 29/06/2026 14:05, Jinjie Ruan wrote:
>> The return value of __secure_computing() currently uses 0 to indicate
>> that a system call should be allowed, and -1 to indicate that it should
>> be blocked/killed. This 0/-1 pattern is non-intuitive for a security
>> check function and makes the control flow at the call sites less
>> readable.
>>
>> Furthermore, any potential future changes to these return values would
>> require a high-risk, error-prone audit of all its users across different
>> architectures.
>>
>> Sanitize this logic by converting the return type of __secure_computing()
>> to a proper boolean, where 'true' explicitly means 'allow' and 'false'
>> means 'fail/deny'.
>>
>> Update all the two dozen or so call sites across the tree to align with
>> this new boolean semantic. No functional changes are intended, as the
>> callers still return -1 to the lower-level assembly entry code upon
>> seccomp denial.
> Would it be relevant to mention that this fixes the unsound return value of
> `syscall_trace_enter()` in generic entry, which motivated the patch
> initially[0] ?

That's a very good point. It's definitely worth mentioning

>> Suggested-by: Thomas Gleixner <tglx@kernel.org>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   arch/alpha/kernel/ptrace.c            |  2 +-
>>   arch/arm/kernel/ptrace.c              |  2 +-
>>   arch/arm64/kernel/ptrace.c            |  2 +-
>>   arch/csky/kernel/ptrace.c             |  2 +-
>>   arch/m68k/kernel/ptrace.c             |  2 +-
>>   arch/mips/kernel/ptrace.c             |  2 +-
>>   arch/parisc/kernel/ptrace.c           |  2 +-
>>   arch/sh/kernel/ptrace_32.c            |  2 +-
>>   arch/um/kernel/skas/syscall.c         |  2 +-
>>   arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
>>   arch/xtensa/kernel/ptrace.c           |  3 +--
>>   include/linux/entry-common.h          |  7 +++---
>>   include/linux/seccomp.h               | 10 ++++----
>>   kernel/seccomp.c                      | 34 +++++++++++++--------------
>>   14 files changed, 36 insertions(+), 38 deletions(-)
> 
> This is missing an update to the Kconfig documentation, a possible
> suggestion :

Will update it.

> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index fa7507ac8e13..9e3d40088afb 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -637,7 +637,7 @@ config HAVE_ARCH_SECCOMP_FILTER
>           - syscall_set_return_value()
>           - SIGSYS siginfo_t support
>           - secure_computing is called from a ptrace_event()-safe context
> -         - secure_computing return value is checked and a return value
> of -1
> +         - secure_computing return value is checked and if false
>             results in the system call being skipped immediately.
>           - seccomp syscall wired up
>           - if !HAVE_SPARSE_SYSCALL_NR, have SECCOMP_ARCH_NATIVE,
> 
>> [...]
>> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
>> index 416a3352261f..3f66320e46d3 100644
>> --- a/include/linux/entry-common.h
>> +++ b/include/linux/entry-common.h
>> @@ -100,9 +100,8 @@ static __always_inline long
>> syscall_trace_enter(struct pt_regs *regs, unsigned l
>>         /* Do seccomp after ptrace, to catch any tracer changes. */
>>       if (work & SYSCALL_WORK_SECCOMP) {
>> -        ret = __secure_computing();
>> -        if (ret == -1L)
>> -            return ret;
>> +        if (!__secure_computing())
>> +            return -1L;
>>       }
>>         /* Either of the above might have changed the syscall number */
>> @@ -113,7 +112,7 @@ static __always_inline long
>> syscall_trace_enter(struct pt_regs *regs, unsigned l
>>         syscall_enter_audit(regs, syscall);
>>   -    return ret ? : syscall;
>> +    return syscall;
>>   }
>> [...]
> 
> Otherwise this feels like a more appropriate change with regards to
> "safeguarding against new `secure_computing()` return value" !
> 
> With the updated Kconfig :
> Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> 
> Thanks,
> Ada
> 
> [0]: https://lore.kernel.org/r/20260511092103.1974980-2-
> ruanjinjie@huawei.com
> 
> 

