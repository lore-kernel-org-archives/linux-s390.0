Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60776 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728364AbgBUMte (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Feb 2020 07:49:34 -0500
Date: Fri, 21 Feb 2020 13:49:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 11/37] KVM: s390: protvirt: Secure memory is not
 mergeable
Message-ID: <20200221134921.341466fc.cohuck@redhat.com>
In-Reply-To: <20200220104020.5343-12-borntraeger@de.ibm.com>
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
        <20200220104020.5343-12-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Thu, 20 Feb 2020 05:39:54 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Janosch Frank <frankja@linux.ibm.com>
> 
> KSM will not work on secure pages, because when the kernel reads a
> secure page, it will be encrypted and hence no two pages will look the
> same.
> 
> Let's mark the guest pages as unmergeable when we transition to secure
> mode.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/gmap.h |  1 +
>  arch/s390/kvm/kvm-s390.c     |  7 +++++++
>  arch/s390/mm/gmap.c          | 30 ++++++++++++++++++++----------
>  3 files changed, 28 insertions(+), 10 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
