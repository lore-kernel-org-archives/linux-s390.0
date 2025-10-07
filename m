Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B6C2E0915
	for <linux-s390@vger.kernel.org>; Tue,  7 Oct 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759866006; cv=none; b=Wrj3nlbamjLQKRLPnkWc/lenUXPvoT/CJuJi5+9DqCOeoN+yC3plWbNviaaGcd0hKXo5S9MV27OwK/KW0SMk0hNaOBhacc6Uy4DEpzGO/yqHpOfuDuFn6aupfD8Sj4NRAZ2Yky3EwRN/m5lgSWEF0UKTlRSs7wnDnS4SyVAPEzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759866006; c=relaxed/simple;
	bh=Udd/yjrW9L4anOjlghUyo9BC8Qll6R5LcXpuy/V6dpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdL2BS7ItDNGNLIzUDgAtFUpID0EcTUzYnS44mLYAj4YS5ex+eCu0IcuAZ8ETAhX8tUO07Kur25BwYVMs7hcaqFfOe9undiMA9GXU8eeC/YcMk1HMH8jeU2g2RRcv9l7IMlalew0vEHwlMxlry4FgsjwTQMqhwqBQua7i+VXM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLbRAgEA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLbRAgEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759866004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9VumtYpTrX67AUkgEfTTMEIc6RIxe4xeW3+00mS96fE=;
	b=LLbRAgEAj1e46bGbVdT5v1q6fAGB8MoWpd0IWGt/bbTUxzJIbJKF0CBoyAOuAYGpVCGpib
	04x3rvGBd9hocRMtgdNoxhBXlln04nnA3TyNLw6AMRLvkGDDeJXUA7zhw4VEQhTDpTQZvv
	MavXXd1CCh4nWrat8S/xCy5YFhsyJgk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-roCyjjiJNw2v2uw2jw5scQ-1; Tue, 07 Oct 2025 15:40:02 -0400
X-MC-Unique: roCyjjiJNw2v2uw2jw5scQ-1
X-Mimecast-MFC-AGG-ID: roCyjjiJNw2v2uw2jw5scQ_1759866001
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3efa77de998so4021117f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 07 Oct 2025 12:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759866001; x=1760470801;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VumtYpTrX67AUkgEfTTMEIc6RIxe4xeW3+00mS96fE=;
        b=QW7WnWNOWrNxSvEjtEtXYvbr0wDirn39FHSM/SYq+pBj3h4f8ukB34RmqTInmACnVs
         rxmkBLjhYTgC6LBH6/0kISyuhy+W+MhqaDuQd4OMGObamRPc1CqhxE8rrsRDz3w/yhJB
         cJ/6f2uyliM+7Hgksg/HYnAznT0Hf68gqtVdnRo/0XErsMZ+XEE9mS+hvmLiqc2NC5R3
         93arwTLo86NmPj/rkiD0CnViPY2wL7RMrdfpC0g1vXRDqS43ylqoDO7rs8r1CCCZH/08
         J1WRaJLs0mz+pRRlZBtT6ENfQDwl2JBqnWGsZ4iMODqkayy2mhwmfO66Y8vPHuVF0wHf
         5BQg==
X-Forwarded-Encrypted: i=1; AJvYcCXGGS3U8+HMuLJg5ilnn+rTn+6aKZamTjBwuezO2hI47Yx0Rs6HbI9G7JYcQsv1a2/XScV5OlB7aNNg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5wzyMS+uwCxVyKukWjK5FROG3DSopnUVceXZtfpOo6PAXEz+
	PDxXiPjF6omkvEbRnBM4hRfRCu2a+MKEt6zvvQsM+SrTr80rSUMSnHCS1hD6udEL447CuunloVL
	62vfGRfBiO7CQoJi55U+J91yHb2Wb049a7fKaP4d9Q54IRfWub1JUvMLjBpa/grY=
X-Gm-Gg: ASbGncu6Ajz2Wi0JS/EdH2DRb2xM91xck4gExI4Dvz7talsPXIOEkv6IkctoR6dsBMV
	h0edjxQkNtozDphcAwgETd74vCRPGBd3WpOcF/1miDu3cnuY+lPVwuTm90lvyqhdrLXRz10IRw/
	6y3Lf6z7vej+SRQZ9abXLag8yKfR7yrYrOlQ8gqjEYPnn5WRZ0wGjMzq9RrbKvb5iADp0DgaxQ7
	WghoqHZXQ07VR+8RCZdJMBtNwXbtU0/2b+Vuh7Xp6HAsG+lFSjWjiZWFDOm/7L+J5pp3y0l5Uie
	87b+XPVUmLo5J3zwjMIe5mx3tRF05Waex+DgPOfGYnVMO7yJ9CbciApCMOhgTqhU0jdfb17/muF
	qS29UWPzq
X-Received: by 2002:a05:6000:208a:b0:3ec:42ad:597 with SMTP id ffacd0b85a97d-4266e7dff52mr302898f8f.37.1759866001467;
        Tue, 07 Oct 2025 12:40:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEej/svesPDrHY997doiJUMRsBCaL4lMY/21dpeNKaxMJMF1Jf9ZuSBWRwx+hr9s6QqrTCUyg==
X-Received: by 2002:a05:6000:208a:b0:3ec:42ad:597 with SMTP id ffacd0b85a97d-4266e7dff52mr302886f8f.37.1759866001067;
        Tue, 07 Oct 2025 12:40:01 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c2a39dsm7457035e9.18.2025.10.07.12.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 12:40:00 -0700 (PDT)
Message-ID: <ba392005-8cb1-44c6-a4ca-7608423fea62@redhat.com>
Date: Tue, 7 Oct 2025 21:39:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] s390/sclp: Remove MHP_OFFLINE_INACCESSIBLE
To: Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
 <20250926131527.3260733-4-sumanthk@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250926131527.3260733-4-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.09.25 15:15, Sumanth Korikkar wrote:
> mhp_flag MHP_OFFLINE_INACCESSIBLE was used to mark memory as not
> accessible until memory hotplug online phase begins.
> 
> Earlier, standby memory blocks were added upfront during boottime and
> MHP_OFFLINE_INACCESSIBLE flag avoided page_init_poison() on memmap
> during mhp addtion phase.
> 
> However with dynamic runtime configuration of memory, standby memory can
> be brought to accessible state before performing add_memory(). Hence,
> remove MHP_OFFLINE_INACCESSIBLE.
> 
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

