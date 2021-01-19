Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 1/2] s390: uv: Fix sysfs max number of VCPUs reporting
References: <20210119100402.84734-1-frankja@linux.ibm.com>
 <20210119100402.84734-2-frankja@linux.ibm.com>
 <d72e2823-f30f-02be-1ee5-445496ca9dbc@de.ibm.com>
 <945319e9-641b-70ea-0e0b-2e71f73cf086@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <b3d99ee1-864c-c96b-34f8-1eb7d464db03@de.ibm.com>
Date: Tue, 19 Jan 2021 11:19:49 +0100
MIME-Version: 1.0
In-Reply-To: <945319e9-641b-70ea-0e0b-2e71f73cf086@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, gor@linux.ibm.com, mihajlov@linux.ibm.com



On 19.01.21 11:15, Janosch Frank wrote:
> On 1/19/21 11:11 AM, Christian Borntraeger wrote:
>>
>>
>> On 19.01.21 11:04, Janosch Frank wrote:
>>> The number reported by the query is N-1 and I think people reading the
>>> sysfs file would expect N instead. For users creating VMs there's no
>>> actual difference because KVM's limit is currently below the UV's
>>> limit.
>>>
>>> The naming of the field is a bit misleading. Number in this context is
>>> used like ID and starts at 0. The query field denotes the maximum
>>> number that can be put into the VCPU number field in the "create
>>> secure CPU" UV call.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Fixes: a0f60f8431999 ("s390/protvirt: Add sysfs firmware interface for Ultravisor information")
>>> Cc: stable@vger.kernel.org
>>> ---
>>>  arch/s390/boot/uv.c        | 2 +-
>>>  arch/s390/include/asm/uv.h | 4 ++--
>>>  arch/s390/kernel/uv.c      | 2 +-
>>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
>>> index a15c033f53ca..afb721082989 100644
>>> --- a/arch/s390/boot/uv.c
>>> +++ b/arch/s390/boot/uv.c
>>> @@ -35,7 +35,7 @@ void uv_query_info(void)
>>>  		uv_info.guest_cpu_stor_len = uvcb.cpu_stor_len;
>>>  		uv_info.max_sec_stor_addr = ALIGN(uvcb.max_guest_stor_addr, PAGE_SIZE);
>>>  		uv_info.max_num_sec_conf = uvcb.max_num_sec_conf;
>>> -		uv_info.max_guest_cpus = uvcb.max_guest_cpus;
>>> +		uv_info.max_guest_cpu_id = uvcb.max_guest_cpu_num;
>>>  	}
>>>  
>>>  #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
>>> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
>>> index 0325fc0469b7..c484c95ea142 100644
>>> --- a/arch/s390/include/asm/uv.h
>>> +++ b/arch/s390/include/asm/uv.h
>>> @@ -96,7 +96,7 @@ struct uv_cb_qui {
>>>  	u32 max_num_sec_conf;
>>>  	u64 max_guest_stor_addr;
>>>  	u8  reserved88[158 - 136];
>>> -	u16 max_guest_cpus;
>>> +	u16 max_guest_cpu_num;
>>
>> I think it would read better if we name this also max_guest_cpu_id.
>> Otherwise this looks good.
>>
> 
> Yes, but I wanted to have the same name as in the specification.
> So, what do we value more?

I think readability is more important. Maybe add a comment in the structure definition that
explains it?
