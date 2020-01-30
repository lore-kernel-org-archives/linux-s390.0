Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34119 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726980AbgA3NBu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 08:01:50 -0500
Date: Thu, 30 Jan 2020 14:01:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9] KVM: s390: Add new reset vcpu API
Message-ID: <20200130140141.0e759a62.cohuck@redhat.com>
In-Reply-To: <20200130125559.30032-1-frankja@linux.ibm.com>
References: <9d64917a-2a0a-46e7-0d78-da2f31eb01c4@linux.ibm.com>
        <20200130125559.30032-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org

On Thu, 30 Jan 2020 07:55:59 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> The architecture states that we need to reset local IRQs for all CPU
> resets. Because the old reset interface did not support the normal CPU
> reset we never did that on a normal reset.
> 
> Let's implement an interface for the missing normal and clear resets
> and reset all local IRQs, registers and control structures as stated
> in the architecture.
> 
> Userspace might already reset the registers via the vcpu run struct,
> but as we need the interface for the interrupt clearing part anyway,
> we implement the resets fully and don't rely on userspace to reset the
> rest.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  Documentation/virt/kvm/api.txt | 43 +++++++++++++++++
>  arch/s390/kvm/kvm-s390.c       | 86 +++++++++++++++++++++++-----------
>  include/uapi/linux/kvm.h       |  5 ++
>  3 files changed, 106 insertions(+), 28 deletions(-)

This version looks good to me.
