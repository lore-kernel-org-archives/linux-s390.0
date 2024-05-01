Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377A12FB06
	for <linux-s390@vger.kernel.org>; Wed,  1 May 2024 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714578871; cv=none; b=nvNRw0QS4U7vibiZhBYRr8l1NmeAH6mvE1qYmRglDz7R2Q6LY4XoFQBVrITEe4WFmFwbdGDeZbi9KSHfSbsazfPJH3Z6tMID1hmY+ifv1opuijrEdKXurx88yflGcHiarvu4j5XlpZqvxKL2cWCEUMCfI8Ohxv3gGFDgkAsvGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714578871; c=relaxed/simple;
	bh=71Le3lhOqF7mJtXiAKBiwjI7NHwk1zXCvXbuooCnktY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVXTKbUxevpdMrBO7QyPaulBWm2do9jiX0aro2hXIyaKVAtMggsvn5MtYT5OeAj6bS5vx5Esse3dLJOasZ/eDQFELkP2f3sXGpD4FgUDVJRlMZ5lc0j3ehtdNRw1Mdt1tHT5WS+aQGA81ZW21/bXeUSqFvDP3Wz82f9zvipxq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Euyjg3qp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Euyjg3qp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714578868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dra4crM6SuKxZJFC32MDFH32iIO5Ahcz86JXAbj7hAo=;
	b=Euyjg3qpaqY1uWKxrESKQ+39YcT4iLzqY/xmvRaXeMZCofCJvDxPVyiYooeiQ3nCgyyNA9
	2asRDoCew3rIb9DHdN1BEqrl65l/eKNoN+PMlV+n6KPqrfQ3SP/UTNc9n9sY2EB792rxom
	jheWM1K8GG/n0JHW/tpymKV3DCpaB5U=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-7VPUJc2oOMWlVA8c98pvhw-1; Wed, 01 May 2024 11:54:24 -0400
X-MC-Unique: 7VPUJc2oOMWlVA8c98pvhw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2dddea1449dso57585991fa.0
        for <linux-s390@vger.kernel.org>; Wed, 01 May 2024 08:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714578863; x=1715183663;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dra4crM6SuKxZJFC32MDFH32iIO5Ahcz86JXAbj7hAo=;
        b=FqtNdEjzy2ymk06xk0NoJxGQ1OT0xCUgi+8yVlJN3fbCGIzALdOic6znLxcnzHYiUO
         8wu3j9akiee2JIM4CFoCLQoktXbbcDNdHrwlkr1k+UxGOvevXYbkfVzb5XsA/UQKxrPO
         JY4DAeeoByvwvByslu8a8V/UJ76V+wfxsINim4XTEVaVJzmZ5j6CztZwXnyIQR6nElgC
         +lsKFSPdjb1NZfUU6LW1WFsK0GiZ28RYJSa4Dj1rKZE5dVVeb/zjmHoEAjluCDqVm5h+
         DEG1Rrw3YEehRq9H6j+QsS5a6hJZR7lR8SC0qXytGqNgCBbpVftz7l9vUky4Ho2QSUMO
         ALzw==
X-Forwarded-Encrypted: i=1; AJvYcCWpM/jHb8JQaSJf4Ew/AewLP9Eus1ynLo68SU/URfoxXD4wl3zL8pByWcv4HGjkB4ir5LvK4CIEIP2I4icj4pFo61SnwcftwXkfWQ==
X-Gm-Message-State: AOJu0YwXOW74mh0N3ne3eh+hBKGPZaX++Pov5yN/SxFQiCF3svoxaCgw
	zkjJYGto184fpOsLts6/djEZepIBLmKCe3CrZ/cO6N9w9rjAAQuz15bR6s6CyC5maCiOR1aQPBS
	MUWpc8AS31SJM652TdTGsDM2lzH5Ge2cRc1Tc8hrR2SlQXLekGxK0C0fTkUE=
X-Received: by 2002:a2e:9b8f:0:b0:2de:8197:4cfe with SMTP id z15-20020a2e9b8f000000b002de81974cfemr1797710lji.42.1714578862723;
        Wed, 01 May 2024 08:54:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKr7d6c/oB7PFq2oL854rqRRnRilrbgxqDDmOJ1RvTkaJGXBxXwYZLNlmieyrQ97pKCT8ojA==
X-Received: by 2002:a2e:9b8f:0:b0:2de:8197:4cfe with SMTP id z15-20020a2e9b8f000000b002de81974cfemr1797697lji.42.1714578862194;
        Wed, 01 May 2024 08:54:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:aa00:299:f96e:f7b3:adae? (p200300cbc712aa000299f96ef7b3adae.dip0.t-ipconnect.de. [2003:cb:c712:aa00:299:f96e:f7b3:adae])
        by smtp.gmail.com with ESMTPSA id w20-20020a05600c475400b0041befc2652csm2604047wmo.31.2024.05.01.08.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 08:54:21 -0700 (PDT)
Message-ID: <736282e2-e17f-4434-9009-8252055451c5@redhat.com>
Date: Wed, 1 May 2024 17:54:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20240426190253.541419-1-zi.yan@sent.com>
 <ZjJCdodEf4CBa1N7@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <5FAD7FB6-4AC0-4427-B56E-4942A95DB68C@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5FAD7FB6-4AC0-4427-B56E-4942A95DB68C@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.05.24 15:38, Zi Yan wrote:
> On 1 May 2024, at 9:24, Alexander Gordeev wrote:
> 
>> On Fri, Apr 26, 2024 at 03:02:53PM -0400, Zi Yan wrote:
>>
>> Hi Zi,
>>
>> It increasingly looks like this commit is crashing on s390 since
>> 2024-04-30 in linux-next. If I do not miss something - since it
>> was included in mm-everything.
>>
>>> @@ -1553,9 +1558,10 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>   		 * page of the folio is unmapped and at least one page
>>>   		 * is still mapped.
>>>   		 */
>>> -		if (folio_test_large(folio) && folio_test_anon(folio))
>>> -			if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
>>> -				deferred_split_folio(folio);
>>> +		if (folio_test_anon(folio) &&
>>> +		    list_empty(&folio->_deferred_list) &&
>>
>> An attempt to reference folio->_deferred_list causes the crash below.
> 
> So if you remove this line, the crash no longer happens? It looks strange to
> me that referencing a anonymous folio's _deferred_list would cause a crash.
> Hmm, unless the folio is order-0.
> 
> Can you try the patch below and see if it fixes the crash? It moves partially_mapped
> ahead to exclude order-0 folios.
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 087a79f1f611..2d27c92bb6d5 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1557,9 +1557,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>                   * page of the folio is unmapped and at least one page
>                   * is still mapped.
>                   */
> -               if (folio_test_anon(folio) &&
> -                   list_empty(&folio->_deferred_list) &&
> -                   partially_mapped)
> +               if (folio_test_anon(folio) && partially_mapped &&
> +                   list_empty(&folio->_deferred_list))
>                          deferred_split_folio(folio);

Yes, that should fix it and is the right thing to do. For small folios, 
partially_mapped will always be false.

-- 
Cheers,

David / dhildenb

