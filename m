Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E88C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 25 Nov 2021 01:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbhKYBOO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 24 Nov 2021 20:14:14 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28105 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345285AbhKYBMO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 24 Nov 2021 20:12:14 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J007m3PLPz1DJWs;
        Thu, 25 Nov 2021 09:06:28 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 09:09:01 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 09:09:00 +0800
Message-ID: <356d857b-1813-6132-d4ae-5bb41190a1a7@huawei.com>
Date:   Thu, 25 Nov 2021 09:08:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] mm: Defer kmemleak object creation of module_alloc()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Yongqiang Liu <liuyongqiang13@huawei.com>
References: <20211124142034.192078-1-wangkefeng.wang@huawei.com>
 <20211124135014.665649a0bcb872367b248cef@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20211124135014.665649a0bcb872367b248cef@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 2021/11/25 5:50, Andrew Morton wrote:
> On Wed, 24 Nov 2021 22:20:34 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> Yongqiang reports a kmemleak panic when module insmod/rmmod
>> with KASAN enabled(without KASAN_VMALLOC) on x86[1].
>>
>> When the module area allocates memory, it's kmemleak_object
>> is created successfully, but the KASAN shadow memory of module
>> allocation is not ready, so when kmemleak scan the module's
>> pointer, it will panic due to no shadow memory with KASAN check.
>>
>> module_alloc
>>    __vmalloc_node_range
>>      kmemleak_vmalloc
>> 				kmemleak_scan
>> 				  update_checksum
>>    kasan_module_alloc
>>      kmemleak_ignore
>>
>> Note, there is no problem if KASAN_VMALLOC enabled, the modules
>> area entire shadow memory is preallocated. Thus, the bug only
>> exits on ARCH which supports dynamic allocation of module area
>> per module load, for now, only x86/arm64/s390 are involved.
>>
>> Add a VM_DEFER_KMEMLEAK flags, defer vmalloc'ed object register
>> of kmemleak in module_alloc() to fix this issue.
>>
> I guess this is worth backporting into -stable kernels?  If so, what
> would be a suitable Fixes: target?  I suspect it goes back to the
> initial KASAN merge date?

The kasan_module_alloc() was introduced from v4.0,

s390: v4.20

793213a82de4 s390/kasan: dynamic shadow mem allocation for modules

arm64: v4.4

39d114ddc682 arm64: add KASAN support

x86: v4.0

bebf56a1b176 kasan: enable instrumentation of global variables

> .
