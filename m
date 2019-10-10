Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfJJLPZ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Oct 2019 07:15:25 -0400
Date: Thu, 10 Oct 2019 13:15:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/2] KVM: s390: count invalid yields
Message-ID: <20191010131519.7c8bd1b1.cohuck@redhat.com>
In-Reply-To: <20191010110518.129256-2-borntraeger@de.ibm.com>
References: <20191010110518.129256-1-borntraeger@de.ibm.com>
        <20191010110518.129256-2-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>

On Thu, 10 Oct 2019 13:05:17 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> To analyze some performance issues with lock contention and scheduling
> it is nice to know when diag9c did not result in any action or when
> no action was tried.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  1 +
>  arch/s390/kvm/diag.c             | 18 ++++++++++++++----
>  arch/s390/kvm/kvm-s390.c         |  1 +
>  3 files changed, 16 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
