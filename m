Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732675AbgKWQKn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Nov 2020 11:10:43 -0500
Date: Mon, 23 Nov 2020 17:10:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/2] s390/gmap: make gmap memcg aware
Message-ID: <20201123171030.7f11dbc4.cohuck@redhat.com>
In-Reply-To: <20201117151023.424575-3-borntraeger@de.ibm.com>
References: <20201117151023.424575-1-borntraeger@de.ibm.com>
        <20201117151023.424575-3-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>

On Tue, 17 Nov 2020 16:10:23 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> gmap allocations can be attributed to a process.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/mm/gmap.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 

Acked-by: Cornelia Huck <cohuck@redhat.com>
