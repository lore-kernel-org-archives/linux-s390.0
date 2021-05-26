Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEB7C2B9F7
	for <linux-s390@archiver.kernel.org>; Wed, 26 May 2021 04:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3FE6113E
	for <linux-s390@archiver.kernel.org>; Wed, 26 May 2021 04:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhEZEZW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 May 2021 00:25:22 -0400
Received: from foss.arm.com ([217.140.110.172]:38110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231136AbhEZEZW (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 May 2021 00:25:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6607A1516;
        Tue, 25 May 2021 21:23:51 -0700 (PDT)
Received: from [10.163.81.152] (unknown [10.163.81.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4560D3F73D;
        Tue, 25 May 2021 21:23:49 -0700 (PDT)
Subject: Re: [PATCH 0/1] mm/debug_vm_pgtable: fix alignment for
 pmd/pud_advanced_tests()
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20210525130043.186290-1-gerald.schaefer@linux.ibm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c120e573-0654-fc1c-634b-88a48383666e@arm.com>
Date:   Wed, 26 May 2021 09:54:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210525130043.186290-1-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/25/21 6:30 PM, Gerald Schaefer wrote:
> We sometimes see a "BUG task_struct (Not tainted): Padding overwritten"
> on s390, directly after running debug_vm_pgtable. This is because of
> wrong vaddr alignment in pmd/pud_advanced_tests(), leading to memory
> corruption at least on s390, see patch description.
> 
> At first glance, other architectures do not seem to care about vaddr in
> their xxx_get_and_clear() implementations, so they should not be affected.

IIRC, alignment (regardless up or down) is the only requirement on certain
platforms. Probably it should not affect other platforms as this change
just aligns the virtual address down.

> One exception is sparc, where the addr is passed over to some tlb_batch
> code, but I'm not sure what implication the wrongly aligned vaddr would
> have in this case.
> 
> Also adding linux-arch, just to make sure.

Right. Not sure if this test gets to run on sparc platform for not being
currently supported. But we could take a look if there are any reported
problems because of vaddr.

> 
> Gerald Schaefer (1):
>   mm/debug_vm_pgtable: fix alignment for pmd/pud_advanced_tests()
> 
>  mm/debug_vm_pgtable.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
