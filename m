Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC96C2E7186
	for <linux-s390@vger.kernel.org>; Tue,  7 Oct 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852979; cv=none; b=BFq6QX3YWNTE9ztvnE9NWPMwtQlsnj22T5alrct1eBpIb4Ud7YSAtbb3j4XpWgKtNfmHSDwmnTi0L17XP0xBhHjOZkWHz7q6+Fl0Yfg8JnaZ+V/N0Gp7BtpcxMQ0/WBNoINfihP3S0Ppuea6+F5iNI+emAr7Hgi5Ynd7NW2d4aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852979; c=relaxed/simple;
	bh=eZnjY/1uRorpVUA11zHcJ2APdx2Vku/TYD0GLCz90q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+J2O/cBr1S+A9ggOXcqZ/9o29Uk5+cnpxfvSJ/t5aWdlWjLQdPATWrMIAAUz90DU1Maztf4F0tga7dYtcX1VnvyUtKe6FU9e4AZC3dIY23g+pExVsZcOhC3vHrHwiphgP8pQ/fZcK9C1hAZF2RBaVkBExrFZ/Zu/GbQX+1NIFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPKhSKtQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPKhSKtQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759852976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D02vIogCWcywjjMvcCY1S+8ke4T1mD4/y69uYsSn6EI=;
	b=DPKhSKtQpYPp7Di4JWW4OMcMpfD2ri6cBhfEOTemg/Ytk2KqAyG4eohGnjqXWHmhvbMBfw
	lB6Fg1q6qEhQ0m0sCwuWvEOKSHJdobKDr9JBUbKaOqqRafgWofb4xZ4UvhYGR0f9nybzsQ
	M+pyOsZOBKGVF/21hyv7DluIq5BdWNE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-GstCZa8WN-y_32DyPaqeCg-1; Tue, 07 Oct 2025 12:02:55 -0400
X-MC-Unique: GstCZa8WN-y_32DyPaqeCg-1
X-Mimecast-MFC-AGG-ID: GstCZa8WN-y_32DyPaqeCg_1759852974
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e473e577eso33682635e9.0
        for <linux-s390@vger.kernel.org>; Tue, 07 Oct 2025 09:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759852974; x=1760457774;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D02vIogCWcywjjMvcCY1S+8ke4T1mD4/y69uYsSn6EI=;
        b=aOLYZmnGV72VGpdNpfcmmLE05459SMs2QWYZ7nrkXX+zHxsJid7R23u7M43kPbsXtn
         xTwbHSYQ0C6qNsGOKAvuMi4rzLw+DeuHc2MXck1ctfeLvKg4K9ReZ8slnRquS6yg+g8q
         /HsL+8/Pg7e9YOzJEkmUgOkr5lHctfJJLR0kOR7woj5tAG0Vn4I/e1ze1Tv6+qTK0Sux
         1ZY6zASOk3pcqoD5Fe+ES47pjDhdGdoYF3zGaAamOnbpl4zh/Rn4QMoI3crzSGeoX+lr
         76yncQ0jlqWrdI+/ls/myF6EGtNPp5//xP6NLjmi/bu6EYm+2guNW/xNa6yj8wGLHa+u
         H43w==
X-Forwarded-Encrypted: i=1; AJvYcCXQuQoqRWF5JN0bFSRg+f/jXBFEwCPiz2WG89QL6H05dCQxS1QzreceGP+2BfFmSHh+7rhsuPYmsSB4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgo5zVKKfcN7lLXSudWvnU+XxY0Fl9oGFMrSqZoy0tpE3rckAq
	z6VGGWAz0BI4Ww1aLhb/C27OwFjMAsZTt3pn0m9m6+j86WX49OJgnPBbCGJ7v19BYe0Hj8KF6DI
	BP4/X9/5Jg3LQakRzftwgWMHfpRT7q43OMJihYVocYf5B0ww8DJNqqgU6ENUxX80=
X-Gm-Gg: ASbGncvxGG7PA3agkPgH4iWUzUICP+V+ldiZE3qrw3bO1b5XfFdkexMWWiG8OOVhEsO
	99IuSVCeho1x8C/TiOXwcruV0Wzq2ZXOByt+jSlNoNkcgV9rsUtrhqFzpGEegq51JrLcJnkxGLf
	/vr7I0ZvNiq5BsifpofPcsEw9wC+v71W9Td89jEVbqWs1cDNn7jTfrdpcUMLYoPsjDRZTxQWF2U
	ChxTCGYKn6+mq+jNQV+NoVTdVORVSG8lZVAPQFbgzGQYMBgrcPDTYypi0a5PPDeS7gMh2Rg6I3y
	FmDheACTgl+xyXTDI6sTLTpabdUtFK5D/XhUspkJBSqJMU32tCqDjL1xlAH2pU4tjmfT5X5PdOe
	S0ay/9mDF
X-Received: by 2002:a05:600c:46cf:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-46fa9b02cebmr918085e9.27.1759852974079;
        Tue, 07 Oct 2025 09:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOCwhrXnFdPlPojqY5siU8KpIQ2/rmE8ldqFTs7bhEaF0DysabXEfVeEe2qCO04cRNTkizwg==
X-Received: by 2002:a05:600c:46cf:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-46fa9b02cebmr917695e9.27.1759852973646;
        Tue, 07 Oct 2025 09:02:53 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d869d50sm26841834f8f.0.2025.10.07.09.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 09:02:53 -0700 (PDT)
Message-ID: <0daf151e-d126-4e7b-adb6-5d6b745f4ad2@redhat.com>
Date: Tue, 7 Oct 2025 18:02:51 +0200
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
 <aOUj_RE8z9OiIIfN@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aOUj_RE8z9OiIIfN@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.10.25 16:30, Sumanth Korikkar wrote:
> On Fri, Sep 26, 2025 at 03:15:23PM +0200, Sumanth Korikkar wrote:
>> Hi,
>>
>> Patchset provides a new interface for dynamic configuration and
>> deconfiguration of hotplug memory on s390, allowing with/without
>> memmap_on_memory support. It is a follow up on the discussion with David
>> when introducing memmap_on_memory support for s390 and support dynamic
>> (de)configuration of memory:
>> https://lore.kernel.org/all/ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com/
>> https://lore.kernel.org/all/20241202082732.3959803-1-sumanthk@linux.ibm.com/
>>
>> The original motivation for introducing memmap_on_memory on s390 was to
>> avoid using online memory to store struct pages metadata, particularly
>> for standby memory blocks. This became critical in cases where there was
>> an imbalance between standby and online memory, potentially leading to
>> boot failures due to insufficient memory for metadata allocation.
>>
>> To address this, memmap_on_memory was utilized on s390. However, in its
>> current form, it adds struct pages metadata at the start of each memory
>> block at the time of addition (only standby memory), and this
>> configuration is static. It cannot be changed at runtime  (When the user
>> needs continuous physical memory).
>>
>> Inorder to provide more flexibility to the user and overcome the above
>> limitation, add an option to dynamically configure and deconfigure
>> hotpluggable memory block with/without memmap_on_memory.
>>
>> With the new interface, s390 will not add all possible hotplug memory in
>> advance, like before, to make it visible in sysfs for online/offline
>> actions. Instead, before memory block can be set online, it has to be
>> configured via a new interface in /sys/firmware/memory/memoryX/config,
>> which makes s390 similar to others.  i.e. Adding of hotpluggable memory is
>> controlled by the user instead of adding it at boottime.
> 
> Hi David,
> 
> Looking forward to your feedback to proceed further.

Thanks for bumping it up in my inbox, will comment today :)

-- 
Cheers

David / dhildenb

