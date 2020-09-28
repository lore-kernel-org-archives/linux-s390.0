Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726576AbgI1Khr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Sep 2020 06:37:47 -0400
Subject: Re: [PATCH v1 2/4] s390x: pv: implement routine to share/unshare
 memory
References: <1601049764-11784-1-git-send-email-pmorel@linux.ibm.com>
 <1601049764-11784-3-git-send-email-pmorel@linux.ibm.com>
 <6c87a0ef-63ef-a0b8-58ff-d60e58bdb223@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <9aa7e0ab-7013-db0b-4af5-8015ade5c40c@linux.ibm.com>
Date: Mon, 28 Sep 2020 12:37:40 +0200
MIME-Version: 1.0
In-Reply-To: <6c87a0ef-63ef-a0b8-58ff-d60e58bdb223@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com



On 2020-09-28 10:22, Janosch Frank wrote:
> On 9/25/20 6:02 PM, Pierre Morel wrote:
>> When communicating with the host we need to share part of
>> the memory.
>>
>> Let's implement the ultravisor calls for this.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   lib/s390x/asm/uv.h | 33 +++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
>> index 4c2fc48..19019e4 100644
>> --- a/lib/s390x/asm/uv.h
>> +++ b/lib/s390x/asm/uv.h
>> @@ -71,4 +71,37 @@ static inline int uv_call(unsigned long r1, unsigned long r2)
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
>> +
>> +	uv_call(0, (u64)&uvcb);
>> +	return uvcb.header.rc;
> 
> That's not a great idea, rc is > 1 for error codes...
> In the kernel we check for the cc instead since uv_call() has only 0/1
> as possible cc return values.

hum, Yes.
I will add some report too here in case of error.




-- 
Pierre Morel
IBM Lab Boeblingen
