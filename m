Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC863EFD0C
	for <linux-s390@vger.kernel.org>; Thu, 14 May 2026 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766829; cv=none; b=XI4RUgHPVwpJB1vFnvQz0RRLwB9LrWuFbX73OJxLhq8YzoXXorZGGgNOrNsCfvbkGW4ow++xHrDlfGzSyqRboXaaZEgcMAfoJ/w1Hep8IO2EHwhsJSpuKg0J7FeChemy0WcC0czI8kJUIVqcrOYnAhQ95xUzMy64cJiyB3YGMFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766829; c=relaxed/simple;
	bh=csuW3myMDRTwfSkVr/fGJ+LdsWf9iBuZuAecKJ3RvRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irNWSQ0f39bw/Fct5UZyFYeH0YW70quMaPz0L5mH8+JMdSKgYmDvcQJuleY1iEfREafs7qcnpr8sVusfqiWnEFYM+1DzNgXp3jSD+JbDsHuyNcg1quclfVewavpMl3sM/FF9yUSKelaH+tSBGrkaGQGXpZ3fcg5cx9cNgX9JwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SLvnJSqG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SLvnJSqG"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-910bb291688so118806985a.1
        for <linux-s390@vger.kernel.org>; Thu, 14 May 2026 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778766827; x=1779371627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+SudBIcbJEYVdXIJisNlY3md8aZgEue8Fntr+vI0eA=;
        b=SLvnJSqGYHVg8h76hYJGqLa/UBEquprmQ+54IoOJ8tLTQsMjASRA5VOoUvFJGAr4jR
         IIdXJmTD0senACMG7slIzQpY3Q8AEF711ZcdzHKrnpkAQbvCIaQfZQYMm0kQX0XeBq5c
         vsk3U/0Obh+72vcKHuYT5MXeNSxKw31q5aEoKg4DzvhlKhwZJlHrVV+gYdtw+UlsAsNb
         fGhMiILm4xIi+Jnl9UVYHzy0zvNRW7EBsEbfYIbu+V4to+vlXz6QuUatvabGYU/glFLN
         IB5Z6J6pk6UbxejQngIXueO3oyJKQ3l2hGy2DcSmjbTW1qcZyEmWe8R+6ukeLoNgt2pE
         nmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778766827; x=1779371627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+SudBIcbJEYVdXIJisNlY3md8aZgEue8Fntr+vI0eA=;
        b=Dg09OX12Zu50mYW2vU3uPvk6lpGdj+m/UdPtQCDk6hqj4tvB7KgQudxxfDxsq6a/lC
         XP7o6/eNClOV0K6CRdEDuWP6zqUdihxadsZjHTS50W6OhBbR6FwuXcPWKmM6Cp/Wcyma
         7uRoN8njCyxSa9MQov+Pb2Ag1nWigIGniaSL8N54eBZU5QhKwC5bSZAYYZuxUanc5CiB
         GpHLDt0Bj7kEkoiJb8iFpicVYq8yl11cENu22LP5yYQSekMTS5EXM3z1sA/ZL0D8A0iz
         SkUD1oK90G8vXki550/KAyaOCuluuvHRQVtosIndL4FxdOSf253yXsIz0l5bB7U98b7X
         aOCA==
X-Forwarded-Encrypted: i=1; AFNElJ8PzdQIZ/3TgNfAH/qTgaua5NLPPjejW+UeVj1u1phG5pTXJ2W0vWYNnNLnf+NaOgTyBK3TwHCsAtZq@vger.kernel.org
X-Gm-Message-State: AOJu0YwmDJ4IPdT4x3cLq6duAbYwdeFGiKUKmGlfnOGJPzZZf3dbyMHk
	21clqX5c2w7V6Fi8/dM6FRQkdhp830IwSKPVKAGQIKbSLxI71zOO4msZ6wgNG0PZQCQ=
X-Gm-Gg: Acq92OFi3jKjVgvpJj/4QAcphkynm1el05jn0TIO5jQ2JVTKChA1Bpos4itGImQNFsM
	rIPu/XuG4cVu+Ot1sv1DFwBzmWIbkV0oI2uZzxDLDxgjDgqjMMOeXioKO/o09dhVDuOtU3EqOK4
	hK59M/O1Tv8rcTloHzsEjMr1an96m1Db/KBpmc6RW3WGAt6tC6S29FDneCoT1en2mBu5OCXJ562
	ey4is4gShh0+zTocbXsabQFmHQryY/Ev9n6UJAk5sP9ZFIxfNeIoof3XLz2ihtTA+CkexInfWB9
	Ro/DgPKMR8URpe6dWJv7vDVJmOuTBUA5JasntIeb5VUKSPpeniViJI9IPBYZ5rHwl6mQg9D3SZH
	5bTfZNsbmd2uwkUbiJfd9t0xJq5A2HXeh2BBYFy0GxSekeNzjhxxdqx2ANwo70NEWtick3JLXyf
	tiFwyfX6Ih3QwGfZEYLgUe4JOnnKTBCpJsyoFGL8tbqFXx51hWqCSClI9umlOcl3Ntw8dCsLqr5
	UvgeS5jS/C3
X-Received: by 2002:a05:620a:7283:b0:90f:d004:5480 with SMTP id af79cd13be357-90fd0045772mr809098685a.6.1778766826553;
        Thu, 14 May 2026 06:53:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba9454basm253697485a.12.2026.05.14.06.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:53:46 -0700 (PDT)
Date: Thu, 14 May 2026 09:53:42 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v7 11/31] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
Message-ID: <agXT5s4FLL54MS-e@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <7d637bcac4bb5705388136a75f0fdfe2881e5f20.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d637bcac4bb5705388136a75f0fdfe2881e5f20.1778616612.git.mst@redhat.com>

On Tue, May 12, 2026 at 05:06:04PM -0400, Michael S. Tsirkin wrote:
> Now that the generic vma_alloc_zeroed_movable_folio() uses
> __GFP_ZERO, the arch-specific macros on alpha, m68k, s390, and
> x86 that did the same thing are redundant.  Remove them.
> 
> arm64 is not affected: it has a real function override that
> handles MTE tag zeroing, not just __GFP_ZERO.
> 
> Suggested-by: David Hildenbrand <david@kernel.org>
> Acked-by: Magnus Lindholm <linmag7@gmail.com>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

