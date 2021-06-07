Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EB8C4743F
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 00:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B7C613C8
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 00:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhFGA5v (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 6 Jun 2021 20:57:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3073 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhFGA5u (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 6 Jun 2021 20:57:50 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fyvtz02SLzWnwv;
        Mon,  7 Jun 2021 08:51:07 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 08:55:55 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 08:55:55 +0800
Subject: Re: [PATCH v2 00/15] init_mm: cleanup ARCH's text/data/brk setup code
To:     Mike Rapoport <rppt@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-snps-arc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-csky@vger.kernel.org>,
        <uclinux-h8-devel@lists.sourceforge.jp>,
        <linux-m68k@lists.linux-m68k.org>, <openrisc@lists.librecores.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-sh@vger.kernel.org>, <linux-s390@vger.kernel.org>
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
 <YL0+Jargm+y9aqx1@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <481056ab-686e-9f42-3b8a-b31941f58af6@huawei.com>
Date:   Mon, 7 Jun 2021 08:55:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YL0+Jargm+y9aqx1@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 2021/6/7 5:29, Mike Rapoport wrote:
> Hello Kefeng,
>
> On Fri, Jun 04, 2021 at 03:06:18PM +0800, Kefeng Wang wrote:
>> Add setup_initial_init_mm() helper, then use it
>> to cleanup the text, data and brk setup code.
>>
>> v2:
>> - change argument from "char *" to "void *" setup_initial_init_mm()
>>    suggested by Geert Uytterhoeven
>> - use NULL instead of (void *)0 on h8300 and m68k
>> - collect ACKs
>>
>> Cc: linux-snps-arc@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-csky@vger.kernel.org
>> Cc: uclinux-h8-devel@lists.sourceforge.jp
>> Cc: linux-m68k@lists.linux-m68k.org
>> Cc: openrisc@lists.librecores.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-riscv@lists.infradead.org
>> Cc: linux-sh@vger.kernel.org
>> Cc: linux-s390@vger.kernel.org
>> Kefeng Wang (15):
>>    mm: add setup_initial_init_mm() helper
>>    arc: convert to setup_initial_init_mm()
>>    arm: convert to setup_initial_init_mm()
>>    arm64: convert to setup_initial_init_mm()
>>    csky: convert to setup_initial_init_mm()
>>    h8300: convert to setup_initial_init_mm()
>>    m68k: convert to setup_initial_init_mm()
>>    nds32: convert to setup_initial_init_mm()
>>    nios2: convert to setup_initial_init_mm()
>>    openrisc: convert to setup_initial_init_mm()
>>    powerpc: convert to setup_initial_init_mm()
>>    riscv: convert to setup_initial_init_mm()
>>    s390: convert to setup_initial_init_mm()
>>    sh: convert to setup_initial_init_mm()
>>    x86: convert to setup_initial_init_mm()
> I might be missing something, but AFAIU the init_mm.start_code and other
> fields are not used really early so the new setup_initial_init_mm()
> function can be called in the generic code outside setup_arch(), e.g in
> mm_init().

Hi Mike， each architecture has their own value, not the same, eg m68K and

h8300, also the name of the text/code/brk is different in some arch, so 
I keep

unchanged.

>   
>>   arch/arc/mm/init.c                 | 5 +----
>>   arch/arm/kernel/setup.c            | 5 +----
>>   arch/arm64/kernel/setup.c          | 5 +----
>>   arch/csky/kernel/setup.c           | 5 +----
>>   arch/h8300/kernel/setup.c          | 5 +----
>>   arch/m68k/kernel/setup_mm.c        | 5 +----
>>   arch/m68k/kernel/setup_no.c        | 5 +----
>>   arch/nds32/kernel/setup.c          | 5 +----
>>   arch/nios2/kernel/setup.c          | 5 +----
>>   arch/openrisc/kernel/setup.c       | 5 +----
>>   arch/powerpc/kernel/setup-common.c | 5 +----
>>   arch/riscv/kernel/setup.c          | 5 +----
>>   arch/s390/kernel/setup.c           | 5 +----
>>   arch/sh/kernel/setup.c             | 5 +----
>>   arch/x86/kernel/setup.c            | 5 +----
>>   include/linux/mm_types.h           | 8 ++++++++
>>   16 files changed, 23 insertions(+), 60 deletions(-)
>>
>> -- 
>> 2.26.2
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
