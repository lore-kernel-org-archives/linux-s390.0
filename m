Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B00216397
	for <linux-s390@vger.kernel.org>; Fri, 20 Dec 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709988; cv=none; b=UWRcE8TGxRq5+TPN8aopoKi4i9H1LefJMecOocAP/8fLgTD+upgystcSrGHaDE1tXefP8pHC9HTDS82P/JP+sxiFQgPtOYRNzpGWRMBsFIhxZzHZRr8xMRzKYUHhb+pUp+ebFAe/XYEj9PlDJwAff25kLVcfOSJnQKLdiMadOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709988; c=relaxed/simple;
	bh=GxEXT+egv7ylGSdwnGzr8SHPU6Pl/TO62zHedVCmYHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGxffoBBO4q4jH7PUMk9Kd0v/CwJzq7NMWXRukIKTapdlB/BIO4sgW9Sc/TIFBbdjai+/ixcPzCbYLO8H81UnnvcGjXKU0a4xwjZz6E1MtVBp2yLzgDk0c0i54kl8P0XKe6aq6j7Dr5D97T20iOpEgnN0jGpaWDoZ3pby/F1oe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuB9s3kP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuB9s3kP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734709985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C4SvBSjYjdr4t3hMBkSnVIu1NnuP93x/++9ZoXt14ag=;
	b=AuB9s3kPgcbX7kDC1wYlV3nRHCYD6gQTa97Tp6ZRs5ZcA1M32uWtOceKtvLlEkBD0s+PhS
	mfvVBBbqekAetkjfB27xhrSOdwdzChr2suX8KfhkR7bEnZyI0ctZVJXsdNGoStSC1J5UZ+
	FXkhh47zTZwBCKb8nlNHbxxXEnXbA0s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-zY8UK2p3OZWRtrG1VPlYXQ-1; Fri, 20 Dec 2024 10:53:04 -0500
X-MC-Unique: zY8UK2p3OZWRtrG1VPlYXQ-1
X-Mimecast-MFC-AGG-ID: zY8UK2p3OZWRtrG1VPlYXQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361b090d23so12397225e9.0
        for <linux-s390@vger.kernel.org>; Fri, 20 Dec 2024 07:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709983; x=1735314783;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C4SvBSjYjdr4t3hMBkSnVIu1NnuP93x/++9ZoXt14ag=;
        b=ORwQ4tsdsFcVrY1jWFtCrrCeetvgTOZJ9BWDZly9tXHpan0cF3zoPQWShHRdhEAYbC
         4Rf/i9SJ9f3uXlIT9tkx5wzSwRgFskr5zAA+tcgfYifsHmMMXF6G0GmLQLda5tMdD1wo
         jioEgCNnSomgLhzB2JZ1p+duDcr8KfR75xJjqeL7hovNGF7rNPvW0SiKVj3VelAK4SP+
         Imen6BR8t39sn//2TuJv4P+uT/qVHPIAJXfoO5q4/ZeWqh2IOpInHR8DvG9hGbsO+n+T
         ymdfMYSDbz4oZSVzOQZvlvzQsnaWVnNV9niVnhDYXGR/4fY+c/RPLO/2qzOIwBn0q55m
         4tuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeVwN/KLOkHfI6xFM8iNzd225NO3W7FueSDr2xMk+aH4gfKBFXoHCoIWvxVLZm7q+gz6f9wb275rLy@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvav1zUkC9/kowLF5SAZVAuH+pckJJYQc/eLBcS2lH/Kp7j0FD
	0xX/3H6kSVc8RarUMMhjjg8jtEPrU2btPJnbtBSL0zDHb4iuurDMpjF5xmwhU1QZb1+ilI0LBC3
	9m270jCD3unUOsOs+gzuOm5v0zWyASnB/BjGMH9uqZ4nvjGXEcGvuY5J9Hpk=
X-Gm-Gg: ASbGnctRXBRHpokdw6NJP3KcHpygRghlkp79i8g1lqa8HzEM3s3w+3i0VeiyNhQKzyX
	6cSLAjEp3Jru4Z/awPWR9f/94brDWGWJSa3waumbo+pFOKevVOX6zjydgoh9m8ltx+Z3jR+xsuY
	cd7u7MmWO3Q+j8J0G3FJETqdPm78gd7Noud+Z0t2wVvAxB9w/FawUJZvmkevvK3ZR9n6R+BHeOn
	gfMqtdKouB+2u7Hum16EgYLeAJ4V1aXTlyVCs2gmYouVmx69cWsxiOjbxtrTTAMXgSLcejIl132
	EQ9160qBJ0wFO12oGYZGEqnI85PFX4yfCdoEBvPjz8ieHgg+2s+RSkw8sP1dtBHN+KnwoDT+qca
	fLnuDfHTB
X-Received: by 2002:a05:600c:1f85:b0:434:f2f4:4c07 with SMTP id 5b1f17b1804b1-436686464d9mr33943165e9.15.1734709983119;
        Fri, 20 Dec 2024 07:53:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzuls9H18mkhnHpgg/ea4i3mJoXhDJHsNfGWiRd+SnTl4kCUqXe2EhHgNQj54R1jkongmwzw==
X-Received: by 2002:a05:600c:1f85:b0:434:f2f4:4c07 with SMTP id 5b1f17b1804b1-436686464d9mr33942795e9.15.1734709982625;
        Fri, 20 Dec 2024 07:53:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3? (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de. [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436612008casm49134655e9.14.2024.12.20.07.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 07:53:02 -0800 (PST)
Message-ID: <1b9285ba-4118-4572-9392-42ec6ba6728c@redhat.com>
Date: Fri, 20 Dec 2024 16:53:01 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm/memory_hotplug: Add interface for runtime
 (de)configuration of memory
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20241202082732.3959803-1-sumanthk@linux.ibm.com>
 <20241202082732.3959803-2-sumanthk@linux.ibm.com>
 <3151b9a0-3e96-4820-b6af-9f9ec4996ee1@redhat.com>
 <Z08WpCxt4lsIsjcN@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z08WpCxt4lsIsjcN@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.12.24 15:33, Sumanth Korikkar wrote:
> On Mon, Dec 02, 2024 at 05:55:19PM +0100, David Hildenbrand wrote:
>> Hi!
>>
>> Not completely what I had in mind, especially not that we need something
>> that generic without any indication of ranges :)
>>
>> In general, the flow is as follows:
>>
>> 1) Driver detects memory and adds it
>> 2) Something auto-onlines that memory (e.g., udev rule)
>>
>> For dax/kmem, 1) can be controlled using devdax, and usually it also tries
>> to take care of 2).
>>
>> s390x standby storage really is the weird thing here, because it does 1) and
>> doesn't want 2). It shouldn't do 1) until a user wants to make use of
>> standby memory.
> 
> Hi David,

Hi,

sorry for the late reply. Cleaning up (some of) my inbox before 
Christmas, and I realized I skipped this mail.

> 
> The current rfc design doesnt do 1) until user initiates it.
> 
> The current rfc design considers the fact that there cannot be memory
> holes, when there is a availability of standby memory. (which holds true
> for both lpars and zvms)
> 
> With number of online and standby memory ranges count
> (max_configurable), prototype lsmem/chmem could determine memory ranges
> which are not yet configured
> i.e. (configurable_memory = max_configurable - online ranges from sysfs
> /sys/devices/system/memory/memory*).
> 
> Example prototype implementation of lsmem/chmem looks like:
> ./lsmem -o RANGE,SIZE,STATE,BLOCK,ALTMAP
> RANGE                                 SIZE        STATE  BLOCK ALTMAP
> 0x0000000000000000-0x00000002ffffffff  12G       online   0-95      0
> 0x0000000300000000-0x00000003ffffffff   4G deconfigured 96-127      -
> 
> # Configure range with altmap
> ./chmem -c 0x0000000300000000-0x00000003ffffffff -a
> ./lsmem -o RANGE,SIZE,STATE,BLOCK,ALTMAP
> RANGE                                 SIZE   STATE  BLOCK ALTMAP
> 0x0000000000000000-0x00000002ffffffff  12G  online   0-95      0
> 0x0000000300000000-0x00000003ffffffff   4G offline 96-127      1
> 
> 
> # Online range
> ./chmem -e 0x0000000300000000-0x00000003ffffffff &&
> ./lsmem -o RANGE,SIZE,STATE,BLOCK,ALTMAP
> RANGE                                 SIZE  STATE  BLOCK ALTMAP
> 0x0000000000000000-0x00000002ffffffff  12G online   0-95      0
> 0x0000000300000000-0x00000003ffffffff   4G online 96-127      1
> 
> Memory block size:       128M
> Total online memory:      16G
> Total offline memory:      0B
> Total deconfigured:        0B
> 
> # offline range
> ./chmem -d 0x0000000300000000-0x00000003ffffffff &&
> ./lsmem -o RANGE,SIZE,STATE,BLOCK,ALTMAP
> RANGE                                 SIZE   STATE  BLOCK ALTMAP
> 0x0000000000000000-0x00000002ffffffff  12G  online   0-95      0
> 0x0000000300000000-0x00000003ffffffff   4G offline 96-127      1
> 
> Memory block size:       128M
> Total online memory:      12G
> Total offline memory:      4G
> Total deconfigured:        0B
> 
> # Defconfigure range.
> ./chmem -g 0x0000000300000000-0x00000003ffffffff &&
> ./lsmem -o RANGE,SIZE,STATE,BLOCK,ALTMAP
> RANGE                                 SIZE        STATE  BLOCK ALTMAP
> 0x0000000000000000-0x00000002ffffffff  12G       online   0-95      0
> 0x0000000300000000-0x00000003ffffffff   4G deconfigured 96-127      -
> 
> Memory block size:       128M
> Total online memory:      12G
> Total offline memory:      0B
> Total deconfigured:        4G

Maybe "standby memory" might make it clearer. The concept is s390x 
specific, and it will likely stay s390x specific.

I like the idea (frontend/tool interface), all we need is a way for 
these commands to detect ranges and turn them from standby into usable 
memory.

> 
> The user can still determine the available memory ranges and make them
> configurable using tools like lsmem or chmem with this approach atleast
> on s390 with this approach.
> 
>> My thinking was that s390x would expose the standby memory ranges somewhere
>> arch specific in sysfs. From there, one could simply trigger the adding
>> (maybe specifying e.g, memmap_on_memory) of selected ranges.
> 
> As far as I understand, sysfs interface limits the size of the buffer
> used in show() to 4kb. 

sysfs want usually "one value per file".

> When there are huge number of standby memory
> ranges, wouldnt it be an issue to display everything in one attribute?

I was rather wondering about a syfs directory structure that exposes 
this information.

For example, in the granularity of storage increments we can enable/disable.

In general, it could be a similar structure as 
/sys/devices/system/memory/ (one director = one standby storage 
increment we can enable/disable?), but residing on the s390x specific 
sysfs area. Or any other way to express ranges that can be 
enabled/disabled as one unit.

I'm not sure if extending /sys/devices/system/memory/ itself would be a 
good idea, though. It all is very s390x specific.

> 
> Or use sysfs binary attributes to overcome the limitation?
> 
> Please correct me, If I am wrong.
> 
> Questions:
> 1. If we go ahead with this sysfs interface approach to list all standby
> memory ranges, could the list be made available via
> /sys/devices/system/memory/configurable_memlist?  This could be helpful,
> as /sys/devices/system/memory/configure_memory performs architecture
> independent checks and could also be useful for other architectures in
> the future.

See above, I think we want this s390x specific.

> 
> 2. Whether the new interface should also be compatible with lsmem/chmem?

Yes, likely we should allow them to query-configure this s390x specific 
thing.

> 
> 3. OR can we have a s390 specific path (eg:
> /sys/firmware/memory/standy_range) to list all standby memory range
> which are in deconfigured state and also use the current design
> (max_configurable) to make it easier for lsmem/chmem tool to detect
> these standby memory ranges?

Ah, there it is, yes!

> 
>> To disable standby memory, one would first offline the memory to then
>> trigger removal using the arch specific interface. It is very similar to
>> dax/kmem's way of handling offline+removal.
> 
> ok
> 
>> Now I wonder if dax/kmem could be (ab)used on s390x for standby storage.
>> Likely a simple sysfs interface could be easier to implement.
> 
> I havent checked dax/kmem in detail yet. I will look into it.

Probably it's not 100% what you want to achieve, just to give you an 
example how similar (but different) technologies have solved this problem.

-- 
Cheers,

David / dhildenb

