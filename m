Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732295AbgKWRPt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Nov 2020 12:15:49 -0500
Subject: Re: [PATCH 0/2] KVM: s390: memcg awareness
References: <20201117151023.424575-1-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <ef538cd6-b82f-0773-3848-f3b5232e7412@de.ibm.com>
Date: Mon, 23 Nov 2020 18:15:43 +0100
MIME-Version: 1.0
In-Reply-To: <20201117151023.424575-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>



On 17.11.20 16:10, Christian Borntraeger wrote:
> This got somehow lost.  (so this is kind of a v2)
> KVM does have memcg awareness. Lets implement this also for s390kvm
> and gmap.
> 
> Christian Borntraeger (2):
>   KVM: s390: Add memcg accounting to KVM allocations
>   s390/gmap: make gmap memcg aware

both applied.
> 
>  arch/s390/kvm/guestdbg.c  |  8 ++++----
>  arch/s390/kvm/intercept.c |  2 +-
>  arch/s390/kvm/interrupt.c | 10 +++++-----
>  arch/s390/kvm/kvm-s390.c  | 20 ++++++++++----------
>  arch/s390/kvm/priv.c      |  4 ++--
>  arch/s390/kvm/pv.c        |  6 +++---
>  arch/s390/kvm/vsie.c      |  4 ++--
>  arch/s390/mm/gmap.c       | 30 +++++++++++++++---------------
>  8 files changed, 42 insertions(+), 42 deletions(-)
> 
