Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152934BA59
	for <linux-s390@vger.kernel.org>; Thu,  9 Oct 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760036620; cv=none; b=ibqE3yQgh3NIDA4McEjSEM0fVn1a8w2lZ1sMbX2SNhtCX5uE9vS8DXsDIUI+IZBbTJRHw5t+oTVS4Mk5zH76aD4MiMqVZHQEjXQSoZXGWJ3tnBrVmHdFJrNSC2qNiT1QMOX/muHzWTNY0R59NQU3vu/D1w/QgNF9abK8ur0KQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760036620; c=relaxed/simple;
	bh=B/0kxFMHOwy7JuUoZgL1UR0F/5ADsv+qa8fGxfyAGWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaiRy330PtIEnaz5Ikzx1Yk82ekWfNr7oT9fSAUFo+nGA+IE+xpjn213kXW2WnTuyZ8yb8GK5OqCl9p2JSek2JRMmlLihWpYQ0qCxz43T3SLAh0rHjYKDtJokGff58dZctAq4qJrG00lNkcxGjwNVwQOdifL1ilT5CGN0S8eHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzY8HEM6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzY8HEM6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760036617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v/ssIfgtDfZ/vZQpJbYy04kO6t4txkot0+r1aHEyw0s=;
	b=LzY8HEM657UM8F5BhNcwW9BNcNr/dhsiuPlzXajZEngN4NyYsYGu61502QupZMvM+8u393
	1wUjxM8dmPJX8lECSusVvCs34IGiCF63FQSmflhiGv4Kcl24ZJ7GnUPW6sTKWHXL3fzu/K
	5RuMQb7qXILBs7PIsnDl2Fp/3NnDeAk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-TjSELij6Mn6BSsClKg08MA-1; Thu, 09 Oct 2025 15:03:36 -0400
X-MC-Unique: TjSELij6Mn6BSsClKg08MA-1
X-Mimecast-MFC-AGG-ID: TjSELij6Mn6BSsClKg08MA_1760036615
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e46486972so8396295e9.0
        for <linux-s390@vger.kernel.org>; Thu, 09 Oct 2025 12:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760036615; x=1760641415;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/ssIfgtDfZ/vZQpJbYy04kO6t4txkot0+r1aHEyw0s=;
        b=BD5R9os3RLjhCXMzHPv0yFj8k61sDy34gE4imxRswZcImWNn+bREp8OqmhblfYFwyT
         qtK6fuaKQEDd53/wC8qBvOd6z6H3RXANOzeoK1xTOQZSR/efMFmePbvnLIFCQ9ZouWvg
         zGkpCfd6gpaAoWgBr4ReYmE2XnsE++H2hMyi87XfO2Lad0VBq5PWwRKtTaW3ckrZy3EO
         LvpMAV1MDsfyQ0lTjdVJzqVcyg+vrt0/8IAchq5cLXYnySVx6X4lyV6BOFq9uhxYjoAY
         TyTJnLS4DCKI64oZeupapusKuWSkrlCkviYy4T3zS3JqjlL8ibr7DjZ0E9jRplUSMbyo
         nMow==
X-Forwarded-Encrypted: i=1; AJvYcCU7Sxnb5eruyGrUxnQIJEJ7zzvvaRtAfrGtlFdD5AWQoBxcUr0tvuP2FUXll3LqzVGRsG6b2c6Bbwmc@vger.kernel.org
X-Gm-Message-State: AOJu0YxwRY8LpD+iMH4Dh9R8AMuwKo96+xpxKQGflSr8EseFEwk4mPdZ
	4dDLEWHWMoFmot0HCFyeyvUuhLvPBytyFZg6LexMCWiMkhU84A4Z7I6R4IbIJXLD+oIDGo2ODdx
	k43MtRlkyJU8P7KF62LYpQtIw3pxF/Ev4T/NeciwxhUme/JqNNHTShnnTLzCuUiw=
X-Gm-Gg: ASbGncsE+ND63DkWUhzS/X05rH7VLZwedDdJcrRPJpMwc0Dis8LLdn57W8qyu+41OIc
	MsI7d0Ow8aEoQSdT2sOL0SQ+OYSa8KTGS5MTWi7fCMzauY+oEDbEQoU2ArUSwnFD+N6JfyonXZR
	7B47xkX5nejfR/GlDNsmR1GNRhJ8MjZXT4cRYFYeVoVhmLQZFvqFwKLpiwb92UrB8eLlTzFm8zG
	p7GSKD6bGP1Dr/Fg/EqJ44RmA31jhq9SwfqxBBiVFZDpRcKyHVOnyEO9G5NYlE09ATKPVGRR4Z/
	oNks8XtzByr+KU0V1ur/zcQKTvkM3rZNCG3mz6BCiB8FEfh55S8UKLVDQzKWVBV5JHQexnBQJS+
	wVbBooAl1
X-Received: by 2002:a05:600c:6287:b0:46f:b42e:edcd with SMTP id 5b1f17b1804b1-46fb42eee07mr11006325e9.38.1760036614783;
        Thu, 09 Oct 2025 12:03:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKJxh6vFQ36gJauYPkq/a3ScSVmIoEQBpQlpefqbtkRe6rn2htikCoXY1hIWlxMFsl+Gqqiw==
X-Received: by 2002:a05:600c:6287:b0:46f:b42e:edcd with SMTP id 5b1f17b1804b1-46fb42eee07mr11006155e9.38.1760036614381;
        Thu, 09 Oct 2025 12:03:34 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe4esm352054f8f.26.2025.10.09.12.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 12:03:33 -0700 (PDT)
Message-ID: <da27231d-e8dc-41f1-b5bd-e32b5eed52f3@redhat.com>
Date: Thu, 9 Oct 2025 21:03:31 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm/memory_hotplug: Remove
 MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
To: Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20251009131839.3739108-1-sumanthk@linux.ibm.com>
 <20251009131839.3739108-5-sumanthk@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251009131839.3739108-5-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.10.25 15:18, Sumanth Korikkar wrote:
> MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE memory notifiers were introduced
> to prepare the transition of memory to and from a physically accessible
> state. This enhancement was crucial for implementing the "memmap on memory"
> feature for s390.
> 
> With introduction of dynamic (de)configuration of hotpluggable memory,
> memory can be brought to accessible state before add_memory(). Memory
> can be brought to inaccessible state before remove_memory(). Hence,
> there is no need of MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE memory
> notifiers anymore.
> 
> This basically reverts commit
> c5f1e2d18909 ("mm/memory_hotplug: introduce MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers")
> Additionally, apply minor adjustments to the function parameters of
> move_pfn_range_to_zone() and mhp_supports_memmap_on_memory() to ensure
> compatibility with the latest branch.
> 
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

