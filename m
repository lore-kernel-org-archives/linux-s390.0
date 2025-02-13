Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B6324A068
	for <linux-s390@vger.kernel.org>; Thu, 13 Feb 2025 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477839; cv=none; b=XO9QnvdoC/RtziodU2fV8ocE7+qHPGaq+xS3RRX9Toon/+Dxum/kNfVvVsb9Qokh4NwOzpqqL77GCdn30MmLgktxik2CpJmWWXpAcJ+cGQHS/LaJ1l29h2n+Dk74j36F3bPNng32SptGfuoEzWHCoR6x4un7kulhAvpUEugknt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477839; c=relaxed/simple;
	bh=HoQdF3QeQ4LrH7HA1RKzuYHX+mrbRfrzTEJLz+xuTIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFQs2gVW6mviWeI3dVvOVNF6S+kwSk5MB3X22u/E0DcT6uwe4KkU5yWUGRiaZkWwG2fHn8yhWDieh48hINHUBur8AVzoDRmoqE1l33WAuJ1Awshl4Hv/7+E3XzrWkrQuVlaxVFBKr6YdEku4gD0SpWsZZGejkfUwUPrfIngqUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOEqPbol; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOEqPbol"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739477836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BGo3+h2k5TPDqtNzkqC5kdvh2J3BneuEnbq2jY5Hj3I=;
	b=gOEqPbol43kNusgfcxQPe4mlec58buuufXt2GRSWUt4bkciC8PQMGtdKeZZXv7NyaIhEtV
	E+X1Rqr/ad78h3J9iyHGPqlVhf/sBV77zqLz40eEQGeRTf7QOHaWL7tfDCLWoah/sN2t6+
	liyVSZ4xP+KTEZAeQJq4CXmA8VrHHt4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-KoOb8nQ5P16BKUKOBjiGgg-1; Thu, 13 Feb 2025 15:17:15 -0500
X-MC-Unique: KoOb8nQ5P16BKUKOBjiGgg-1
X-Mimecast-MFC-AGG-ID: KoOb8nQ5P16BKUKOBjiGgg_1739477834
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-439605aea5bso7188995e9.1
        for <linux-s390@vger.kernel.org>; Thu, 13 Feb 2025 12:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739477834; x=1740082634;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BGo3+h2k5TPDqtNzkqC5kdvh2J3BneuEnbq2jY5Hj3I=;
        b=Ckjz06hiLfxnMw+acavfbSj8/LjHXqJ+SzOkUYYWKc8lMO1fw0d9IOT7ItX+zAaN8a
         27lwB+fsQH+aCXcW4jU3vz9GcOZ5IuS1DVA9QI9z6wacpGK5Eb3N4kT/1hq/agGZAbJH
         hxRBgpGCKBLsY9ZQc5yFipV1voIk12Z8SIWhzDFuPZQAib7rLwSFcm1hsv93ZFsMXGvT
         MR+bq6ljJDaJAQwIxTKfAp0+zv+cL1zGt0Fl97XDGR9wzpekRCnkOfaQGhgMVbDoNVh5
         OdiNh6Lx/yvPSnyWAX+bdy+OLpCdTqFDmkax6KbcX5NcmNC6WmMns4W8r9GSxwqbc5s6
         MgIg==
X-Forwarded-Encrypted: i=1; AJvYcCVuXjcaYfjsgX5XAIWVR4XZV8ItSvbYPc2uLVtLHXsdk8Osx4hSnovaCrN8tefqo7dBCazONL4sxBsK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+pUvaYoocy4ZLyLUXBbCd57UBu3ErulouSFiD+ZiW4h5WN1p
	P23aLekTCOrQAoDBAreyMtDNzUPguy6j4m2KgIAcK02CC6U2fVNriEbJXCxFgbZpbrr6gvuLJHQ
	EQmwK+YH1SRhHqQFI1ru9QVnrT8AKN0u1/CAC33qIyJ2puTYoaJ5NL1+8ce0=
X-Gm-Gg: ASbGncu4oh+Nme+uzwrlyT/WPv+WfkJpklypmuWWZF3ZxKZzdgPMBI5hQYdQX/GxLZ/
	5Y0tGdNrDH/UgSo9jxXwW8cliJJVzw9cifxmrO0Nzyd7020dMkSUziRPFVE+ixqGoF948+aWJ2/
	fOs35ggAw238OP6C9/+rpVRdAoeBGReYzn7xKxvFtjj02IzHYwsZF3JOr6Klp8ccMWYiW3CZOj7
	hZ0f37+Gv1F4o/aoCWBWJxchPJbM7e9gWFF5/9e5rw51adiWFLYeDHfvuLCsYAkrfyRaLEs5CFR
	y2di0dL5U47p0YY4qk38xzMSUrrKv/kNZm8=
X-Received: by 2002:a05:600c:1c84:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-43958169fa4mr113436165e9.7.1739477834099;
        Thu, 13 Feb 2025 12:17:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOwQrzMx6mzF34oagv4phSuZe+sFnsgm7REJuXPhoW4eKwVPGPx8edkZ281TMbOD8fUrHCnw==
X-Received: by 2002:a05:600c:1c84:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-43958169fa4mr113435915e9.7.1739477833820;
        Thu, 13 Feb 2025 12:17:13 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6c7e.dip0.t-ipconnect.de. [91.12.108.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f217sm56924685e9.1.2025.02.13.12.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 12:17:12 -0800 (PST)
Message-ID: <e58310a9-0fd7-44fa-b66b-b98502dbed30@redhat.com>
Date: Thu, 13 Feb 2025 21:17:10 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] KVM: s390: fix issues when splitting folios
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 frankja@linux.ibm.com, borntraeger@de.ibm.com, nrb@linux.ibm.com,
 seiden@linux.ibm.com, nsg@linux.ibm.com, schlameuss@linux.ibm.com,
 hca@linux.ibm.com
References: <20250213200755.196832-1-imbrenda@linux.ibm.com>
 <20250213200755.196832-2-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250213200755.196832-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> +	struct folio *folio = page_folio(page);
>   	int rc;
>   
>   	lockdep_assert_not_held(&mm->mmap_lock);
> @@ -2645,7 +2646,11 @@ int kvm_s390_wiggle_split_folio(struct mm_struct *mm, struct folio *folio, bool
>   	lru_add_drain_all();
>   	if (split) {
>   		folio_lock(folio);
> -		rc = split_folio(folio);
> +		rc = min_order_for_split(folio);
> +		if (rc > 0)
> +			rc = -EINVAL;
> +		if (!rc)
> +			rc = split_huge_page_to_list_to_order(page, NULL, 0);

split_huge_page() ?

But see my reply to #2. Likely we should just undo the refactorings you 
added while moving the code.

-- 
Cheers,

David / dhildenb

