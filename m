Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450DC1A314F
	for <linux-s390@vger.kernel.org>; Wed, 21 May 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837539; cv=none; b=ZEqT6drNSXz79rVKmUpj1n/DlQ8rGSjQg14JWYSvgxmf9S6tXw3l6C4QrSj3VcEf5HuGNiZd5jR9FV6oQ7TMyUzlaXn3nCiiJLk8nV8aWwdAdL5LjmPd7vkTZ0jDA/wnaE2OLlo4yBa34NuCoA6Ro/JhdySrS/OhaNNSr9Fv+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837539; c=relaxed/simple;
	bh=ERle5Shf5e07jHKS+coVt0FM90M8WmvFlbKyLcKihYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8RDQ4nDrOoxNeTVbK2/DmyuJItkaetTjrATpOhIp3igkRvK6AJ8kKovf3wTDKQllLZcIz+Sx+dxfzo1R64BJ7IlZItu65i45LznwchfSOAPU/xVDaaGVLQfKIXCnbES9Y5RGpIqiX7T+isTCXHhLCq/G6z2ExT5xAv3wMYX62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=co+HOmlE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="co+HOmlE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747837537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vtz3zCRfFVtYQqsEeh2I2d2h76gJuvlzOjcLp7jFKks=;
	b=co+HOmlEpAcTq0I8kLQj0BvqgubIn1xwEtoZoKW5dDa03Q8ZK9Ka2pZbZ2gVYwOIq/kxhh
	aEwbHkyWsH/hAb590491AI0aOrLZfNMDjNpdQddYO7OfHDJdoq06M512pt3JqCG/HzWnvl
	oAYCCQDCutfJpg41xbeFTO0EwMNSHRI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-A3fvBoflPymRusMp53TdXw-1; Wed, 21 May 2025 10:25:35 -0400
X-MC-Unique: A3fvBoflPymRusMp53TdXw-1
X-Mimecast-MFC-AGG-ID: A3fvBoflPymRusMp53TdXw_1747837534
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so37446665e9.1
        for <linux-s390@vger.kernel.org>; Wed, 21 May 2025 07:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747837534; x=1748442334;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vtz3zCRfFVtYQqsEeh2I2d2h76gJuvlzOjcLp7jFKks=;
        b=LEABmbtUZSTV9lcLX7606is+Vj5gp5hCOcmzaFM8zOwXMx92rdcm/QXB7jrYQhSYsF
         3SY7A+pUTVs0bULcOsUBXTMLAbCBP4H3kGOISPUco3+2VT/947j2y3Nul/DE0+4saZiD
         QtPzCn0fm2J8/JBcedRekO19JbvwCh84t5EK+6L322v42/C0b3jzGTm5qCiEQmdoXyC3
         LUbFjmh4Gutho9R2zAED18zMJchWZiO31yeML04N8CSbKk0vWrokq9QUQokkzocbhR2o
         BZgUlcM1+jGj+lVBJ1OHPJ7hzEWDiZiJ3IBZ7JqmMH7SL/S69IEBgdG3XzQ4f+zfF9uN
         OQLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlF0ApX6agEXFsgx26WqaEpPDUpAXh4hclWBJdTi8gqBnwrz8vDtXnKfa6z94CKgGDjFNfS+79QpXz@vger.kernel.org
X-Gm-Message-State: AOJu0YzZKQx7AUt2IjKjCfPO1+nfyScBBfKhu9UL0GVBobqXH/fmK7Vt
	G3bJcQiazAi3ZQ+mNApEz1TLKGAirkcuf+j3/hpRW+E8SJ79H56dDVaCEFwyacPwNEWKcH8Thhy
	5JdC66UXPCGQNa8/6G21SO8ehjphAJShqUAz1EmmQV/U4/mMg7DS9KtpiZHv6ASU=
X-Gm-Gg: ASbGnct3cXV0uvva9Df/syvEjcygArjDWG7xm0Xu0bMTGs6tFw76/NePE0DDc5Dp2F3
	NAmrJrcfZsGm22v0zMq2zW4p+yau4wBVyBAlOiArxvadpKB8AugRscZoWZ5nHsSCi4q31SPjF3C
	FU6LlCqDI+QX2zMPZvIkGsG8kmc76LFOwcJqKP7zJEFxleNnxXU0vYZKRNcQCczFd36xCN9DyCL
	epB11MPjCTeHh2/x9zhptMjizGLfgN6n6mO3O3KaaLgwyQMOx4Eocp/RwazI8YqgpowjK3mQmWN
	csWnUkGnV5k5M/DZU6ABfrCpKNFtgFOVhMnHco1BrYIenOBEHuF1eeect6DXTz76RAn/SQKwqha
	/QL1Ceon48x1iCDfw1pkpX4l+tOFLbtKjGn1VkG4=
X-Received: by 2002:a05:600c:a0b:b0:43c:e2dd:98f3 with SMTP id 5b1f17b1804b1-442ff029d0emr167080365e9.21.1747837534058;
        Wed, 21 May 2025 07:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH25l4CJ4kyN0aKiV6eZa261E7FBFCeGJlxOSvF96Y32jlEIFnp2FS8jC7CA1v8/E6Axnwzjg==
X-Received: by 2002:a05:600c:a0b:b0:43c:e2dd:98f3 with SMTP id 5b1f17b1804b1-442ff029d0emr167079985e9.21.1747837533661;
        Wed, 21 May 2025 07:25:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:9c00:e2c7:6eb5:8a51:1c60? (p200300d82f259c00e2c76eb58a511c60.dip0.t-ipconnect.de. [2003:d8:2f25:9c00:e2c7:6eb5:8a51:1c60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-448ba3d8facsm48483235e9.6.2025.05.21.07.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 07:25:33 -0700 (PDT)
Message-ID: <63967c9a-0ae7-42c1-9a2e-31213ad1fa90@redhat.com>
Date: Wed, 21 May 2025 16:25:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm/memory_hotplug: Add interface for runtime
 (de)configuration of memory
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20241202082732.3959803-1-sumanthk@linux.ibm.com>
 <20241202082732.3959803-2-sumanthk@linux.ibm.com>
 <3151b9a0-3e96-4820-b6af-9f9ec4996ee1@redhat.com>
 <Z08WpCxt4lsIsjcN@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1b9285ba-4118-4572-9392-42ec6ba6728c@redhat.com>
 <aCx-SJdHd-3Z12af@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <fca5fe72-55a8-456c-a179-56776848091d@redhat.com>
 <aC2sUdhavboOgS83@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <496e6707-bdc9-4ad2-88e2-51236549b5f2@redhat.com>
 <20250521142149.11483C95-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250521142149.11483C95-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.05.25 16:21, Heiko Carstens wrote:
> On Wed, May 21, 2025 at 02:33:42PM +0200, David Hildenbrand wrote:
>> On 21.05.25 12:34, Sumanth Korikkar wrote:
>>> As you pointed out, how about having something similar to
>>> 73954d379efd ("dax: add a sysfs knob to control memmap_on_memory behavior")
>>
>> Right. But here, the use case is usually (a) to add a gigantic amount of
>> memory using add_memory(), not small blocks like on s390x (b) consume the
>> memmap from (slow) special-purpose memory as well.
>>
>> Regarding (a), the memmap could be so big that add_memory() might never
>> really work (not just because of some temporary low-memory situation).
> 
> What is "big"? Worst case for s390 with existing machines would be an
> increment size (aka memory block size) of 64GB.
Oh! I was assuming the increment size would always be around 256MiB or so.

In that case, it can make sense to have this, yes!

-- 
Cheers,

David / dhildenb

