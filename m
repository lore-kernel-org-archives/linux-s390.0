Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19734 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgBJLoA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 06:44:00 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ABbG6E172496
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 06:43:58 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ucj117h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 06:43:58 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 11:43:56 -0000
Subject: Re: [PATCH 08/35] KVM: s390: protvirt: Add initial lifecycle handling
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-9-borntraeger@de.ibm.com>
 <2e5203d7-e162-ddd6-9281-44aa34fe32e7@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 12:43:51 +0100
MIME-Version: 1.0
In-Reply-To: <2e5203d7-e162-ddd6-9281-44aa34fe32e7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <62d5cd46-93d7-e272-f9bb-d4ec3c7a1f71@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 08.02.20 15:54, Thomas Huth wrote:
> On 07/02/2020 12.39, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> This contains 3 main changes:
>> 1. changes in SIE control block handling for secure guests
>> 2. helper functions for create/destroy/unpack secure guests
>> 3. KVM_S390_PV_COMMAND ioctl to allow userspace dealing with secure
>> machines
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  24 ++-
>>  arch/s390/include/asm/uv.h       |  69 +++++++++
>>  arch/s390/kvm/Makefile           |   2 +-
>>  arch/s390/kvm/kvm-s390.c         | 191 +++++++++++++++++++++++-
>>  arch/s390/kvm/kvm-s390.h         |  27 ++++
>>  arch/s390/kvm/pv.c               | 244 +++++++++++++++++++++++++++++++
>>  include/uapi/linux/kvm.h         |  33 +++++
>>  7 files changed, 586 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/s390/kvm/pv.c
> [...]
>> +struct kvm_pv_cmd {
>> +	__u32	cmd;	/* Command to be executed */
>> +	__u16	rc;	/* Ultravisor return code */
>> +	__u16	rrc;	/* Ultravisor return reason code */
> 
> What are rc and rrc good for? I currently can't spot the code where they
> are used...

Janosch want to have those for some cases. I will post an addon patch
as a reply.

> 
>> +	__u64	data;	/* Data or address */
>> +};
>> +
>> +/* Available with KVM_CAP_S390_PROTECTED */
>> +#define KVM_S390_PV_COMMAND		_IOW(KVMIO, 0xc5, struct kvm_pv_cmd)
>> +#define KVM_S390_PV_COMMAND_VCPU	_IOW(KVMIO, 0xc6, struct kvm_pv_cmd)
> 
> If you intend to return values in rc and rrc, shouldn't this rather be
> declared as _IOWR instead ?

If yes then Yes.
