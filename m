Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729839AbgBYNHu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 08:07:50 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PD5Jl0087137
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 08:07:49 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yax38v8j7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 08:07:49 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Feb 2020 13:07:47 -0000
Subject: Re: [PATCH v4 24/36] KVM: s390: protvirt: Do only reset registers
 that are accessible
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-25-borntraeger@de.ibm.com>
 <20200225133252.479644ea.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 25 Feb 2020 14:07:39 +0100
MIME-Version: 1.0
In-Reply-To: <20200225133252.479644ea.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b1f6e91a-661b-a553-718f-4d78c90838ca@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 25.02.20 13:32, Cornelia Huck wrote:
> On Mon, 24 Feb 2020 06:40:55 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> For protected VMs the hypervisor can not access guest breaking event
>> address, program parameter, bpbc and todpr. Do not reset those fields
>> as the control block does not provide access to these fields.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 6ab4c88f2e1d..c734e89235f9 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -3499,14 +3499,16 @@ static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>>  	kvm_s390_set_prefix(vcpu, 0);
>>  	kvm_s390_set_cpu_timer(vcpu, 0);
>>  	vcpu->arch.sie_block->ckc = 0;
>> -	vcpu->arch.sie_block->todpr = 0;
>>  	memset(vcpu->arch.sie_block->gcr, 0, sizeof(vcpu->arch.sie_block->gcr));
>>  	vcpu->arch.sie_block->gcr[0] = CR0_INITIAL_MASK;
>>  	vcpu->arch.sie_block->gcr[14] = CR14_INITIAL_MASK;
>>  	vcpu->run->s.regs.fpc = 0;
>> -	vcpu->arch.sie_block->gbea = 1;
>> -	vcpu->arch.sie_block->pp = 0;
>> -	vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
>> +	if (!kvm_s390_pv_cpu_is_protected(vcpu)) {
>> +		vcpu->arch.sie_block->gbea = 1;
>> +		vcpu->arch.sie_block->pp = 0;
>> +		vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
>> +		vcpu->arch.sie_block->todpr = 0;
> 
> What happens if we do change those values? Is it just ignored or will
> we get an exception on the next SIE entry?

These fields (offsets in the sie control block) are not defined or re-defined for secure guests.
So we better leave them unchanged.
