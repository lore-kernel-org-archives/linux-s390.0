Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A244C04FF3
	for <linux-s390@archiver.kernel.org>; Mon, 24 May 2021 09:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19071611EE
	for <linux-s390@archiver.kernel.org>; Mon, 24 May 2021 09:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhEXJmP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 May 2021 05:42:15 -0400
Received: from foss.arm.com ([217.140.110.172]:40330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhEXJmO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 May 2021 05:42:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DED0F31B;
        Mon, 24 May 2021 02:40:46 -0700 (PDT)
Received: from [10.163.81.166] (unknown [10.163.81.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B64F3F73B;
        Mon, 24 May 2021 02:40:43 -0700 (PDT)
Subject: Re: [PATCH] mm/thp: Make ARCH_ENABLE_SPLIT_PMD_PTLOCK dependent on
 PGTABLE_LEVELS > 2
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1620621345-29176-1-git-send-email-anshuman.khandual@arm.com>
 <a4403be6-5b74-2c86-bc4c-42ae4f0764dc@arm.com>
 <20210517161358.49683f34@thinkpad> <20210519130722.7d255b7f@thinkpad>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <06299fb2-2f64-9094-3bf4-77045101ae22@arm.com>
Date:   Mon, 24 May 2021 15:11:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210519130722.7d255b7f@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/19/21 4:37 PM, Gerald Schaefer wrote:
> On Mon, 17 May 2021 16:13:57 +0200
> Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:
> 
>> On Mon, 17 May 2021 09:45:31 +0530
>> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>>>
>>>
>>> On 5/10/21 10:05 AM, Anshuman Khandual wrote:  
>>>> ARCH_ENABLE_SPLIT_PMD_PTLOCK is irrelevant unless there are two page table
>>>> levels including PMD (also per Documentation/vm/split_page_table_lock.rst).
>>>> Make this dependency explicit on remaining platforms i.e x86 and s390 where
>>>> ARCH_ENABLE_SPLIT_PMD_PTLOCK is subscribed.  
>>
>> For s390, I don't think this makes a lot of sense. We always have 5 levels
>> defined for PGTABLE_LEVELS, and we would not even compile with any other
>> value, because of the "#error CONFIG_PGTABLE_LEVELS" in include/linux/pgtable.h.
>>
>> Our pagetable folding also works a bit different than it does on other archs,
>> and we would actually have pmd level entries for 2-level pagetables, so it should
>> all work fine also with PGTABLE_LEVELS == 2 (if it was possible).
>>
>> In fact, I do not really see why you would need "more than two levels" on any
>> arch, in order to use split PMD locks. Your description also just says
>> "irrelevant unless there are two page table levels", and not "more than two
>> levels", like in Documentation/vm/split_page_table_lock.rst.
>>
>> Yet, your patch adds checks for "more than", so at least the description
>> seems a bit misleading. I assume that the "more than" has to do with folded
>> PMD on a 2-level system, but the way we fold on s390 I do not see why that
>> should be a problem. Could you please elaborate a bit?
>>
>> We also have different levels of pagetables for kernel (CONFIG_PGTABLE_LEVELS)
>> and user processes on s390. The latter can have dynamic levels, currently
>> starting with 3, but previously we also had 2 levels for compat tasks e.g.
>> These dynamic levels for user processes are also independent from the
>> CONFIG_PGTABLE_LEVELS used for the kernel pagetable, while the split PMD lock
>> of course also affects user process pagetables, so that would be another
>> reason not to add such a dependency for ARCH_ENABLE_SPLIT_PMD_PTLOCK on s390.
> 
> Ouch, I guess I was a bit confused here. I thought the split PMD lock
> was part of the struct page for the 4 KB page where the PMD entry is located,
> and therefore, with more than one page, it still would make (a little) sense
> to use it also for 2 pagetable levels.
> 
> However, pmd_to_page() always returns the struct page of the first page,
> so there is only one split PMD lock for the whole thing (4 pages for s390).
> Of course that means that with 2 pagetable levels, and only one PMD directory,
> the split PMD lock would be equivalent to the global pagetable lock, and
> therefore not make any sense.
> 
> Maybe you could change the description to also mention "more than two"
> levels?

Yes, will change it.

> 
> I still do not see a real benefit of the patch, e.g. it does not really
> fix any possible misconfiguration, at least on s390. But it certainly is not
> wrong, and at least it had the benefit of making me aware again of how split
> PMD locks work, so I'll happily add this

Right, even though it does not change the functionality, the purpose
of this patch is to enforce (and also possibly document) an inherent
assumption which may not hold true on all other platforms like arm64.

> 
> Acked-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com> # s390
> 

Thanks for reviewing.
