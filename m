Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949392264BB
	for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338244; cv=none; b=YZTzu0AcQoOkahuB+4pFdk/ZyBzcd/J9HfpKm5UzPO0ugEzAkUTDv42YPRmoPBoiKeEqrp8j8DwMprP3+1U5nTfvH14k3Eu5CbRD2y4/obLGPJfMuAkJf1DcEo6H/5pbZ9KdvAKJPzSUrJqnAiFaha5vK97AaoxIw7rdNXKJZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338244; c=relaxed/simple;
	bh=brPT+lM2XPdvJ0J0zQqzP3FRuejOJIrYJjvdheDJC0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huh+jRXCUOfU2J25+uuAaxhNg1qaTPwVG0gglPW/4zQ5472EWkM1rLVZ3e4Tn8BIwIvhxAh+YDcM8ykaHAX95734WdglaWH+yf+j6k2pRV7IOYOwKvZLKCKOE3vbfNMmD0QJA0dQVykZJDIJ2rGukrvZ1EB+egdCK+AU36VsKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qgjWqiQg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qgjWqiQg"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4e89d2eaca9so15516671cf.1
        for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761338241; x=1761943041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn4hQEcGul2fUa7R/OzGXx8vWTt9TjtrdGmgBs4cZEg=;
        b=qgjWqiQg7Mw0bd6Y7P3gb+spLRaKxWc55mXCg5lTEioPzr2WALPNAO9coZW5YwSU/Q
         CutOTbPQFirUB6W23YGRV/4n3KJAwDc2HuZ1vmW9vsHfhTQE1lFOzrT1zKthKJ1vN7w8
         J99nIJOu6f1vbKH/VbY6iGK7SaV9bmoiquLKjhFMYlujpJGyyVA8Y6ikqLPzjJZE3K4u
         OZgIq3WLWE0V48aNTFEFsT8fugi2BJ4QfjAxzSnSHsv/2yqeA/JFfFAvF5Jn45VPjnM2
         VbQo5z+uEOp/ZfIDudxeAtIZujmHqqIYhpz5spR8VsG3LNndPL57lSFQQ4mQS3eRwY0J
         boJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338241; x=1761943041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn4hQEcGul2fUa7R/OzGXx8vWTt9TjtrdGmgBs4cZEg=;
        b=M9TBOc4791v8I2WmTbuqwI4NqIr6e9VY+WHWboRijCuU8aHm+tPHc5tekQVGMIYNic
         2u6T9CFaMAWQDf9J/9O4odBn0XBe2k8O6CZQEJhNQAhBctwKX7jRriqXOdifVWjWEe1o
         BYk01b9ZQp0poow1/dPVlRYq9va79pn5mM6IXuoMsKROd+nrCXZTGczfuN+bZb8glIYq
         P0EBaQEX4MFYuYbnOnvqqgcoqhUS9XcL00DOls4OxAckcjN8ZzlsAE+lCd1BCYwcZZJV
         wFVEGk+p6WuIFHqmawFJmk80cvRw7G6G4T76SoBcY1EwzpKI7C+uY0fNdi4hShYGOLlJ
         cHQw==
X-Forwarded-Encrypted: i=1; AJvYcCV9RxLcwDyR9Y7fQnoQHn16rgnbdG+0eePg3d807I97K/sjrzLHR0SC9YyFKAAtQwuVlUBQGG6kbEZ9@vger.kernel.org
X-Gm-Message-State: AOJu0YxqaA4pEQuZBTbJ2Y7AKXCfbP0SYy8b5pQSQJ0PIaABljh8Mtyx
	UkMgVxcrdtCeE26Y2AknIa8fuvwT+Sg5aTT1sXZmTfBzzkhYTbyJIYVOkktJ+KSO8zI=
X-Gm-Gg: ASbGncsznkGH1TdqObKAii7iY823vz64oibsoYc4WDo//B3AtOU7nohKSerLPnJPwXf
	7LsIq9P9K8YKSaTaQlYj6r+dsy6jQ0Pu6GdUiWU0WIolVxlz1uubIyrDkYrUYQAcQqM07n0GZSg
	n8xQi+pUQKTRj5Jgt9O25QfdGWplJWC8mNjhB/lFO5tYO5mGfB2ghBZhBgLzva0SUTPlxDHEymm
	/jbwy6ahILmNBSh/+6M3zMDPYpqo/cHJtaYwl9RrEDgCQEXk4DGv9sLCJw67pcBLMdl2hjYItci
	43vt2pMFqvq8byX2dSkiqLcty+hdeI9se7muAJ8ULgc9TZpUiIE1FE+JrnfHUZXCBBWoapeVIbd
	5fPgzR58PG2sWDgH+3iwG42sFc3uBZUktzaWkeu3mYq6FIUco+bwi2J5BM2TCwPMYr6K9cpo1D8
	ufJzi0LxncZz8vMfbn/EU6GBFUjR3m66Zrlo+9YW3YDcoSH7iprZ4L8v0xHlAsnyXH7Vkq9Q==
X-Google-Smtp-Source: AGHT+IEizsVD5MWKlpznZSR+oUAoDamQsr5IFux8tgX6jFrLAoh3hAikSuRK1/9hfCiWycXsqW7SdA==
X-Received: by 2002:ac8:58d6:0:b0:4e8:8ed7:da6a with SMTP id d75a77b69052e-4e89d20680bmr359946041cf.8.1761338241380;
        Fri, 24 Oct 2025 13:37:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37b96d0sm861481cf.6.2025.10.24.13.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:37:20 -0700 (PDT)
Date: Fri, 24 Oct 2025 16:37:18 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 05/12] fs/proc/task_mmu: refactor pagemap_pmd_range()
Message-ID: <aPvjfo1hVlb_WBcz@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <2ce1da8c64bf2f831938d711b047b2eba0fa9f32.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPu4LWGdGSQR_xY0@gourry-fedora-PF4VCD3F>
 <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>
 <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
 <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>

On Fri, Oct 24, 2025 at 09:15:59PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 24, 2025 at 03:12:08PM -0400, Gregory Price wrote:
> 
> So maybe actually that isn't too bad of an idea...
> 
> Could also be
> 
> nonpresent_or_swap_t but that's kinda icky...

clearly we need:

union {
	swp_entry_t swap;
	nonpresent_entry_t np;
	pony_entry_t pony;
	plum_emtry_t beer;
} leaf_entry_t;

with

leaf_type whats_that_pte(leaf_entry_t);

with 20 more new functions about how to manage leaf_entries ;]

no not seriously, please have a good weekend!

and thanks again for doing this!
~Gregory
