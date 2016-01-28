Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] kexec: unmap reserved pages for each error-return way
References: <1453895311-11087-1-git-send-email-dsafonov@virtuozzo.com>
 <20160128062906.GA4170@dhcp-128-25.nay.redhat.com>
From: Dmitry Safonov <dsafonov@virtuozzo.com>
Message-ID: <56A9D7F2.5000504@virtuozzo.com>
Date: Thu, 28 Jan 2016 11:57:22 +0300
MIME-Version: 1.0
In-Reply-To: <20160128062906.GA4170@dhcp-128-25.nay.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Minfei Huang <mhuang@redhat.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ebiederm@xmission.com, akpm@linux-foundation.org, linux-s390@vger.kernel.org, 0x7f454c46@gmail.com, kexec@lists.infradead.org, holzheu@linux.vnet.ibm.com, dyoung@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 01/28/2016 09:29 AM, Minfei Huang wrote:
> On 01/27/16 at 02:48pm, Dmitry Safonov wrote:
>> For allocation of kimage failure or kexec_prepare or load segments
>> errors there is no need to keep crashkernel memory mapped.
>> It will affect only s390 as map/unmap hook defined only for it.
>> As on unmap s390 also changes os_info structure let's check return code
>> and add info only on success.
> Hi, Dmitry.
>
> Previously, I sent a patch to fix this issue. You can refer it in
> following link.
>
> http://lists.infradead.org/pipermail/kexec/2015-July/013960.html
Oh, scratch my patch - I'm fine with yours, wanted to do the similar thing
because it has dazzled me while I was debugging around.
>
> And this patch is fixed from kexec.
>
> If crash_map_reserved_pages fails to map reserved memory, is it
> necessary to continue the process on s390? If no, it is better to enter
> the error handle path, then return. Thus there is no need to pass the
> parameter to indicate the error or not.
>
>> @@ -147,39 +147,34 @@ static int kdump_csum_valid(struct kimage *image)
>>   }
>>   
>>   /*
>> - * Map or unmap crashkernel memory
>> + * Map crashkernel memory
>>    */
>> -static void crash_map_pages(int enable)
>> +void crash_map_reserved_pages(void)
>>   {
>>   	unsigned long size = resource_size(&crashk_res);
>>   
>>   	BUG_ON(crashk_res.start % KEXEC_CRASH_MEM_ALIGN ||
>>   	       size % KEXEC_CRASH_MEM_ALIGN);
>> -	if (enable)
>> -		vmem_add_mapping(crashk_res.start, size);
>> -	else {
>> -		vmem_remove_mapping(crashk_res.start, size);
>> -		if (size)
>> -			os_info_crashkernel_add(crashk_res.start, size);
>> -		else
>> -			os_info_crashkernel_add(0, 0);
>> -	}
>> -}
>> -
>> -/*
>> - * Map crashkernel memory
>> - */
>> -void crash_map_reserved_pages(void)
>> -{
>> -	crash_map_pages(1);
>> +	vmem_add_mapping(crashk_res.start, size);
>>   }
> It is fine to cleanup this function. And add the logic into function
> crash_unmap_reserved_pages.
>
>>   
>>   /*
>>    * Unmap crashkernel memory
>>    */
>> -void crash_unmap_reserved_pages(void)
>> +void crash_unmap_reserved_pages(int error)
>>   {
>> -	crash_map_pages(0);
>> +	unsigned long size = resource_size(&crashk_res);
>> +
>> +	BUG_ON(crashk_res.start % KEXEC_CRASH_MEM_ALIGN ||
>> +	       size % KEXEC_CRASH_MEM_ALIGN);
>> +	vmem_remove_mapping(crashk_res.start, size);
>> +
>> +	if (error)
>> +		return;
>> +	if (size)
>> +		os_info_crashkernel_add(crashk_res.start, size);
>> +	else
>> +		os_info_crashkernel_add(0, 0);
>>   }
>>   
>>   /*
> Thanks
> Minfei


-- 
Regards,
Dmitry Safonov
