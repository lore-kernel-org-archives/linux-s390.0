Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BAF31E0F2
	for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331268; cv=none; b=WfxK5FZYotqPZV8xPXrM9emmhOCERMnUOhpp6mr60uYPytfxZsy91+khwqUjLzcRiVeAaZOr13deo2Kaq2sAUVtbKQW+xQ1yQhOSAh75E0Xqzi026zM1ikzzC0EI6wegnLoD73/9ckwqkkUePFIs/l5e1YoExrMne3N9Ghee62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331268; c=relaxed/simple;
	bh=0nC8tJfsbUxYAiM3oB8e/6iPoDpwQx4IwD1lKsUxMmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU7NnK2sVPnLGMLzPQ6FXgCmIBaWHsrpgYG+T/Ve/yLbWDOkc/XU1Hip3r0hmRRRg9Dz/KDesMF4/SWN97h3U60JHo90I0M1vgb+QjMWco2VcN9PnzowpIwtA8KiLkcQ1eTx9e5/8xpw/pS0qugbHdB/sifw23PzJyHMp2vsLEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BGyX8JeR; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BGyX8JeR"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8906eb94264so258632985a.0
        for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761331266; x=1761936066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKqOWG1gpzHwxwYl3SQC/dTHK3GeimTlZWo8wLiUVXY=;
        b=BGyX8JeRXEcu4pr63rHWRLPkb+MIPvJk1pfjW/kGtqHWCx/l7kobKlb6qKNA4J5LvK
         6yTqO4lbvILYPnhvyamfWOyygZkULwde22ElPZcvDjAbrZf35Bjbuvr0uF5pAlYUuliX
         45Ypq8+gYGFk0DNuaJE/5KuPXKhupuGY2eyZSnuR2TLUIahRmhs6v1k1GHZpWOUuolPH
         Ch+Hzyquuq1vwUzB6sjGuFajYHxKZb6M5gB9GPXEaqIWpOKXltFC/7q4SYswK3eAvp23
         TWoo/Kb5dx+2BSk4k8QoWyX8gC+bEhTY+UoGX6YtShx3Ph4ag4IQPGzlIpm4FJ4R2xof
         CsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761331266; x=1761936066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKqOWG1gpzHwxwYl3SQC/dTHK3GeimTlZWo8wLiUVXY=;
        b=e8nuHtUgeNRcqM7m5OMRF+6PGuNlfm9SEGayTCTP04IICTBPUihLT+626frj7FjI+s
         m5srKvKYRFKJrmWSER8RYUyYjy0ga6iZkaZnO9xgPvpfh7xWMoXwobVDmkYAoTZXRBGz
         Q3i2qPt1lDzFUz8DvN/NZ9aHrYahn4itD0NDzSFRpj0akOCggOO7ZtdpsIcEPuoE/8EC
         Ke4F34X0T0Z9wM0gLb684ngYACDR93QPMZ+6m+SmfFyN5qRODyTNG8GKUD/ClTJ2SPqX
         c9Novu9gR775w0jHEUzHs4c9bHQxqeRrFkymJIOjOEDMaSFjpSQH2rcG4M/NirLIo0rL
         s43g==
X-Forwarded-Encrypted: i=1; AJvYcCXldNjJV+naoZ14q8SFkbkluf/pztLEYZMlzjfEMPsPEOq90u6NFrxR9RICJrDnjLJV1wwgjeQ+8lHv@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvaEH2YkHn1IAk+NQFnrJ+7Qpv4lm+zflicxOQvgULql/ePiP
	y+xoXQ1AQp9vTRRZokg7Qd8QNsY5NqcqHa7sRkxj38lz0m8okbr+e2282Dv5+6EiqQk=
X-Gm-Gg: ASbGnctb3S8qp4mouW0TwR3vQ7iL5aHeTFkXyTT1CcDIuc2p2HQdIBd1n4iy0cY1+Gc
	/FjhkRtRqSveQ2xxNQxmYZZFnt/7rcXr5dF3i2BVxxOBLHrzCix4ApcvUQwFLyROUAVhMr6d1Wa
	9O6hEBKyPFBlE9n1lThqA8fA9a+Afr9oUaBp6ZkVTap/EkCrLFI8pGliiRFdcP7rdBvvCLeqan1
	kwOgQM0c/2BUc7xJ9pPU7NTs844/KUFRbceg3NPU9AObu7PXJa0Y5oxGbjj5E6AIuHXWjBWAQ/M
	/g2aReCzCXIh17O2y7Zzwkb/i54AwsLd0bCh69Hw6e04qC7JRKKEDlrCFx0UOErBQ4tpafOX12L
	D9GNbkv9CBJjO2VTkuRSpk4GN0liopry58LERadzZLCCKiWWrchKfymxsTJJzpgbAw1Ao4rz3Bh
	iyAgW1NvIMhD65W262ijTaMGmjeajO5tYP5FzpkQBXnKPGR4efzlUYCuBxIAmncpfKld7tncRcI
	6ZhHnt6
X-Google-Smtp-Source: AGHT+IGnY4R12t5EHq14eSTeJNU2ADxULRmUNWe43hSkC8AnH74fLNRTNtzJmefk6NfxewScJ3xiIw==
X-Received: by 2002:a05:620a:190e:b0:883:5640:b0da with SMTP id af79cd13be357-8906e2cf39dmr3403918985a.3.1761331265598;
        Fri, 24 Oct 2025 11:41:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c0dbcd225sm441582885a.12.2025.10.24.11.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:41:05 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:41:02 -0400
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
Message-ID: <aPvIPqEfnxxQ7duJ@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <282c5f993e61ca57a764a84d0abb96e355dee852.1761288179.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <282c5f993e61ca57a764a84d0abb96e355dee852.1761288179.git.lorenzo.stoakes@oracle.com>

On Fri, Oct 24, 2025 at 08:41:25AM +0100, Lorenzo Stoakes wrote:
> Similar to copy_huge_pmd(), there is a large mass of open-coded logic for
> the CONFIG_ARCH_ENABLE_THP_MIGRATION non-present entry case that does not
> use thp_migration_supported() consistently.
> 
> Resolve this by separating out this logic and introduce
> change_non_present_huge_pmd().
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
--- >8

> +	if (thp_migration_supported() && is_swap_pmd(*pmd)) {
> +		change_non_present_huge_pmd(mm, addr, pmd, uffd_wp,
> +					    uffd_wp_resolve);

You point out the original code doesn't have thp_migration_supported()

is this a bug? or is it benign and just leads to it failing (nicely)
deeper in the stack?

If it's a bug, maybe this patch should be pulled out ahead of the rest?

~Gregory
