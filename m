Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724533F37A
	for <linux-s390@vger.kernel.org>; Fri,  8 May 2026 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221429; cv=none; b=Yv5OhsV6q2JEUvUzp6PcChrPdoMHFrm0/Qg7VaBGh/KIEWqoe9h3VSgFeTl/x7Pds4XBXRsPVwAOEEY1g8q7hMgjz8tHgcf5QnnALxaoKXLziIRGZc+NsKpug+ErFCIBTpYw5XS0qRbh/TcAjg7h7wWOeOFYRlJyyiaUlNJaFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221429; c=relaxed/simple;
	bh=7JxXt4uHdrVE7v93uVNogT7YTIaV3Hld1ObpxEw8oLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBrdSHGT70aSjSUfDuMtMiK+czaK9fYGdsZPR94+6HfisrsOSsF7cXNDziLjQEhpv4KYMHnMkyx53A6hlYJmMvbhniCMV/QHgka+Cc7vzZjFOOgV5izN30B7uaI80pYGRj2ePsS8AdEabLVtzg8wEwFgVhRJoyK3NCJOy/EGAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoAm6bqn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoAm6bqn"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bc66ad3742fso281468566b.1
        for <linux-s390@vger.kernel.org>; Thu, 07 May 2026 23:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778221421; x=1778826221; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXmCROexOu1XWxsa6Gr/P0MP9TotLBuHxBkK2z9uZ5I=;
        b=BoAm6bqn7DKKLmbPf8TnghP6syF3hgEH1UlPdTpYZhuXtBzcUjfRHSTZ34rKfYGGe9
         pumqBM8NVx7/cF0kblApXUK35cldymambctWCdxJfZLQi8OUo+PUaa4PRHCeN6YscBGv
         e7dLo2zrvDjpyNVhgjL5cFcMFM3HNtH6E2D6z0b1SaPuQBWLhdDGAQaUY4URMpDjiUPk
         b0nUNlNgTSnGFT/FkjUqEMR3tDBUD3AT1rC8PFIFDDTJQas1wz10U6FeTODLVqcie/bD
         Cutf8+ew1lydxE8E3FB6p3MK/8BG9qEPBg5ClamkYBVkArCwHvXF8IfKQa+cMRAUuk2P
         Xbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778221421; x=1778826221;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXmCROexOu1XWxsa6Gr/P0MP9TotLBuHxBkK2z9uZ5I=;
        b=d4WrqMq7h9QVUR/3otEUhCFs3O2ZdATl63N/56C2Vw7Taxh1n/vZMr55Y41S3mDOJB
         J1SwlTid3yAhu/3mi3821xHDfW8xSH4p1/nXh8qPCU8w+m74dQMJxWkT7BkBN5UTn5Li
         /9DIf6YrgCwaf1S5u1x6aZIZEVVPGz/QHdhzAFMnr+ksTc6cLUI300aEi92BuSfl7w6Y
         adJfCq43CocEv6k5/lc48Jg3dYiKVn+HMH5W6/4cNDaCPpf44/4rvtZj9scI0Ap6wWZx
         d3Tj/Dq9L+/UdL+SoJI5yFO5LRWNDNv8Hcry9cDBh6OsjP23MeJ4uz5b/zzoSUVWSWep
         cVhw==
X-Forwarded-Encrypted: i=1; AFNElJ8hBs8YmYivI4si/r8GxYYx/X/xXp+GzEdbG+w9ggDnm/gQ+ihfKC30d/0HUc/6eEHdmXYhgCX4x/yM@vger.kernel.org
X-Gm-Message-State: AOJu0YyjARbGOb3xZtEinNi2DYNvWzGEtu+SQAfMEkkTnmytR/rbY/Aw
	J/R7MhT6gj3NZBqsKmwyvTe0sqy9MXlAqVWyEVnFrjNZpnJS64IADBs2
X-Gm-Gg: Acq92OFfnVviFHW4pVXOq6xQxuqBFfJ2AznWE791NHiwmRvUCOAmuMN4Ik0En3dYvO8
	YzdVdNJ8R2QpxlnjttuQFwPYpFwT8HpUkAbYvb1A5gEED7UoDTUOYCpbBzITDbP/QKvurnwpX3B
	vAKwbh62jrOg8yM8kXirUe9WKzL9x4GncPkiu9v9GNL3YGSNwlCWpG0mMJnOnP844M4/5/8CS+p
	zz9HCNyZnz7rMj5wKpeKk4uWXRoINt/DqhFCC7BNFbjpEcDq3PAYsOyOYT4WnyZFHiwu0Sl5Qi2
	THD96TKZtOeGcyAAXC77a6NGiSXdEShcAWCAM19VW6FHhy7uyT4jiO7nOp0iiQl8Pzu0wEsVmy9
	RWVDgx2/j6wbW7oZ6PHXP4rGWdu1yFheAi06G7u+jOtWBS0wDLploR1bGmxDH7uuvyS0TItZEIH
	thBrHYXHL0ee3ofeWEZJB/Mt54i9cD4sqr
X-Received: by 2002:a17:907:7284:b0:bc4:8738:486e with SMTP id a640c23a62f3a-bcaa9f5f0d8mr76170166b.2.1778221420652;
        Thu, 07 May 2026 23:23:40 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac4849e22sm33580966b.59.2026.05.07.23.23.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2026 23:23:39 -0700 (PDT)
Date: Fri, 8 May 2026 06:23:38 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oscar Salvador <osalvador@suse.de>, linux-s390@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] mm/page_vma_mapped_walk: Use ptep_get_lockless() for
 lockless access
Message-ID: <20260508062338.h7xmz3hjzozdrg5t@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260504130434.2285053-1-agordeev@linux.ibm.com>
 <20260507093433.q5xybwumryxclnqy@master>
 <43815634-29d3-4fa4-b967-0e251ff32f73-agordeev@linux.ibm.com>
 <20260508010040.o7bypjnfceeqloeq@master>
 <4da2d354-808d-463e-ac85-5b1f3fd51618-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4da2d354-808d-463e-ac85-5b1f3fd51618-agordeev@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, May 08, 2026 at 07:15:45AM +0200, Alexander Gordeev wrote:
>On Fri, May 08, 2026 at 01:00:40AM +0000, Wei Yang wrote:
>> On Thu, May 07, 2026 at 12:32:09PM +0200, Alexander Gordeev wrote:
>> >On Thu, May 07, 2026 at 09:34:33AM +0000, Wei Yang wrote:
>> >> >@@ -310,7 +310,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> >> > 				goto restart;
>> >> > 			}
>> >> > 			pvmw->pte++;
>> >> >-		} while (pte_none(ptep_get(pvmw->pte)));
>> >> >+		} while (pte_none(ptep_get_lockless(pvmw->pte)));
>> >> 
>> >> As Oscar mentioned in lkml.org/lkml/2026/4/27/630, map_pte() may take the
>> >> lock. So probably it is not right?
>> >
>> >If I read the code correctly map_pte() might take the lock, but also
>> >might not take it. If it took the lock and uses ptep_get_lockless(),
>> >then it is fine. But if it did not take the lock and uses ptep_get(),
>> >then it is an issue.
>> >
>> 
>> So the rule here is:
>> 
>>   * ptep_get_lockless() could be used for locked and not locked
>>   * ptep_get() only used when locked
>> 
>> Right?
>
>Yes, this is my assumption.
>

Thanks, if so, it looks good.

>> >> > 
>> >> > 		if (!pvmw->ptl) {
>> >> > 			spin_lock(ptl);
>> >> >-- 
>> >> >2.51.0
>> >> >
>> >> 
>> >> -- 
>> >> Wei Yang
>> >
>> >Thanks!
>> 
>> -- 
>> Wei Yang
>> Help you, Help me

-- 
Wei Yang
Help you, Help me
