Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388615AbhATMRl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Jan 2021 07:17:41 -0500
Subject: Re: [kvm-unit-tests PATCH v3 1/3] s390x: pv: implement routine to
 share/unshare memory
References: <1611085944-21609-1-git-send-email-pmorel@linux.ibm.com>
 <1611085944-21609-2-git-send-email-pmorel@linux.ibm.com>
 <211a4bd3-763a-f8fc-3c08-8d8d1809cc7c@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <eecc5b27-12b7-8a9a-febe-a98d2f8ec7b5@linux.ibm.com>
Date: Wed, 20 Jan 2021 13:16:52 +0100
MIME-Version: 1.0
In-Reply-To: <211a4bd3-763a-f8fc-3c08-8d8d1809cc7c@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com



On 1/20/21 11:48 AM, Thomas Huth wrote:
> On 19/01/2021 20.52, Pierre Morel wrote:
>> When communicating with the host we need to share part of
>> the memory.
>>
>> Let's implement the ultravisor calls for this.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   lib/s390x/asm/uv.h | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
>> index 4c2fc48..1242336 100644
>> --- a/lib/s390x/asm/uv.h
>> +++ b/lib/s390x/asm/uv.h
>> @@ -71,4 +71,42 @@ static inline int uv_call(unsigned long r1, 
>> unsigned long r2)
>>       return cc;
>>   }
>> +static inline int share(unsigned long addr, u16 cmd)
>> +{
>> +    struct uv_cb_share uvcb = {
>> +        .header.cmd = cmd,
>> +        .header.len = sizeof(uvcb),
>> +        .paddr = addr
>> +    };
>> +    int cc;
>> +
>> +    cc = uv_call(0, (u64)&uvcb);
>> +    if (!cc && (uvcb.header.rc == 0x0001))
> 
> You can drop the innermost parentheses.

OK.

> 
>> +        return 0;
>> +
>> +    report_info("cc %d response code: %04x", cc, uvcb.header.rc);
>> +    return -1;
>> +}
>> +
>> +/*
>> + * Guest 2 request to the Ultravisor to make a page shared with the
>> + * hypervisor for IO.
>> + *
>> + * @addr: Real or absolute address of the page to be shared
> 
> When is it real, and when is it absolute?

It only depends on the prefixing, the call can use both.

> 
>> + */
>> +static inline int uv_set_shared(unsigned long addr)
>> +{
>> +    return share(addr, UVC_CMD_SET_SHARED_ACCESS);
>> +}
>> +
>> +/*
>> + * Guest 2 request to the Ultravisor to make a page unshared.
>> + *
>> + * @addr: Real or absolute address of the page to be unshared
> 
> dito
> 
>> + */
>> +static inline int uv_remove_shared(unsigned long addr)
>> +{
>> +    return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
>> +}
>> +
>>   #endif
> 
> Apart from the nits:
> Acked-by: Thomas Huth <thuth@redhat.com>
> 

Thanks thomas for reviewing.

Regards,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
