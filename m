Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35869 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbgC0J7p (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 05:59:45 -0400
Date: Fri, 27 Mar 2020 10:59:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] s390/gmap: return proper error code on ksm unsharing
Message-ID: <20200327105933.6edf41d9.cohuck@redhat.com>
In-Reply-To: <20200327092356.25171-1-borntraeger@de.ibm.com>
References: <20200327092356.25171-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Fri, 27 Mar 2020 05:23:56 -0400
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> If a signal is pending we might return -ENOMEM instead of -EINTR.
> We should propagate the proper error during KSM unsharing.
> 
> Fixes: 3ac8e38015d4 ("s390/mm: disable KSM for storage key enabled pages")
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/mm/gmap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
