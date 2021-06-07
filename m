Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48210C4743E
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 01:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF5061164
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 01:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhFGBw2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 6 Jun 2021 21:52:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4370 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhFGBw1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 6 Jun 2021 21:52:27 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fyx774Ylsz69Gm;
        Mon,  7 Jun 2021 09:46:43 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 09:50:32 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 09:50:31 +0800
Subject: Re: [PATCH v2 01/15] mm: add setup_initial_init_mm() helper
To:     Mike Rapoport <rppt@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-snps-arc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-csky@vger.kernel.org>,
        <uclinux-h8-devel@lists.sourceforge.jp>,
        <linux-m68k@lists.linux-m68k.org>, <openrisc@lists.librecores.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-sh@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <x86@kernel.org>
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
 <20210604070633.32363-2-wangkefeng.wang@huawei.com>
 <YL0+nZPViz5xzxca@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <d07abbe5-941d-a27f-d968-e3d14ef9329a@huawei.com>
Date:   Mon, 7 Jun 2021 09:50:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YL0+nZPViz5xzxca@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 2021/6/7 5:31, Mike Rapoport wrote:
> Hello Kefeng,
>
> On Fri, Jun 04, 2021 at 03:06:19PM +0800, Kefeng Wang wrote:
>> Add setup_initial_init_mm() helper to setup kernel text,
>> data and brk.
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
>> Cc: x86@kernel.org
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   include/linux/mm_types.h | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 5aacc1c10a45..e1d2429089a4 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -572,6 +572,14 @@ struct mm_struct {
>>   };
>>   
>>   extern struct mm_struct init_mm;
>> +static inline void setup_initial_init_mm(void *start_code, void *end_code,
>> +					 void *end_data, void *brk)
> I think it's not that performance sensitive to make it inline. It can be
> placed in mm/init-mm.c with a forward declaration in mm.h

Ok, I will send a update one with this change.

>
>> +{
>> +	init_mm.start_code = (unsigned long)start_code;
>> +	init_mm.end_code = (unsigned long)end_code;
>> +	init_mm.end_data = (unsigned long)end_data;
>> +	init_mm.brk = (unsigned long)brk;
>> +}
>    
>>   /* Pointer magic because the dynamic array size confuses some compilers. */
>>   static inline void mm_init_cpumask(struct mm_struct *mm)
>> -- 
>> 2.26.2
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
