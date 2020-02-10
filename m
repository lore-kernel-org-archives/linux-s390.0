Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50446 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727054AbgBJRdC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 12:33:02 -0500
Date: Mon, 10 Feb 2020 18:32:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 0/1] s390/uv: fix for ultravisor query function
Message-ID: <20200210183249.7816e316.cohuck@redhat.com>
In-Reply-To: <20200210165439.3767-1-borntraeger@de.ibm.com>
References: <20200210165439.3767-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>

On Mon, 10 Feb 2020 11:54:38 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> As outlined by the architects the query command could actually return more
> than the minimal 168 bytes.
> 
> I will carry this with the KVM host support for protected virtualization

As this is cc:stable (and also relevant for the guest side), why not
merge it right now?

> 
> Christian Borntraeger (1):
>   s390/uv: Fix handling of length extensions
> 
>  arch/s390/boot/uv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
