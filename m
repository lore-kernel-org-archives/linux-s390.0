From: David Hildenbrand <david@redhat.com>
Date: Thu, 06 Dec 2018 09:16:21 +0000
Subject: Re: [kvm-unit-tests PATCH v2 5/6] s390x: Use interrupts in SCLP
Message-Id: <4cdcf1d7-71a9-eded-8e92-eb5a371f3add@redhat.com>
In-Reply-To: <d3886e82-6ce5-7df3-610a-593282cd74f8@linux.ibm.com>
References: <d3886e82-6ce5-7df3-610a-593282cd74f8@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


> 
>>
>>> +
>>>  void sclp_memory_setup(void)
>>>  {
>>>  	ReadInfo *ri = (void *)_sccb;
>>> @@ -37,7 +76,10 @@ void sclp_memory_setup(void)
>>>  	int cc;
>>>  
>>>  	ri->h.length = SCCB_SIZE;
>>> +	sclp_busy = true;
>>>  	sclp_service_call(SCLP_CMDW_READ_SCP_INFO_FORCED, ri);
>>> +	while (sclp_busy)
>>> +		/* Wait for SCLP request to complete */;
>>
>> Should we factor that out into something like
> 
> As written above, I'm all for the second one, but I dislike the start
> one liner.
> 

Sure, fine with me!


-- 

Thanks,

David / dhildenb
