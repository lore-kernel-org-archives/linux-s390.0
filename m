Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B4F35773C
	for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333005; cv=none; b=PQO+DjDH6hbK1D1NotZRxdP27twlSNZH/SgQ2IJP3P7in4NG67Hg2c2142rMA1oNRVyqtYEoWJ1Dgdf5gz2DD9iw698nFP/p16kQ1/7llXUIm9dcLgWawt6NlgoYBbp0D6/UF2TXkeqxRRJQcycZYTU3YdIG5J7C2TGYuc4hMtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333005; c=relaxed/simple;
	bh=eOV8n3GyeI7NGmNQOPYmpec1MI+qOKDL2up+UvX3whg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv6Ypx8TMLDygflNN/H9lBdtD7RLaAef6Pa/2sowIst3aGz/A2KG8b17ktTS0D5k5zH/BL6WM7V/W4iTd08z5MVpp1LoYEijX7bxpcAglmad1eXbwn1HLr8nz2cLoPO0XkrRmioxHTYLwODoS89gipmPUJXc/YDalVohA+Qev2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YvjFzXO0; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YvjFzXO0"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-88ed6837e2eso356516585a.1
        for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761333000; x=1761937800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r4YhT6UkULx0zY0BI31WYEg/XWXtKp76n8KPsV3vFlM=;
        b=YvjFzXO0J6h2ss5Sjx0x/YOHwNaZ4Tm+e+WqDpFH9ACMNz46aWXSiaQsQwolqekzQO
         2buiBh7TWFig/XGHuU8xyyyCnwtmRTYFFY45EsAZmWULSomAfW1N2sgkiqXHUoHo6QTR
         7CZ5LqV7OgWZGlcGb5jecQPrBWfpBrrsKfEN6nhZgnr0/mzyWb95v2Aoqltu98hD3TZk
         IOG5fzcgJua53NNBnVpecM0fDkXU6wkdxKPJBexBF6Z3DCRjfkWDwMDZqWSMFu5PvSkZ
         K75yKN3CZw31D88pNNMrUcdvvRHb3zV1rkpRutMPmDiSN1YLdM+henQF42C8jPnce2uU
         k2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333000; x=1761937800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4YhT6UkULx0zY0BI31WYEg/XWXtKp76n8KPsV3vFlM=;
        b=jqLpo5FgVrVqrw/zg7EPPGUMOFC3d+PD0MHDPKJ3VymxKwMHg1Orr3oVrPjd8jbSEs
         SNF6z7G5+iljO/m7GVFw12940N/Hcbe9lwIXaP7lVXdbtj0Mk07neoZlmUHE5E8JDkqB
         Yv97j0RqHpcFByGbOy1UkpY/w9cjl4LtJaCKkro6UmxYz6+OvA0zq5yBNxcNpvMHm30K
         ch3flejUmiCi5i0K7x4b8DhnUvtalQ6C8a1LL5U0bPzI+U2kyyIZ28l/zR6JOF3S+KcD
         JImyAs6Z6Bi7Oowkb6lvTFV3uIaubR1tDsdRV3K//adWGXHR4QR0IWLXxKZb8t50KXrG
         2NgA==
X-Forwarded-Encrypted: i=1; AJvYcCUolD1OiXrQVRQPld0RLKe5om4fhBSqXUH1RtsMK6gURvyoLiWF8HGzyUFU0lPgL1PuuckfqhbETjdF@vger.kernel.org
X-Gm-Message-State: AOJu0YzYEc9z2KmdpLB4Ia4CSqVpiAZLGZBI3dANvUHQneAd3BzEKlcf
	ZPgiJZuHYCE/qdc55wtjHlPXtjyr8P5BU758F0G6x7H07tf6fqPrAg9eGaSRdNTBBcU=
X-Gm-Gg: ASbGnctx4oFGYBhDLtDeaZa5D9BQ85MoKKEs06n/rkvtJinBkCqSv8UBYs3W4IDJhLk
	ulWVuR4LaIugK6NgLHjgOg1hI2M4FmHI42FEFv38U+rGCFcwHcsjOp7D5reymYWRgmTc59D5Gll
	aU+p/yln8swf3Ty4P0J7TzwZ5OiKA0rK1xQLzRYkvnBsD9MBFmZGJU7k0Ayv8XeNpWZq8Zcz1OF
	w0jO7TGX7JM5+iN7m2i1vEy54S58frnu5TzIXSQ0N3Im6/4lRnqNp0cwuNQ0CnxHa/axU4UY/+6
	908rJZ7jd3QB7doHnGaaNeX3DvzjQg4YaV+Ew8cyVk4+u3S8RFP5Ckz69cFxmSsrge5mFt9Y8KP
	hh5gNGb27ekz9E6YV5g/Xh6i1zrX1YZASIAttuiYWAiqykg7DgTdudw+xKvDnmqNJOyTCweaoBi
	yhFqUg+W0WRKWoVkGScR3kWuDBG/RS9X2CXYT5v6PBMo/pGmeBF0QsrNBzFtY=
X-Google-Smtp-Source: AGHT+IHrkcPaJLyTM5pJbJ/XVcfel+4u6gv+3P752b0IEbbyKeVVUPlOZ4xL4VMnAte1FxD358/CqA==
X-Received: by 2002:a05:620a:40c4:b0:85f:82c1:c8b1 with SMTP id af79cd13be357-8907011583dmr3539276185a.46.1761333000331;
        Fri, 24 Oct 2025 12:10:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c11e631e4sm442634485a.44.2025.10.24.12.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:09:59 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:09:57 -0400
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
Subject: Re: [RFC PATCH 09/12] mm/huge_memory: refactor change_huge_pmd()
 non-present logic
Message-ID: <aPvPBS5H0E9OXEo1@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <282c5f993e61ca57a764a84d0abb96e355dee852.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPvIPqEfnxxQ7duJ@gourry-fedora-PF4VCD3F>
 <2563f7e1-347c-4e62-9c03-98805c6aa446@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2563f7e1-347c-4e62-9c03-98805c6aa446@lucifer.local>

On Fri, Oct 24, 2025 at 07:44:41PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 24, 2025 at 02:41:02PM -0400, Gregory Price wrote:
> 
> You can see it's equivalent except we rely on compiler removing dead code when
> we use thp_migration_supported() obviously (which is fine)
> 

derp - disregard.  End of the day friday is probably not the time to
be doing core patch reviews :P.

Cheers,
~Gregory
