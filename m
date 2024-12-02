Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188D163A97
	for <linux-s390@vger.kernel.org>; Mon,  2 Dec 2024 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158527; cv=none; b=PQ7zkJ6o38VJnx91s8+6jT/qQ20VHFrFEsEOhI9EHMxe45tTqxHMe5BP/QJxZD41Ahe29T/gkMtOxAkR12bOZSOUuExqJeiGtr+ojquxV0aOIrebfmC0B2O4+a9dj8woRMItdD68EYvahpbXFFXOFpr7/HinbZqDMrxNDnxCjjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158527; c=relaxed/simple;
	bh=HmNQcl2Sxo3wxFpfuZGiRayplpR6Di2q8KOODc0dlBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dt9AI8w3KQN7EZAblOp/LeFI0CTbR787mq0e23EVCqa4nFZbfJVi0q7bjq1vOFdSA5qox/+3c5k7TIfCgi/84q5AHetNrNC4VufdnJFj3f0ywG/Gua4cbJoFvm3CC8wYw0/9LoYVhptJYLLDJI19SGm7Oc7eUvrfWONTRQ+8/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RM4M4WMT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RM4M4WMT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733158524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZkmfYGZLWiuDUUCqQg2H7+C1NBiXVbzJFa81KDJM/oo=;
	b=RM4M4WMT/wpKwOQmFo7UPk/MkpmLudzqa/pptnY4gP7+QHA3EDAZkwXmVWpbkVece+yvZS
	JkF+eZUE5Xa8+w/KJH5SCK+pE097Xx2PVrtblYkMbZi7/yzgKlFglImLy0srEMYdGEi93V
	WAoiTFCO+VWKeKJ8pV8vI4Z0GH9DNgA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-OebUvbOrPKKzr_daBDVWnA-1; Mon, 02 Dec 2024 11:55:23 -0500
X-MC-Unique: OebUvbOrPKKzr_daBDVWnA-1
X-Mimecast-MFC-AGG-ID: OebUvbOrPKKzr_daBDVWnA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43498af79a6so25338695e9.0
        for <linux-s390@vger.kernel.org>; Mon, 02 Dec 2024 08:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733158522; x=1733763322;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZkmfYGZLWiuDUUCqQg2H7+C1NBiXVbzJFa81KDJM/oo=;
        b=Ml2Di4eZGzbRtMPz7AR96JL3E6GMsV9eTqp5quKc9zYTy51yAgNJxhOIzkiQ/EX/yB
         hPE7oqe/K0lG3Q/Vebi905TWZXIwqy3AT+usqoGLoaep7Ks0TCQmv/82k0cg6WjVXomG
         amyo/chsODtM/S8cya3g8ol/iovYMDOu/IyXLmjEntuTIeh2FOTiQqbqstpM4ZD38c0Q
         m+YOtjkuaPNXrD6mSaoMoBdAB5hS29N4bJGOe2o9r6dEPgnxEPki6JG03oH1gYC6200p
         QSzvl497eNXvoy5gJ3VBK9znVvE6EFxyj8B+0my98koWN11p1w1Z/mC8Z4qtBHQLWEq9
         W1lw==
X-Forwarded-Encrypted: i=1; AJvYcCWfrvA9ikVqyQwKy/7qYGrkCVCt2COxQTiO9zH7Rb+t15oqk9LiMfVh0n/KLT79kWszqBeERsEnyWSF@vger.kernel.org
X-Gm-Message-State: AOJu0YzuD2iBeF95HKq5zURctvNYIX6TRCA0XQJOdrZ1+JH4qwVvI/ie
	mJQDEj3D9uo/IvWF+P+8Ptmy+Ypr8T/OlX1M0+yXAnxUli2oCjdm8Hgj1mjRsf7MJoMTwY6NAZo
	visEvOW91epjUEGsMP8N70zFoatpb3fCx5KlTXNjAHx+8EQdDUt7K0QRoeSI=
X-Gm-Gg: ASbGncvDVPFWUftUgrG0jgGlsEglPho3foKJ9yNXf60JEUyq2woXKawV2+UjxjqK4Bu
	ebwK3vitte/sHHo6Po4ex3ec/1c13QrCxVMWIaXKs0DDBymjApQ9DRx2O53ThS+Bf5BpOvPt6Pt
	VcABo5Kqy49iQhbxHMzr5JPutTHPEwc91Q2ppaemYSfV45IFuABBg2HGTfxbnB5j4pWP1sFm1Qn
	/uZrW9uIBtHWJcVwcyKXaXZ4h8zfKDtPJKuuowCzjXHnhHn9M+MfiEuqY2L/BWntXhtJce3FRbB
	FDK98neA1QIlOBLBFCOyjZIHlle4Yc5hQ4HUo3f0a73siFuJRV/Zmsr39Rl2KfzdYhURph7N4JY
	5gQ==
X-Received: by 2002:a05:600c:3108:b0:431:559d:4103 with SMTP id 5b1f17b1804b1-434afbaf2c6mr167966605e9.7.1733158521868;
        Mon, 02 Dec 2024 08:55:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnqxWFD31buGEosC5pAcQXzuQR7HqwK3YBfiLJK8GWATp5GYDxoynDv8O7xwFg3WQch2oobg==
X-Received: by 2002:a05:600c:3108:b0:431:559d:4103 with SMTP id 5b1f17b1804b1-434afbaf2c6mr167966455e9.7.1733158521493;
        Mon, 02 Dec 2024 08:55:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:ba00:bcff:e7c1:84bd:9486? (p200300cbc73bba00bcffe7c184bd9486.dip0.t-ipconnect.de. [2003:cb:c73b:ba00:bcff:e7c1:84bd:9486])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f7dccasm157467945e9.43.2024.12.02.08.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 08:55:20 -0800 (PST)
Message-ID: <3151b9a0-3e96-4820-b6af-9f9ec4996ee1@redhat.com>
Date: Mon, 2 Dec 2024 17:55:19 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm/memory_hotplug: Add interface for runtime
 (de)configuration of memory
To: Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-mm <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20241202082732.3959803-1-sumanthk@linux.ibm.com>
 <20241202082732.3959803-2-sumanthk@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <20241202082732.3959803-2-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.12.24 09:27, Sumanth Korikkar wrote:
> Provide a new interface for dynamic configuration and deconfiguration of
> hotplug memory, allowing for mixed altmap and non-altmap support.  It is
> a follow-up on the discussion with David:
> 
> https://lore.kernel.org/all/ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com/
> 
> As mentioned in the discussion, advantages of the new interface are:
> 
> * Users can dynamically specify which memory ranges should have altmap
>    support, rather than having it statically enabled or disabled for all
>    hot-plugged memory.
> 
> * In the long term,  user could specify a memory range, including
>    multiple blocks, and whether user wants altmap support for that range.
>    This could allow for the altmap block grouping, or even variable-sized
>    blocks, in the future. i.e. "grouping" memory blocks that share a same
>    altmap located on the first memory blocks in the group and reduce
>    fragementation due to altmap.
> 
> To leverage these advantages:
> Create a sysfs interface /sys/bus/memory/devices/configure_memory, which
> performs runtime (de)configuration of memory with altmap or non-altmap
> support. The interface validates the memory ranges against architecture
> specific memory configuration and performs add_memory()/remove_memory().
> Dynamic (de)configuration of memory is made configurable via config
> CONFIG_RUNTIME_MEMORY_CONFIGURATION.

Hi!

Not completely what I had in mind, especially not that we need something 
that generic without any indication of ranges :)

In general, the flow is as follows:

1) Driver detects memory and adds it
2) Something auto-onlines that memory (e.g., udev rule)

For dax/kmem, 1) can be controlled using devdax, and usually it also 
tries to take care of 2).

s390x standby storage really is the weird thing here, because it does 1) 
and doesn't want 2). It shouldn't do 1) until a user wants to make use 
of standby memory.


My thinking was that s390x would expose the standby memory ranges 
somewhere arch specific in sysfs. From there, one could simply trigger 
the adding (maybe specifying e.g, memmap_on_memory) of selected ranges.


To disable standby memory, one would first offline the memory to then 
trigger removal using the arch specific interface. It is very similar to 
dax/kmem's way of handling offline+removal.

Now I wonder if dax/kmem could be (ab)used on s390x for standby storage. 
Likely a simple sysfs interface could be easier to implement.

-- 
Cheers,

David / dhildenb

