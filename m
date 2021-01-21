Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728483AbhAUJwt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 04:52:49 -0500
Subject: Re: [kvm-unit-tests PATCH v4 1/3] s390x: pv: implement routine to
 share/unshare memory
References: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
 <1611220392-22628-2-git-send-email-pmorel@linux.ibm.com>
 <a4ad5c0f-2e77-4ea9-9efd-f4d000f17b72@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <27a07988-ab93-a482-3d60-cf76bf460b20@linux.ibm.com>
Date: Thu, 21 Jan 2021 10:52:00 +0100
MIME-Version: 1.0
In-Reply-To: <a4ad5c0f-2e77-4ea9-9efd-f4d000f17b72@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com



On 1/21/21 10:20 AM, Janosch Frank wrote:
> On 1/21/21 10:13 AM, Pierre Morel wrote:
>> When communicating with the host we need to share part of
>> the memory.
>>
>> Let's implement the ultravisor calls for this.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>> Acked-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   lib/s390x/asm/uv.h | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
>> index 4c2fc48..8400026 100644
>> --- a/lib/s390x/asm/uv.h
>> +++ b/lib/s390x/asm/uv.h
>> @@ -71,4 +71,42 @@ static inline int uv_call(unsigned long r1, unsigned long r2)
>>   	return cc;
>>   }
>>   
>> +static inline int share(unsigned long addr, u16 cmd)
>> +{
>> +	struct uv_cb_share uvcb = {
>> +		.header.cmd = cmd,
>> +		.header.len = sizeof(uvcb),
>> +		.paddr = addr
>> +	};
>> +	int cc;
>> +
>> +	cc = uv_call(0, (u64)&uvcb);
>> +	if (!cc && uvcb.header.rc == 0x0001)
> 
> s/0x0001/UVC_RC_EXECUTED/

OK

> 
> 
>> +		return 0;
>> +
>> +	report_info("cc %d response code: %04x", cc, uvcb.header.rc);
> 
> Will the print have the string UV in it or will I need to guess that a
> UV call failed?

I will change for a more explicit

> 
> I'm wondering if an assert would make more sense, if callers are
> interested in the uv rc they will need to write an own share function
> anyway.

No need (reported OOB by Janosch)

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
