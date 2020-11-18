Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40891 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbgKRKJ4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 05:09:56 -0500
Date: Wed, 18 Nov 2020 11:09:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 0/2] Fix and MAINTAINER update for 5.10
Message-ID: <20201118110941.14e12cf5.cohuck@redhat.com>
In-Reply-To: <20201118093942.457191-1-borntraeger@de.ibm.com>
References: <20201118093942.457191-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On Wed, 18 Nov 2020 10:39:40 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Conny, David,
> 
> your chance for quick feedback. I plan to send a pull request for kvm
> master soon.
> 
> I have agreed with Heiko to carry this via the KVM tree as
> this is KVM s390 specific.
> 
> Christian Borntraeger (2):
>   s390/uv: handle destroy page legacy interface
>   MAINTAINERS: add uv.c also to KVM/s390
> 
>  MAINTAINERS           | 1 +
>  arch/s390/kernel/uv.c | 9 ++++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 

For both:

Acked-by: Cornelia Huck <cohuck@redhat.com>
