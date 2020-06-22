Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22982 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729493AbgFVQFa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 22 Jun 2020 12:05:30 -0400
Date: Mon, 22 Jun 2020 18:04:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 2/2] s390/kvm: diagnose 0x318 sync and reset
Message-ID: <20200622180459.4cf7cbf4.cohuck@redhat.com>
In-Reply-To: <20200622154636.5499-3-walling@linux.ibm.com>
References: <20200622154636.5499-1-walling@linux.ibm.com>
        <20200622154636.5499-3-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On Mon, 22 Jun 2020 11:46:36 -0400
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
> This data is reset on load normal and clear resets.

Looks good to me AFAICS without access to the architecture.

Acked-by: Cornelia Huck <cohuck@redhat.com>

One small thing below.

> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  4 +++-
>  arch/s390/include/uapi/asm/kvm.h |  5 ++++-
>  arch/s390/kvm/kvm-s390.c         | 11 ++++++++++-
>  arch/s390/kvm/vsie.c             |  1 +
>  include/uapi/linux/kvm.h         |  1 +
>  5 files changed, 19 insertions(+), 3 deletions(-)

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

Should we document this in Documentation/virt/kvm/api.rst?

(Documentation of KVM caps generally seems to be a bit of a
hit-and-miss, though. But we could at least document the s390 ones :)

I also noticed that the new entries for the vcpu resets and pv do not
seem to be in proper rst format. Maybe fix that and add the new doc in
an add-on series?

>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
