Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729222AbgBQPC4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 10:02:56 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HEwsFv111473
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:02:55 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e1ggcqf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:02:55 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 17 Feb 2020 15:02:52 -0000
Subject: Re: [PATCH 2/2] merge vm/cpu create
References: <c77dbb1b-0f4b-e40a-52a4-7110aec75e32@redhat.com>
 <20200217145302.19085-1-borntraeger@de.ibm.com>
 <20200217145302.19085-3-borntraeger@de.ibm.com>
 <5c0b4baa-4113-d183-5bc6-c1e7b1f3032c@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Feb 2020 16:02:46 +0100
MIME-Version: 1.0
In-Reply-To: <5c0b4baa-4113-d183-5bc6-c1e7b1f3032c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <fe034c64-2924-9a5d-60bd-d982c53e2e4a@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, david@redhat.com
Cc: Ulrich.Weigand@de.ibm.com, cohuck@redhat.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com



On 17.02.20 16:00, Janosch Frank wrote:
> On 2/17/20 3:53 PM, Christian Borntraeger wrote:
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 55 +++++++++++++++++++++++++++++-----------
>>  1 file changed, 40 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index a095d9695f18..10b20e17a7fe 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2171,9 +2171,41 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
>>  	return r;
>>  }
>>  
>> +static int kvm_s390_switch_from_pv(struct kvm *kvm, u16 *rc, u16 *rrc)
>> +{
>> +	int i, r = 0;
>> +
>> +	struct kvm_vcpu *vcpu;
>> +
>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>> +		r = kvm_s390_pv_destroy_cpu(vcpu, rc, rrc);
>> +		if (r)
>> +			break;
>> +	}
>> +	return r;
>> +}
>> +
>> +static int kvm_s390_switch_to_pv(struct kvm *kvm, u16 *rc, u16 *rrc)
>> +{
>> +	int i, r = 0;
>> +	u16 dummy;
>> +
>> +	struct kvm_vcpu *vcpu;
>> +
>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>> +		r = kvm_s390_pv_create_cpu(vcpu, rc, rrc);
>> +		if (r)
>> +			break;
>> +	}
>> +	if (r)
>> +		kvm_s390_switch_from_pv(kvm,&dummy, &dummy);
>> +	return r;
>> +}
> 
> Why does that only affect the cpus?
> If we have a switch function it should do VM and VCPUs, no?

It is a helper function for the function below. 

FWIW, it also needs to take the cpu->mutex for each cpu.
