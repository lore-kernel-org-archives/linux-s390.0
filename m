Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727762AbgBKUGU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Feb 2020 15:06:20 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BK5N6i037498
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 15:06:19 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y38gymd78-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 15:06:18 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 11 Feb 2020 20:06:17 -0000
Subject: Re: [PATCH 16/35] KVM: s390: protvirt: Add SCLP interrupt handling
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-17-borntraeger@de.ibm.com>
 <dbeb32f7-7cf5-ad93-fb79-94d4ac7e3d8c@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 11 Feb 2020 21:06:12 +0100
MIME-Version: 1.0
In-Reply-To: <dbeb32f7-7cf5-ad93-fb79-94d4ac7e3d8c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <56e8d455-d5f1-4fb2-38ee-052cc1abc8a0@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 11.02.20 13:00, Thomas Huth wrote:
[...]
>> +
>> +static int write_sclp(struct kvm_vcpu *vcpu, u32 parm)
>> +{
>> +	int rc;
>> +
>> +	if (kvm_s390_pv_handle_cpu(vcpu)) {
>> +		vcpu->arch.sie_block->iictl = IICTL_CODE_EXT;
>> +		vcpu->arch.sie_block->eic = EXT_IRQ_SERVICE_SIG;
>> +		vcpu->arch.sie_block->eiparams = parm;
>> +		return 0;
>> +	}
>> +
>> +	rc  = put_guest_lc(vcpu, EXT_IRQ_SERVICE_SIG, (u16 *)__LC_EXT_INT_CODE);
>> +	rc |= put_guest_lc(vcpu, 0, (u16 *)__LC_EXT_CPU_ADDR);
>> +	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
>> +			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
>> +	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
>> +			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
>> +	rc |= put_guest_lc(vcpu, parm,
>> +			   (u32 *)__LC_EXT_PARAMS);
>> +	return rc;
> 
> I think it would be nicer to move the "return rc ? -EFAULT : 0;" here
> instead of using it in the __deliver_service* functions...

ack. That would also allow to get rid of rc in the deliver functions.
