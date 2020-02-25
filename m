Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23380 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729852AbgBYNCC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 08:02:02 -0500
Date: Tue, 25 Feb 2020 14:01:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 28/36] KVM: s390: protvirt: Report CPU state to
 Ultravisor
Message-ID: <20200225140151.5e639df1.cohuck@redhat.com>
In-Reply-To: <d75b4759-9fff-fef0-e6ec-09dd81a01355@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-29-borntraeger@de.ibm.com>
        <3c653e60-5ef4-4b81-3bbd-4d72144b9d0b@redhat.com>
        <d75b4759-9fff-fef0-e6ec-09dd81a01355@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Tue, 25 Feb 2020 09:29:42 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 24.02.20 20:05, David Hildenbrand wrote:
> > On 24.02.20 12:40, Christian Borntraeger wrote:  
> >> From: Janosch Frank <frankja@linux.ibm.com>
> >>
> >> VCPU states have to be reported to the ultravisor for SIGP
> >> interpretation, kdump, kexec and reboot.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> >> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>  
> > 

> Looks now like:
> 
> @@ -4445,18 +4451,27 @@ static void __enable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
>         kvm_s390_sync_request(KVM_REQ_ENABLE_IBS, vcpu);
>  }
> 
> -void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
> +int kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
>  {
> -       int i, online_vcpus, started_vcpus = 0;
> +       int i, online_vcpus, r = 0, started_vcpus = 0;
> 
>         if (!is_vcpu_stopped(vcpu))
> -               return;
> +               return 0;
> 
>         trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 1);
>         /* Only one cpu at a time may enter/leave the STOPPED state. */
>         spin_lock(&vcpu->kvm->arch.start_stop_lock);
>         online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
> 
> +       /* Let's tell the UV that we want to change into the operating state */
> +       if (kvm_s390_pv_cpu_is_protected(vcpu)) {
> +               r = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR);
> +               if (r) {
> +                       spin_unlock(&vcpu->kvm->arch.start_stop_lock);
> +                       return r;
> +               }
> +       }
> +
>         for (i = 0; i < online_vcpus; i++) {
>                 if (!is_vcpu_stopped(vcpu->kvm->vcpus[i]))
>                         started_vcpus++;
> @@ -4481,22 +4496,31 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
>          */
>         kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
>         spin_unlock(&vcpu->kvm->arch.start_stop_lock);
> -       return;
> +       return r;
>  }
> 
> 

Hm, this is actually one of the cases where posting a new patch would
be less confusing than not doing so :)
