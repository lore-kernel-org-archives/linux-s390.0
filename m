Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2283 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbgBRJho (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 04:37:44 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01I9TsVP172913
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:37:43 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6b56jjv8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:37:42 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 18 Feb 2020 09:37:41 -0000
Subject: Re: [PATCH v2 28/42] KVM: s390: protvirt: Add program exception
 injection
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-29-borntraeger@de.ibm.com>
 <0911c8c1-0877-047b-0da5-4c7f79aef3ae@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 18 Feb 2020 10:37:33 +0100
MIME-Version: 1.0
In-Reply-To: <0911c8c1-0877-047b-0da5-4c7f79aef3ae@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2374ea8d-0244-f710-36b9-54ec1e9b4b7f@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 18.02.20 10:33, David Hildenbrand wrote:
eliver_prog(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
>> @@ -856,6 +871,9 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
>>  	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
>>  					 pgm_info.code, 0);
>>  
>> +	if (kvm_s390_pv_is_protected(vcpu->kvm))
> 
> Can we actually ever have PER set, and what would happen if so?
> Shouldn't we also return -EINVAL?

The ultravisor would add a concurrent PER event if appropriate.
