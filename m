Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388430AbgBNUN4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 15:13:56 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01EK3ZaQ107661
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 15:13:55 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j885j55-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 15:13:55 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 14 Feb 2020 20:13:48 -0000
Subject: Re: [PATCH 07/35] KVM: s390: add new variants of UV CALL
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-8-borntraeger@de.ibm.com>
 <b9988313-74d1-6e68-efef-d012aae30d6d@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Feb 2020 21:13:43 +0100
MIME-Version: 1.0
In-Reply-To: <b9988313-74d1-6e68-efef-d012aae30d6d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <bb832871-8caa-30c3-1597-27bce32aa9b4@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 14.02.20 19:28, David Hildenbrand wrote:
> On 07.02.20 12:39, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> This add 2 new variants of the UV CALL.
>>
>> The first variant handles UV CALLs that might have longer busy
>> conditions or just need longer when doing partial completion. We should
>> schedule when necessary.
>>
>> The second variant handles UV CALLs that only need the handle but have
>> no payload (e.g. destroying a VM). We can provide a simple wrapper for
>> those.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/uv.h | 59 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
>> index 1b97230a57ba..e1cef772fde1 100644
>> --- a/arch/s390/include/asm/uv.h
>> +++ b/arch/s390/include/asm/uv.h
>> @@ -14,6 +14,7 @@
>>  #include <linux/types.h>
>>  #include <linux/errno.h>
>>  #include <linux/bug.h>
>> +#include <linux/sched.h>
>>  #include <asm/page.h>
>>  #include <asm/gmap.h>
>>  
>> @@ -91,6 +92,19 @@ struct uv_cb_cfs {
>>  	u64 paddr;
>>  } __packed __aligned(8);
>>  
>> +/*
>> + * A common UV call struct for calls that take no payload
>> + * Examples:
>> + * Destroy cpu/config
>> + * Verify
>> + */
>> +struct uv_cb_nodata {
>> +	struct uv_cb_header header;
>> +	u64 reserved08[2];
>> +	u64 handle;
>> +	u64 reserved20[4];
>> +} __packed __aligned(8);
>> +
>>  struct uv_cb_share {
>>  	struct uv_cb_header header;
>>  	u64 reserved08[3];
>> @@ -98,6 +112,31 @@ struct uv_cb_share {
>>  	u64 reserved28;
>>  } __packed __aligned(8);
>>  
>> +/*
>> + * Low level uv_call that takes r1 and r2 as parameter and avoids
>> + * stalls for long running busy conditions by doing schedule
>> + */
>> +static inline int uv_call_sched(unsigned long r1, unsigned long r2)
>> +{
>> +	int cc;
>> +
>> +	do {
>> +		asm volatile(
>> +			"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
> 
> label not necessary

ack
> 
>> +			"		ipm	%[cc]\n"
>> +			"		srl	%[cc],28\n"
>> +			: [cc] "=d" (cc)
>> +			: [r1] "d" (r1), [r2] "d" (r2)
>> +			: "memory", "cc");
> 
> I was wondering if we could reuse uv_call() - something like
> 
> static inline int __uv_call(unsigned long r1, unsigned long r2)
> {
> 	int cc;
> 
> 	asm volatile(
> 		"	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
> 		"		ipm	%[cc]\n"
> 		"		srl	%[cc],28\n"
> 		: [cc] "=d" (cc)
> 		: [r1] "a" (r1), [r2] "a" (r2)
> 		: "memory", "cc");
> 	return cc;
> }
> 
> static inline int uv_call(unsigned long r1, unsigned long r2)
> {
> 	int rc;
> 
> 	do {
> 		cc = __uv_call(unsigned long r1, unsigned long r2);
> 	} while (cc > 1)
> 	return rc;

This will likely generate less efficient assembly code but it is certainly
easier to read. WIll change. 
> }
> 
> static inline int uv_call_sched(unsigned long r1, unsigned long r2)
> {
> 	int rc;
> 
> 	do {
> 		cc = __uv_call(unsigned long r1, unsigned long r2);
> 		cond_resched();
> 	} while (rc > 1)
> 	return rc;
> }

> 
>> +		if (need_resched())
>> +			schedule();
> 
> cond_resched();

ack

> 
>> +	} while (cc > 1);
>> +	return cc;
>> +}
>> +
>> +/*
>> + * Low level uv_call that takes r1 and r2 as parameter
>> + */
> 
> This "r1 and r2" does not sound like relevant news. Same for the other
> variant above.
> 
>>  static inline int uv_call(unsigned long r1, unsigned long r2)
>>  {
>>  	int cc;
>> @@ -113,6 +152,26 @@ static inline int uv_call(unsigned long r1, unsigned long r2)
>>  	return cc;
>>  }
>>  
>> +/*
>> + * special variant of uv_call that only transports the cpu or guest
>> + * handle and the command, like destroy or verify.
>> + */
>> +static inline int uv_cmd_nodata(u64 handle, u16 cmd, u32 *ret)
> 
> uv_call_sched_simple() ?

I think nodata is actually a better description
