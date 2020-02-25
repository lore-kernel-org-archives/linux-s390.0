Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729565AbgBYHu6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 02:50:58 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01P7nfpH044110
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 02:50:56 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb12brgvq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 02:50:56 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Feb 2020 07:50:54 -0000
Subject: Re: [PATCH v4 18/36] KVM: S390: protvirt: Introduce instruction data
 area bounce buffer
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-19-borntraeger@de.ibm.com>
 <3db82b2d-ad79-8178-e027-c19889d96558@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 25 Feb 2020 08:50:47 +0100
MIME-Version: 1.0
In-Reply-To: <3db82b2d-ad79-8178-e027-c19889d96558@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <f8d7321e-400e-ed82-471e-166a2d18ede6@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 24.02.20 20:13, David Hildenbrand wrote:
> On 24.02.20 12:40, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> Now that we can't access guest memory anymore, we have a dedicated
>> satellite block that's a bounce buffer for instruction data.
>>
>> We re-use the memop interface to copy the instruction data to / from
>> userspace. This lets us re-use a lot of QEMU code which used that
>> interface to make logical guest memory accesses which are not possible
>> anymore in protected mode anyway.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> [...]
> 
>> +
>>  long kvm_arch_vcpu_async_ioctl(struct file *filp,
>>  			       unsigned int ioctl, unsigned long arg)
>>  {
>> @@ -4683,7 +4732,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>  		struct kvm_s390_mem_op mem_op;
>>  
>>  		if (copy_from_user(&mem_op, argp, sizeof(mem_op)) == 0)
>> -			r = kvm_s390_guest_mem_op(vcpu, &mem_op);
>> +			r = kvm_s390_guest_memsida_op(vcpu, &mem_op);
>>  		else
>>  			r = -EFAULT;
>>  		break;
>> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
>> index 014e53a41ead..cd81a58349a9 100644
>> --- a/arch/s390/kvm/pv.c
>> +++ b/arch/s390/kvm/pv.c
>> @@ -33,10 +33,13 @@ int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
>>  	if (!cc)
>>  		free_pages(vcpu->arch.pv.stor_base,
>>  			   get_order(uv_info.guest_cpu_stor_len));
>> +
>> +	free_page(sida_origin(vcpu->arch.sie_block));
>>  	vcpu->arch.sie_block->pv_handle_cpu = 0;
>>  	vcpu->arch.sie_block->pv_handle_config = 0;
>>  	memset(&vcpu->arch.pv, 0, sizeof(vcpu->arch.pv));
>>  	vcpu->arch.sie_block->sdf = 0;
>> +	vcpu->arch.sie_block->gbea = 1;
> 
> I am very confused why gbea is set to 1 when destroying the CPU. It's
> otherwise never set (always 0). What's the meaning of this?

This is the guest breaking event address. So a guest (and QEMU) can read it.
It is kind of overlaid sida and gbea. Something like this:

diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index cd81a58349a9..055bf0ec8fbb 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -39,6 +39,11 @@ int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
        vcpu->arch.sie_block->pv_handle_config = 0;
        memset(&vcpu->arch.pv, 0, sizeof(vcpu->arch.pv));
        vcpu->arch.sie_block->sdf = 0;
+       /*
+        * the sidad field (for sdf == 2) is now the gbea field (for sdf == 0).
+        * Use the reset value of gbea to not leak the kernel pointer of the
+        * just free sida
+        */
        vcpu->arch.sie_block->gbea = 1;
        kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 



> 
> Apart from that, looks good to me.
> 
> 
