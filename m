Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DE2136352
	for <linux-s390@vger.kernel.org>; Fri, 27 Sep 2024 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440324; cv=none; b=cY8UiRNDGDP7MOdCjYIicotzm49FmhjfyzyarJE9wSBh3ngYqza/Ap8e3TbQRkuCU6rtrrHRFZLGGsz0PaZ0FtBOCzDzA3kG6R0ipwd5VXfHh6CsRm32XFXwJHfK4Xmfu1yNTJATacp0BMC+sVXecizMnzYX6FuGiUeR6ZHGkAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440324; c=relaxed/simple;
	bh=UxGFMmoodHYFh3x+RXaDfvpykCNvMRihH3+3CLw0XEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s98DpAlPJ14O/xU0aD50D69GdzuGX5Kv2teGUXN1Y2Ifk8ecro3tY3xrxdhUqhh/0ARwE5qGzl1IRkqms0MF6vGqluCAWDSvCurpyRHDQc2vwA9it8y160u/CIi32BFTrvmJzSQDW/UR7XX4zpl1D54bJvVDI1nFd7bVGZEADyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kjnrp6Vg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kjnrp6Vg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727440321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nghQlGVXIvvnLt/JiqYj6QczxOiCCBXyk/YGSHq/I1Q=;
	b=Kjnrp6VgDrbiN8fMGz2YOVRRrln8hd0wI0/IIRGS+HYtQ/XDrZGSwh6RC3BEfkHDtTgVyj
	zy+Ct/mXKnq6v9vR5TCYvSswH4wmb30Lp5qiWHjVI/LG8ARdGCt+JHgXhLrcapxRBICyUT
	tYGGJ03nGUOrKFix8orozgf+8BFsnng=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-IPzp6aPpOfGiJMGZs1tL7A-1; Fri, 27 Sep 2024 08:31:56 -0400
X-MC-Unique: IPzp6aPpOfGiJMGZs1tL7A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb236ad4aso12073145e9.3
        for <linux-s390@vger.kernel.org>; Fri, 27 Sep 2024 05:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727440315; x=1728045115;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nghQlGVXIvvnLt/JiqYj6QczxOiCCBXyk/YGSHq/I1Q=;
        b=AkMDYAuZlZDUlB+/Tz7fQZb342cHD8ONGKWCytk//WrQrHV/PyOtfdfLzDLsGEdAWW
         CMW3w4GhXHuVtPjXIrYuE2Fdmw2oclZl0rRxa1k/xNnp06b/dOhJ8trrjRPlGtWNoMwE
         OzwNx7SmMa0mubrIkAY+7A2Bzvsyq+vywJoR2rsRXCLMFnwJthgI5S4U01y67Qf9krQV
         KJ8Co9YUgoEpwl9XpTaWOQQnsyY1JFgCPe8gwsu/q6N6w6NBIrppXNko0PqUwkhb9BH/
         CuT6QcUt4CRRshDa9ieAG6vv24tWdnXvw6rZEuhdLFSobVZLAnezABMFMtr6T6YzTqDp
         FoPw==
X-Forwarded-Encrypted: i=1; AJvYcCVkXAKVRng3GjKIoXKM2yoz9nH1O/NYGYidDrAwg9Fo1D34+NNJ+S51bX/pXeAs7rrb8wLWBceRfEY7@vger.kernel.org
X-Gm-Message-State: AOJu0YxJYT7UYHpiGpuJbTpjDbVaq6zA7kLwUkMMbo5fxOH5Ta9RmRve
	2260YYDcuLTscKxJY760vX9gr9oJMl+wL1uQKasW1jbGqLo48cT2xM6o40MbxLq861R+DahYXRw
	5/mpAB/yZn15y2p4lMHhQkg/InI62vUZncevJ+/QKnUI39x5NGzqwWCdsMv4=
X-Received: by 2002:a05:600c:1551:b0:426:554a:e0bf with SMTP id 5b1f17b1804b1-42f5844baf3mr25127965e9.16.1727440314881;
        Fri, 27 Sep 2024 05:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSxQuZVTjNGEswklOGtpwrowZZmdwmK+D7kC/KtO7F+lQj94trZK7vGwZdIOQ+D8N9X/RvuA==
X-Received: by 2002:a05:600c:1551:b0:426:554a:e0bf with SMTP id 5b1f17b1804b1-42f5844baf3mr25127655e9.16.1727440314423;
        Fri, 27 Sep 2024 05:31:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:8000:b502:8c1c:3624:99d4? (p200300cbc7098000b5028c1c362499d4.dip0.t-ipconnect.de. [2003:cb:c709:8000:b502:8c1c:3624:99d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd57423afsm2356049f8f.90.2024.09.27.05.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 05:31:53 -0700 (PDT)
Message-ID: <1d734979-0ea1-4943-857c-3d458e33af5a@redhat.com>
Date: Fri, 27 Sep 2024 14:31:52 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dcssblk: Mark DAX broken
To: Dan Williams <dan.j.williams@intel.com>, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>,
 Alistair Popple <apopple@nvidia.com>, linux-s390@vger.kernel.org,
 linux-mm@kvack.org
References: <172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com>
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
In-Reply-To: <172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.24 00:59, Dan Williams wrote:
> The dcssblk driver has long needed special case supoprt to enable
> limited dax operation, so called CONFIG_FS_DAX_LIMITED. This mode
> works around the incomplete support for ZONE_DEVICE on s390 by forgoing
> the ability of dax-mapped pages to support GUP.
> 
> Now, pending cleanups to fsdax that fix its reference counting [1] depend on
> the ability of all dax drivers to supply ZONE_DEVICE pages.
> 
> To allow that work to move forward, dax support needs to be paused for
> dcssblk until ZONE_DEVICE support arrives. That work has been known for
> a few years [2], and the removal of "pte_devmap" requirements [3] makes the
> conversion easier.
> 
> For now, place the support behind CONFIG_BROKEN, and remove PFN_SPECIAL
> (dcssblk was the only user).
> 
> Link: http://lore.kernel.org/cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com [1]
> Link: http://lore.kernel.org/20210820210318.187742e8@thinkpad/ [2]
> Link: http://lore.kernel.org/4511465a4f8429f45e2ac70d2e65dc5e1df1eb47.1725941415.git-series.apopple@nvidia.com [3]
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

