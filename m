Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276B405DA
	for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954112; cv=none; b=cp7Vbhl8PNzKbMU3F5ynYFhWM85tgX7qEj2Bm0Lm89ehYGUVTpbZewgujh5M2sd4dJ1EzfMbnRVxBvIOG6exrC3dllWqFtKfXy+ZK2Ki/mDJLtzTQO797DgFE4oLogmud8KpmYjxvuoJdwJgeIq6lKlyWEaLFqxYhBoQBwNUCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954112; c=relaxed/simple;
	bh=z5uM5OZjv/G1w3yuWwSEb6giYuSWp5QrDCaBnZEn+yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbHRUglwpEL0zmsXlbM64g80ncifGIxYPYkWh8K4dAd89tAz2voOQ8W7SIlZF6G/RTpg4Z5Dymq/kztbr88KlLQ2cmwAh51vIUFBioAlKmQc694egXtufnkxhKaOYHNeKjlYOSvVJcvYEj0DWAFiHfGpDyvArbog0nPB3ZnaTfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LeEQBGEE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeEQBGEE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705954110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=74vQSZ9Ib6W2cdwmSu4B7EOliPKMRAyQqJMwdDwvZic=;
	b=LeEQBGEEZ2f9UL6FzLIbO2BRIZZw8RErJhCVKYm1p9ZmnYPl6kJwnggPIOoSOgZ+nRpWay
	DV3SZgjoXJSSPVulYFa91Kce3vJo2s4WoiIb30NTZmwDS112+61Ih8Audq5VW5Ju26pLbR
	6AGRHiYsS9FaVYTLIlZ0ymLzbIH1J6Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-vJP2BtnhND-K6WIGOkCC8A-1; Mon, 22 Jan 2024 15:08:28 -0500
X-MC-Unique: vJP2BtnhND-K6WIGOkCC8A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e4f70af99so33305805e9.2
        for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 12:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705954107; x=1706558907;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74vQSZ9Ib6W2cdwmSu4B7EOliPKMRAyQqJMwdDwvZic=;
        b=GhaGNjD3L2dP3FciSYGQLjgn9Cpj9GLafsPr4fBarlDeIWHurlmNvhw0w3e2f+jdZS
         1DedtHUv8l/MaaIp9ZeCMDukrIZfWYhAKyMhNVgnxzVYCW//9l70bwQG6Xw6DbN2CTlB
         kGvgq78AOACiVT3+mIuLh5pcZu2WSvZucqZNeWbWFehSBo3cgld89+ByZIuWUFAEYix9
         b0HLx3G7rrLZcgBBVCI9wu3OF83fHFaBHx9cx60Zh1Mwt/9lKln/QgUhtW7odBNxtTEo
         HM9qfdKgko3nCPj0LaZEBUoZNZuf228zHDyjgiq2T8QoBwllUhjcwllQUMqcwNy5GDgV
         /JEA==
X-Gm-Message-State: AOJu0YzXbKbI18vAApJ83jmy65o8A34wOzxBBT7/M1RqQsIQiR8S5ELF
	sNnJ7eQMYAcVXNtCsfh2mLtofV9y4CB3iC7N3Pnm6V4Fe+COweU6IMPtmEmfAikxZJZbupSIYii
	lYPokpJxv+x+OZoGNOkwbaE3xmhCGdLN4M1Jau/qW9p97rYlSscMznM1eipk=
X-Received: by 2002:a05:600c:4f4a:b0:40e:b207:37ad with SMTP id m10-20020a05600c4f4a00b0040eb20737admr585134wmq.130.1705954106935;
        Mon, 22 Jan 2024 12:08:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK8OlAl3XA9eIoNh6f85JWWWd6CdUDvuraIncansW9lJ4yoYjQun4BKcSrDUo/pFZGmSKIpg==
X-Received: by 2002:a05:600c:4f4a:b0:40e:b207:37ad with SMTP id m10-20020a05600c4f4a00b0040eb20737admr585125wmq.130.1705954106524;
        Mon, 22 Jan 2024 12:08:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c737:f400:b194:1841:c4a5:75f5? (p200300cbc737f400b1941841c4a575f5.dip0.t-ipconnect.de. [2003:cb:c737:f400:b194:1841:c4a5:75f5])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d4b10000000b00337d4eed87asm11594671wrq.115.2024.01.22.12.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 12:08:26 -0800 (PST)
Message-ID: <01aa95ee-0abd-4d65-b03b-2191285d1ac3@redhat.com>
Date: Mon, 22 Jan 2024 21:08:24 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] risc: pgtable: define PFN_PTE_SHIFT
Content-Language: en-US
To: Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-5-david@redhat.com>
 <5601b896-f67c-432d-a169-0f08928123fc@ghiti.fr>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5601b896-f67c-432d-a169-0f08928123fc@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.01.24 21:03, Alexandre Ghiti wrote:
> Hi David,
> 
> On 22/01/2024 20:41, David Hildenbrand wrote:
>> We want to make use of pte_next_pfn() outside of set_ptes(). Let's
>> simpliy define PFN_PTE_SHIFT, required by pte_next_pfn().
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    arch/riscv/include/asm/pgtable.h | 2 ++
>>    1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 0c94260b5d0c1..add5cd30ab34d 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -523,6 +523,8 @@ static inline void __set_pte_at(pte_t *ptep, pte_t pteval)
>>    	set_pte(ptep, pteval);
>>    }
>>    
>> +#define PFN_PTE_SHIFT		_PAGE_PFN_SHIFT
>> +
>>    static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>>    		pte_t *ptep, pte_t pteval, unsigned int nr)
>>    {
> 
> 
> There is a typo in the commit title: risc -> riscv. Otherwise, this is
> right so:

Whops :)

> 
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

-- 
Cheers,

David / dhildenb

