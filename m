Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57936 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731611AbgBYSji (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 13:39:38 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PIcND6173362
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 13:39:37 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb00apq1g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 13:39:36 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Feb 2020 18:39:35 -0000
Subject: Re: [PATCH v4 18/36] KVM: S390: protvirt: Introduce instruction data
 area bounce buffer
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-19-borntraeger@de.ibm.com>
 <3db82b2d-ad79-8178-e027-c19889d96558@redhat.com>
 <f8d7321e-400e-ed82-471e-166a2d18ede6@de.ibm.com>
 <20200225182142.37fbf6c3.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 25 Feb 2020 19:39:28 +0100
MIME-Version: 1.0
In-Reply-To: <20200225182142.37fbf6c3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <452dbb48-dc21-1983-b70e-f4ad04540636@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 25.02.20 18:21, Cornelia Huck wrote:
> On Tue, 25 Feb 2020 08:50:47 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> This is the guest breaking event address. So a guest (and QEMU) can read it.
>> It is kind of overlaid sida and gbea. Something like this:
>>
>> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
>> index cd81a58349a9..055bf0ec8fbb 100644
>> --- a/arch/s390/kvm/pv.c
>> +++ b/arch/s390/kvm/pv.c
>> @@ -39,6 +39,11 @@ int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
>>         vcpu->arch.sie_block->pv_handle_config = 0;
>>         memset(&vcpu->arch.pv, 0, sizeof(vcpu->arch.pv));
>>         vcpu->arch.sie_block->sdf = 0;
>> +       /*
>> +        * the sidad field (for sdf == 2) is now the gbea field (for sdf == 0).
> 
> s/the sidad/The sidad/

ack
> 
>> +        * Use the reset value of gbea to not leak the kernel pointer of the
> 
> s/to not leak/to avoid leaking/

> 
>> +        * just free sida
> 
> s/free sida/freed sida./

ack

> 
