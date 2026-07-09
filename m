Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6513D6673;
	Thu,  9 Jul 2026 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579039; cv=none; b=tM5AnYJ8JgmSn9kvcKIQR2PICnizbU3b5SPSMd74nyULgelOnQbDEh10/6OhXhC/lmfq95k1tAOHRSXosLSJVmrqIsgWPIcUkBBQVLumVXtfFcbQtuBIiOMwNbdIn/A79rA6lEU6DaDyF0svhOtBc6TmO5vqAFHbdvtElq/uScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579039; c=relaxed/simple;
	bh=ZGZSufB/FTVHL/6/3ZAoa3duk4z4JeP6OXQqkwhGhx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SXinZSPEBlE+qdUZDugDHQQLFY+W3gqxCfZeS66vinspUwnurkX/XrsA4oRkv7DIp8f98piGmkIdX8coH/rwvvJOki+tytTaPwDvyIUA4G76KLvKEJElfnk6EKqNfwi6uyRhFo6LBTjV+yIyLwI2lTpIcoV0lxf6J+iaGBJjoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ktnvhwnt; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ktnvhwnt"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nx9uTIIpEYlLKn/TlkCDaDRFao/mdFBZNp54PrQsjPw=;
	b=ktnvhwntGgaRfWEAoNl4nP/eMAv3WF40w6U+rHuISN9Agz4HcuqKVmp7oYolkH1rs7mUNfj74
	gCHhpWuGxUwoXRpbuDGJzqHbbuU4k1jP4vTX4mO+NAfGMKawslgm9u9z/t6vpBkLBD6GuiT0hg5
	ivGaNCxTDm241yTFRway9Ns=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gwlQ654XpzRhRh;
	Thu,  9 Jul 2026 14:27:58 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id ED73340579;
	Thu,  9 Jul 2026 14:37:11 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jul 2026 14:37:07 +0800
Message-ID: <21875fb4-434b-480d-b68b-e2ffd5fff5ae@huawei.com>
Date: Thu, 9 Jul 2026 14:37:05 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 18/18] arm64: vdso: Expose sigreturn address on vdso
 to the kernel
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
CC: <oleg@redhat.com>, <richard.henderson@linaro.org>, <mattst88@gmail.com>,
	<linmag7@gmail.com>, <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <kees@kernel.org>, <guoren@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <geert@linux-m68k.org>,
	<tsbogend@alpha.franken.de>, <James.Bottomley@hansenpartnership.com>,
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
	<thuth@redhat.com>, <mark.rutland@arm.com>, <ada.coupriediaz@arm.com>,
	<kevin.brodsky@arm.com>, <linusw@kernel.org>, <yeoreum.yun@arm.com>,
	<song@kernel.org>, <james.morse@arm.com>, <anshuman.khandual@arm.com>,
	<broonie@kernel.org>, <liqiang01@kylinos.cn>, <pengcan@kylinos.cn>,
	<ryan.roberts@arm.com>, <yangtiezhu@loongson.cn>, <sshegde@linux.ibm.com>,
	<mchauras@linux.ibm.com>, <austin.kim@lge.com>, <jchrist@linux.ibm.com>,
	<arnd@arndb.de>, <sohil.mehta@intel.com>, <andrew.cooper3@citrix.com>,
	<jgross@suse.com>, <kas@kernel.org>, <x86@kernel.org>,
	<linux-alpha@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-csky@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-m68k@lists.linux-m68k.org>, <linux-mips@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <linux-um@lists.infradead.org>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-19-ruanjinjie@huawei.com>
 <20260630172619-6c78c2e2-c2d3-44be-88e6-6c82de12baf4@linutronix.de>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260630172619-6c78c2e2-c2d3-44be-88e6-6c82de12baf4@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 6/30/2026 11:32 PM, Thomas Weißschuh wrote:
> On Mon, Jun 29, 2026 at 09:06:16PM +0800, Jinjie Ruan wrote:
>> Syscall User Dispatch (SUD) requires the signal trampoline code to not be
>> intercepted. This is necessary to support returning with a locked selector
>> while avoiding infinite recursion back into the signal handler.
>>
>> Implement arch_syscall_is_vdso_sigreturn() for arm64 to support this
>> exclusion mechanism. For native 64-bit tasks, it checks whether the current
>> PC matches the 'svc #0' instruction inside the vDSO sigreturn trampoline.
>>
>> 	SYM_CODE_START(__kernel_rt_sigreturn)
>> 	        mov     x8, #__NR_rt_sigreturn
>> 	        svc     #0
>> 	SYM_CODE_END(__kernel_rt_sigreturn)
>>
>> For COMPAT tasks, it verifies if the instruction falls within
>> the architecture's 'sigpage' range, allowing the kernel to safely bypass
>> dispatching syscalls originating from these areas back to userspace.
>>
>> Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> Suggested-by: kemal <kmal@cock.li>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/include/asm/elf.h |  1 +
>>  arch/arm64/kernel/vdso.c     | 16 ++++++++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
>> index d2779d604c7b..f43d4dea916a 100644
>> --- a/arch/arm64/include/asm/elf.h
>> +++ b/arch/arm64/include/asm/elf.h
>> @@ -185,6 +185,7 @@ do {									\
>>  struct linux_binprm;
>>  extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>>  				       int uses_interp);
>> +extern bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
> 
> A header for that?

Sure, it need a cleanup, as currently, there is no syscall_user_dispatch
header file related to the architecture.

> 
>>  /* 1GB of VA */
>>  #ifdef CONFIG_COMPAT
>> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
>> index 592dd8668de4..5a0314a3c26e 100644
>> --- a/arch/arm64/kernel/vdso.c
>> +++ b/arch/arm64/kernel/vdso.c
>> @@ -343,3 +343,19 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>>  
>>  	return ret;
>>  }
>> +
>> +bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
>> +{
>> +	unsigned long sigtramp;
>> +
>> +#ifdef CONFIG_COMPAT
>> +	if (is_compat_task()) {
>> +		unsigned long sigpage = (unsigned long)current->mm->context.sigpage;
>> +
>> +		return regs->pc >= sigpage && regs->pc < (sigpage + PAGE_SIZE);
>> +	}
>> +#endif
>> +	sigtramp = (unsigned long)VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
>> +
>> +	return regs->pc == (sigtramp + 8);
> 
> Instead of hardcoding 'sigtramp + 8' you could add a new label to the 'svc #0'
> instruction and use that with VDSO_SYMBOL().

It seems that the modification of __kernel_rt_sigreturn() is not recommended

> 
> 
> Thomas

