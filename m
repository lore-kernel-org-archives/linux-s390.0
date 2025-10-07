Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34561FDE09
	for <linux-s390@vger.kernel.org>; Tue,  7 Oct 2025 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853483; cv=none; b=J0eNfl+uzmUk2x1wTG09TpUa30KyCgwNfJiO1Y39SdphwviMSEks5vu17xYqxh0ww8bhRjIBUMk/FpnJ8C37NClgxR0JtVGj6iPGXhD7yhCstjDxHTSUr9vACVyVpek2iR0dMsSVV1Y/wEvUkBBQnieakK43oWsNAI4DFiSZ76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853483; c=relaxed/simple;
	bh=AiOrPIJwttq3xRREeRU1YWy7Kn6StknJmn8+55UXyVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrheJTeGOeHpD8fbmknde1oEROljzl3tuevDbJA3rzDK6MP3eS3KCQgU1mCNZ07jm4V+MJAmCN6aTTBki4cRgJxy5EaeKbGLB2J1Wti6iCC/+78FQMNM7NBhZGeg9xypK0KXx7z2/k/LqV8ps140kTU+g2EzFXSy2s82jhKkXBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BC7WI6mo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BC7WI6mo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759853480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l1TG7fNWBYED87Irl/Zr2hY86eg+AQbf2b3fSmJLhsM=;
	b=BC7WI6mou2OSCHBztVg8FRr0/omkEnNPvN80u+8lm3Y0hHPKvWq/ukfC3YmoZBnh/utUyQ
	Z0SmvjfCxFGUEpbkVZ8n6xmo+AEWm5tBQZL5DzO3raeqAb2LASAPslM8nYEGCu94LRdhrT
	cbpAjaz1GhuXP1V6RV2Nk5pF2kH4IqQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-EAl74U5YOdeh4ZRQ_OyBJQ-1; Tue, 07 Oct 2025 12:11:19 -0400
X-MC-Unique: EAl74U5YOdeh4ZRQ_OyBJQ-1
X-Mimecast-MFC-AGG-ID: EAl74U5YOdeh4ZRQ_OyBJQ_1759853478
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e36686ca1so62708035e9.2
        for <linux-s390@vger.kernel.org>; Tue, 07 Oct 2025 09:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853478; x=1760458278;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1TG7fNWBYED87Irl/Zr2hY86eg+AQbf2b3fSmJLhsM=;
        b=CChUklCwJ36jqxImWSQcuX9wS3a1zrUtodyFAP4AskGPdmLfaosYEnesVIgvpViqLG
         ZhzQUb1L3kuE8BV90aJ9ri34eDWlNeuZ0qe6PYkw0riiCxEy1mSdPqIukF162aULIw/4
         VD7nkgjko1gZYWXBrz7AXbhPPSAGVO8Uu1sDT5+m+pPeI7bS0C9yMVaRj7QUcN6tYikR
         UY4jCK9Cfd+XrjBy0q98tlopwgj5r3/E9Ep8j2NE67cI2z+S2Ta2gMOaXVaqaZyDwtNM
         t3UU4cWIZJk1kH5NyFIyjkx6cu8Dk86uogCaROXDc7t73k+OYBLLi3TPVRf/F0J+abQw
         u1mA==
X-Forwarded-Encrypted: i=1; AJvYcCVLiqQrkKBluNay8dePUbKyBS3TjUOSNAugumxNoRu26PQMswWltq7GyezFwJotyHUz4eMwFqcJqfLn@vger.kernel.org
X-Gm-Message-State: AOJu0YxEQW/viB1Inh/y1bdWNe1U9cK7WdvM37QCu8PG4YR3ar3TYKdR
	TacIGesfAteDAoQLcGXQqPJGZIlVTxFv6P+PPemKCm4IwzOUrpwSuaAvAJOGteK09ltVKsPU0J7
	jv4uwgomEwRnQSlxVxEF4Rd6hwrIaB1Ek3fRpbia/IfAxBq/Qm59Pcppxyb4XgCQ=
X-Gm-Gg: ASbGncvfX3OvZwyAZRD5C0kDxWZ5GQbI6D1py1QUNI3tntrwd8K28+2uF7oJqoq0Pg/
	UwVIyCq3RD3gfLa6ktX6DQ65pjDYJxwTkSti1u0zZkC5fwrqyXqU/xYlnkoZQn7WXsGfS0/0OXe
	zAQbbjNCFA9JhunNU3KqahL0MLileaxDzi6Lr36Qslx1smy3EXZusKYRB2aNlxYSqhEC28Q+NSu
	NppWxYkc3ItzQAcqsqHwL5DrV0qqGIsJjtHUjFBNBQ2fP5o9mT+MnT3EsH0Bz8dFP7DCLm/L95q
	IQ2fOUHh+gaoT9hm0ab3Ovu7hGe/vOySl2zJuRLcI9dFk8P3OGATQmMinN41CCS80FHIsPttO+l
	GhEpJicqB
X-Received: by 2002:a05:600c:468e:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-46fa9b092femr1336575e9.31.1759853478058;
        Tue, 07 Oct 2025 09:11:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7kxIG94axeHuIA4cL4kYLnzrOyY3qxXsr5H8R4EofA01FREwYYzGLEMnYegBwXYAIBqinkA==
X-Received: by 2002:a05:600c:468e:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-46fa9b092femr1336305e9.31.1759853477513;
        Tue, 07 Oct 2025 09:11:17 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8acc4csm25683339f8f.16.2025.10.07.09.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 09:11:17 -0700 (PDT)
Message-ID: <ab366c03-8c78-449d-bfc4-2d155212d9d7@redhat.com>
Date: Tue, 7 Oct 2025 18:11:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Support dynamic (de)configuration of memory
To: Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.09.25 15:15, Sumanth Korikkar wrote:
> Hi,

Hi,

> 
> Patchset provides a new interface for dynamic configuration and
> deconfiguration of hotplug memory on s390, allowing with/without
> memmap_on_memory support. It is a follow up on the discussion with David
> when introducing memmap_on_memory support for s390 and support dynamic
> (de)configuration of memory:
> https://lore.kernel.org/all/ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com/
> https://lore.kernel.org/all/20241202082732.3959803-1-sumanthk@linux.ibm.com/
> 
> The original motivation for introducing memmap_on_memory on s390 was to
> avoid using online memory to store struct pages metadata, particularly
> for standby memory blocks. This became critical in cases where there was
> an imbalance between standby and online memory, potentially leading to
> boot failures due to insufficient memory for metadata allocation.
> 
> To address this, memmap_on_memory was utilized on s390. However, in its
> current form, it adds struct pages metadata at the start of each memory
> block at the time of addition (only standby memory), and this
> configuration is static. It cannot be changed at runtime  (When the user
> needs continuous physical memory).
> 
> Inorder to provide more flexibility to the user and overcome the above
> limitation, add an option to dynamically configure and deconfigure
> hotpluggable memory block with/without memmap_on_memory.

This will cleanly add/remove the memory, including the directmap and 
other tracking data, so I like it.

> 
> With the new interface, s390 will not add all possible hotplug memory in
> advance, like before, to make it visible in sysfs for online/offline
> actions. Instead, before memory block can be set online, it has to be
> configured via a new interface in /sys/firmware/memory/memoryX/config,
> which makes s390 similar to others.  i.e. Adding of hotpluggable memory is
> controlled by the user instead of adding it at boottime.

Before I dig into the details, will onlining/offling still trigger 
hypervisor action, or does that now really happen when memory is 
added/removed?

That would be really nice, because it would remove the whole need for 
"standby" memory, and having to treat hotplugged memory differently 
under LPAR/z/VM than anywhere else (-> keep it offline).

> 
> s390 kernel sysfs interface to configure/deconfigure memory with
> memmap_on_memory (with upcoming lsmem changes):
>      
> * Initial memory layout:
> lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
> RANGE                 SIZE   STATE BLOCK CONFIGURED MEMMAP_ON_MEMORY
> 0x00000000-0x7fffffff   2G  online 0-15  yes        no
> 0x80000000-0xffffffff   2G offline 16-31 no         yes

Could we instead modify "STATE" to reflect that it is "not added" / "not 
configured" / "disabled" etc?

Like

lsmem -o RANGE,SIZE,STATE,BLOCK,MEMMAP_ON_MEMORY
RANGE                 SIZE    STATE BLOCK
0x00000000-0x7fffffff   2G   online 0-15
0x80000000-0xffffffff   2G disabled 16-31

Or is that an attempt to maintain backwards compatibility?

> 
> * Configure memory
> echo 1 > /sys/firmware/memory/memory16/config

The granularity here is also memory_block_size_bytes(), correct?

> lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
> RANGE                  SIZE  STATE   BLOCK CONFIGURED MEMMAP_ON_MEMORY
> 0x00000000-0x7fffffff    2G  online  0-15  yes        no
> 0x80000000-0x87ffffff  128M offline    16  yes        yes
> 0x88000000-0xffffffff  1.9G offline 17-31  no         yes
> 
> * Deconfigure memory
> echo 0 > /sys/firmware/memory/memory16/config
> lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
> RANGE                 SIZE   STATE BLOCK CONFIGURED MEMMAP_ON_MEMORY
> 0x00000000-0x7fffffff   2G  online 0-15  yes        no
> 0x80000000-0xffffffff   2G offline 16-31 no         yes
> 
> * Enable memmap_on_memory and online it.
> (Deconfigure first)
> echo 0 > /sys/devices/system/memory/memory5/online
> echo 0 > /sys/firmware/memory/memory5/config
> 
> lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
> RANGE                  SIZE  STATE  BLOCK CONFIGURED MEMMAP_ON_MEMORY
> 0x00000000-0x27ffffff  640M  online 0-4   yes        no
> 0x28000000-0x2fffffff  128M offline 5     no         no
> 0x30000000-0x7fffffff  1.3G  online 6-15  yes        no
> 0x80000000-0xffffffff    2G offline 16-31 no         yes
> 
> (Enable memmap_on_memory and online it)
> echo 1 > /sys/firmware/memory/memory5/memmap_on_memory
> echo 1 > /sys/firmware/memory/memory5/config
> echo 1 > /sys/devices/system/memory/memory5/online

I guess the use for memmap_on_memory would now be limited to making 
hotplug more likely to succeed in OOM scenarios.

> 
> lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
> RANGE                  SIZE  STATE   BLOCK CONFIGURED MEMMAP_ON_MEMORY
> 0x00000000-0x27ffffff  640M  online  0-4   yes        no
> 0x28000000-0x2fffffff  128M  online  5     yes        yes
> 0x30000000-0x7fffffff  1.3G  online  6-15  yes        no
> 0x80000000-0xffffffff    2G  offline 16-31 no         yes
> 
> * Disable memmap_on_memory and online it.
> (Deconfigure first)
> echo 0 > /sys/devices/system/memory/memory5/online
> echo 0 > /sys/firmware/memory/memory5/config
> 
> lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
> RANGE                  SIZE  STATE  BLOCK CONFIGURED MEMMAP_ON_MEMORY
> 0x00000000-0x27ffffff  640M  online 0-4   yes        no
> 0x28000000-0x2fffffff  128M offline 5     no         yes
> 0x30000000-0x7fffffff  1.3G  online 6-15  yes        no
> 0x80000000-0xffffffff    2G offline 16-31 no         yes
> 
> (Disable memmap_on_memory and online it)
> echo 0 > /sys/firmware/memory/memory5/memmap_on_memory
> echo 1 > /sys/firmware/memory/memory5/config
> echo 1 > /sys/devices/system/memory/memory5/online
> 
> lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
> RANGE                  SIZE  STATE   BLOCK CONFIGURED MEMMAP_ON_MEMORY
> 0x00000000-0x7fffffff  2G    online  0-15  yes        no
> 0x80000000-0xffffffff  2G    offline 16-31 no         yes
> 
> * Userspace changes:
> lsmem/chmem tool is also changed to use the new interface. I will send
> it to util-linux soon.
> 
> Patch 1 adds support for removal of boot-allocated memory blocks.
> 
> Patch 2 provides option to dynamically configure and deconfigure memory
> with/without memmap_on_memory.
> 
> Patch 3 removes MHP_OFFLINE_INACCESSIBLE from s390. The mhp flag was
> used to mark memory as not accessible until memory hotplug online phase
> begins.  However, with patch 2, it is no longer essential. Memory can be
> brought to accessible state before adding memory, as the memory is added
> during runttime now instead of boottime.

Nice.

> 
> Patch 4 removes the MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers. It
> is no longer needed.  Memory can be brought to accessible state before
> adding memory now, with runtime (de)configuration of memory.

Nice.


-- 
Cheers

David / dhildenb

