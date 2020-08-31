Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29898 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgHaLxp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 31 Aug 2020 07:53:45 -0400
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <9071c9fa-ba6a-90dc-2d7a-8b155141d890@de.ibm.com>
Date: Mon, 31 Aug 2020 13:53:36 +0200
In-Reply-To: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>



On 28.08.20 16:03, Gerald Schaefer wrote:
[...]
> We came up with two possible fix-ups, both will introduce some gup-specific
> helper functions, which will have no effect on other archs than s390.
> 
> Patch 1 is the solution that has already been discussed in
> https://lkml.kernel.org/r/20190418100218.0a4afd51@mschwideX1
> It will additionally pass along pXd pointers in gup_pXd_range, and
> also introduce pXd_offset_orig for s390, which takes an additional
> pXd entry value parameter. This allows correctly returning / incrementing
> pointers while still preseving the READ_ONCE logic for gup_fast.
> 
> Patch 2 would instead introduce new gup_pXd_addr_end helpers, which take
> an additional pXd entry value parameter, that can be used on s390
> to determine the correct page table level and return corresponding
> end / boundary. With that, the pointer iteration will always
> happen in gup_pgd_range.
> 

> Comments / preferences are welcome. As a last resort, we might also
> revert back to the s390-specific gup_fast code, if none of the options
> are agreeable.

given that this is a data integrity issue, I think it would be good to 
have some feedback soon if option 1 or option 2 would be acceptable 
from a common code perspective. Andrew, who of the mm people would 
be the right one to decide?
