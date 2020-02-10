Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727452AbgBJIek (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 03:34:40 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01A8YcrZ140093
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 03:34:39 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1tncnp6m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 03:34:39 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 08:34:21 -0000
Subject: Re: [PATCH 08/35] KVM: s390: protvirt: Add initial lifecycle handling
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-9-borntraeger@de.ibm.com>
 <c4949664-c6fd-f4d9-d42d-f2fa9426db00@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 09:34:15 +0100
MIME-Version: 1.0
In-Reply-To: <c4949664-c6fd-f4d9-d42d-f2fa9426db00@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5f9da2a4-8e76-5b2e-b455-f91e60e8e505@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 07.02.20 17:32, Thomas Huth wrote:
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
> [...]
>> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
>> index e1cef772fde1..7c21d55d2e49 100644
>> --- a/arch/s390/include/asm/uv.h
>> +++ b/arch/s390/include/asm/uv.h
>> @@ -23,11 +23,19 @@
>>  #define UVC_RC_INV_STATE	0x0003
>>  #define UVC_RC_INV_LEN		0x0005
>>  #define UVC_RC_NO_RESUME	0x0007
>> +#define UVC_RC_NEED_DESTROY	0x8000
> 
> This define is never used. I'd suggest to drop it.

I should be used in 

diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index da281d8dcc92..8cc927ca061f 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -189,7 +189,7 @@ int kvm_s390_pv_create_vm(struct kvm *kvm)
        /* Outputs */
        kvm->arch.pv.handle = uvcb.guest_handle;
 
-       if (rc && (uvcb.header.rc & 0x8000)) {
+       if (rc && (uvcb.header.rc & UVC_RC_NEED_DESTROY)) {
                kvm_s390_pv_destroy_vm(kvm);
                return -EINVAL;
        }


Will fix.
