Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbgBSLDF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Feb 2020 06:03:05 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JB0ER1025176
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 06:03:04 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8uecya1r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 06:03:04 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 19 Feb 2020 11:03:02 -0000
Subject: Re: [PATCH 2/2] merge vm/cpu create
References: <c77dbb1b-0f4b-e40a-52a4-7110aec75e32@redhat.com>
 <20200217145302.19085-1-borntraeger@de.ibm.com>
 <20200217145302.19085-3-borntraeger@de.ibm.com>
 <5c0b4baa-4113-d183-5bc6-c1e7b1f3032c@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 19 Feb 2020 12:02:54 +0100
MIME-Version: 1.0
In-Reply-To: <5c0b4baa-4113-d183-5bc6-c1e7b1f3032c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f74eca96-89b4-cc01-e1f2-adfd6a851843@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, david@redhat.com
Cc: Ulrich.Weigand@de.ibm.com, cohuck@redhat.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com



On 17.02.20 16:00, Janosch Frank wrote:

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

I will rename that to kvm_s390_switch_cpus_to/from.
