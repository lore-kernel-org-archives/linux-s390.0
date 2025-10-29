Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C32BEC20
	for <linux-s390@vger.kernel.org>; Wed, 29 Oct 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732023; cv=none; b=F8SROCeD4TVdvzpjjCZbhjBbPr8NH9q/1nzKjuEbkEw8AwMRQQVJCY+Tklw7tU5La9y1lN2XH8ziQMNT5jtkpzsFjfdOYWboXYVCeUmPnHFtxuxKDPy91zRXYB+Y1ak39d5U7KN02OeqoI/ImWWr3e8GbhCwFeEPCsUSn9gFS/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732023; c=relaxed/simple;
	bh=SKZe0CVlQ/p+I/GhlcWTfXycD/+oUUOcjJrYGg72xyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQoFr9Ae5if0jT5dsQHjSvqvHfKkoLtGttpV/yvByKF0QMZUKnG4nA5r3uY/mjyTN+tmppRpr9EW8bML2j8ZW5Z1yha3wrWNAKL7HQLNmg4PjRVbY139VHXYuQRQgEGryb6jWqOIuqN2ky7eyQuoiIu64R2ZdWZ7wvPMcsrVYnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bl6nJXM+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bl6nJXM+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761732020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hEtH/DOi8ufPul8rQIFdoeVO4A7KFJe7+IrA/7Qq9Tk=;
	b=Bl6nJXM+2Bt0zK3cy5OzjYqWxx9/97RvTYbUdHAaFxcYXoV4o6Ln5LpX6TjaNBiYhM7nhs
	ZVfWPsAi1Xpc91lkNLD6aqsyCA1mDYGZ3oEpOXcann4daFp9LX3vTj4Glj0Sk9y+CwpbQx
	CYXuHDaA5RJFdsGhVOGSZbVwlP1EaUI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-jVg61N2HN4uwvIwZVD3nTw-1; Wed, 29 Oct 2025 06:00:18 -0400
X-MC-Unique: jVg61N2HN4uwvIwZVD3nTw-1
X-Mimecast-MFC-AGG-ID: jVg61N2HN4uwvIwZVD3nTw_1761732017
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477113a50fcso28700375e9.1
        for <linux-s390@vger.kernel.org>; Wed, 29 Oct 2025 03:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761732017; x=1762336817;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEtH/DOi8ufPul8rQIFdoeVO4A7KFJe7+IrA/7Qq9Tk=;
        b=trhbtkvfE6z5pHZry50Xmw6kbsdreKnx5ZbiKOOU8Rc1TgmzaBfM2NuQ4qAa33yyyn
         Llvh7Z780NpcmrIr6NqkY5dZl3j16RKaKBOrqGZJrie6xr3w2B6mNusukK3qKvhZxeh5
         PKOrrijKYqCdDXfeAT7WbnX80qnWXbZ4KdogUW5cjOmY8MglyTeDJZkhlBaHBBKGwAXp
         IEBgUq9ezYIReK/aLGJI/k7GKSfQ8JdNOqg/WfT4T4ypVJu6434jL0O95UVmbmDjlbfy
         WEIf1jSdY2yRLSCg5s0y2aSKWas5uh2JoZcyR8yHZ3kmsmAZMCSwB/MTv1bo0YLbSNmt
         1ECQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr5s43LWgNsLDwEWMCABhgoq0n6GKgA/VN6zyR2f+zngmQS9Kwu0VWevEhyzmmoI2hn18vfXMt+8Dh@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAyxS9uMRAwj1X4HmhKKhqe+atw0sgTey0CfTWBJ0pMK+q/ui
	fhqmU86ZGaVJDpoAXV3p+fFSH8BrOdqXtM4kmDheqKJtAmmAsjWc6i/qh5VdqrRI6jqNvl2fMqQ
	oZj4OpEPGj26fZT2ziKN/CYDOmElfoJ0IEOzTDXdw7h8o+7tpJrxwjTJei6SJvNo=
X-Gm-Gg: ASbGncviYpxmuD4Dz1cJguijanyDWEkJcz7trvazEJXzgkjCnmqbn+ZmhEDNCC8NBE9
	5P1frt28rQEBVZZNCRln23Ae1yPWWV2gDxaB9KaoTlIVBM+a/ArrIfaZ2IMJiEdWFMGsULG86xL
	fymZryvn/zgpFkg64NbjG8S1t4yGiSYfX0AKdnLwkvg3JnRKbeULAeKCo9rlwZCztUuVgaQad/E
	ebAEG3JDo4ZULBMrvbd2CAnoS03f05PUHoiA1RDNFFxexI8y9vK5Y51KuJPQmMyEWhiwrKS+rfS
	RDKoTu1b83I112xEzs87jpRlvQgCqeOLwf8ug+3I+I3KoKJbOHSeCQcegk/cpy1WjNCZ6tobZv/
	oM+7mAcHAbclcyGRnX6SnAA==
X-Received: by 2002:a05:600d:4398:b0:475:dae5:d972 with SMTP id 5b1f17b1804b1-4771e85156emr12759415e9.23.1761732016768;
        Wed, 29 Oct 2025 03:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnA3IRpFHhYsZzK6qc9l0qizFN8SkkYYfFwlHAG+3t4PNESgPO0z5ya7ZscSCTji9s1WIskA==
X-Received: by 2002:a05:600d:4398:b0:475:dae5:d972 with SMTP id 5b1f17b1804b1-4771e85156emr12758875e9.23.1761732016284;
        Wed, 29 Oct 2025 03:00:16 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771902fa8dsm39879465e9.8.2025.10.29.03.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 03:00:15 -0700 (PDT)
Message-ID: <db143076-afa0-4129-b5b0-eab85ec54aac@redhat.com>
Date: Wed, 29 Oct 2025 11:00:14 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] KVM: s390: Fix missing present bit for gmap puds
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, akpm@linux-foundation.org
Cc: balbirs@nvidia.com, borntraeger@de.ibm.com, Liam.Howlett@oracle.com,
 airlied@gmail.com, apopple@nvidia.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, byungchul@sk.com, dakr@kernel.org,
 dev.jain@arm.com, dri-devel@lists.freedesktop.org,
 francois.dugast@intel.com, gourry@gourry.net, joshua.hahnjy@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, lyude@redhat.com, matthew.brost@intel.com,
 mpenttil@redhat.com, npache@redhat.com, osalvador@suse.de, rakie.kim@sk.com,
 rcampbell@nvidia.com, ryan.roberts@arm.com, simona@ffwll.ch,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-next@vger.kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com
References: <d4a09cc8-84b2-42a8-bd03-7fa3adee4a99@linux.ibm.com>
 <20251028130150.57379-1-imbrenda@linux.ibm.com>
 <20251028130150.57379-2-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251028130150.57379-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.25 14:01, Claudio Imbrenda wrote:
> For hugetlbs, gmap puds have the present bit set. For normal puds
> (which point to ptes), the bit is not set. This is in contrast to the
> normal userspace puds, which always have the bit set for present pmds.
> 
> This causes issues when ___pte_offset_map() is modified to only check
> for the present bit.
> 
> The solution to the problem is simply to always set the present bit for
> present gmap pmds.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Link: https://lore.kernel.org/lkml/20251017144924.10034-1-borntraeger@linux.ibm.com/
> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>   arch/s390/mm/gmap.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 8ff6bba107e8..22c448b32340 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -599,8 +599,9 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
>   					| _SEGMENT_ENTRY_GMAP_UC
>   					| _SEGMENT_ENTRY;
>   			} else
> -				*table = pmd_val(*pmd) &
> -					_SEGMENT_ENTRY_HARDWARE_BITS;

I'd add a comment here like

/* Make sure that pmd_present() will work on these entries. */

> +				*table = (pmd_val(*pmd) &
> +					_SEGMENT_ENTRY_HARDWARE_BITS)
> +					| _SEGMENT_ENTRY;
>   		}
>   	} else if (*table & _SEGMENT_ENTRY_PROTECT &&
>   		   !(pmd_val(*pmd) & _SEGMENT_ENTRY_PROTECT)) {

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

