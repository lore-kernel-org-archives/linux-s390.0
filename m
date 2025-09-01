Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB4338F5B
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735102; cv=none; b=AVV9IkjqFN+1ABkvmfmF7JnZ1cK+X7qkS78LCOxgihB/b+0l6DNhsMZdH83jPHPjdREUo/kiTjBsg+3cPgToSsobNTd7mf1HXahLw2NxaVsajtUJwoXX2OsLwLDmsdK9ox927KxINg9gLBZFVe0caqjLqFVZPxXuYd9qMn4APx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735102; c=relaxed/simple;
	bh=BWDUSuDVWAcV6ssqnXmQLrpXsFYZAiCIUF1sPpSZkrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f4cAKaBj+jv5yedaofSY55oJvhe2VcUN+wFJ1HclgqPrWrweL7N//h2eq84UNz/7I/znMuD8TreHXCAiGxj72joWQBmcp4fXw0zO+UmI1HNZ8lY7Hw6vTUTnVS1rX0KuhhIa6sgQkacIsdLTzlJqauw2A2juEib1RhZHR4QaGXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1O1aBhK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1O1aBhK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756735100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UPcea11oImlNUykreQKcnkewIQP8bQmzD1K+RUPYzZM=;
	b=L1O1aBhKdpM/Ayv+J1wSOgTHwSGQa/qOA3G4o3xhDUkoL8Og3LZHlh2WWy/EbBStwAWddu
	yNcP30RSc6kfUAqR92o6PG3N9JWX+0lKpkvnkk0YxzUcPYB+4/NFQ2GXqkze6bSq++Wr3r
	oiKbrKBBbUg5fHQJgI1shHrky0aIZ8U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-_zgIGebePV-TYH2EdDko4A-1; Mon, 01 Sep 2025 09:58:18 -0400
X-MC-Unique: _zgIGebePV-TYH2EdDko4A-1
X-Mimecast-MFC-AGG-ID: _zgIGebePV-TYH2EdDko4A_1756735098
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b869d3582so9355245e9.1
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 06:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735097; x=1757339897;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPcea11oImlNUykreQKcnkewIQP8bQmzD1K+RUPYzZM=;
        b=meO5aDMHGx7ACfZMcVqbLlq6L5RlfuJe3JJ9gBOn4rkaKA+0p3AAHbONEsKUdZzHWb
         a1tIfJ7lc0gBIcGoHroJLgvZ2JzynxzGXiiTm8KW90j2inPPf/+bga6jjE0CipQxbNFh
         cY9jkU9rLxts8SD20PJ5gvQDDlYf59ED23y0KHeZIsfOoZ+VRsvYVXy/cn+STxcDJzu5
         2XvNUtYKsy5AH8mVlCIGKru5yCJKqpPu1l1F5Riq8vzIgjdpfZrFiwsCEVAwmckazp4b
         wHmI6crRSjsbefnsoWENcSZ/LjOVT9bkF08aihDpJ5Lq0FXbrh/YaDVT6TAWzWx000s0
         Ysvw==
X-Forwarded-Encrypted: i=1; AJvYcCUeubPGujBZ9QRfpaRY4x39wYl5FrGtVelPawqKAMKlf2qBwHkWH7CeMuKkOBodoOdvcdFB8d29ik5X@vger.kernel.org
X-Gm-Message-State: AOJu0YwvMEc9fR29G3L7cy4h6s35ly94Sz5U774uqr4Pj4kDnF6JiTDB
	2N/29hh8Pbt9lcWW8+F/DtHi4NuJNaP1oOfGCYxReqql3uQQvGx1WDJ7lqeIT0/JUzO1svLQ6i9
	g/WruGsO2aO2SoePfmCJ+EgV4x9W1ZjKHiJB5U3ULR1hiAQ0mF4YTgTa1JP6qfgc=
X-Gm-Gg: ASbGncvLfXxQSCHgrUFtFfkLQYmeOKB+3vb43tqxyuCxWgRbkmugEh14wc8sqZ0eFso
	jCC8dPRfpjZBRgoGfTTmfK+Z8OxojwWbkCVPN1IdZxKFH7bcSuwR0VKB09LZo2FtnbC6kTaNFJd
	9CzlDsO48rq8th6Bk5UgWP7zVYwjmPrKX0ydUMq47Bk7IXyrDnUbmwhJ46gjjjYj4pSge7kh6j+
	4wjNA7GiiUDkEBFywy0z+YjVGSYr1XJfhP01TbRj/uqKZXegcQE3EtRxgqkKu83x+xZr5W+Z1Hr
	yQXu67KOvoM7HskNftNJ2Rtih5nCoUUy1FYNjdL7FzC+UIYfHCPm0LXhhUoNN+xnrR2nmTr0h9e
	TdwopQ7Cqv+wWGtYJGlk3Xf/sNozGwYmF6XK4dcBxxP/0hG63BFkF+2pVMIurCrTRaiA=
X-Received: by 2002:a05:600c:3149:b0:459:d9a2:e920 with SMTP id 5b1f17b1804b1-45b8553f0d6mr59404785e9.4.1756735097377;
        Mon, 01 Sep 2025 06:58:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn3qnjVr3vNwl0OPfOfAX2NQN1Ov4ftn1WPYrnzUffpb/PLcS4jgL1Mkb7uQh+fwL+1q0Rlw==
X-Received: by 2002:a05:600c:3149:b0:459:d9a2:e920 with SMTP id 5b1f17b1804b1-45b8553f0d6mr59404385e9.4.1756735096846;
        Mon, 01 Sep 2025 06:58:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7df3ff72sm99174625e9.1.2025.09.01.06.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:58:16 -0700 (PDT)
Message-ID: <2ad655ca-7003-4030-bb2d-1c4bcfda30cc@redhat.com>
Date: Mon, 1 Sep 2025 15:58:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] mm: constify arch_pick_mmap_layout() for
 improved const-correctness
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@HansenPartnership.com, deller@gmx.de,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
 rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
 broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
 mpe@ellerman.id.au, nysal@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-9-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901123028.3383461-9-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 14:30, Max Kellermann wrote:
> This function only reads from the rlimit pointer (but writes to the
> mm_struct pointer which is kept without `const`).
> 
> All callees are already const-ified or (internal functions) are being
> constified by this patch.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---

[...]

> index 2201da0afecc..0232d983b715 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -178,7 +178,7 @@ static inline void mm_update_next_owner(struct mm_struct *mm)
>   #endif
>   
>   extern void arch_pick_mmap_layout(struct mm_struct *mm,
> -				  struct rlimit *rlim_stack);
> +				  const struct rlimit *rlim_stack);
>   
>   unsigned long
>   arch_get_unmapped_area(struct file *filp, unsigned long addr,
> @@ -211,7 +211,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
>   				  unsigned long flags, vm_flags_t vm_flags);
>   #else
>   static inline void arch_pick_mmap_layout(struct mm_struct *mm,
> -					 struct rlimit *rlim_stack) {}
> +					 const struct rlimit *rlim_stack) {}
>   #endif

Should both these cases also use *const?

(for the latter we probably don't care either, but maybe just to be 
consistent)

-- 
Cheers

David / dhildenb

