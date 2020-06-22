Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30387 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726841AbgFVKZQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Jun 2020 06:25:16 -0400
Date: Mon, 22 Jun 2020 12:24:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v8 2/2] s390/kvm: diagnose 0x318 sync and reset
Message-ID: <20200622122456.781492a8.cohuck@redhat.com>
In-Reply-To: <20200618222222.23175-3-walling@linux.ibm.com>
References: <20200618222222.23175-1-walling@linux.ibm.com>
        <20200618222222.23175-3-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On Thu, 18 Jun 2020 18:22:22 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> DIAGNOSE 0x318 (diag318) sets information regarding the environment
> the VM is running in (Linux, z/VM, etc) and is observed via
> firmware/service events.
> 
> This is a privileged s390x instruction that must be intercepted by
> SIE. Userspace handles the instruction as well as migration. Data
> is communicated via VCPU register synchronization.
> 
> The Control Program Name Code (CPNC) is stored in the SIE block. The
> CPNC along with the Control Program Version Code (CPVC) are stored
> in the kvm_vcpu_arch struct.
> 
> The CPNC is shadowed/unshadowed in VSIE.
> 
> This data is reset on load normal and clear resets.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  4 +++-
>  arch/s390/include/uapi/asm/kvm.h |  5 ++++-
>  arch/s390/kvm/kvm-s390.c         | 11 ++++++++++-
>  arch/s390/kvm/vsie.c             |  3 +++
>  include/uapi/linux/kvm.h         |  1 +
>  5 files changed, 21 insertions(+), 3 deletions(-)
> 

(...)

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 4fdf30316582..35cdb4307904 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1031,6 +1031,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_PPC_SECURE_GUEST 181
>  #define KVM_CAP_HALT_POLL 182
>  #define KVM_CAP_ASYNC_PF_INT 183
> +#define KVM_CAP_S390_DIAG318 184

Do we strictly need this new cap, or would checking against the sync
regs capabilities be enough?

>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
