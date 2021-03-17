Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E4AC433DB
	for <linux-s390@archiver.kernel.org>; Wed, 17 Mar 2021 05:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E44E64F92
	for <linux-s390@archiver.kernel.org>; Wed, 17 Mar 2021 05:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhCQF6b (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Mar 2021 01:58:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13637 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhCQF6K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 Mar 2021 01:58:10 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F0fXm6M3nz17M4p;
        Wed, 17 Mar 2021 13:56:08 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 13:57:58 +0800
Subject: Re: [PATCH v2] mm: Move mem_init_print_info() into mm_init()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-ia64@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        Guo Ren <guoren@kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Jonas Bonn <jonas@southpole.se>,
        <linux-s390@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        <linux-hexagon@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        <linux-csky@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        <linux-snps-arc@lists.infradead.org>,
        <linux-xtensa@linux-xtensa.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        <linux-um@lists.infradead.org>, <linux-m68k@lists.linux-m68k.org>,
        <openrisc@lists.librecores.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        <linux-parisc@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        <linux-alpha@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
References: <4d488195-7281-9238-b30d-9f89a6100fb9@csgroup.eu>
 <20210317015210.33641-1-wangkefeng.wang@huawei.com>
 <3f6959d6-1f37-8baf-a12e-3fbda6a17c7d@csgroup.eu>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <fef8ca3b-97ae-5c19-69ea-bb1dfe88cf9c@huawei.com>
Date:   Wed, 17 Mar 2021 13:57:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3f6959d6-1f37-8baf-a12e-3fbda6a17c7d@csgroup.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 2021/3/17 13:48, Christophe Leroy wrote:
>
>
> Le 17/03/2021 à 02:52, Kefeng Wang a écrit :
>> mem_init_print_info() is called in mem_init() on each architecture,
>> and pass NULL argument, so using void argument and move it into 
>> mm_init().
>>
>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>> v2:
>> - Cleanup 'str' line suggested by Christophe and ACK
>>
>>   arch/alpha/mm/init.c             |  1 -
>>   arch/arc/mm/init.c               |  1 -
>>   arch/arm/mm/init.c               |  2 --
>>   arch/arm64/mm/init.c             |  2 --
>>   arch/csky/mm/init.c              |  1 -
>>   arch/h8300/mm/init.c             |  2 --
>>   arch/hexagon/mm/init.c           |  1 -
>>   arch/ia64/mm/init.c              |  1 -
>>   arch/m68k/mm/init.c              |  1 -
>>   arch/microblaze/mm/init.c        |  1 -
>>   arch/mips/loongson64/numa.c      |  1 -
>>   arch/mips/mm/init.c              |  1 -
>>   arch/mips/sgi-ip27/ip27-memory.c |  1 -
>>   arch/nds32/mm/init.c             |  1 -
>>   arch/nios2/mm/init.c             |  1 -
>>   arch/openrisc/mm/init.c          |  2 --
>>   arch/parisc/mm/init.c            |  2 --
>>   arch/powerpc/mm/mem.c            |  1 -
>>   arch/riscv/mm/init.c             |  1 -
>>   arch/s390/mm/init.c              |  2 --
>>   arch/sh/mm/init.c                |  1 -
>>   arch/sparc/mm/init_32.c          |  2 --
>>   arch/sparc/mm/init_64.c          |  1 -
>>   arch/um/kernel/mem.c             |  1 -
>>   arch/x86/mm/init_32.c            |  2 --
>>   arch/x86/mm/init_64.c            |  2 --
>>   arch/xtensa/mm/init.c            |  1 -
>>   include/linux/mm.h               |  2 +-
>>   init/main.c                      |  1 +
>>   mm/page_alloc.c                  | 10 +++++-----
>>   30 files changed, 7 insertions(+), 42 deletions(-)
>>
>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 89314651dd62..c2e0b3495c5a 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2373,7 +2373,7 @@ extern unsigned long free_reserved_area(void 
>> *start, void *end,
>>                       int poison, const char *s);
>>     extern void adjust_managed_page_count(struct page *page, long 
>> count);
>> -extern void mem_init_print_info(const char *str);
>> +extern void mem_init_print_info(void);
>
> Sorry I didn't see that in previous patch.
>
> 'extern' keyword is pointless for function prototypes and is 
> deprecated, you should remove it.
>
> That said,
>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr> # focussed on 
> powerpc
Thanks, let's wait for more feedback from other architectures, if 
necessary,  will send a new one.
>
>>     extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t 
>> end);
> .
>
