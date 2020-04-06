Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728964AbgDFQGs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 12:06:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036G4euP138771
        for <linux-s390@vger.kernel.org>; Mon, 6 Apr 2020 12:06:48 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3082hfthjw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2020 12:06:47 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 6 Apr 2020 17:06:20 +0100
Subject: Re: [PATCH v2 0/5] KVM: s390: vsie: fixes and cleanups
References: <20200403153050.20569-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 6 Apr 2020 18:06:41 +0200
MIME-Version: 1.0
In-Reply-To: <20200403153050.20569-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <d2d2fe98-bfc5-a43e-a8a8-a3da7f765b56@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>

Series applied. thanks. 
I will schedule the first 3 for master, 4 and 5 for next.


On 03.04.20 17:30, David Hildenbrand wrote:
> Some vsie/gmap fixes and two cleanups/improvements.
> 
> Patch #1 fixes an issue reported by Janosch. It was never observed so far,
> because KVM usually doesn't use a region 1 table for it's guest (unless
> memory would be exceeding something like 16 EB, which isn't even supported
> by the HW). Older QEMU+KVM or other hypervisors can trigger this.
> 
> Patch #2 fixes a code path that probably was never taken and will most
> probably not be taken very often in the future - unless somebody really
> messes up the page tables for a guest (or writes a test for it). At some
> point, a test case for this would be nice.
> 
> Patch #3 fixes a rare possible race. Don't think this is stable material.
> 
> Gave it some testing with my limited access to somewhat-fast s390x
> machines. Booted a Linux kernel, supplying all possible number of
> page table hiearchies.
> 
> v1 -> v2:
> - "KVM: s390: vsie: Fix region 1 ASCE sanity shadow address checks"
> -- Fix WARN_ON_ONCE
> - "gmap_table_walk() simplifications"
> -- Also init "table" directly
> 
> David Hildenbrand (5):
>   KVM: s390: vsie: Fix region 1 ASCE sanity shadow address checks
>   KVM: s390: vsie: Fix delivery of addressing exceptions
>   KVM: s390: vsie: Fix possible race when shadowing region 3 tables
>   KVM: s390: vsie: Move conditional reschedule
>   KVM: s390: vsie: gmap_table_walk() simplifications
> 
>  arch/s390/kvm/vsie.c |  4 ++--
>  arch/s390/mm/gmap.c  | 17 +++++++++++------
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
