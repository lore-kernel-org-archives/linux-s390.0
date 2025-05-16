Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE027FB07
	for <linux-s390@vger.kernel.org>; Fri, 16 May 2025 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421798; cv=none; b=GzI7znJDx363cTydTywwX1TBmo3yCWirPm6cNxk58Ky3XB7xPogcvfTpOSHwlpVZ5DKGw+xXLTK/pBlJdayzwB8N69LDrE1LTuiMbzTW7nKSBid4dtr5P//yx6lCSXPq6ax7wFIXcicUdQajSEgUNnEF0UNabXjPpxoyj80UqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421798; c=relaxed/simple;
	bh=7UqtzUtVmyD7A3rWpGZUDe3v1crBMFvZJX7iNW8CaaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZW4IwFnGkvGRYdVrg/GrxkXqi8/BqHhcZAPoP6WwYeCcdhTMJhYNATnm722HgB7ffDZtfvzeedlrNbaMCz8I9mo4MYMOauQfKqa1X3Qt3MB5Dl3oCHQ2VF3Q6rURAYc0Kyxc3jRxlGfJPzoeAXeromUqTVAcvagXojOGl6f4hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYvSR2H0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYvSR2H0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747421795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ifcGTgJelxajCiU2FWoz2x8XggC8WSn+rbLJz+ygqMw=;
	b=TYvSR2H0SUWnrHZicXV7JJxUzFSFd0mM/APwaxz5IUaBMurnExS1sNjclltk6L8rHNyPs+
	KAGD/2aHzWWQHQB4Kmq3JXTD+SnAboiExM5c0RM4vlL5oWoaXWOBXE918/x8ll14LiRTlB
	lLb0lkztlcvScWQqNI7O1uUOHqW3O1o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-eUxIN13JPhm15xUn5BHrww-1; Fri, 16 May 2025 14:56:33 -0400
X-MC-Unique: eUxIN13JPhm15xUn5BHrww-1
X-Mimecast-MFC-AGG-ID: eUxIN13JPhm15xUn5BHrww_1747421792
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a0b6cb5606so1458464f8f.0
        for <linux-s390@vger.kernel.org>; Fri, 16 May 2025 11:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747421792; x=1748026592;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ifcGTgJelxajCiU2FWoz2x8XggC8WSn+rbLJz+ygqMw=;
        b=r04vH/R9U5Zy1DU+4hZFzxdXVGF5pPqC1j6fcufxvX/VqZs2xyUm4cAs4Uqec0MNwe
         l+a5C6S80bTcnFZXQj5x+ivil5Mcz1frFk49fsrunuQXad3P0/5uCPdAlr5dbX1RrUNa
         bS3hn3i039RJQq775emZbJZtAz4pqP8zwgvFJbctNIhWMbbkZrZ4A5zJbb64l0Kmpzl9
         0HPihLqL1Tb7iRAMNtcOza5ddp0P/ubAJE/B6gOyi8JVs3D8FxaCGQ/f3RW7EieHbLLy
         p7VaaUlhwWmWGYw15hWvKVbNuA9Dya1LyikyH3Dhr0bcN6/w/+4xuHx3KajP98Eq7ocE
         hmoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZOIMtFcd1cNHocyUPkfhtDmkY50r5NqGzIpn4L/9zYKYf3uh/Q4c71jt0roqzfuhFVpSfVm5zA055@vger.kernel.org
X-Gm-Message-State: AOJu0YwajbWv8sPmzNb7lha+r6Vl0/i6VeellRbTjWtSmr6Z7M5PjNAS
	1UDBYtBBFjYrX0OXqd0/9Pgnk0pnu6l0xIWjyckl+keCvDa3uEeFCbBRXRonwNpIPaxDOl53KqC
	l3AhJ+vPrAq6dJU33odulK6biQL6k2TvXK5u63xgzdvcL6yj6n5/e4WYyTWKxL5I=
X-Gm-Gg: ASbGncsyHs5Q5ctNFiZNmHMJ/w1EAzyyBjr4/D7CvVVWO5fNtDnPu7boJIzYo5TXHOw
	hWqU0RiJN01pFa+AuR4OWgR/CbEmodSfx0OKKZPFJkecZ5RLf/6dvpqhMvrP+ejXU2IY7Wp8xg6
	bdAgk3ORnhLFGCPtT23mFa8ThOI3Dx94cpCrVVdAfwEOUoxB8w19C2ugybt9h3j+Pq0pe7z4om1
	69W4aZyC0UqJj6EtA3kquICNEJl+bggh9d6V8adgevycbqTM6zfA2vNalHHbcGug0aX/u+zQiW4
	zsb3WSuxcV7Q+fGkVcaDS8cY4lou4CqRyQ2kxTGlEQ==
X-Received: by 2002:a05:6000:2dc2:b0:3a0:b65b:78ef with SMTP id ffacd0b85a97d-3a35c845c04mr4820394f8f.52.1747421792493;
        Fri, 16 May 2025 11:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkqi1Ur9MV4UU247rCekfZQh5zJYD0LlUxflLVxHjPBhdhdSsqXUpzAVzfUm2pO8VCCsxcJA==
X-Received: by 2002:a05:6000:2dc2:b0:3a0:b65b:78ef with SMTP id ffacd0b85a97d-3a35c845c04mr4820376f8f.52.1747421792158;
        Fri, 16 May 2025 11:56:32 -0700 (PDT)
Received: from [192.168.3.141] (p57a1ac29.dip0.t-ipconnect.de. [87.161.172.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d230sm3656530f8f.4.2025.05.16.11.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 11:56:31 -0700 (PDT)
Message-ID: <eb93777b-cb74-41d9-80e9-a700bf693d4e@redhat.com>
Date: Fri, 16 May 2025 20:56:30 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] s390/uv: handle folios that cannot be split while
 dirty
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Zi Yan <ziy@nvidia.com>, Sebastian Mitterle <smitterl@redhat.com>
References: <20250516123946.1648026-1-david@redhat.com>
 <20250516191748.3bd0861c@p-imbrenda>
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
In-Reply-To: <20250516191748.3bd0861c@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.05.25 19:17, Claudio Imbrenda wrote:
> On Fri, 16 May 2025 14:39:43 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>>  From patch #3:
>>
>> "
>> Currently, starting a PV VM on an iomap-based filesystem with large
>> folio support, such as XFS, will not work. We'll be stuck in
>> unpack_one()->gmap_make_secure(), because we can't seem to make progress
>> splitting the large folio.
>>
>> The problem is that we require a writable PTE but a writable PTE under such
>> filesystems will imply a dirty folio.
>>
>> So whenever we have a writable PTE, we'll have a dirty folio, and dirty
>> iomap folios cannot currently get split, because
>> split_folio()->split_huge_page_to_list_to_order()->filemap_release_folio()
>> will fail in iomap_release_folio().
>>
>> So we will not make any progress splitting such large folios.
>> "
>>
>> Let's fix one related problem during unpack first, to then handle such
>> folios by triggering writeback before immediately trying to split them
>> again.
>>
>> This makes it work on XFS with large folios again.
>>
>> Long-term, we should cleanly supporting splitting such folios even
>> without writeback, but that's a bit harder to implement and not a quick
>> fix.
> 
> picked for 6.16, I think it will survive the CI without issues, since
> I assume you tested this thoroughly

I did test what was known to be broken, but our QE did not run a bigger 
test on it. So giving it some soaking time + waiting for a bit for more 
review might be a good idea!

-- 
Cheers,

David / dhildenb

