Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729720AbgBYIaL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 03:30:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01P8Tvdr045759
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 03:30:09 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yb1c76qyf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 03:30:08 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Feb 2020 08:29:49 -0000
Subject: Re: [PATCH v4 28/36] KVM: s390: protvirt: Report CPU state to
 Ultravisor
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-29-borntraeger@de.ibm.com>
 <3c653e60-5ef4-4b81-3bbd-4d72144b9d0b@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 25 Feb 2020 09:29:42 +0100
MIME-Version: 1.0
In-Reply-To: <3c653e60-5ef4-4b81-3bbd-4d72144b9d0b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <d75b4759-9fff-fef0-e6ec-09dd81a01355@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 24.02.20 20:05, David Hildenbrand wrote:
> On 24.02.20 12:40, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> VCPU states have to be reported to the ultravisor for SIGP
>> interpretation, kdump, kexec and reboot.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> [...]
> 
>>  
>> -void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>> +int kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>>  {
>> -	int i, online_vcpus, started_vcpus = 0;
>> +	int i, online_vcpus, r = 0, started_vcpus = 0;
>>  	struct kvm_vcpu *started_vcpu = NULL;
>>  
>>  	if (is_vcpu_stopped(vcpu))
>> -		return;
>> +		return 0;
>>  
>>  	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 0);
>>  	/* Only one cpu at a time may enter/leave the STOPPED state. */
>> @@ -4501,6 +4509,9 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>>  	kvm_s390_clear_stop_irq(vcpu);
>>  
>>  	kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOPPED);
>> +	/* Let's tell the UV that we successfully stopped the vcpu */
>> +	if (kvm_s390_pv_cpu_is_protected(vcpu))
>> +		r = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_STP);
>>  	__disable_ibs_on_vcpu(vcpu);
>>  
>>  	for (i = 0; i < online_vcpus; i++) {
>> @@ -4519,7 +4530,7 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>>  	}
>>  
>>  	spin_unlock(&vcpu->kvm->arch.start_stop_lock);
>> -	return;
>> +	return r;
>>  }
> 
> So... you stopped the CPU, the UV call failed, and you'll return an
> error. But you did stop the CPU. What is user space expected to do with
> that error?

If that call returns with an error the QEMU and ultravisor are out of sync.
The only possible solution in such a case is probably to pause the guest (or
exit with an error) or to do a system_restart.

To make the system restart possible I will move the pv_set_cpu_state to the
beginning of the function and do an early exit on error. 

> 
> After all, it can't retrigger a STOP, due to if (is_vcpu_stopped(vcpu)).
> Same applies to the start path.

Looks now like:

@@ -4445,18 +4451,27 @@ static void __enable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
        kvm_s390_sync_request(KVM_REQ_ENABLE_IBS, vcpu);
 }

-void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
+int kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 {
-       int i, online_vcpus, started_vcpus = 0;
+       int i, online_vcpus, r = 0, started_vcpus = 0;

        if (!is_vcpu_stopped(vcpu))
-               return;
+               return 0;

        trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 1);
        /* Only one cpu at a time may enter/leave the STOPPED state. */
        spin_lock(&vcpu->kvm->arch.start_stop_lock);
        online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);

+       /* Let's tell the UV that we want to change into the operating state */
+       if (kvm_s390_pv_cpu_is_protected(vcpu)) {
+               r = kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR);
+               if (r) {
+                       spin_unlock(&vcpu->kvm->arch.start_stop_lock);
+                       return r;
+               }
+       }
+
        for (i = 0; i < online_vcpus; i++) {
                if (!is_vcpu_stopped(vcpu->kvm->vcpus[i]))
                        started_vcpus++;
@@ -4481,22 +4496,31 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
         */
        kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
        spin_unlock(&vcpu->kvm->arch.start_stop_lock);
-       return;
+       return r;
 }
