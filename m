Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbfKMP5Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 10:57:24 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADFg38e014643
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 10:57:23 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w8kq4bxcf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 10:57:23 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <mimu@linux.ibm.com>;
        Wed, 13 Nov 2019 15:57:21 -0000
Reply-To: mimu@linux.ibm.com
Subject: Re: [RFC 15/37] KVM: s390: protvirt: Add machine-check interruption
 injection controls
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-16-frankja@linux.ibm.com>
 <6b0bef57-cbe3-99df-354e-061a12d4cc31@redhat.com>
From: Michael Mueller <mimu@linux.ibm.com>
Date: Wed, 13 Nov 2019 16:57:15 +0100
MIME-Version: 1.0
In-Reply-To: <6b0bef57-cbe3-99df-354e-061a12d4cc31@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7ff507ad-a725-b7b4-6a6e-9ae283a0ffd2@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com



On 13.11.19 15:49, Thomas Huth wrote:
> On 24/10/2019 13.40, Janosch Frank wrote:
>> From: Michael Mueller <mimu@linux.ibm.com>
>>
>> The following fields are added to the sie control block type 4:
>>       - Machine Check Interruption Code (mcic)
>>       - External Damage Code (edc)
>>       - Failing Storage Address (faddr)
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h | 33 +++++++++++++++++++++++---------
>>   1 file changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 63fc32d38aa9..0ab309b7bf4c 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -261,16 +261,31 @@ struct kvm_s390_sie_block {
>>   #define HPID_VSIE	0x5
>>   	__u8	hpid;			/* 0x00b8 */
>>   	__u8	reservedb9[7];		/* 0x00b9 */
>> -	__u32	eiparams;		/* 0x00c0 */
>> -	__u16	extcpuaddr;		/* 0x00c4 */
>> -	__u16	eic;			/* 0x00c6 */
>> +	union {
>> +		struct {
>> +			__u32	eiparams;	/* 0x00c0 */
>> +			__u16	extcpuaddr;	/* 0x00c4 */
>> +			__u16	eic;		/* 0x00c6 */
>> +		};
>> +		__u64	mcic;			/* 0x00c0 */
>> +	} __packed;
>>   	__u32	reservedc8;		/* 0x00c8 */
>> -	__u16	pgmilc;			/* 0x00cc */
>> -	__u16	iprcc;			/* 0x00ce */
>> -	__u32	dxc;			/* 0x00d0 */
>> -	__u16	mcn;			/* 0x00d4 */
>> -	__u8	perc;			/* 0x00d6 */
>> -	__u8	peratmid;		/* 0x00d7 */
>> +	union {
>> +		struct {
>> +			__u16	pgmilc;		/* 0x00cc */
>> +			__u16	iprcc;		/* 0x00ce */
>> +		};
>> +		__u32	edc;			/* 0x00cc */
>> +	} __packed;
>> +	union {
>> +		struct {
>> +			__u32	dxc;		/* 0x00d0 */
>> +			__u16	mcn;		/* 0x00d4 */
>> +			__u8	perc;		/* 0x00d6 */
>> +			__u8	peratmid;	/* 0x00d7 */
>> +		};
>> +		__u64	faddr;			/* 0x00d0 */
>> +	} __packed;
> 
> Maybe drop the __packed keywords since the struct members are naturally
> aligned anyway?
> 
>   Thomas
> 

Thanks, I will give it a try.

Michael
