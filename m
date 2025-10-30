Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136903271F0
	for <linux-s390@vger.kernel.org>; Thu, 30 Oct 2025 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837042; cv=none; b=lldxMp/z+U/oyiRcAReOpvkveXfUoCrpNBsTo37SrGrJ9+x3M8I96NCzn/dhdE/V3dQCiHm9tQ+EMIqvD+UefWJke7m9pkhFjYZQC/uAdnAnHFcCWq2TFvGPksxNA2qiGaS7Iyl026knIlbUcVMThP+Vec+ErRHhzJSt/5tQvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837042; c=relaxed/simple;
	bh=iDmEJBVp46fcT0CkdrnVmOa5uOg5MoMhiqO85juqzGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpevuIXgbs9gacjYIEFPX8DKJ3OdTm7ICFC8MtWHotmEl8g2XhoKyNzKFodMQV2q5aOTUeVpWIJBVtxLWWVM8KsD5VKA7Wdi21TmSFCc7I0oH813kcbGORminVEbkFWcvwebEliN1BWrDamv2dhhJy1q/0cCuWx/WijB9SDF2NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3CAd9i6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3CAd9i6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761837038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pDCQK9hlLE+TETBGIIHqM4Q6IjU8KzujqNQtOJ112xA=;
	b=Y3CAd9i62NCHZZf4p+nrk2n3JrFmNxmuarSZpxR9VAeddiHfD1viws1ZvX0PaHHjoEKSwh
	LMjViDd1bDi48ZNtZtEaRcur59M1KWlUwJ80p+QUiaG1K0FG7eiZnNjqQWqX/81uk/BooW
	VbV26G7loZFXY6+F0EwOGwrA6/0pP5o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-8vQHxhTfPcuK_Bk7JUcfWg-1; Thu, 30 Oct 2025 11:10:37 -0400
X-MC-Unique: 8vQHxhTfPcuK_Bk7JUcfWg-1
X-Mimecast-MFC-AGG-ID: 8vQHxhTfPcuK_Bk7JUcfWg_1761837036
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-427015f63faso708950f8f.0
        for <linux-s390@vger.kernel.org>; Thu, 30 Oct 2025 08:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761837036; x=1762441836;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDCQK9hlLE+TETBGIIHqM4Q6IjU8KzujqNQtOJ112xA=;
        b=EBx5exoQSE5elfBotHXHiR6uhEnezkQg3VWgTzcRt54nLgiuuZPTGmXLdWoUHCDnrw
         4sCOCwjYRwLxfbD//8+CrmNyFrNcZpzhVp73GU+Ohlb6EWmo4HEvEPQi1VhZU7SIHH2i
         ivbilosGUCPz+tMOo4yBBAe/yR7YKG54VYrAfj7QsuP/yr1v159jBXAOXHg8Ym5ojmob
         zROOQtrIxeKrZZMnBhQ/J2R1y1xih6qbbkSCAASh73J0f4m8iPBGGgs8q+Cj5Pc/dr2Q
         jdEOA+LATb5YBNclw6iehXdSj/beE4/a01R5/CEn16O25DuUmUeWtBucAS6DYg5HC47y
         SAyg==
X-Forwarded-Encrypted: i=1; AJvYcCWdm4o+xapRiKDiZUi5DqG4kem+iCd31n2jkaxBBIg1t7SVjI4j3bT72BVcnXMWiqGxMeOz0fFd3zrG@vger.kernel.org
X-Gm-Message-State: AOJu0YzEQXR1Vb2qVsdQ1dMGUmDc/bauCNYB/S6ROaRnO+f4m/UqG/ks
	8Gs+WrAZbT1DVFi7XkS87N/+BuEh6G7yS4lzzoEHAbv0S8RE5HZGcYeL4qY6sRpv58/2s8caOkI
	cFiyumF1RB3JHNA5NlCXRYC0C4NtGh+quVgDBZXdBp393aE21GD3hCI2K9D+dcVk=
X-Gm-Gg: ASbGnctmNzG6vLaAaR32ZoEzN7wp1RnP8sRuIDCrlQ/RnaF7WLrpqxp7jmL0JbrcA+i
	Re6+oRyO7/T3dFz9wcXY+Hrs4bDYUumu20GY4icpeUfClIP1P5y/mftxA1dPiMT9ogLrXx1MhVU
	UkAmDesuv+ohUwXk4LlTw3GOjk+F/Nvu5MYBSSytWC87WepZMLdYK+n+AfMYOyzku7+VprQskE+
	UxrwWTnmpq8qw2+iGEu4YM0u63T+DQfhfiHSLJfM3M1WLfQtTU5PKE1G1CzQXspgwHb7dghCZNs
	o5yDEXYrNcO3r6zuQpCofemGCppx6PBxyFQzvtOun2HN5yAHrVm93z1lYsHmhQoxHXhdp+b5iPq
	6XEx7uH16ygPhcaWudRFg6L4uKWQ6G4lxb9iQHPg1OI0Dr0XiWUE0oM7T5m0KrNvcsQ3vSR0gBv
	F3xm4/di96iAQU3guYUC88hB/6uFs=
X-Received: by 2002:a05:600c:6389:b0:477:da4:364c with SMTP id 5b1f17b1804b1-47730797bcamr672105e9.4.1761837035739;
        Thu, 30 Oct 2025 08:10:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4KUGeZbzNKm7MNGtt8D6Fso8lLniBFswbKsZjSsZ0KgGlb6Xh2MXwXuc5z8HUy7nMGWyBeQ==
X-Received: by 2002:a05:600c:6389:b0:477:da4:364c with SMTP id 5b1f17b1804b1-47730797bcamr671735e9.4.1761837035238;
        Thu, 30 Oct 2025 08:10:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429bb752b49sm1353322f8f.9.2025.10.30.08.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 08:10:34 -0700 (PDT)
Message-ID: <4f68e609-a40c-4844-ad40-9ed31c88adb4@redhat.com>
Date: Thu, 30 Oct 2025 16:10:33 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
To: Heiko Carstens <hca@linux.ibm.com>, Luiz Capitulino <luizcap@redhat.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, osalvador@suse.de,
 aneesh.kumar@kernel.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org
References: <20251030145505.2764038-1-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251030145505.2764038-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.10.25 15:55, Heiko Carstens wrote:
> As reported by Luiz Capitulino enabling HVO on s390 leads to reproducible
> crashes. The problem is that kernel page tables are modified without
> flushing corresponding TLB entries.
> 
> Even if it looks like the empty flush_tlb_all() implementation on s390 is
> the problem, it is actually a different problem: on s390 it is not allowed
> to replace an active/valid page table entry with another valid page table
> entry without the detour over an invalid entry. A direct replacement may
> lead to random crashes and/or data corruption.
> 
> In order to invalidate an entry special instructions have to be used
> (e.g. ipte or idte). Alternatively there are also special instructions
> available which allow to replace a valid entry with a different valid
> entry (e.g. crdte or cspg).
> 
> Given that the HVO code currently does not provide the hooks to allow for
> an implementation which is compliant with the s390 architecture
> requirements, disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP again, which is
> basically a revert of the original patch which enabled it.
> 
> Reported-by: Luiz Capitulino <luizcap@redhat.com>
> Closes: https://lore.kernel.org/all/20251028153930.37107-1-luizcap@redhat.com/
> Fixes: 00a34d5a99c0 ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

