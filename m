Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59061 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390047AbgFYHKN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 25 Jun 2020 03:10:13 -0400
Subject: Re: [PATCH 1/2] docs: kvm: add documentation for KVM_CAP_S390_DIAG318
References: <20200624202200.28209-1-walling@linux.ibm.com>
 <20200624202200.28209-2-walling@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bead57a6-412a-c6b8-24be-2615979931ac@redhat.com>
Date: Thu, 25 Jun 2020 09:10:00 +0200
MIME-Version: 1.0
In-Reply-To: <20200624202200.28209-2-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On 24.06.20 22:21, Collin Walling wrote:
> Documentation for the s390 DIAGNOSE 0x318 instruction handling.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  Documentation/virt/kvm/api.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 426f94582b7a..056608e8f243 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6150,3 +6150,22 @@ KVM can therefore start protected VMs.
>  This capability governs the KVM_S390_PV_COMMAND ioctl and the
>  KVM_MP_STATE_LOAD MP_STATE. KVM_SET_MP_STATE can fail for protected
>  guests when the state change is invalid.
> +
> +8.24 KVM_CAP_S390_DIAG318
> +-------------------------
> +
> +:Architecture: s390
> +
> +This capability allows for information regarding the control program that may
> +be observed via system/firmware service events. The availability of this
> +capability indicates that KVM handling of the register synchronization, reset,
> +and VSIE shadowing of the DIAGNOSE 0x318 related information is present.
> +
> +The information associated with the instruction is an 8-byte value consisting
> +of a one-byte Control Program Name Code (CPNC), and a 7-byte Control Program
> +Version Code (CPVC). The CPNC determines what environment the control program
> +is running in (e.g. Linux, z/VM...), and the CPVC is used for extraneous
> +information specific to OS (e.g. Linux version, Linux distribution...)
> +
> +If this capability is available, then the CPNC and CPVC can be synchronized
> +between KVM and userspace via the sync regs mechanism (KVM_SYNC_DIAG318).
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
