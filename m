Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732077AbgKWQJL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Nov 2020 11:09:11 -0500
Date: Mon, 23 Nov 2020 17:08:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/2] KVM: s390: Add memcg accounting to KVM allocations
Message-ID: <20201123170857.1218d5e7.cohuck@redhat.com>
In-Reply-To: <20201117151023.424575-2-borntraeger@de.ibm.com>
References: <20201117151023.424575-1-borntraeger@de.ibm.com>
        <20201117151023.424575-2-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>

On Tue, 17 Nov 2020 16:10:22 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Almost all kvm allocations in the s390x KVM code can be attributed to
> process that triggers the allocation (in other words, no global

s/process/the process/

> allocation for other guests). This will help the memcg controller to do

s/do/make/

> the right decisions.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kvm/guestdbg.c  |  8 ++++----
>  arch/s390/kvm/intercept.c |  2 +-
>  arch/s390/kvm/interrupt.c | 10 +++++-----
>  arch/s390/kvm/kvm-s390.c  | 20 ++++++++++----------
>  arch/s390/kvm/priv.c      |  4 ++--
>  arch/s390/kvm/pv.c        |  6 +++---
>  arch/s390/kvm/vsie.c      |  4 ++--
>  7 files changed, 27 insertions(+), 27 deletions(-)

Didn't do a deep review, but looks reasonable.

Acked-by: Cornelia Huck <cohuck@redhat.com>
