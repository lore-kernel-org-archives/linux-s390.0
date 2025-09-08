Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B76314B6B
	for <linux-s390@vger.kernel.org>; Mon,  8 Sep 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353157; cv=none; b=eu+DIOJgUFKrZC4GeRs4z6MbPrBEHM4i1e5FCOjGIUmcWMf0vYyqKfJ9F2r2Vks+yFy0vRWQLWCBiyOX5lqoDoA20NKYFeNM/1rFhMGls761ofEFNt5L1FRvGb7uG6uHuaDSii5+gJF8IdGMaxis0xiG6oaadjoqHxhzS8nvxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353157; c=relaxed/simple;
	bh=/wwPPT3D3B4H3qD59iTMkFD0CIp2bDbDQ/50sGFVtEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rK0FNt36fhl04Hj3v7+dgkse2x8TG+7OkHRraDrJwg1GKG0GFeijylvu1tRdRGG/VlNRNCP7EglzFPKryv9KapXYRdinBBxQ3ykEATzs8LjFQcDq7Hn5zlKqhDDvC/BEj0hQ3PEKuhSq4XI5P4sPOEVMc+BbWt5Cn8mhdiZo0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5zRbCIK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5zRbCIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757353151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3P5EwsaOJG0kp/tyGnSgePetI5hCYz4arKjA4KqYxlA=;
	b=M5zRbCIK8Y9tLYH13Z9j8WGoII3sLGMYqz+TayL3zEOKcBUkUFIdecr7eUzmid0ucjpvkJ
	pGgyN8SLYTfnFFcscGYYPVtUctNLv0vDONzbXlENj7uSppKAiRfkYMnKpmtAoZFcEjTBUx
	GpZeXoebHRoCy1iDCbcIT04ZTCRFKtw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-gc0xFOroM9uA-o_FqpDWXw-1; Mon, 08 Sep 2025 13:39:05 -0400
X-MC-Unique: gc0xFOroM9uA-o_FqpDWXw-1
X-Mimecast-MFC-AGG-ID: gc0xFOroM9uA-o_FqpDWXw_1757353144
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so36682285e9.0
        for <linux-s390@vger.kernel.org>; Mon, 08 Sep 2025 10:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757353143; x=1757957943;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3P5EwsaOJG0kp/tyGnSgePetI5hCYz4arKjA4KqYxlA=;
        b=B/juc8bF/M0RKAd7Xg+CxyeDkBISPvPDOSinXnJPIN2iHL+8gKqKtohyUCF1wKyItD
         g4Qioc3Gn+uRsNIvv6ldC69OcqtboI4/nuhJAjFuAd997kAsIIi/JLpbSortRIqmwdEn
         ibP0m0H75R9+hs4LHoa0PTPP0CVR3440Cp2ZcqN4dCp8w2Vl13kaTLwPIyP+3aD4y55Y
         0ERCTaZpliMXOqpxc/fgenfD7s7s/coj41op3qDk3ehBc7Pt/zfJtAWesGLeXqIA4dmN
         Kc8fIQkTPnOgqw0gbHwceDza7k2M+ah7g78PYBOh6c3z5ag5O+yxB0uGpPvNTMtvjHnD
         KXGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX6Epr2mr9mOQCzINER3WnklgavDJqBJbine63SON7AZpyms5x/diTj+Et9lTL+kaecJDaFiI9ll8I@vger.kernel.org
X-Gm-Message-State: AOJu0YxDUxDi5ogdnHBEh4CWeKudJK+HvuK9F0HXyPLluRip9ynsNoCp
	ixttb+xwLuvAv/Hh3Dl6LC7WS2svGyWyLlI+NT+d8m6QqsLY+0zRkHhMleWqsFPLRxYDMOdKfsU
	ZpiJmMPV23XGjBViW2EzflkjWIf5nSVzlJWGDuVClWOg3QcgGuaxosbG+gY9qCDE=
X-Gm-Gg: ASbGnctUAriIdN+Rp6KZkMt/8hqGTeL9l5Dydtoe7VvCFAqVtYT+oUEP/+Dk2Drqpsp
	k4vK57u1Qs3OfFglbyYIEFD/x53KxRIV0jrvPtpwRU06qlVnn7EayE44/cMU8cdgzQSLAqxEsR3
	vTziXSM/QIhsdCWE7o2HxjxQBNV6GFQhLOWFbynmOfFOGnpsyRuDS8rOI75TAkET8oXMWWUko9P
	dzy3g+Tnqs+O2Hm+1KU4ph+URPV9+xbFUxmk+r3zb1n7szBTDDbgqMw15w7XVU7DUQ+lzY71C68
	8CjOsoQxMoNoqwdhkjMpz+pQkz0i83myDuybR8oiiMqXvvbNf108cyzlCdi5hZsokMcsHbDd802
	eIhx48kVDcfev/piuB51klY6wOXSwN0N2/BehIVMPl4Tel1/+2fGpLIIyu+1DkAi2
X-Received: by 2002:a05:600c:1c9f:b0:459:d3d0:650e with SMTP id 5b1f17b1804b1-45de870ac82mr30366635e9.13.1757353142603;
        Mon, 08 Sep 2025 10:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt8ktxg4j7+rHzwwJQeZDohdWogsGJakCqu7C8BDn8f2aNE74iKc5paKrXN3SjMzlRF+4VLA==
X-Received: by 2002:a05:600c:1c9f:b0:459:d3d0:650e with SMTP id 5b1f17b1804b1-45de870ac82mr30365735e9.13.1757353142034;
        Mon, 08 Sep 2025 10:39:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e92a42asm450957385e9.20.2025.09.08.10.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 10:39:01 -0700 (PDT)
Message-ID: <225a3143-93de-4968-bfc5-6794c70f3f82@redhat.com>
Date: Mon, 8 Sep 2025 19:38:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] mm/vma: rename mmap internal functions to avoid
 confusion
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Guo Ren <guoren@kernel.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
 kexec@lists.infradead.org, kasan-dev@googlegroups.com,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <626763f17440bd69a70391b2676e5719c4c6e35f.1757329751.git.lorenzo.stoakes@oracle.com>
 <07ea2397-bec1-4420-8ee2-b1ca2d7c30e5@redhat.com>
 <a8fe7ef8-07e5-45af-b930-ce5deda226d9@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <a8fe7ef8-07e5-45af-b930-ce5deda226d9@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 17:31, Lorenzo Stoakes wrote:
> On Mon, Sep 08, 2025 at 05:19:18PM +0200, David Hildenbrand wrote:
>> On 08.09.25 13:10, Lorenzo Stoakes wrote:
>>> Now we have the f_op->mmap_prepare() hook, having a static function called
>>> __mmap_prepare() that has nothing to do with it is confusing, so rename the
>>> function.
>>>
>>> Additionally rename __mmap_complete() to __mmap_epilogue(), as we intend to
>>> provide a f_op->mmap_complete() callback.
>>
>> Isn't prologue the opposite of epilogue? :)
> 
> :) well indeed, the prologue comes _first_ and epilogue comes _last_. So we
> rename the bit that comes first
> 
>>
>> I guess I would just have done a
>>
>> __mmap_prepare -> __mmap_setup()
> 
> Sure will rename to __mmap_setup().
> 
>>
>> and left the __mmap_complete() as is.
> 
> But we are adding a 'mmap_complete' hook :)'
> 
> I can think of another sensible name here then if I'm being too abstract here...
> 
> __mmap_finish() or something.

LGTM. I guess it would all be clearer if we could just describe less 
abstract what is happening. But that would likely imply a bigger rework. 
So setup/finish sounds good.

-- 
Cheers

David / dhildenb

