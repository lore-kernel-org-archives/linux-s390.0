Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8464913E6B1
	for <linux-s390@vger.kernel.org>; Wed, 27 Mar 2024 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547798; cv=none; b=oagUDY60MW7ergZBOs8LvtJfKGawasUOaPxxWmCw46ox/osSnaF1M7xhiAolatkoH9MF9ZxcV8NQ3nmI1tRdrACoBqqLEjZNGPXN+Bu/FFEf3jtU8Of8zZqYOWE2+LCn8UKQYYFzFqN11/0OZeD/axuD6u8q+R7mKcS1EoFU/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547798; c=relaxed/simple;
	bh=q1Sl6onKIcjh+IyaRcKCsDzaQX9LhL1hX70A2AlEmms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4/1a4nHraB9XqAIBRJmEpVsVfCjmh2A7SBibQZj59/5yM4AjwTkkLBQQvNp9z4VVTfMfG00UpVUnEmWqCO+uza102gpfiPoVsOy90df7A/rKelqLDk68c5jspqxWDtRhULFPmFQ0lZY+B31NwIlyUNpCc0kgNFJM2MQXUInm9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYeqIgCT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYeqIgCT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711547795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wwFOu67rAm/jgeVVs/VXwT1nwHyOmGUKbXFLwpopGYg=;
	b=UYeqIgCTfF2dn3Xo6lcDAyozg7uAooAOtyl+sxJn22W8kXrRe6ma0O8PQ5BBvbVFYtqtE+
	GlKUIAlAKWrb8p1mIfhKzNZBeIlrndSczMWMinvAG+RPkQ+u0BTyIYMEmZ9s7lgnreeDl4
	cc6M0xPOSbE5AIetalIxfIRF/4VEOro=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-j9_wMOj6PB-o-Ks4hRdbZA-1; Wed, 27 Mar 2024 09:56:34 -0400
X-MC-Unique: j9_wMOj6PB-o-Ks4hRdbZA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4140bf38378so48353235e9.1
        for <linux-s390@vger.kernel.org>; Wed, 27 Mar 2024 06:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711547793; x=1712152593;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwFOu67rAm/jgeVVs/VXwT1nwHyOmGUKbXFLwpopGYg=;
        b=TyRCYp/FOAIApxaMao9PgphjQgQVrrtl5HxDimkMSeQnQc47VzVxdJkrVeu4RkG4qx
         adTLHhuOJkjz+qTIDOjQXozPExgrfXzQ0C7aeEDW+NqmKKc0VUno3yLbTe1PeSpSLhkT
         h6ge8e63PFNkW/3oQnbdBmfMXaUjvmSoju9ov46coOvxzlRP8fzn6cJWbl4YLGkKIOPd
         3UBzoduSf2POaJmTe39txs8fPUEncyhzQxMJQsrVbtCpmxvbffCSLjeIohq+QXYqwHt5
         G5VsU16XRlauvncSRuIkv6C+mG2BCyocrzPuZsd+LtCOfAiPE99ZW3ZgLhNu0t2XNAyT
         5PuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMDLlPuIn5tYPoR/gTt5rGAqehzgwRruzYIwKJzMqFk6jDqsN4/cVp3tAnFepXxW0jSH4aFp8uoPdlcY5wrbw3TGLlnYtAH9LDvQ==
X-Gm-Message-State: AOJu0Yyj82HsqHwlVT705pPSjp15bV32x2McARbOccx5hOaswr4EeQ5e
	6NYY90jpqWCEw1KLFuO/rs30OC2PwsR3NyXqMp/I1OtEEVv5cCDJSPgoBHsGzhd5nlZx9rJkAJ6
	lwm6DIvkJhtSl47XYmDggQrM++VUc5vtwOIhdC/MhKOuw6BWbx6yZwtFlHPU=
X-Received: by 2002:a05:600c:a08:b0:414:392:38d2 with SMTP id z8-20020a05600c0a0800b00414039238d2mr74557wmp.24.1711547793057;
        Wed, 27 Mar 2024 06:56:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExpTOhHThCpVA+4b+ZiNKOUdia4Bzq6YqF2zp26xsxLD8eZI4hj+mGwvlthboaboFnQKnRxA==
X-Received: by 2002:a05:600c:a08:b0:414:392:38d2 with SMTP id z8-20020a05600c0a0800b00414039238d2mr74531wmp.24.1711547792613;
        Wed, 27 Mar 2024 06:56:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8a00:362b:7e34:a3bc:9ddf? (p200300cbc7088a00362b7e34a3bc9ddf.dip0.t-ipconnect.de. [2003:cb:c708:8a00:362b:7e34:a3bc:9ddf])
        by smtp.gmail.com with ESMTPSA id k33-20020a05600c1ca100b0041409cabb39sm2218013wms.18.2024.03.27.06.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 06:56:32 -0700 (PDT)
Message-ID: <7631ff56-fa16-4b2b-87b2-1e93691bd110@redhat.com>
Date: Wed, 27 Mar 2024 14:56:31 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] mm/gup: consistently name GUP-fast functions
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 x86@kernel.org
References: <20240327130538.680256-1-david@redhat.com>
 <20240327130538.680256-2-david@redhat.com>
 <20240327135256.GG946323@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240327135256.GG946323@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.03.24 14:52, Jason Gunthorpe wrote:
> On Wed, Mar 27, 2024 at 02:05:36PM +0100, David Hildenbrand wrote:
>> Let's consistently call the "fast-only" part of GUP "GUP-fast" and rename
>> all relevant internal functions to start with "gup_fast", to make it
>> clearer that this is not ordinary GUP. The current mixture of
>> "lockless", "gup" and "gup_fast" is confusing.
>>
>> Further, avoid the term "huge" when talking about a "leaf" -- for
>> example, we nowadays check pmd_leaf() because pmd_huge() is gone. For the
>> "hugepd"/"hugepte" stuff, it's part of the name ("is_hugepd"), so that
>> says.
>>
>> What remains is the "external" interface:
>> * get_user_pages_fast_only()
>> * get_user_pages_fast()
>> * pin_user_pages_fast()
>>
>> And the "internal" interface that handles GUP-fast + fallback:
>> * internal_get_user_pages_fast()
> 
> This would like a better name too. How about gup_fast_fallback() ?

Yes, I was not able to come up with something I liked. But I do like
your proposal, so I'll do that!

[...]

> 
> I think it is a great idea, it always takes a moment to figure out if
> a function is part of the fast callchain or not..
> 
> (even better would be to shift the fast stuff into its own file, but I
> expect that is too much)

Yes, one step at a time :)

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks Jason!

-- 
Cheers,

David / dhildenb

