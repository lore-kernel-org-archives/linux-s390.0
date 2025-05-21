Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7E625D8FC
	for <linux-s390@vger.kernel.org>; Wed, 21 May 2025 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830829; cv=none; b=Ysf2URxIkmH2TH7wBllVfpykuNbBy+gTgUFwAuG5kmwm2BxvCMCTYyCIsuvdntfpXZFfE6MmYn2IsIrUpaDq0OdKGann+F/U0Uw0Z8bfcbeNwrAYIys8U7VN91QX7FYqKEwUvjEtpuzYfFwFuFKrCNYWhLY/9mw1IoToDm/cP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830829; c=relaxed/simple;
	bh=/J31I1VeOqilhP57gGkdulMAKp2jqhIrFoKsD2DHzJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgNEvk9bSQd4fdRzrpewahZNj5GF7mXrPoKT8nlWvPuWBj7ufapS2FTpjy1Gfcy0mijqzUg6vN3DHBeTEPZP+MRZQs1oVvTJLADLQZlgnmrA5mjB5/wDXTckIZcLhPUV6rZK/qcOgQ8YclpYa+GEfn6MAs+Z8HjacEV7A/dwywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBQG80xl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBQG80xl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747830826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wsM7de2ozG2CBcHx9WKMJOITJyMGGHvzj51fSnRL1g0=;
	b=OBQG80xlfsGLXOkWobnHTQjXfkyyA+uOWEvANU30Md/Vhftls9711Kx4UD5rJlU7xXbnl0
	9N6VhXJX+LqKAtjdW//P+iOkrR8PrOPkIJjYdJv+4HrD7yIPSNZPFGBUSb3kEUZHxoPpWg
	Mbc9M2JoiITajqbzIMyBYnjJBHh7aTU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-FlnSP2mgMauDquX3fTTyWQ-1; Wed, 21 May 2025 08:33:45 -0400
X-MC-Unique: FlnSP2mgMauDquX3fTTyWQ-1
X-Mimecast-MFC-AGG-ID: FlnSP2mgMauDquX3fTTyWQ_1747830824
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a370309dcbso1596309f8f.1
        for <linux-s390@vger.kernel.org>; Wed, 21 May 2025 05:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747830824; x=1748435624;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wsM7de2ozG2CBcHx9WKMJOITJyMGGHvzj51fSnRL1g0=;
        b=p3roscgsqnOiF2YVD6Hjnf16k73IHWfbTafAkFNP667iV0bZrWC+chVyYKu8tuWjNf
         8HpfE6eZrBgUasHosha9a+Q8Zw+Ai7/7NASAhxgegUdunxDN0lrTbrJNw4BTGBZVdA+k
         CaMB8lgt8UgAq4em8txNHktAlg5zgc5BQ0AR+GVbFEJnfI6RBIZTIvB2TvtOvIf02G8z
         49aEvwbMbC0VNZucJSk53grhsZ+JqFS+0F6t2xsJvwlA+xIz/afNytXtwIhtyoFQMaVO
         8gZoTsfD21JwzWvTdZvWvDUgfN/w8pwUymY22ohM1y+Kzn5FRHvh38pQyCTbFQWlM//g
         ZELg==
X-Forwarded-Encrypted: i=1; AJvYcCXCR5MpZ+vEZ+GS3ZrouEx3Ga10G9nbzCuzVOfNmFSL6djLuMkua1ypy/VAZag0yrGPWVqBS9c/5d3R@vger.kernel.org
X-Gm-Message-State: AOJu0YwKc59KNllsB0SrJNFRxgOG86/5aj+bLGN3tYbuESl01UrDj4ou
	ICJ6xIFjF83zhrToXpJq8lt5QhULqqgkUDVW9ukW/YhyormBmaPjAeacDLLU8eaJmWTYUd347IS
	m1uBEZNJbU08wiqm0oWF2PuXO/+jITUY4o0+uIwsHrA7fXM2btd/6r3NJL9nJ9CiFR4oZNiSLmA
	==
X-Gm-Gg: ASbGncuYIuQIA4fp4Fu+bNnt98Dy7NpY6PrVGsx0Qi4NARy8eTPwAUlciNQUDhiJm/8
	yAIBQqDzwx1XE3Ovw2aCACZ9gjh+iHD8wj4wZw7Mit6TxhZXjzIInk3C7YerXtNUVk3+1nimp2/
	/rllgrrIHzyZ52rTvQec/5sYJMBIFoq7XXKRhdwPwW7dwaypuR9Qi7MPcFTFqOXhTndgz7joGZ4
	lGa7nPDPee2+IdfTuc6uAJvbmOIorUs6o3qX7wmwEvVpO0pm1ZR+kUCBfcSLaQnAv3wdKqzPVON
	Ungd77tcUe2sUHytOADWOkn5EHTatRSxmfpFrYq8Zc5+MAU76c3boy7UxQ07KExUMkavTzAj5O9
	Z35xwCPgSopbDihllSwI2T1Z/3+TXtLNuSZwy8fs=
X-Received: by 2002:a05:6000:4024:b0:3a3:6afd:f2dd with SMTP id ffacd0b85a97d-3a36afdf4demr10724625f8f.50.1747830824374;
        Wed, 21 May 2025 05:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHobOgMbYJvIpX0FdYzYdcchaMuwD3lmfcK/SS6/lCg3ErfzBZ0Bd5TLuDKEUuzn0qvGxiFw==
X-Received: by 2002:a05:6000:4024:b0:3a3:6afd:f2dd with SMTP id ffacd0b85a97d-3a36afdf4demr10724586f8f.50.1747830823880;
        Wed, 21 May 2025 05:33:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:9c00:e2c7:6eb5:8a51:1c60? (p200300d82f259c00e2c76eb58a511c60.dip0.t-ipconnect.de. [2003:d8:2f25:9c00:e2c7:6eb5:8a51:1c60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a360b0b766sm19342415f8f.56.2025.05.21.05.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 05:33:43 -0700 (PDT)
Message-ID: <496e6707-bdc9-4ad2-88e2-51236549b5f2@redhat.com>
Date: Wed, 21 May 2025 14:33:42 +0200
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
 <1b9285ba-4118-4572-9392-42ec6ba6728c@redhat.com>
 <aCx-SJdHd-3Z12af@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <fca5fe72-55a8-456c-a179-56776848091d@redhat.com>
 <aC2sUdhavboOgS83@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aC2sUdhavboOgS83@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.05.25 12:34, Sumanth Korikkar wrote:
>>> Introduce new interface on s390 with the following attributes:
>>>
>>> 1) Attribute1:
>>> /sys/firmware/memory/block_size_bytes
>>
>> I assume this will be the storage increment size.
> 
> Hi David,
> 
> No, this is memory block size.

So, the same as /sys/devices/system/memory/block_size_bytes ?

In a future where we could have variable sized memory blocks, what would 
be the granularity here?

> 
>>>> 2) Attribute2:
>>> /sys/firmware/memory/memoryX/config
>>> echo 0 > /sys/firmware/memory/memoryX/config  -> deconfigure memoryX
>>> echo 1 > /sys/firmware/memory/memoryX/config ->  configure memoryX
>>
>> And these would configure individual storage increments, essentially calling
>> add_memory() and (if possible because we could offline the memory)
>> remove_memory().
> 
> configure or deconfigure memory in units of entire memory blocks.

I assume, because that is assumed to be the smallest granularity in 
which we can add_memory().

And the memory block size is currently always at least the storage 
increment size, correct?

> 
> As I understand it, add_memory() operates on memory block granularity,
> and this is enforced by check_hotplug_memory_range(), which ensures the
> requested range aligns with the memory block size.

Yes. I was rather wondering, if we could have storage increment size > 
memory block size.

> 
>>> 3) Attribute3:
>>> /sys/firmware/memory/memoryX/altmap_required
>>> echo 0 > /sys/firmware/memory/memoryX/altmap_required -> noaltmap
>>> echo 1 > /sys/firmware/memory/memoryX/altmap_required -> altmap
>>> echo N > /sys/firmware/memory/memoryX/altmap_required -> variable size
>>> 	 altmap grouping (possible future requirements),
>>> 	 where N specifies the number of memory blocks that the current
>>> 	 memory block manages altmap. There are two possibilities here:
>>>          * If the altmap cannot fit entirely within memoryX, it can
>>>            extend into memoryX+1, meaning the altmap metadata will span
>>>            across multiple memory blocks.
>>>          * If the altmap for memory range cannot fit within memoryX,
>>>            then config will return -EINVAL.
>>
>> Do we really still need this when we can configure/deconfigure?
>>
>> I mean, on s390x, the most important use case for memmap-on-memory was not
>> wasting memory for offline memory blocks.
>>
>> But with a configuration interface like this ... the only benefit is being
>> able to more-reliably add memory in low-memory conditions. An unlikely
>> scenario with standby storage IMHO.
>>
>> Note that I dislike exposing "altmap" to the user :) Dax calls it
>> "memmap_on_memory", and it is a device attrivute.
>>
>> As soon as we go down that path we have the complexity of having to group
>> memory blocks etc, and if we can just not go down that path right now it
>> will make things a lot simpler.
>>
>> (especially, as you document above, the semantics become *really* weird)
>>
>> As yet another point, I am not sure if someone really needs a per-memory
>> block control of the memmap-on-memory feature.
>>
>> If we could simplify here, that would be great ...
> 
> The original motivation for introducing memmap_on_memory on s390 was to
> avoid using online memory to store struct page metadata, particularly
> for standby memory blocks.

Right, when they were added but not online (memory not usable).

> This became critical in cases where there was
> an imbalance between standby and online memory, potentially leading to
> boot failures due to insufficient memory for metadata allocation.

Right, too much memory wasted on unused memmaps.

> 
> To address this, memmap_on_memory was utilized on s390. However, in its
> current form, it adds altmap metadata at the start of each memory block
> at the time of addition, and this configuration is static. It cannot be
> changed at runtime.

Yes.

> 
> I was wondering about the following practical scenario:
> 
> When online memory is nearly full, the user can add a standby memory
> block with memmap_on_memory enabled. This allows the system to avoid
> consuming already scarce online memory for metadata.

Right, that's the use case I mentioned. But we're talking about ~ 2/4 
MiB on s390x for a single memory block. There are other things we have 
to allocate memory for when onlining memory, so there is no guarantee 
that it would work with memmap_on_memory either.

It makes it more likely to succeed :)

> 
> After enabling and bringing that standby memory online, the user now
> has enough free online memory to add additional memory blocks without
> memmap_on_memory. These later blocks can provide physically contiguous
> memory, which is important for workloads or devices requiring continuous
> physical address space.
> 
> If my interpretation is correct, I see good potential for this be be
> useful.

Again, I think only in the case where we don't have have 2/4 MiB for the 
memmap.

If this is triggered from inside the VM, might just be that the admin 
can not even login anymore and trigger this if really close to OOM ...

> 
> As you pointed out, how about having something similar to
> 73954d379efd ("dax: add a sysfs knob to control memmap_on_memory behavior")

Right. But here, the use case is usually (a) to add a gigantic amount of 
memory using add_memory(), not small blocks like on s390x (b) consume 
the memmap from (slow) special-purpose memory as well.

Regarding (a), the memmap could be so big that add_memory() might never 
really work (not just because of some temporary low-memory situation).

> 
> i.e.
> 
> 1) To configure/deconfigure a memory block
> /sys/firmware/memory/memoryX/config
> 
> 1 -> configure
> 0 -> deconfigure
> 
> 2) Determine whether memory block should have memmap_on_memory or not.
> /sys/firmware/memory/memoryX/memmap_on_memory
> 1 -> with altmap
> 0 -> without altmap
> 
> This attribute must be set before the memoryX is configured. Or else, it
> will default to CONFIG_MHP_MEMMAP_ON_MEMORY / memmap_on_memory parameter.

I don't have anything against that option. Just a thought if we really 
have to introduce this right now.

-- 
Cheers,

David / dhildenb

