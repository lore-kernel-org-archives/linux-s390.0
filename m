Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57788 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726980AbgA3NAq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jan 2020 08:00:46 -0500
Date: Thu, 30 Jan 2020 14:00:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 1/6] KVM: s390: do not clobber registers during guest
 reset/store status
Message-ID: <20200130140037.11c4cf33.cohuck@redhat.com>
In-Reply-To: <20200130123434.68129-2-frankja@linux.ibm.com>
References: <20200130123434.68129-1-frankja@linux.ibm.com>
        <20200130123434.68129-2-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org

On Thu, 30 Jan 2020 07:34:29 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> From: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> The initial CPU reset clobbers the userspace fpc and the store status
> ioctl clobbers the guest acrs + fpr.  As these calls are only done via
> ioctl (and not via vcpu_run), no CPU context is loaded, so we can (and
> must) act directly on the sync regs, not on the thread context.
> 
> Cc: stable@kernel.org
> Fixes: e1788bb995be ("KVM: s390: handle floating point registers in the run ioctl not in vcpu_put/load")
> Fixes: 31d8b8d41a7e ("KVM: s390: handle access registers in the run ioctl not in vcpu_put/load")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Add your s-o-b?

> ---
>  arch/s390/kvm/kvm-s390.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
