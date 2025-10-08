Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2C19D8BC
	for <linux-s390@vger.kernel.org>; Wed,  8 Oct 2025 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759910555; cv=none; b=JnM6KxKAYLXPaYfTXQrq93/HNJtP2GHS2qj+eyBDXmMlOOYJ2emPC31hHtIatUGrQSwaSTiZyO7uf/qW27jpGT7K51ZTcfL3XTfn8NS1J/kdXwNa6UmZ6AW8pNjr56YoTkV+LXIuOeR424/iXZHFSlhAPYiIr8a3nTHB5w3rKZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759910555; c=relaxed/simple;
	bh=Y02Z5LfdT7QBwB7Olb29gAwh2+0LN36RT7fk6o03+Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFcnAXID0P56Ecyx/zGc08rmKZfFu5OzU1wQ9heshAnlznNP8C5vqDfPxmnyoCxBld7lxOQLIlmWP6IPWiW1dERnPKo/2R22HhztDYSndYLQQmQPyTOcDjyrTq9L0h7lUaGh6Gsjgml1m/ZZ0oKizh6PeEegomst4NKNq6VVT7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVQSMVrl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVQSMVrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759910552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pddHH/uKIG+2OdAE3dfwxjSpPlFOQuBykDEPMc5UKGA=;
	b=aVQSMVrliEYvrPpdMO+VoIgDrNP8XV5XWd0ujqs0TJCak8xaF0l2B6LePTZpjK3DZR/WQE
	jECg/Clk05Dr9kPOGrugJnht7GJX2wZP62PTYTtdF43zawcXT3u4SRE0xQPPezm1T5K4gE
	H8dePjuwFY7+NN4x3RomFSU7tz6E4NA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Afuwd-jiOgC-aeZkELbWcg-1; Wed, 08 Oct 2025 04:02:31 -0400
X-MC-Unique: Afuwd-jiOgC-aeZkELbWcg-1
X-Mimecast-MFC-AGG-ID: Afuwd-jiOgC-aeZkELbWcg_1759910550
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e38bd6680so24137035e9.1
        for <linux-s390@vger.kernel.org>; Wed, 08 Oct 2025 01:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759910550; x=1760515350;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pddHH/uKIG+2OdAE3dfwxjSpPlFOQuBykDEPMc5UKGA=;
        b=g/z9IdxjKJM+0chmyO0GbDjfBllWWvgILR8Dtv5WAcNyjSD7Oc+s+8SZakuyBusJn5
         6JiK3yk9GDiuAT7wJMSP1b2jVWoxwxmnieuPW7w0e/9bgWFBuer1DqICUgLxrMXUcmNZ
         /3zubnsIV7+zztIaFv2pWqcS7fghLDMi8IARJPAsnsd/juKdAJs9hlvok+wgFA9R8ks6
         H4TPAY6veOwKHmT2fS3NO3WmjD7JlSCrxxTsES+LZMtvAWHL6CbyjFhZCKYxZEOWnAQc
         NIQjZfmvGejbT0tXY8IwJ9/WepArPZ6r8s+cuE0orvREWsO6HkTW8uptcBiN7TfhzBjQ
         VQsg==
X-Forwarded-Encrypted: i=1; AJvYcCVS3T3cFDYD3uE5yF1D/G1BHSucNALCZBocz4Dt+bquzwx5VKk760hNT1tbxDa/uSp+uXK1z8hMPe/8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Bo0cvhKNMlFAbMjz3KfJv/0lQkrgvlkz2mHKD2ZKpZnJuLKo
	sJRfCvhds+oXl+1BCsutXvrft3Pd/wipBSbWS/hMrKJmLAkc1C+4Ijo0Zea5mUqpfUjc3WsVUzf
	R3ehK4V2zmGtdOXUbJWZr34Xsi9Cu8vsYATodaKpeTfVi36UU05uVQUto3fWjFmQ=
X-Gm-Gg: ASbGncsPdDYrtiSC6fBhihVDW20s/YNGo5Stkh671w55WVv1/BPefYkodBrOiutBQlW
	CQqou8RuvovzwTPUwaFUTgFDNeBieL08zcU+BYMR02Pov5/YQ6kl0s8Xki78z3L8me9LHbXqepp
	+DoYOV86y635nyOhhVIRRe2zvxgbACwgMCeESS6csj7vrUUDDYqMjmcu7WzAFQW7uBW+LDUht16
	fkjYN2cJte8MOPTZyThDWuM3InHAVPGtR316mGRYNYtr7WIn/L0VrFS1uuOzJ4n2wjvP2V00PkI
	VOVh9gdoYdxlxzPxQzMOItj+/D1iqic+/cKL/uo1oWPdp6HbTuy0lhDdDoASHn34XeVY68UsOCH
	2EL2CaCys
X-Received: by 2002:a05:600c:34c2:b0:46e:21c8:ad37 with SMTP id 5b1f17b1804b1-46fa9b06d3dmr14877345e9.25.1759910550016;
        Wed, 08 Oct 2025 01:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEbw0aJZMLEsvRDrluvzxmPzzAjNZ2fUN5jdXsXVmOstYYrD7freeeFECzzcJlyO/7OK6m0A==
X-Received: by 2002:a05:600c:34c2:b0:46e:21c8:ad37 with SMTP id 5b1f17b1804b1-46fa9b06d3dmr14877115e9.25.1759910549578;
        Wed, 08 Oct 2025 01:02:29 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f083asm28904014f8f.43.2025.10.08.01.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:02:28 -0700 (PDT)
Message-ID: <1efcb368-fcdf-4bdd-8b94-a705b7806bc2@redhat.com>
Date: Wed, 8 Oct 2025 10:02:26 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aOX_L1_2S30XhLRA@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.10.25 08:05, Sumanth Korikkar wrote:
>> Care to share an example output? I only have a s390x VM with 2 CPUs and no
>> way to configure/deconfigure.
> 
> lscpu -e
> CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
>    0    0      0    0      0    0 0:0:0         yes yes        vert-medium  0
>    1    0      0    0      0    0 1:1:1         yes yes        vert-medium  1
>    2    0      0    0      0    1 2:2:2         yes yes        vert-low     2
>    3    0      0    0      0    1 3:3:3         yes yes        vert-low     3
>    
> # chcpu -d 2-3
> CPU 2 disabled
> CPU 3 disabled
> # chcpu -g 2
> CPU 2 deconfigured
> # chcpu -c 2
> CPU 2 configured
> # chcpu -e 2-3
> CPU 2 enabled
> CPU 3 enabled

Makes sense, thanks!

> 
>>> chmem changes would look like:
>>> chmem -c 128M -m 1 : configure memory with memmap-on-memory enabled
>>> chmem -g 128M : deconfigure memory
>>
>> I wonder if the above two are really required. I would expect most/all users
>> to simply keep using -e / -d.
>>
>> Sure, there might be some corner cases, but I would assume most people to
>> not want to care about memmap-on-memory with the new model.
> 
> I believe this remains very beneficial for customers in the following
> scenario:
> 
> 1) Initial memory layout:
> 4 GB configured online
> 512 GB standby
> 
> If memory_hotplug.memmap_on_memory=Y is set in the kernel command line:
> Suppose user requires more memory and onlines 256 GB. With memmap-on-memory
> enabled, this likely succeeds by default.
> 
> Later, the user needs 256 GB of contiguous physical memory across memory
> blocks. Then, the user can still configure those memory blocks with
> memmap-on-memory disabled and online it.
> 
> 2) If the administrator forgets to configure
> memory_hotplug.memmap_on_memory=Y, the following steps can be taken:
> Rescue from OOM situations: configure with memmap-on-memory enabled, online it.

That's my point: I don't consider either very likely to be used by 
actual admins.

I guess in (1) it really only is a problem with very big memory blocks. 
Assuming a memory block is just 128 MiB (or even 1 GiB), you can 
add+online them individually. Once you succeeded with the first one 
(very likely), the other ones will follow.

Sure, if you are so low on memory that you cannot even a single memory 
block, then memmap-on-memory makes sense.

But note that memmap-on-memory was added to handle hotplug of large 
chunks of memory (large DIMM/NVDIMM, large CXL device) in one go, 
without the chance to add+online individual memory blocks incrementally.

That's also the reason why I didn't care so far to implement 
memmap-on-memory support for virito-mem: as we add+online individual 
(small) emmory blocks, the implementation effort for supporting 
memmap_on_memory was so far not warranted.

(it's a bit trickier for virtio-mem to implement :) )

-- 
Cheers

David / dhildenb

