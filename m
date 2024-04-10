Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9EABA39
	for <linux-s390@vger.kernel.org>; Wed, 10 Apr 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766834; cv=none; b=QCV/77hF4rCyKHEnK7FDBo9aOotQ3cZy6tCU8NSOQadCROqsT8s5tORbVZ2CYt7HfNV7b8XAOzPgmI2luMjp6JuNNPTWQEUD6G/tmRYmu/HTAhCJpoKpUjvtoPpx0m1bC/YY/tpCClfRod/aaIuIcwQm+J6THWCj5lqS0bIfGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766834; c=relaxed/simple;
	bh=UMS/eyWgwHQ3yM65JOAqgS7M+xl3pWqS5ZqjDWpiBFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjcnuuPRJr3vZ5WFLm+yzznWMlli6qmMMYfAPM4tPPIO3+nySHHEEcQDQY8u43e2aYi1yuMx4f2NOd02Ho6fSTDlC7froJJajTdheQb7WVCEL3DHVVy8fp3gYASEwIltoKvKqZLO+NRuf9ya5VlBPvg5r+J0RubqU/CnnH65rDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxM7bIKO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxM7bIKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712766831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqUP56LAHm5QWmZInX2pt0/23Oe37lP9qAH/Ei2rnL0=;
	b=UxM7bIKO2WG4xHB55887S6UcB8fNuQYTbOv4jmlVxY66c27gi4DLEEuZKJ1DMtYLPE41lP
	NlJQo1BqYGNXBAsBejLt7RKFhb0aVptbHMZs9u8TRgk6b5jOpvdR9cdjq+UFC/N6iVtCt+
	Wbk25ubNs7Wh2WeBmqPfy+6IzWER4Rs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-NRK4h08SMZKK8-geWHKBVw-1; Wed, 10 Apr 2024 12:33:50 -0400
X-MC-Unique: NRK4h08SMZKK8-geWHKBVw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-434ed2e412fso6950911cf.0
        for <linux-s390@vger.kernel.org>; Wed, 10 Apr 2024 09:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712766829; x=1713371629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqUP56LAHm5QWmZInX2pt0/23Oe37lP9qAH/Ei2rnL0=;
        b=MF5LVU1zYzpOQUrG3smzzHPMVomIP0TKtHxQiiApov8RGhRQ4crwBnhh1I33Niotuz
         b5e+nre6AU7B7VquiDcy8lv+OZaWGlUiKX9cddd5VY/duIfxNqtcAWihAOI33xp4DRBr
         hMlmqB1scK+G6wiGpqqukZVfdMBbXYopJQwdjLY7P6s1NgDEUTRiuBZlpf+33AGPNzdo
         BZsJH/+6umkk86/rek+Q3ixkNBZvXBJHipMkPp/8ZM+d8MVLXPvFDUaC8NE+Tz4n+gpy
         qF0WHc7H5nGpu3drkix+weOoo/Fs5RWkYQEKTUonjLQyPpz9X+1vOIQum2GrUrn3Qvxv
         J31w==
X-Forwarded-Encrypted: i=1; AJvYcCWQnbXXgagWDfI4dfFkDsS8f2ZGxpjjJwTnpXmdwxWjjZyPWCcebaajveR6S0QWIodpjV/1D1gz7Tw/FQCa7YMFDln43fwy0/g45Q==
X-Gm-Message-State: AOJu0YyaZQGBhbP9xun7HGzgYLgIoMTK/lUbRNnxIILeBu4ceD/rcOFd
	SCIQo/fY7MFXtGrVa7qI86OLIx2Yl/e2RW4opgnhsSaNg9MpHUzFyNxkbLBncFoCyW+FdItgMRp
	HvvMz+naPfeFbR7WGQziPFsmNxwnrpBTr1jf9SaviSg661U4P5WdQhyYwfiQnC1s+FbM=
X-Received: by 2002:a05:6214:3018:b0:699:4a1:e12d with SMTP id ke24-20020a056214301800b0069904a1e12dmr3340424qvb.0.1712766829182;
        Wed, 10 Apr 2024 09:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhHEeK0Z21Hv+XY+0uQzZDjNJnCyA6fiR8by+XEvbvIcY63kybP9mgoWUYTyVjx2wWFUSKrg==
X-Received: by 2002:a05:6214:3018:b0:699:4a1:e12d with SMTP id ke24-20020a056214301800b0069904a1e12dmr3340388qvb.0.1712766828551;
        Wed, 10 Apr 2024 09:33:48 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id u10-20020a05621411aa00b0069b407ac4fasm529376qvv.6.2024.04.10.09.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:33:48 -0700 (PDT)
Date: Wed, 10 Apr 2024 12:33:46 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, hughd@google.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, iii@linux.ibm.com,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] mm/shmem: Inline shmem_is_huge() for disabled
 transparent hugepages
Message-ID: <Zha_auw6yBx0YRWQ@x1n>
References: <20240409155407.2322714-1-sumanthk@linux.ibm.com>
 <594dbec7-b560-44e5-a684-93dcb8ba85df@redhat.com>
 <Zhavr9NxvayDhU9X@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <29b613a8-f0d5-4f5f-adbc-d64ed8908044@redhat.com>
 <Zha5V0QxODZR4qOW@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1ce2fe6c-b56a-4582-a5d8-babc8fccef52@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ce2fe6c-b56a-4582-a5d8-babc8fccef52@redhat.com>

On Wed, Apr 10, 2024 at 06:12:34PM +0200, David Hildenbrand wrote:
> On 10.04.24 18:07, Sumanth Korikkar wrote:
> > On Wed, Apr 10, 2024 at 05:51:28PM +0200, David Hildenbrand wrote:
> > > On 10.04.24 17:26, Sumanth Korikkar wrote:
> > > > On Wed, Apr 10, 2024 at 02:34:35PM +0200, David Hildenbrand wrote:
> > > > > On 09.04.24 17:54, Sumanth Korikkar wrote:
> > > > > > In order to  minimize code size (CONFIG_CC_OPTIMIZE_FOR_SIZE=y),
> > > > > > compiler might choose to make a regular function call (out-of-line) for
> > > > > > shmem_is_huge() instead of inlining it. When transparent hugepages are
> > > > > > disabled (CONFIG_TRANSPARENT_HUGEPAGE=n), it can cause compilation
> > > > > > error.
> > > > > > 
> > > > > > mm/shmem.c: In function ‘shmem_getattr’:
> > > > > > ./include/linux/huge_mm.h:383:27: note: in expansion of macro ‘BUILD_BUG’
> > > > > >      383 | #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
> > > > > >          |                           ^~~~~~~~~
> > > > > > mm/shmem.c:1148:33: note: in expansion of macro ‘HPAGE_PMD_SIZE’
> > > > > >     1148 |                 stat->blksize = HPAGE_PMD_SIZE;
> > > > > > 
> > > > > > To prevent the possible error, always inline shmem_is_huge() when
> > > > > > transparent hugepages are disabled.
> > > > > > 
> > > > > 
> > > > > Do you know which commit introduced that?
> > > > Hi David,
> > > > 
> > > > Currently with CONFIG_CC_OPTIMIZE_FOR_SIZE=y and expirementing with
> > > > -fPIC kernel compiler option, I could see this error on s390.
> > > 
> > > Got it. I assume on Linus' tree, not mm/unstable?
> > 
> > It's not yet upstream.
> > > 
> > > > 
> > > > However, default kernel compiler options doesnt end up with the above
> > > > pattern right now.
> > > 
> > > Okay, just asking if this is related to recent HPAGE_PMD_SIZE changes:
> > > 
> > > commit c1a1e497a3d5711dbf8fa6d7432d6b83ec18c26f
> > > Author: Peter Xu <peterx@redhat.com>
> > > Date:   Wed Mar 27 11:23:22 2024 -0400
> > > 
> > >      mm: make HPAGE_PXD_* macros even if !THP
> > > 
> > > Which is still in mm-unstable and not upstream.
> > 
> > Not related to this commit. I tried on master branch.
> 
> Thanks! Can you try with Peters patch? (ccing Peter)
> 
> If I am not wrong, that should also resolve the issue you are seeing.

David,

Do you mean this one?

https://lore.kernel.org/all/20240403013249.1418299-4-peterx@redhat.com/

That's indeed similar but that was for pud_pfn() not HPAGE_* stuff.

I just had a quick look, Sumanth's fix looks valid, and IIUC the goal is
also that we should keep these build checks around for the long term goal
(Jason definitely preferred that [1] too, which I agree).

I removed that build check there for pud_pfn just to avoid other build
fallouts for other archs as a temporary measure.  For this one if it's in
common code for a long time and if it's the single spot maybe it's nice to
have this patch as proposed, as it means it optimizes the if check too
besides fixing the build error.  After all referencing HPAGE_* with
!THP+!HUGETLB shouldn't happen logically.

[1] https://lore.kernel.org/r/20240404112404.GG1723999@nvidia.com

Thanks,

-- 
Peter Xu

