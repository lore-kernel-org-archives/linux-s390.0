Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB60631A567
	for <linux-s390@vger.kernel.org>; Wed, 29 Oct 2025 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773025; cv=none; b=IuzigrKG9UtBhHFIF/P6JPyYM/l5iGtQYg6+hq2bu8TXHvtkj9xzzpATKO4VQBBfdoWLCSD43g2gKvMg8r9H+GLuw2riZYTeLdZt1lAa75IZaxjWEvS0e2Lyb3otyg/1tg8W1kgr728A9GLwq/2zBcb90lLnA956jmHdG5V35H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773025; c=relaxed/simple;
	bh=ehgfTYPPDlsusZMBOPSQ1VgmMj1ez7+siAFBL0GrCb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jfrk9mRwAz1SyHZ/82u4rALW7i58NQDuYytg2ho3JzVDdscF/gA5aqCW+DCiHtwy7rpS5afto6CkhRtWkspkH373JWVw2zMc+KKXPUxvmx3tli9nBpUnw3av0dMh/fVFauCQC9ayVyjbBXKC5cXWJag30ykHa0PH2sE7GmVqwH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=urLqhlLl; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="urLqhlLl"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-89f54569415so31776985a.1
        for <linux-s390@vger.kernel.org>; Wed, 29 Oct 2025 14:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761773023; x=1762377823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aRjtLU1r2HfZv4PRAYf6oYIopT/Rmxw6gRmhQBXOWjA=;
        b=urLqhlLlu9UJRrNAv8mxw8gJSp5bTU1q4MfB4xz/BNdfJojwPWc3ojV+Xqu7d88+Gi
         cx2KJuVyH2djo08+S0tPYNoHfLa5P1ipiuJCTfFnogktqc9DCKdKt8ZRfcGZX77HKkUv
         9bk2VsOtQpbQfvzRNkzRF4w3+4Fm+F3EBJVJAoElPSdBVO8MwUlvqk39+rrAz5ukULGw
         4Q+nxxdFSwsmvwnWS4fleRIK/xG1X/CQt/XhSd9YIg4BgQsxkbc0TIyrARhRlvSwdwU8
         fbhCTOvZm4jtYMSrfupKg+0YP3/iURXwZp5hF5pg8Jv73Hd2Xi9YOaS7C19p8tExVTjR
         rFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761773023; x=1762377823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRjtLU1r2HfZv4PRAYf6oYIopT/Rmxw6gRmhQBXOWjA=;
        b=iosWhczquytorjvnQSgeF4jiQeHoF8QBObmsysEZcTeUNKOmKDZwdLZndYRccwFx58
         8eSTvC70iYOhPlpx/M8/RnMrVWGLvaqUw5nOxTcnqb8cqKqlXYMQ/HJI4j1lk8V4py1x
         IIaBoWb1IsNuZ8DD8YKPVjre8Y99euFUxuNyANsNV4WZxsb1M0I/BObVbLSb3tLJrqH5
         HO2y+p/RoT7LqfdadLHJJzdnR869l4YxKMn0jSSfbcoW3v79wmg8q+mb53hyNYNVbokH
         CVNoBLh3Ct21DOp+FNtv3z2DkELCYm4oDtKA5cj/ChYNuZOQgi6OYmgQQS/4S4iMOUbt
         +oEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4dBRVLvKzKpgKQ1e+VnC8YfTanroyUkessex1IliqTwiR1pmGPjqEJzD1iKCrYldNykMr3k/UONSo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Q5N1bij9v4YDDrftStwJKvYRi+bD66krTUyZL4p3N5ynPbyC
	PUSg2mlRuxaAn5suJN91Y8fX7b0xyoDxttcqXWgedDOzBOmNDyZIdULAJQOAHiO+T5U=
X-Gm-Gg: ASbGncsXhe9LU4YppnhZ9Ttr8DumjQ/lVyErPWYMpQ4qtD7b9yFswhqaljOoZkgW4tZ
	hLfiP7oiRU7mG9vdlaUi6XFyoQMi3l8GyjLlwbrUR6XTA4GuJCExrj7JgUOWZ60wBJ1msL6/gjK
	1WjlUUsm4TtTaEhGzOp9OlSPGv4ztePks70+MOhR9B8Ach5j06nZNISXOXXZbFAkMvZ7OuMWf2X
	McWJmRqtkeTBjLs6IZfLsQFZOeVEIyeId8xo5VfzrnATP2IIJJJkjwzjYidDYy8N6WDUzXl1b24
	W+ltmv89ObyILHMGZiSHNE2/AjgZH8xibny77m7sf3INUaCbA6PTQ05/Cl411p9J9JEyn26RJIK
	sU+mYdWyUUMlAytELPf9SlQ4FJgr5PBcOomngcb8F2+iMIa/T5qEQZu/9kSHTONcrQ/D6ebvS+/
	ehIkvskwdUeo8ykeeX059LBjA6t36RX/ry1Pe83/1AkkimJiL2CrtVS3y9Va0=
X-Google-Smtp-Source: AGHT+IHIvemppeW4VU2bcQtfcjjrB/a+ZhJ9fpfDcYpqh7YEbBY+IwMLRkdQTC8NbNXnWXScRwyJQw==
X-Received: by 2002:a05:620a:29c4:b0:82e:ce61:f840 with SMTP id af79cd13be357-8aa2ea07948mr164184685a.84.1761773022583;
        Wed, 29 Oct 2025 14:23:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421fc6fsm1114391785a.9.2025.10.29.14.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:23:42 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:23:39 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [RFC PATCH 00/12] remove is_swap_[pte, pmd]() + non-swap
 confusion
Message-ID: <aQKF2y7YI9SUBLKo@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <20251027160923.GF760669@ziepe.ca>
 <8d4da271-472b-4a32-9e51-3ff4d8c2e232@lucifer.local>
 <20251028124817.GH760669@ziepe.ca>
 <ce71f42f-e80d-4bae-9b8d-d09fe8bd1527@lucifer.local>
 <20251029141048.GN760669@ziepe.ca>
 <4fd565b5-1540-40bc-9cbb-29724f93a4d2@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fd565b5-1540-40bc-9cbb-29724f93a4d2@lucifer.local>

On Wed, Oct 29, 2025 at 07:09:59PM +0000, Lorenzo Stoakes wrote:
> >
> > pmd_is_leaf_or_leafent()
> >
> > In the PTE API we are calling present entries that are address, not
> > tables, leafs.
> 
> Hmm I think pmd_is_present_or_leafent() is clearer actually on second
> thoughts :)
> 

apologies if misunderstanding, but I like short names :]

#define pmd_exists(entry) (pmd_is_present() || pmd_is_leafent())

If you care about what that entry is, you'll have to spell out these
checks in your code anyway, so no need to explode the naming to include
everything that might be there.

~Gregory
