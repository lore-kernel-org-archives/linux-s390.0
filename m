Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726945AbgBQSko (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 13:40:44 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HIdN0F143194
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 13:40:43 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6bumjvb7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 13:40:43 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 17 Feb 2020 18:40:41 -0000
Subject: Re: [PATCH v2 23/42] KVM: s390: protvirt: Write sthyi data to
 instruction data area
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-24-borntraeger@de.ibm.com>
 <0054ceb5-a1ab-5129-cc34-b785ee8ad782@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Feb 2020 19:40:34 +0100
MIME-Version: 1.0
In-Reply-To: <0054ceb5-a1ab-5129-cc34-b785ee8ad782@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <286d4d0a-84a2-5298-c4f9-221d5b4d2b13@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 17.02.20 15:24, David Hildenbrand wrote:
> On 14.02.20 23:26, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> STHYI data has to go through the bounce buffer.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/intercept.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
>> index 1e231058e4b3..cfabeecbb777 100644
>> --- a/arch/s390/kvm/intercept.c
>> +++ b/arch/s390/kvm/intercept.c
>> @@ -392,7 +392,7 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
>>  		goto out;
>>  	}
>>  
>> -	if (addr & ~PAGE_MASK)
>> +	if (!kvm_s390_pv_is_protected(vcpu->kvm) && (addr & ~PAGE_MASK))
>>  		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>>  
>>  	sctns = (void *)get_zeroed_page(GFP_KERNEL);
>> @@ -403,10 +403,15 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
>>  
>>  out:
>>  	if (!cc) {
>> -		r = write_guest(vcpu, addr, reg2, sctns, PAGE_SIZE);
>> -		if (r) {
>> -			free_page((unsigned long)sctns);
>> -			return kvm_s390_inject_prog_cond(vcpu, r);
>> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> 
> I have the feeling that we might have to think about proper locking for
> kvm_s390_pv_is_protected(). We have to make sure there cannot be any
> races with user space. Smells like a new r/w lock maybe.

I think we can keep that within kvm->lock (for the global changes) and vcpu->mutex. 
All the intercepts only happen within the vcpu run ioctl and that takes the
vcpu->mutex. See my other patch (with  mutex_lock(&vcpu->mutex) and mutex_unlock(&vcpu->mutex)
around the create/destroy functions). lockdep_assert_help is happy and as long as the
pv_handle reflects the state of the control block of that CPU we are good.

I pushed out the patch/rfcs to pv_worktree on kvms390.git.
