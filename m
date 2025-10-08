Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75391E25F9
	for <linux-s390@vger.kernel.org>; Wed,  8 Oct 2025 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759916040; cv=none; b=C1MEd9u1AAwJ8i/a+j2lFtjdNhdAPeIX9TzMIJe1QP8F+/A4EOCJazFrGKHa9kNtj151tztqRbypHqQ+7cC1faGggTD16NEpFavZ22HVUNdqkCi14kk8u08rnFS4LzqO9vjAjLgw+ML9Kbpby3cKFy4o8lAjcRt8eQyWlILUidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759916040; c=relaxed/simple;
	bh=6zxM30aDH01IiYvZ1H7Wr1pAyvigajpz0autcEP1khY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AR6RJ0iD6sJseM3khDP4lE3vkVqJiGTwwEts/D4CS1ICWZQt0tHCf5n12/VABRonxJd2AeqPW6rfOHxrmBXozwvvFGyHYH601x1tGGbD5THnNOa1Qlw+At4EaihiuH90qMh2OpaLmaAHM/bZiYqWzeNwOTkURfsZGonV76Ky5Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVeoDjOK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVeoDjOK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759916037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pvNQ2sqsxcgVrxGJZXdoSqap7VzzZ3mjW5LxJACJ12c=;
	b=bVeoDjOKPj0XetoejOhFasGEUkL641UKLGMlsT2j24Ka2OuHjJN26NOBZGNisa+tZvGqnS
	VKjk17PsxTcyzp6qYPgdfH/+B/GFpAvob0wUd7jFgGqY5bKMf6ip8elZRZBfeCuJKiLNZu
	jHG8kr63bKTSBL9nnb9BEdVBjUW5nfw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-FYqxn6SSM-yFWTKwfDxrTw-1; Wed, 08 Oct 2025 05:33:56 -0400
X-MC-Unique: FYqxn6SSM-yFWTKwfDxrTw-1
X-Mimecast-MFC-AGG-ID: FYqxn6SSM-yFWTKwfDxrTw_1759916035
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ed9557f976so4871741f8f.3
        for <linux-s390@vger.kernel.org>; Wed, 08 Oct 2025 02:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759916034; x=1760520834;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvNQ2sqsxcgVrxGJZXdoSqap7VzzZ3mjW5LxJACJ12c=;
        b=d+zgb65++dJs3N3n6sgCp792Eb6ItVfOwB3Bm1GQDLQckRvD+5t66JEri3cKwm5oJL
         +2imWCrAY5yayV3DwNUkZ2Fhyg6V0zU1b+KH52lVeCJj5CUdj4NSudE5R7tvq58aKdVe
         ok7TaUMOQj7bt/NZ5F+/OjqOIJT0ub7JfV9i1QDFG60KEFu7eQ11nVML8FIoUBErNuBB
         A324ipAj1ZHx5ZU5ve9pKXrcZwtXcGId6dYWGiv+xULT2M9RaHZSCYAKlEHiOrvb7xeu
         haleWZdrZo5H61SL/mmlvNrUtuFBePP4pldoxg0SFTZ/demB/rLcUPR+1L62bIMcgG4Q
         0DmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkVu9bUkwsTQ/Vnfyz1yE7o6W22BNKzCoaGpYT4kMLrsDPB01azHhYttwEwLIIGw8do473vQ0mfXLe@vger.kernel.org
X-Gm-Message-State: AOJu0YztJxWmmo+j3n7BjEti5n4G7ONWI3v5rPotun2k/7aS/gOAggA1
	b0JQyxpLP7CCvo4++znm35c2ZouwTucRY5QaXfxJeoofXn6Yix8YwiM2UWJKmpmwpGEcNbntiu8
	gHX9MnsU5xPQ2Ts5+26wETO7HbVFJfoV2mhMdBlnHcMeANb9pN6U6CeTiuWH4L6o=
X-Gm-Gg: ASbGncuHCujSUjZA87XZpKCmdjBCCgWXmZY9PF/STiGR/NQhb9bV9dZ58pm2Aec3Kix
	yniXsAFD+xBXtB0zv8VArh2XA5/LHlsOlhWTlWQRM0G1AtQPs3h7OQTEMFqNGRaXY9rMfvdxYWt
	9AcMFrqneCBJlCbQZa7JVup+viMzn0JxdXzhW7fk1KxpK/227EGOtXmgou8pvcbSjO3g73Deiqb
	eNht/xW/xsV8RtssdjikyBiC+9qT+osmgNXJ621KuaMuLjbo00B7Hs/b00YlCueJexS+AZeU0DU
	ulIkZcy+L2n0YJ04C8gQYwP6h6yD8JzQ3w6gc+hs5ZAEgj+QS1K8EMoD+g5/7gDzNoI23vTUJRU
	f9TVYlqMm
X-Received: by 2002:a05:6000:2408:b0:414:6fe6:8fbd with SMTP id ffacd0b85a97d-4266e8de55dmr1525953f8f.54.1759916034443;
        Wed, 08 Oct 2025 02:33:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRgm9ENNBAKPQVvD/piMECVRSv9+MLaK5jztOw4UsWToxz1h/ZD5Ud2PMOKOKZArxB19KvCg==
X-Received: by 2002:a05:6000:2408:b0:414:6fe6:8fbd with SMTP id ffacd0b85a97d-4266e8de55dmr1525932f8f.54.1759916034010;
        Wed, 08 Oct 2025 02:33:54 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4cc3sm29006938f8f.55.2025.10.08.02.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:33:53 -0700 (PDT)
Message-ID: <9f35aedb-fd67-412f-a3d3-bb6692f7c2ce@redhat.com>
Date: Wed, 8 Oct 2025 11:33:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Support dynamic (de)configuration of memory
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-s390
 <linux-s390@vger.kernel.org>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
 <ab366c03-8c78-449d-bfc4-2d155212d9d7@redhat.com>
 <aOVUNmDiWgrDJ1dJ@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <5e3b16ec-9ef9-483e-b97e-bff0c1915b19@redhat.com>
 <aOX_L1_2S30XhLRA@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1efcb368-fcdf-4bdd-8b94-a705b7806bc2@redhat.com>
 <aOYrUEr-inqogzJE@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aOYrUEr-inqogzJE@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.10.25 11:13, Sumanth Korikkar wrote:
>>>> I wonder if the above two are really required. I would expect most/all users
>>>> to simply keep using -e / -d.
>>>>
>>>> Sure, there might be some corner cases, but I would assume most people to
>>>> not want to care about memmap-on-memory with the new model.
>>>
>>> I believe this remains very beneficial for customers in the following
>>> scenario:
>>>
>>> 1) Initial memory layout:
>>> 4 GB configured online
>>> 512 GB standby
>>>
>>> If memory_hotplug.memmap_on_memory=Y is set in the kernel command line:
>>> Suppose user requires more memory and onlines 256 GB. With memmap-on-memory
>>> enabled, this likely succeeds by default.
>>>
>>> Later, the user needs 256 GB of contiguous physical memory across memory
>>> blocks. Then, the user can still configure those memory blocks with
>>> memmap-on-memory disabled and online it.
>>>
>>> 2) If the administrator forgets to configure
>>> memory_hotplug.memmap_on_memory=Y, the following steps can be taken:
>>> Rescue from OOM situations: configure with memmap-on-memory enabled, online it.
>>
>> That's my point: I don't consider either very likely to be used by actual
>> admins.
>>
>> I guess in (1) it really only is a problem with very big memory blocks.
>> Assuming a memory block is just 128 MiB (or even 1 GiB), you can add+online
>> them individually. Once you succeeded with the first one (very likely), the
>> other ones will follow.
>>
>> Sure, if you are so low on memory that you cannot even a single memory
>> block, then memmap-on-memory makes sense.
>>
>> But note that memmap-on-memory was added to handle hotplug of large chunks
>> of memory (large DIMM/NVDIMM, large CXL device) in one go, without the
>> chance to add+online individual memory blocks incrementally.
> 
> Interesting. Thanks David.
> 
> Heiko suggested that memory increment size could also be upto
> 64GB. In that case, it might be useful.

Yeha, rings a bell. But that would not be your 4GiB scenario you shared :)

-- 
Cheers

David / dhildenb

