Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbgBSLBT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Feb 2020 06:01:19 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JAxxMe192668
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 06:01:18 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ub9qknb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 06:01:18 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 19 Feb 2020 11:01:16 -0000
Subject: Re: [PATCH v2.1] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <20200214222658.12946-10-borntraeger@de.ibm.com>
 <20200218083946.44720-1-borntraeger@de.ibm.com>
 <42deaa19-d2ca-f1cc-3e83-af0d5d77347f@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 19 Feb 2020 12:01:09 +0100
MIME-Version: 1.0
In-Reply-To: <42deaa19-d2ca-f1cc-3e83-af0d5d77347f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <4386caa5-6158-0f8b-cb9f-fd9ab3435910@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Ulrich.Weigand@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com



On 18.02.20 10:12, David Hildenbrand wrote:
ock the VCPU, it cannot be running, right?
> 
>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>> +		mutex_lock(&vcpu->mutex);
>> +		r = kvm_s390_pv_destroy_cpu(vcpu, rc, rrc);
>> +		mutex_unlock(&vcpu->mutex);
>> +		if (r)
>> +			break;
>> +	}
> 
> Can this actually ever fail? 

Every reason for failure seems to be wrong usage by KVM. So it should not fail and if if does
we should probably warn. 

If so, you would leave half-initialized
> state around. Warn and continue?

So yes, maybe warn and try to continue to destroy the remaining CPUs.

> 
> Especially, kvm_arch_vcpu_destroy() ignores any error from
> kvm_s390_pv_destroy_cpu() as well ...
> 
> IMHO, we should make kvm_s390_switch_from_pv() and
> kvm_s390_pv_destroy_cpu() never fail.

ack.
