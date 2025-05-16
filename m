Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B483327D781
	for <linux-s390@vger.kernel.org>; Fri, 16 May 2025 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421735; cv=none; b=LKse0A4L76MvtR9oJsdDiGTgLpCwhjLwJxjgThPhhgIkLZpVtSzp6jXqXxfDXBZGz2wuytMXvVyil5/OfAPqU2yFeOUGBYoWRcy00YY86NMurc43F/A9xP7EWg05az0oc/H/6V8AAMa3Y+JDzGPe3Z0/P6jF/p+YtbiHVnc99JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421735; c=relaxed/simple;
	bh=G3eptgK8Klfl0SQ0qKF2kBePOio3LIT52ROdnYjywmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHO9tpVhO+uyPPO2pZGYEXMnBIw3z3GNvrwVctxxDd28uyIEfc/71fekDn7GQGPiYrjXk6qcUDefYIDfNe7mcOPoCNfkH4FBwOgA9MslRgDFombdFhLBEYxSYsYzkgrSVTgalBtx3Dri+8W+4nBr3pA8UHLBPF/mpRo1QlmsvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzsoAMCv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzsoAMCv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747421732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ncy0IOMN62OZsySnUUO+DO+ffjUqHUwVWIhcHttPrHk=;
	b=YzsoAMCvKGDZtp00ZQ4KcdKqaiRh3Cfe4m9Wflxss5+DA1ymB/bIZohTFu89K8OFWXSxLh
	UA9ChMbrAh58cgJwI+/eLwvF7tkLT+rZuq9BOl9T4fBXgEmfOKWOVhqst/zhzk5F6w3d43
	G3wNF3idzMl4fEcHYFu3laITxwM35CQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-57mopIDOOpWBHilw_3WaVQ-1; Fri, 16 May 2025 14:55:31 -0400
X-MC-Unique: 57mopIDOOpWBHilw_3WaVQ-1
X-Mimecast-MFC-AGG-ID: 57mopIDOOpWBHilw_3WaVQ_1747421730
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eed325461so13906915e9.3
        for <linux-s390@vger.kernel.org>; Fri, 16 May 2025 11:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747421730; x=1748026530;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ncy0IOMN62OZsySnUUO+DO+ffjUqHUwVWIhcHttPrHk=;
        b=GssB7m2TUtKzoTVESiA5Rus+HsJ5BctUHj38VuxwXhW+1L+BVHB/v5ZHpyWe8PEbeN
         CmgxbwCmZJVX4Nt0qNefbLDH3os0lERC+8l3T52Y6E+Vo++AT+DSXz+RJEfjChTgddl5
         YZeiyu01dgt28ZAQ6zRdDua0oiKrC/cPvIHjN91HLsaaTDy9UQYBx7xf3LyvQqb97wTu
         VnwVXiogkP2eLfi12xHOaeQCuG1/bnMvQW0VuTzk5+onbMLzKNSnPmyot9soFMfPwltm
         8sj7Tsg+YPn2EBTZJtqoNED//+6BiWaAgrr8P0tKyF0MwiYj5Yz49hQIyTX8ciomgIsQ
         wAUg==
X-Forwarded-Encrypted: i=1; AJvYcCWwSXaMGLHuy67ujfVREmRh4aK5yen2CTU2BzkmGq+NoR/BKianFjNoF6BchKUjwF+8YmS1APoy68Rj@vger.kernel.org
X-Gm-Message-State: AOJu0YwYefdY2GsBRs0/OHh5+TFzkQuwU2fJX3HoKHMLnJvKyMfR7CoV
	YTIXArVa1wHSHFb2QSoroYIjhFeqpZwAz6l8q/Dpcc5SbMiOrJckfqzYB6+eKOU9tU96UHjg6V5
	j0wAEyFbmTqWgmOIKXaQU7XY/BwFlB5KxaEZr1eUe6+Hpu2bG0l8K3WPpJCz++rA=
X-Gm-Gg: ASbGncttmpRWWPBFm0cehrxnknaUWtGWQhszLN/xjg1XgrSbR3yXsQhngNbprRgqdzv
	/xoQydzj+q7LPK1eS4YFbxLZNQGuNCJXI9/pW+surTfcKrCdcLaB1v4G0q8keOk6twuySawSydg
	PdEMjtqfI9PXIcbzTO9o3smuCvpS99FaunS24Ky2Bgq2gIDFXYPU4VtFu88Z6o3+PCs4G8yy8kq
	M5RIk6Kb0GWjCYHVOvtLjBGy79pB9nU4caCHZ2rScUXcz9HsZ1o3Uibi80CLrN6YAQpWN+9KDXs
	WE+FBD2VnMUU9xVi/MFSiPC+rBM56VM7fKkK83+ycQ==
X-Received: by 2002:a05:6000:1acf:b0:3a2:25d3:3912 with SMTP id ffacd0b85a97d-3a3601d0869mr3566034f8f.57.1747421729865;
        Fri, 16 May 2025 11:55:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnvFvNMoXbCy664/fMYQNUZNHGmO5/8svXPk9nFJJT/F2j7rlj0r91U2NP66XBmlT+dm2IQA==
X-Received: by 2002:a05:6000:1acf:b0:3a2:25d3:3912 with SMTP id ffacd0b85a97d-3a3601d0869mr3566005f8f.57.1747421729439;
        Fri, 16 May 2025 11:55:29 -0700 (PDT)
Received: from [192.168.3.141] (p57a1ac29.dip0.t-ipconnect.de. [87.161.172.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a363d1fba6sm1606167f8f.95.2025.05.16.11.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 11:55:29 -0700 (PDT)
Message-ID: <8811fc8a-5f1a-4a1b-883b-f006da844e55@redhat.com>
Date: Fri, 16 May 2025 20:55:27 +0200
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
 <20250516190755.32917d48@p-imbrenda>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250516190755.32917d48@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.05.25 19:07, Claudio Imbrenda wrote:
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
> yet another layer of duck tape
> 
> I really dislike the current interaction between secure execution and
> I/O, I hope I can get a cleaner solution as soon as possible

I'll be more than happy to review such a series -- hoping we can just 
support large folios naturally :)

> 
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> 
> 

Thanks!

> David: thanks for fixing this mess!


NP; I had a prototype of patch #3 for a long time. But after rebasing on 
top of your work I saw these weird validation errors and just couldn't 
find the issue. And I only saw them with patch #3 on ordinary pagecache 
folios, not with shmem, which severely confused.

... gave it another try today after ~1month and almost immediately 
spotted the issue.

Some things just need time :)

-- 
Cheers,

David / dhildenb

