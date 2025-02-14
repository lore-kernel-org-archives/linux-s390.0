Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25FD25A645
	for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2025 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528847; cv=none; b=ciRQqhThTmV2PvWhmeeW7x9szo6tIaNjc1YedP2QvKNfiA+eUmMXJRv9AJQhvu/sY8xc/ty/9jsJlRMIUyw2yDVFmFsniU4AAsRPHRGADNs9Iyrp7Dqfw/byLP6BkXqBqB9iZmgo+96NWH114f9edgrBOXC9zRtU7HxVBWxJdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528847; c=relaxed/simple;
	bh=78xrz/HVPw8CC87OYPuhUyUhsOxpY1yFErv89zo64dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSzkf8G+MLBzWx6f+xBiGCrjMQz2KgHVqJNshemw4UXvJx9cJniSvrqGU7SvAS3qPxQ/JrqwktyiLoeXsWbP3Df99l9UEAbJpstL7fc9RwyibfJOplbNThZFkSDpA7BgR72xng9cH6YO1d7Txjlxicsr+HLI7ofOQ9E55KBnfJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzqvDQ7C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzqvDQ7C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739528844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hZWMT8WxbxzIhhzmDc7Gm/l6y+y9ahJ/5zA846b5VzU=;
	b=fzqvDQ7CaZHTkdRLVIKDLBODJavJhXP/aMFYWECUXTTrZa9khdTK3zHgnhqu3tXBgznQX/
	pLvHyJQw1cXL5idaTHIKG+tNb45PSWNu0b2mtkrL2YwtYDOraeVlinJgYlo5BaWGZAq9O0
	JlH+QhhM6rtuX9CVod51efuJAoCJEnE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-G8LMWnvMP3anaQq0_6HX7g-1; Fri, 14 Feb 2025 05:27:22 -0500
X-MC-Unique: G8LMWnvMP3anaQq0_6HX7g-1
X-Mimecast-MFC-AGG-ID: G8LMWnvMP3anaQq0_6HX7g_1739528842
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4395ff90167so10396495e9.2
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2025 02:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739528841; x=1740133641;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hZWMT8WxbxzIhhzmDc7Gm/l6y+y9ahJ/5zA846b5VzU=;
        b=Mct2la6RwSmBSkQV6HIpN/M996p0ZHOIpmGC5JLkmKgCvZmX0lOukrse5k2w5x0FKH
         0EVoUMrX5CNm1geR9EkeWG1A+KRXENNW/ivpzgBpLYo4AkaMwlFT/1l/FvGdmk6MX4e8
         qWIqrBOYfB+fBaUgFmuuNevroenpjez8cWAVQaFnBfKkjBpyJ3yB4IA4hAxbt2hvH8fz
         n/cXmoZw2TYu8s6NQKjMM7Xo6m7UROl0vyB56sW4cpTlggtn0WRqV1Ncm6NB+KmBZruI
         on3SU4P1DzsAZj0b9GVqqvyqAGF923JKYrReZAoKKQ88dfPwygtwJeNoazT85wWc6Zdk
         9GBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvrfjo9IRsqBBnq2tMlfjX/hsIpXrFEdHzoAnrEuFK/nG9vrIpbPnfoEa/aLQGCuBJ3eoDmaeOdvjt@vger.kernel.org
X-Gm-Message-State: AOJu0YzQtGvPBoq+P4XDSaYP8L4z59S/GwIonKboc1xHl6r7dEEahiCF
	x9/Lsc71TIr2emgkoaRL4R5pWImfjQoliIsp0HpKNc/BAJJI+UfSmCvqXOvlskUlbJV+AGZnR8f
	OHWow5A3LuaAI2YD5ohve5tvFHj1BlXB9u3uB9p5UMQIBgK1InALZJllEdzM=
X-Gm-Gg: ASbGncstWdYCmzDTz7T5RUOsABN2moSufyZKB47LtFbbv7mS6XtF7u13Th501QVrCaW
	COgdb9GC6FgIE5FP5smrOMXHhCkLWrcOCB9E0UBXNgvUETWwEaLSK9cxQ9AGgvxw4jV19aKtOoU
	wJT8QvciVV31LzR6cBmnjRgdla2t9KZBkg1A8NLmLC0FiT5oc0tf+1AnSGFFZTn3B8yD7f5zB+n
	PoJx+9HHzn1NF48o8I3Whq7Nh/3pJN7ytUUu/6KPnRotcibdODvpqRKa3a9Un87VY38IJkHoSLc
	lqph8U4oQpquP8Xyu4uhW3+upJE/bM55Rk03tlDw1dgnjyhFnlJMT8aK6BkH/jp/jsaU1Iyqh5v
	rbCNx/w8Rg17M8Wlh5Ej6pTiI50Tyuw==
X-Received: by 2002:a05:600c:3d86:b0:439:61cd:4fc3 with SMTP id 5b1f17b1804b1-43961cd52a3mr60414875e9.1.1739528840732;
        Fri, 14 Feb 2025 02:27:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGE2/P4K8BMb25jacqE9tesNpiJRwAuk8pmttt4ogltkz1XhcRLH1qgjw26RrtASRE1eojWxA==
X-Received: by 2002:a05:600c:3d86:b0:439:61cd:4fc3 with SMTP id 5b1f17b1804b1-43961cd52a3mr60413595e9.1.1739528838802;
        Fri, 14 Feb 2025 02:27:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:a00:7d7d:3665:5fe4:7127? (p200300cbc7090a007d7d36655fe47127.dip0.t-ipconnect.de. [2003:cb:c709:a00:7d7d:3665:5fe4:7127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618a9970sm40364945e9.33.2025.02.14.02.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 02:27:17 -0800 (PST)
Message-ID: <ad8ae139-546d-4ade-abb9-455b339a8a92@redhat.com>
Date: Fri, 14 Feb 2025 11:27:15 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] KVM: s390: pv: fix race when making a page secure
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, frankja@linux.ibm.com, borntraeger@de.ibm.com,
 nrb@linux.ibm.com, seiden@linux.ibm.com, nsg@linux.ibm.com,
 schlameuss@linux.ibm.com, hca@linux.ibm.com
References: <20250213200755.196832-1-imbrenda@linux.ibm.com>
 <20250213200755.196832-3-imbrenda@linux.ibm.com>
 <6c741da9-a793-4a59-920f-8df77807bc4d@redhat.com>
 <20250214111729.000d364e@p-imbrenda>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250214111729.000d364e@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.02.25 11:17, Claudio Imbrenda wrote:
> On Thu, 13 Feb 2025 21:16:03 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 13.02.25 21:07, Claudio Imbrenda wrote:
>>> Holding the pte lock for the page that is being converted to secure is
>>> needed to avoid races. A previous commit removed the locking, which
>>> caused issues. Fix by locking the pte again.
>>>
>>> Fixes: 5cbe24350b7d ("KVM: s390: move pv gmap functions into kvm")
>>
>> If you found this because of my report about the changed locking,
>> consider adding a Suggested-by / Reported-y.
> 
> yes, sorry; I sent the patch in haste and forgot. Which one would you
> prefer (or both?)
> 

Maybe Reported-by.

> [...]
> 
>>> @@ -127,8 +128,11 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
>>>    
>>>    	page = gfn_to_page(kvm, gpa_to_gfn(gaddr));
>>>    	mmap_read_lock(gmap->mm);
>>> -	if (page)
>>> -		rc = __gmap_make_secure(gmap, page, uvcb);
>>> +	vmaddr = gfn_to_hva(gmap->private, gpa_to_gfn(gaddr));
>>> +	if (kvm_is_error_hva(vmaddr))
>>> +		rc = -ENXIO;
>>> +	if (!rc && page)
>>> +		rc = __gmap_make_secure(gmap, page, vmaddr, uvcb);
>>>    	kvm_release_page_clean(page);
>>>    	mmap_read_unlock(gmap->mm);
>>>      
>>
>> You effectively make the code more complicated and inefficient than
>> before. Now you effectively walk the page table twice in the common
>> small-folio case ...
> 
> I think in every case, but see below
> 
>>
>> Can we just go back to the old handling that we had before here?
>>
> 
> I'd rather not, this is needed to prepare for the next series (for
> 6.15) in a couple of weeks, where gmap gets completely removed from
> s390/mm, and gmap dat tables will not share ptes with userspace anymore
> (i.e. we will use mmu_notifiers, like all other archs)

I think for the conversion we would still:

GFN -> HVA

Walk to the folio mapped at HVA, lock the PTE and perform the conversion.

So even with memory notifiers, that should be fine, no?

So not necessarily "the old handling that we had before" but rather "the 
old way of looking up what's mapped and performing the conversion under 
the PTL".

For me to fix the refcount freezing properly on top of your work, we'll 
need the PTL (esp. to exclude concurrent GUP-slow) etc.

-- 
Cheers,

David / dhildenb

