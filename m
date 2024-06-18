Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047BA20C5AF
	for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704647; cv=none; b=L5UgdHeuO4CQm3dyiQq5Bv1lzrBVEtAMhCccNtFKMf4pukbw8L/WOo7CN7H/iQWXQVGFRN5E4HdmIG5cfqTQxZY+oaXUNmSKt1EDmY/lcfORLC05GX1IxlH7IlgvFU+zrbRt2ccN6C3vDXnIiTG3qEf8+2+5fn3XbEiPReIkvVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704647; c=relaxed/simple;
	bh=zHKySP+EhAjEhkOM4e6WVbgojcJbC7/esjDgsPt5RJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VORZlMc8/pAaXQ87yWYnAHxQbx3whHtWw1R3oeXid09Wtnk1/FrRsWx9IHJbAIb+0naSGYzX8UjLGBt9pPJFv2RMF5aEMOMFmRIWh6NQfXDDL+QGl/S1iyLJxEA4YJvRVXomNCQlmc0iDWNKWTE6rqQxd/3v7K4ymMT7prnK+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XdrFMMFv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdrFMMFv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718704644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WbXpHb98FLaqgjtCsdMyl1KZ1e/Ur0AIXYqnzGExZh8=;
	b=XdrFMMFv2XK8PupO9k4SK1JsZpObrAEkR1h/g/KVm5JrUw0MXCuHyaF/QUbNEDCKmcZd/e
	lRKyaestCl1DVMtr3d4pob0O28Ux2zEMzF90ilRwSq/wAdp47GEfCrY5Esm5W6Bal+iNOb
	u0SG/ziMTYTHptUDHkj65rzbvgaZ3zU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-J0zTDy-MN2aPwaB79HjBcA-1; Tue, 18 Jun 2024 05:57:23 -0400
X-MC-Unique: J0zTDy-MN2aPwaB79HjBcA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52c989652e6so3729302e87.0
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 02:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718704642; x=1719309442;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbXpHb98FLaqgjtCsdMyl1KZ1e/Ur0AIXYqnzGExZh8=;
        b=KWvgpvZk3HrJUkLMK3IdQoBHT8GbiYD+zCIgHc9hE4r+5jbbIeER023XBm0OMsxm4T
         j5YgFJcMumQwg2uj/djIbAVpBtaOoOZuXwC7JG4+zL+cvHyiS4qX0hyoOddlqkH+D6+1
         HEULI7byKPVynE636kx5+h39osB2IoaJq8ru9CY2VBbkJaqWG5f7YYflo731txyhLBDO
         r53f4yghrl+ijmYIuXpE37uVAfV0aAZ771mRH7J6w2yXSl3GhPnlyZvCtLNuEqwRsPu6
         JvmLW5SZ6fnTXlbC4xQIg2/hjzn1olhC8NurK47uQ+E/PlqBphbJwIuDEajzEGmPvRMk
         Gh3w==
X-Gm-Message-State: AOJu0Yz0dEvvIc8O+fHTBHy9eqbznxQ2P3ntCg4wa0uwko9UMhm+ECOj
	q0Gi5r9rMrMwpk5g6A8Kz2F8DeuXEAVB9hKsHOpycCv5B69gzGG2tLFM71733EQDP+S4ZcH7cDr
	zw7HwjbSvKsBTzcxW9NWabkb8ss8AgLYVZ2ypib/he6iNizEYJS90e1FEYgs=
X-Received: by 2002:ac2:58e5:0:b0:52b:bd21:eea7 with SMTP id 2adb3069b0e04-52ca6e9a4bemr8845385e87.66.1718704641731;
        Tue, 18 Jun 2024 02:57:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR09GmuA97h360mswfj4ZRjZr+Cfz9q2tgOxitakWoOPfHa/LPgqv0uUKMzXBacQAhJWUUJg==
X-Received: by 2002:ac2:58e5:0:b0:52b:bd21:eea7 with SMTP id 2adb3069b0e04-52ca6e9a4bemr8845372e87.66.1718704641251;
        Tue, 18 Jun 2024 02:57:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1400:78ba:c2d2:22a1:8858? (p200300cbc705140078bac2d222a18858.dip0.t-ipconnect.de. [2003:cb:c705:1400:78ba:c2d2:22a1:8858])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a6c1sm184681675e9.40.2024.06.18.02.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 02:57:20 -0700 (PDT)
Message-ID: <75ee1ec6-12b0-461e-9dab-6fb6d5cc235f@redhat.com>
Date: Tue, 18 Jun 2024 11:57:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/mm: get total ram pages from memblock
To: Wei Yang <richard.weiyang@gmail.com>, agordeev@linux.ibm.com,
 gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
 Mike Rapoport <rppt@kernel.org>
References: <20240616013537.20338-1-richard.weiyang@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240616013537.20338-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.06.24 03:35, Wei Yang wrote:
> On s390, zero page's size relies on total ram pages.
> 
> Since we plan to move the accounting into __free_pages_core(),
> totalram_pages may not represent the total usable pages on system
> at this point when defer_init is enabled.
> 
> We can get the total usable pages from memblock directly. The size maybe
> not accurate due to the alignment, but enough for the calculation.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Mike Rapoport (IBM) <rppt@kernel.org>
> CC: David Hildenbrand <david@redhat.com>
> 
> ---
> Not tested on a machine, hope it is fine.
> ---
>   arch/s390/mm/init.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index e769d2726f4e..d811ffa5e147 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -65,12 +65,13 @@ static void __init setup_zero_pages(void)
>   	unsigned int order;
>   	struct page *page;
>   	int i;
> +	unsigned long total_pages = PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
>   
>   	/* Latest machines require a mapping granularity of 512KB */
>   	order = 7;
>   
>   	/* Limit number of empty zero pages for small memory sizes */
> -	while (order > 2 && (totalram_pages() >> 10) < (1UL << order))
> +	while (order > 2 && (total_pages >> 10) < (1UL << order))
>   		order--;
>   
>   	empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);

I suspect that this is good enough as an approximation for that purpose.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

