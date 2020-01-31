Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22393 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728492AbgAaLoR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 31 Jan 2020 06:44:17 -0500
Subject: Re: [PATCH v10 3/6] KVM: s390: Add new reset vcpu API
References: <20200131100205.74720-1-frankja@linux.ibm.com>
 <20200131100205.74720-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7e36cbd4-3f37-8509-400e-c2c708281aeb@redhat.com>
Date: Fri, 31 Jan 2020 12:44:05 +0100
MIME-Version: 1.0
In-Reply-To: <20200131100205.74720-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 31/01/2020 11.02, Janosch Frank wrote:
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
>  arch/s390/kvm/kvm-s390.c       | 84 +++++++++++++++++++++++-----------
>  include/uapi/linux/kvm.h       |  5 ++
>  3 files changed, 105 insertions(+), 27 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
