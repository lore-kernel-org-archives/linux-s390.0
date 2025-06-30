Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6328C031
	for <linux-s390@vger.kernel.org>; Mon, 30 Jun 2025 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751313582; cv=none; b=YzfeIuICBHjUlpLDtxvbndIOG3H89t4ApmNY2YwFyf0FpBxK/QATQ5ARIPIFQpoaXGvnLIBGDhy2knEW+cq0silDDm44jlB15xcITPqXw00KJigKWFvvrGWhmuq0hl7UsNoE6lyWWSwrGS7GJWEQz2+4/Wl3vPnCoxagd1K4wvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751313582; c=relaxed/simple;
	bh=bEyFQdROXjvQGTSACHDcdffQHMnpw3tqIfURRH6j37Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmLLuRziXvtOh7+SwuXtDlcQgez3CmCpybwqEEXlIb8FysXqQPRTT4FedJG7qj5cGWV6qyRbwEpwupHA5+1Nt9CJx6//zimIrwVCIMRyDBCJquGZNOyHEFrLHzm18I49IqLzBvT95zrWuIIltbxt8mx9rDTtI+eEauIq4lK0RqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wj9fAl3D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wj9fAl3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751313579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HdrBjyR4v5jVUYn1vKqc34BfB7r5dg0swuUmPBgV3KI=;
	b=Wj9fAl3DsBuU862Kep3P5kZi2EXeNrdTTm6w/rIiiwJnexTL/AvmPgrG8bQHq9fyBcLEMW
	J+x1hG46/P0ofW9t7FwK7atBHjghomDeq9Ijwrqrse0o189tjHBQueyGmct5/+w+eaTf3+
	YY23s/C51g3R4PZo3ZBEtzDfDo/xeG4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-4tT1P9GaM4-_98fA4euDLA-1; Mon, 30 Jun 2025 15:59:36 -0400
X-MC-Unique: 4tT1P9GaM4-_98fA4euDLA-1
X-Mimecast-MFC-AGG-ID: 4tT1P9GaM4-_98fA4euDLA_1751313575
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so23087905e9.2
        for <linux-s390@vger.kernel.org>; Mon, 30 Jun 2025 12:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751313575; x=1751918375;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HdrBjyR4v5jVUYn1vKqc34BfB7r5dg0swuUmPBgV3KI=;
        b=uHslQ3jQvBpKzP+jCRXZJIr0GaAmnXy/BHQrOTkMO+wNF5z3f0CX5p2VaBrCPg9mvi
         NgJpeiFtkNP5dBM39wj/HLWZoxztZkvBC2I1vsQLnAoF41KCF9YYvlN0Z6sda8CfZjfB
         yxD6iF9br2Yp0RraXWnf0NsteO/SKH7/GdlbC9F1sOy0IWo9EYcu4T8GjXE5m+QEGlpV
         ZV3Cg7r+0ONfSi6Y5Bff5XxuKE7vuCBnoLnVxGICSjheYMXZhv3SW+3F6w/kawNFjvla
         nXBPARz5APJpBc7ZKfxrqO7OuxcZGwg6Ul1Ge5NTvOUzovcdAugkc6XueaXa1EfnXNEt
         OxDg==
X-Forwarded-Encrypted: i=1; AJvYcCV8mezCDABAua2q+VYrrxnZa/Hge5CGcaNEAJ24KIJHl07sBtfPPoEKLgpPL+XU3D6eCQBWm5dwFPdN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5wp8wDKtvBHeb4aOZbtmE53IKLHPLyZAcH89Jndf72gpgE+vo
	8ww8LYrze3ySHC4Sz4fhZR05A/sxvklywdwP512Itz1hwQMydMCG4/aDW3cBY91NUmga02s/+Q/
	cFM09E5sRCnenUmbBxSe+ZNX/wBkvueBz/m9T0f4EgUAeuwQNZFDdvwCzmK9sh4I=
X-Gm-Gg: ASbGncv/m3Me7dteWynd6RD+uJz3bauzCDy40c5xs9faiwln8N+AQiJ2e+BJNCFaPYG
	RT7VfvrEmX/jwGDJvXkBJhdrCAScWQQ61Hwipg21cLgZunJqcX2eNVEueyR6ozQnmYc6DCTIgiH
	L98O3odcWU9bggBpal8lEFZsDQeGfuFWKt4FCEHEEubcHwX/ko03BZ+HnMojXVEbQs2mYj8AMr+
	vza55dxOTQT0srcEZr2f1hGnRgbKz/YgedbquwwHSXHZ1sk3/rb4pV97jHIONyfTrTrtqgWPh11
	qeYBJPm95bfSDA3WMLKUlZJwcLAaOe5nFKPlFX/DxEGBkvj2dkaZ+JOWfKKRbi8T2HJpnXbPzlt
	75e052b0HDQdrnN7wTFYLRHGbvDXz/OeZGFf8v8LAfdfBS3UUPg==
X-Received: by 2002:a05:600c:4f91:b0:43c:fd27:a216 with SMTP id 5b1f17b1804b1-4538ee62323mr136097465e9.23.1751313575155;
        Mon, 30 Jun 2025 12:59:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB25voiAoiR44h3/h5Hyv2OovvDqu/+y6RXHR7m45D5JHSU9OHh2vv9oqZJUIAD+vuFLCH6w==
X-Received: by 2002:a05:600c:4f91:b0:43c:fd27:a216 with SMTP id 5b1f17b1804b1-4538ee62323mr136097265e9.23.1751313574715;
        Mon, 30 Jun 2025 12:59:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f40:b300:53f7:d260:aff4:7256? (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad1adsm175294865e9.24.2025.06.30.12.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 12:59:34 -0700 (PDT)
Message-ID: <5e878654-e00e-4782-bb99-b460a93dd6ab@redhat.com>
Date: Mon, 30 Jun 2025 21:59:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/debug_vm_pgtable: Use a swp_entry_t input value for
 swap tests
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 linux-s390 <linux-s390@vger.kernel.org>
References: <20250630164726.930405-1-gerald.schaefer@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250630164726.930405-1-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 18:47, Gerald Schaefer wrote:
> The various __pte/pmd_to_swp_entry and __swp_entry_to_pte/pmd helper
> functions are expected to operate on swap PTE/PMD entries, not on
> present and mapped entries.
> 
> Reflect this in the swap tests by using a swp_entry_t as input value,
> and convert it to a swap PTE/PMD for testing, similar to how it is already
> done in pte_swap_exclusive_tests(). Move the swap entry creation from
> there to init_args() and store it in args, so it can also be used in other
> functions.
> 
> The pte/pmd_swap_tests() are also changed to compare entries instead of
> pfn values, again similar to pte_swap_exclusive_tests(). pte/pmd_pfn()
> helpers are also not expected to operate on swap PTE/PMD entries at all.
> 
> Also update documentation, to reflect that the helpers operate on swap
> PTE/PMD entries and not present and mapped entries, and use correct names,
> i.e. __swp_to_pte/pmd_entry -> __swp_entry_to_pte/pmd.
> 
> For consistency, also change pte/pmd_swap_soft_dirty_tests() to use
> args->swp_entry instead of a present and mapped PTE/PMD.
> 
> Link: https://lore.kernel.org/all/20250623184321.927418-1-gerald.schaefer@linux.ibm.com
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

