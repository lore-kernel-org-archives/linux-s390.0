Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94218A6A8
	for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982601; cv=none; b=tR+BPHQEJF8MkiK4DXle6keutVZ7haeEFkXbJmT56H4MJAqKhEomagzJbCcTy+xmMs2sf8Co9A4qhwELyQ8He71v6OU5wG2qsN87p6QX9O/Eg73LzOoHikClBLh9/fX3OmaOyizTkAq148dRz7BCrh9FdNnZNUKwDNRIJfhgnOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982601; c=relaxed/simple;
	bh=O42w5CTLhbMRclTCviYPTVvqTr9R+AzQm5hnoWoyrw0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pYKyvOfUnTEbXEsKHu+cToIdQ4GwjLuyVm1KYd3nG9+2K6RJ5VCKCQKtW35aJd3LkSCRpGkAbFuTdyobwYnDFMQT3Etoa7yjZ0wFzL+zqYVwT14gzDNtWqnMY+s6Wn0yfaFOf65hwU8xmyLFs2kvmQfrjqg5LlMP6jhHhEZYntM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJ9pXGy0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJ9pXGy0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728982599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2JTzqyMVBj94VglYxJ5U9erxgRtGYL/iWlOKct2eeCo=;
	b=SJ9pXGy0kammhX5xfaBzQXHxXET4aP3DY7KfuLs4qeb8SIkrN5VXuUmF+ojEz3wzI7orMV
	yCNKrcLxV5sNWn6tj9t/sIqqPQ3BuWJUfS8h0TcKjtKhnfsrL3ORtOUcjVcetgcvR6ESqf
	pr1szcj5tJnhis8L39Ue5VAV2QxTCeY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-U85708EOMhChL66KTzTPUQ-1; Tue, 15 Oct 2024 04:56:37 -0400
X-MC-Unique: U85708EOMhChL66KTzTPUQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d60f3e458so1782613f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2024 01:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728982596; x=1729587396;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2JTzqyMVBj94VglYxJ5U9erxgRtGYL/iWlOKct2eeCo=;
        b=n72ygzmNwTdcF9Kv59NfmKYOzb5UW72aZzD1lpxEwJfaoOJgPFNt0xhyPJMC8fqf44
         6ehanhUnwlrB1ESMyepsCpKBjsxz1Iq2LT/mN2L9gu+rLHBPlqTTlggI/7lVi5RSPMeB
         9bSwIjWGpWQYS4+akiU8nPbtCobHrJcZ4/DHEx7WTz85Oje8on6jeCHSa20cnGNM5YMk
         yaPGTl0mP/XbB4KzS6uiUVQQMUqflSx3eUdYqVtghUkN83t0dGUV/hNr19hAvm0/zY5j
         d8N8TLvQ0e1eK47xLxUW+RblWK/HE0G2pVftk6gEgKQJqV2XR7TG4i/w1n8P0WVWAdOT
         Xq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXp2Y4ak4rjrgyCpGLkP5f1iKi4FyPIwxd1VuA+umkOrPt5TiZ3YQuQm2jEBiUehZ3JiFC8vT98lnWh@vger.kernel.org
X-Gm-Message-State: AOJu0YwPo382SqrslA0hm4BCcmbz1ctpNdT2ZRHaYFc+2BVlASbr+sCd
	QwWAQBqMckkFphnk68w4hgMyGc8rqDJESdUUKd47K1WMT9IkxcoB/EEkonNN3vHJZ3kHBP9n77g
	kor7iV+X0Xnpk5WdwqqhyET0coo5mYZMMjJ03t5M9UEFGVXHyXnXhAdfxDYw=
X-Received: by 2002:a05:6000:18ad:b0:37d:2de3:bf8a with SMTP id ffacd0b85a97d-37d5ff8e86amr11867118f8f.26.1728982596584;
        Tue, 15 Oct 2024 01:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF962U15sbK8PU8Ne9hmX+D8SM5tX4rDWSW8Z7Xq3Jkp8kq7XgpWY4UJlJ8ZyjHK7dXO9k0w==
X-Received: by 2002:a05:6000:18ad:b0:37d:2de3:bf8a with SMTP id ffacd0b85a97d-37d5ff8e86amr11867083f8f.26.1728982596121;
        Tue, 15 Oct 2024 01:56:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c730:9700:d653:fb19:75e5:ab5c? (p200300cbc7309700d653fb1975e5ab5c.dip0.t-ipconnect.de. [2003:cb:c730:9700:d653:fb19:75e5:ab5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a1e0sm1024500f8f.9.2024.10.15.01.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 01:56:35 -0700 (PDT)
Message-ID: <f061c60c-91f6-4d6b-83dd-36c7d2f92062@redhat.com>
Date: Tue, 15 Oct 2024 10:56:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] s390/kdump: implement is_kdump_kernel()
From: David Hildenbrand <david@redhat.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Mario Casquero <mcasquer@redhat.com>
References: <20241014144622.876731-1-david@redhat.com>
 <20241014144622.876731-2-david@redhat.com>
 <20241014182054.10447-D-hca@linux.ibm.com>
 <f93b2c89-821a-4da1-8953-73ccd129a074@redhat.com>
 <20241015083040.7641-C-hca@linux.ibm.com>
 <0c7e876f-5648-4a82-b809-ca48f778b4a6@redhat.com>
 <9be496ff-9d94-4680-b095-863ec12e3261@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9be496ff-9d94-4680-b095-863ec12e3261@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.24 10:53, David Hildenbrand wrote:
> On 15.10.24 10:41, David Hildenbrand wrote:
>> On 15.10.24 10:30, Heiko Carstens wrote:
>>> On Mon, Oct 14, 2024 at 09:26:03PM +0200, David Hildenbrand wrote:
>>>> On 14.10.24 20:20, Heiko Carstens wrote:
>>>>> Looks like this could work. But the comment in smp.c above
>>>>> dump_available() needs to be updated.
>>>>
>>>> A right, I remember that there was some outdated documentation.
>>>>
>>>>>
>>>>> Are you willing to do that, or should I provide an addon patch?
>>>>>
>>>>
>>>> I can squash the following:
>>>>
>>>> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
>>>> index 4df56fdb2488..a4f538876462 100644
>>>> --- a/arch/s390/kernel/smp.c
>>>> +++ b/arch/s390/kernel/smp.c
>>>> @@ -587,16 +587,16 @@ int smp_store_status(int cpu)
>>>>      *    with sigp stop-and-store-status. The firmware or the boot-loader
>>>>      *    stored the registers of the boot CPU in the absolute lowcore in the
>>>>      *    memory of the old system.
>>>> - * 3) kdump and the old kernel did not store the CPU state,
>>>> - *    or stand-alone kdump for DASD
>>>> - *    condition: OLDMEM_BASE != NULL && !is_kdump_kernel()
>>>> + * 3) kdump or stand-alone kdump for DASD
>>>> + *    condition: OLDMEM_BASE != NULL && !is_ipl_type_dump() == false
>>>>      *    The state for all CPUs except the boot CPU needs to be collected
>>>>      *    with sigp stop-and-store-status. The kexec code or the boot-loader
>>>>      *    stored the registers of the boot CPU in the memory of the old system.
>>>> - * 4) kdump and the old kernel stored the CPU state
>>>> - *    condition: OLDMEM_BASE != NULL && is_kdump_kernel()
>>>> - *    This case does not exist for s390 anymore, setup_arch explicitly
>>>> - *    deactivates the elfcorehdr= kernel parameter
>>>> + *
>>>> + * Note that the old Kdump mode where the old kernel stored the CPU state
>>>
>>> To be consistent with the rest of the comment, please write kdump in
>>> all lower case characters, please.
>>
>> It obviously was too late in the evening for me :) Thanks!
>>
>>>
>>>> + * does no longer exist: setup_arch explicitly deactivates the elfcorehdr=
>>>> + * kernel parameter. The is_kudmp_kernel() implementation on s390 is independent
>>>
>>> Typo: kudmp.
>>>
>>>> Does that sound reasonable? I'm not so sure about the "2) stand-alone kdump for
>>>> SCSI/NVMe (zfcp/nvme dump with swapped memory)": is that really "kdump" ?
>>>
>>> Yes, it is some sort of kdump, even though a bit odd.
>>
>> My concern is that we'll now have
>>
>> bool is_kdump_kernel(void)
>> {
>>           return oldmem_data.start && !is_ipl_type_dump();
>> }
>>
>> Which matches 3), but if 2) is also called "kdump", then should it
>> actually be
>>
>> bool is_kdump_kernel(void)
>> {
>>           return oldmem_data.start;
>> }
>>
>> ?
>>
>> When I wrote that code I was rather convinced that the variant in this
>> patch is the right thing to do.
>>
> 
> I think we can do some follow up cleanups, assuming is_kdump_kernel() here is correct:
> 
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index cca1827d3d2e..fbc5de66d03b 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -609,7 +609,7 @@ int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size)
>           u64 hdr_off;
>    
>           /* If we are not in kdump or zfcp/nvme dump mode return */
> -       if (!oldmem_data.start && !is_ipl_type_dump())
> +       if (!dump_available())
>                   return 0;
>           /* If we cannot get HSA size for zfcp/nvme dump return error */
>           if (is_ipl_type_dump() && !sclp.hsa_size)
> diff --git a/arch/s390/kernel/os_info.c b/arch/s390/kernel/os_info.c
> index b695f980bbde..09578f400ef7 100644
> --- a/arch/s390/kernel/os_info.c
> +++ b/arch/s390/kernel/os_info.c
> @@ -148,7 +148,7 @@ static void os_info_old_init(void)
>    
>           if (os_info_init)
>                   return;
> -       if (!oldmem_data.start && !is_ipl_type_dump())
> +       if (!dump_available())
>                   goto fail;
>           if (copy_oldmem_kernel(&addr, __LC_OS_INFO, sizeof(addr)))
>                   goto fail;
> diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
> index 33cebb91b933..6a194b4f6ba5 100644
> --- a/drivers/s390/char/zcore.c
> +++ b/drivers/s390/char/zcore.c
> @@ -300,9 +300,7 @@ static int __init zcore_init(void)
>           unsigned char arch;
>           int rc;
>    
> -       if (!is_ipl_type_dump())
> -               return -ENODATA;
> -       if (oldmem_data.start)
> +       if (is_kdump_kernel())
>                   return -ENODATA;
>    
>           zcore_dbf = debug_register("zcore", 4, 1, 4 * sizeof(long));
> 
> 

Ugh, ignore the last one, I'm just confused about dumping options on 
s390x at this point :)

-- 
Cheers,

David / dhildenb

