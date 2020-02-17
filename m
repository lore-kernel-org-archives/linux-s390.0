Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729102AbgBQMEW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 07:04:22 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HC0vVR170001
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 07:04:21 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6d60hgtv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 07:04:21 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 17 Feb 2020 12:04:18 -0000
Subject: Re: [PATCH v2 09/42] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-10-borntraeger@de.ibm.com>
 <9cac0f98-e593-b6ae-9d53-d3c77ea090a1@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Feb 2020 13:04:11 +0100
MIME-Version: 1.0
In-Reply-To: <9cac0f98-e593-b6ae-9d53-d3c77ea090a1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <f70b97fe-fbaf-2e5a-cc7d-a7529a8943f4@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 17.02.20 11:56, David Hildenbrand wrote:
> [...]
>>  
>> +static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>> +{
>> +	int r = 0;
>> +	void __user *argp = (void __user *)cmd->data;
>> +
>> +	switch (cmd->cmd) {
>> +	case KVM_PV_VM_CREATE: {
>> +		r = -EINVAL;
>> +		if (kvm_s390_pv_is_protected(kvm))
>> +			break;
> 
> Isn't this racy? I think there has to be a way to make sure the PV state
> can't change. Is there any and I am missing something obvious? (is
> suspect we need the kvm->lock)


Yes, kvm->lock around kvm_s390_handle_pv is safer.

Something like


diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 932f7f32e82f..87dc6caa2181 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2422,7 +2422,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
                        r = -EFAULT;
                        break;
                }
+               mutex_lock(&kvm->lock);
                r = kvm_s390_handle_pv(kvm, &args);
+               mutex_unlock(&kvm->lock);
                if (copy_to_user(argp, &args, sizeof(args))) {
                        r = -EFAULT;
                        break;



[...]


>> +	case KVM_PV_VM_SET_SEC_PARMS: {
> 
> I'd name this "KVM_PV_VM_SET_PARMS" instead.

[...]

>> @@ -2975,6 +3121,9 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
>>  
>>  	kvm_s390_vcpu_crypto_setup(vcpu);
>>  
>> +	if (kvm_s390_pv_is_protected(vcpu->kvm))
>> +		rc = kvm_s390_pv_create_cpu(vcpu, &uvrc, &uvrrc);
> 
> With an explicit KVM_PV_VCPU_CREATE, this does not belong here. When
> hotplugging CPUs, user space has to do that manually. But as I said
> already, this user space API could be improved. (below)

With your proposed API this would stay.

[...]

>> @@ -4493,6 +4674,25 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>  					   irq_state.len);
>>  		break;
>>  	}
>> +	case KVM_S390_PV_COMMAND_VCPU: {
>> +		struct kvm_pv_cmd args;
>> +
>> +		r = 0;
>> +		if (!is_prot_virt_host()) {
>> +			r = -EINVAL;
>> +			break;
>> +		}
>> +		if (copy_from_user(&args, argp, sizeof(args))) {
>> +			r = -EFAULT;
>> +			break;
>> +		}
>> +		r = kvm_s390_handle_pv_vcpu(vcpu, &args);
>> +		if (copy_to_user(argp, &args, sizeof(args))) {
>> +			r = -EFAULT;
>> +			break;
>> +		}
>> +		break;
>> +	}
>>  	default:
>>  		r = -ENOTTY;
> 
> 
> Can we please discuss why we can't
> 
> - Get rid of KVM_S390_PV_COMMAND_VCPU
> - Do the allocation in KVM_PV_VM_CREATE
> - Rename KVM_PV_VM_CREATE -> KVM_PV_ENABLE
> - Rename KVM_PV_VM_DESTROY -> KVM_PV_DISABLE
> 
> This user space API is unnecessary complicated and confusing.

I will have a look if this is feasible.
