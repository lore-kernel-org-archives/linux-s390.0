Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31105 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726216AbgBXTGE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 14:06:04 -0500
Subject: Re: [PATCH v4 28/36] KVM: s390: protvirt: Report CPU state to
 Ultravisor
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-29-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3c653e60-5ef4-4b81-3bbd-4d72144b9d0b@redhat.com>
Date: Mon, 24 Feb 2020 20:05:55 +0100
MIME-Version: 1.0
In-Reply-To: <20200224114107.4646-29-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 24.02.20 12:40, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> VCPU states have to be reported to the ultravisor for SIGP
> interpretation, kdump, kexec and reboot.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

[...]

>  
> -void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
> +int kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>  {
> -	int i, online_vcpus, started_vcpus = 0;
> +	int i, online_vcpus, r = 0, started_vcpus = 0;
>  	struct kvm_vcpu *started_vcpu = NULL;
>  
>  	if (is_vcpu_stopped(vcpu))
> -		return;
> +		return 0;
>  
>  	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 0);
>  	/* Only one cpu at a time may enter/leave the STOPPED state. */
> @@ -4501,6 +4509,9 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>  	kvm_s390_clear_stop_irq(vcpu);
>  
>  	kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOPPED);
> +	/* Let's tell the UV that we successfully stopped the vcpu */
> +	if (kvm_s390_pv_cpu_is_protected(vcpu))
> +		r = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_STP);
>  	__disable_ibs_on_vcpu(vcpu);
>  
>  	for (i = 0; i < online_vcpus; i++) {
> @@ -4519,7 +4530,7 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>  	}
>  
>  	spin_unlock(&vcpu->kvm->arch.start_stop_lock);
> -	return;
> +	return r;
>  }

So... you stopped the CPU, the UV call failed, and you'll return an
error. But you did stop the CPU. What is user space expected to do with
that error?

After all, it can't retrigger a STOP, due to if (is_vcpu_stopped(vcpu)).
Same applies to the start path.


-- 
Thanks,

David / dhildenb
