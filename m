Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CE28DB73;
	Wed,  6 Aug 2025 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490670; cv=none; b=qUqV7ogYe4ORAj0mNtVJk9TfdylDFdo6e9fVeDLRaRxdacnHc+h5GLSHiE43pSCXEmBn+T0RCXMR6UJVauTA0249mNXCIzMvlMz0hlC0wxD2xBEis4HgH0xe3zpwduSOS91dU2IeWKpZiu+I5RseYNfRM2M9UtZpYBpgr6lkfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490670; c=relaxed/simple;
	bh=51iGBEZcY/EqbLoV88af8ibWcVYMdxoMAXgSf8UfsAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI5MnNdhrWpjT8NIURzBUVd0JgWGCP0/+HMaMxR7W98rBPt/pX45+DTaLZj/35zWr8ug3+hoKMNokMHvEKbDXc+JSITqlmsvnUz16wY2Y5tdSsSCDOpFPoYz5X8iSW/F0QXgniVlSA+7MgwQWGwKhfF9K+ZDbHg8AAy4w3rZjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1aV33IV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1aV33IV"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6156a162537so11367622a12.2;
        Wed, 06 Aug 2025 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754490665; x=1755095465; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrgGiOBYMFYIIMzsimnDnHrC9UaIdenX2JqDgAaCvnc=;
        b=O1aV33IV/KaI18ccVstoKK1sfW1Ge/jm/zEQuifC4LN7xbEVkn9+RaTLEK8D0tY9AT
         H7m+BBg4i7UIgjH5bd9sqeVz/5uRu2zHK/ooQjc5rKPAdyBX8gMG/hfJ+uyO1CkZhniB
         NL39ebLLZp+BqnWZMC9K53A1cGuCCKXJlMf4hdQSbDO2OqXtIbL8qxHwmzIe4oxWXvny
         uL+l+7eYdqnAXhl+o3t+tIMZmzh6g0C3vPqncpDHRA2SMJoTKrcLpVIIDS08xQ86rMYE
         pVDCQi4TVSknqp9tRiqMCctInsOsYrVZvkZR4MDGgVq0WjwoJTymYYJAj7IctAPiuJmw
         m+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754490665; x=1755095465;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VrgGiOBYMFYIIMzsimnDnHrC9UaIdenX2JqDgAaCvnc=;
        b=C+qkk/wh7+8XbtXsgAWtziCOsuPnabvNIJKD5jK12vWs02MmvRasnucbVKHyj4iGwp
         LrzF+tm7dzeuwZfuxcQ7bg3Z4hWhx+dDP4CQH54lax2fxKmvXH3l945Jg7sV3VEmtEB4
         uQlXpQN8O8DcmWGmUpZAsWXGbfbLHZoYErq2bfXaUOus0XwMHIj5pJ3NJ/zldGfI5CgY
         GixvSMmXPvfvvLI8IEWXLjf5zyQMNMuSB6lXF9umtb4rD0i6YdTY8baHUff2oJS85h+U
         +oCMAwCyL/AR0nL4GbRDvnIyztyHwLlvDShds3h6gbUug4nfeo0GHfbJ667Nc6MUPf6a
         LrKg==
X-Forwarded-Encrypted: i=1; AJvYcCUfZQxestQiPij25wJULp0U6qREtcXzl2rPoKUeO/5B2FTPRp14aGbsuJKTJqTPNz/vwJcIwH2LHVcJgNs=@vger.kernel.org, AJvYcCWRXMeykaEJfPaWqXAB96uCExWdbjO0aRxQvh5rg57g/V0QeeRz5nmLrdGVdormhDu6TSKlA/ZuH/OC8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfyhthByHgvt0i40SqNGJ5KhH6mkoGs5qfeh+GN1BWwlicxqy
	HWDg6n4WWK+MXNuJj0OrwyPZNgmN3xGAbnYr/ulDITcUeblCFxq8AgxP5hq0B7rH
X-Gm-Gg: ASbGncugqj3yB7z14oS8/Iy1W5vCNMXCa47gBDfO/Rp/FY13+WHXVmKNXXMo+kMq7dL
	9DNNCdErEGDt/aksyAFn/7a0fIu6DYZeLGdGb2FVcWU+cUZVZOM9u42qlabXzNsOXSi/E6gW+sF
	5c/nuUCj2eX36+s1qen691vGH7f4Tow+vo5BfqiLMM11geFRfHriH1rBn+DpEcG+DlcsdbcdwjX
	fUol7hC/3MwhIR4RBSiyHvenOU51HKfwym58K2W86k7py24pGoM0jJxgMyVMV9OJW7qbX3eFZhO
	Bun94H7E5lUwkwlb+bPVVHVNmqCWPZsiHjPbWaWAkskX6c8btnUCZ1LTg0B59wfuWvX7cZU9aUW
	YSZDSF6YcYNU2TRaqCwAYZ137z2EcjVbd
X-Google-Smtp-Source: AGHT+IHgT5O0Iq3yZz68l1DnW8bbga5gPsAheej3jhuIVZ6EgFLEZ3o2jOGtaQ0DYWIboOiRFGYRmQ==
X-Received: by 2002:a05:6402:4304:b0:608:f493:871c with SMTP id 4fb4d7f45d1cf-61797d6ad0amr2329670a12.14.1754490664668;
        Wed, 06 Aug 2025 07:31:04 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6175ee53a1esm4730587a12.10.2025.08.06.07.31.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Aug 2025 07:31:04 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:31:03 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v2] mm: fix accounting of memmap pages for early sections
Message-ID: <20250806143103.xkdz4sinbhcq4vyd@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250804151328.2326642-1-sumanthk@linux.ibm.com>
 <20250806090320.wdt4zsfiambtgkvy@master>
 <aJNOs0IB1d33GSSW@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJNOs0IB1d33GSSW@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Aug 06, 2025 at 02:46:43PM +0200, Sumanth Korikkar wrote:
>> The change here is reasonable. While maybe we still miss the counting at some
>> other points.
>> 
>> For example:
>> 
>> a. 
>> 
>>   sparse_init_nid()
>>     __populate_section_memmap()
>> 
>> If !CONFIG_SPARSEMEM_VMEMMAP, and sparse_buffer_alloc() return NULL, it
>> allocate extra memory from bootmem, which looks not counted.
>
>Currently, the accounting is done upfront in sparse_buffer_init(), where
>memmap_boot_pages_add() is called for !CONFIG_SPARSEMEM_VMEMMAP.
>
>The function sparse_buffer_alloc() can return NULL in two scenarios:
>
>* During sparse_buffer_init(), if memmap_alloc() fails, sparsemap_buf will be NULL.
>* Inside sparse_buffer_alloc(), if ptr + size exceeds sparsemap_buf_end,
>  then ptr is set to NULL.
>
>Considering this, perhaps memmap_boot_pages_add() could be moved into
>__populate_section_memmap(), with the accounting done only if the
>operation is successful. What do you think?
>

Looks reasonable to me.

>>   section_activate()
>>     populate_section_memmap()
>> 
>> If !CONFIG_SPARSEMEM_VMEMMAP, it just call kvmalloc_node(), which looks not
>> counted.
>
>Sounds right. This means nr_memmap_pages adjustment is needed for
>!CONFIG_SPARSEMEM_VMEMMAP here. I will recheck this.
>
>Thank you

-- 
Wei Yang
Help you, Help me
