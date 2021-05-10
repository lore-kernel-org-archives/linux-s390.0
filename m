Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4194C433ED
	for <linux-s390@archiver.kernel.org>; Mon, 10 May 2021 10:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA2E613AF
	for <linux-s390@archiver.kernel.org>; Mon, 10 May 2021 10:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhEJKHL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 10 May 2021 06:07:11 -0400
Received: from foss.arm.com ([217.140.110.172]:53376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhEJKHK (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 May 2021 06:07:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D657915BE;
        Mon, 10 May 2021 03:06:05 -0700 (PDT)
Received: from [10.163.77.48] (unknown [10.163.77.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FB2A3F719;
        Mon, 10 May 2021 03:06:02 -0700 (PDT)
Subject: Re: [PATCH] mm/thp: Make ARCH_ENABLE_SPLIT_PMD_PTLOCK dependent on
 PGTABLE_LEVELS > 2
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1620621345-29176-1-git-send-email-anshuman.khandual@arm.com>
 <20210510085313.GB5618@worktop.programming.kicks-ass.net>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <843e545a-ca0c-6a1e-2ab0-28ccca182400@arm.com>
Date:   Mon, 10 May 2021 15:36:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210510085313.GB5618@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/10/21 2:23 PM, Peter Zijlstra wrote:
> On Mon, May 10, 2021 at 10:05:45AM +0530, Anshuman Khandual wrote:
>> -	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if X86_64 || X86_PAE
>> +	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if (PGTABLE_LEVELS > 2) && (X86_64 || X86_PAE)
> 
> It's still very early on a Monday, but IIRC this new condition is
> identical to the pre-existing one.

Did not get it, could you please elaborate ?
