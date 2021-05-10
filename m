Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581F2C43460
	for <linux-s390@archiver.kernel.org>; Mon, 10 May 2021 10:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3F261424
	for <linux-s390@archiver.kernel.org>; Mon, 10 May 2021 10:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhEJKLP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 10 May 2021 06:11:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:54516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhEJKLO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 May 2021 06:11:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 677B0B036;
        Mon, 10 May 2021 10:10:09 +0000 (UTC)
Date:   Mon, 10 May 2021 12:10:07 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/thp: Make ARCH_ENABLE_SPLIT_PMD_PTLOCK dependent on
 PGTABLE_LEVELS > 2
Message-ID: <20210510101006.GB22664@linux>
References: <1620621345-29176-1-git-send-email-anshuman.khandual@arm.com>
 <20210510085313.GB5618@worktop.programming.kicks-ass.net>
 <843e545a-ca0c-6a1e-2ab0-28ccca182400@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843e545a-ca0c-6a1e-2ab0-28ccca182400@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 10, 2021 at 03:36:29PM +0530, Anshuman Khandual wrote:
> 
> 
> On 5/10/21 2:23 PM, Peter Zijlstra wrote:
> > On Mon, May 10, 2021 at 10:05:45AM +0530, Anshuman Khandual wrote:
> >> -	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if X86_64 || X86_PAE
> >> +	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if (PGTABLE_LEVELS > 2) && (X86_64 || X86_PAE)
> > 
> > It's still very early on a Monday, but IIRC this new condition is
> > identical to the pre-existing one.
> 
> Did not get it, could you please elaborate ?

When using x86_PAE, you must have more than two pgtable levels, right?
And not speaking of x86_64.

-- 
Oscar Salvador
SUSE L3
