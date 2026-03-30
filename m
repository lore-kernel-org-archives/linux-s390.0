Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131432C3257
	for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2026 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774904225; cv=none; b=rS16wNv6tdeTC+Q2pFaMNIuIYuvuVTWE9fS09mOu7x4fBvtyZrsoepRGv1T5Ss3NYV2bbvJQEOiHaHpwh/a/uGm9Qo4ciEVFcdRomgCZ7gILMdUk62ii8PyG+FA89ifVrNRRUqmizoOV/+9YA/Gk8tTy2eSOcr8zh1PxyyYIRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774904225; c=relaxed/simple;
	bh=AqDyeJBlFvD1ECz+1bX+PCvLbT7WHT5dPT2WM4h/fgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4LpD7YQmMSVPhQT4B1Upyw/406+lDjtGNlALsIGb7v5ICM0lA3njJ+sPS+DhzZvzpHbZ4q50+YsIztM+rtVi7vW3K6J+EPD+6r6BjDsC54HUixHGHnDP6DzdCxpqRIwiaKOdHmsN8Nb6yDtaY+iKXF7zREwq3xFqAIBEIcuG7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=RtchhClp; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="RtchhClp"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506a6cf8242so43688691cf.1
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2026 13:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1774904221; x=1775509021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xkx0jjaeGcgjHSJFqfBmG/G2bLO7kuY+j9mFgCW8oA4=;
        b=RtchhClpWhgXuv6mMfe3Y41QOueuidVXs+A/wVekfbvTDrGDYi/Xj1k8dGPre3q1u+
         r8oVKmfrtQQpt3hH/yx/KtKOOqnCqIq+Cx03V+unff3uaSQbsgwGaEyMArpIumfGEHub
         88DgLMal+9I6pOYRUS6SD8L3Kbzm01z0k6sfjSB3fbCTZJmr1l/x/MMMdKipbwRU0v2B
         +Ulx1C2yuERg5RmeeLGrMSxl4AQ3EiwLl/w9L8cx6Yzm84z5JRnJtCieDo7cLwr+PZUn
         nIKuj+RV8UbMtiiSlJ8E0LgkAwbmN6WPSTr2K1Dd7RxzXgnUvrnKmwOcbygKvr1AEdxa
         Eiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774904221; x=1775509021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkx0jjaeGcgjHSJFqfBmG/G2bLO7kuY+j9mFgCW8oA4=;
        b=aHy1SaTi/gPawL7VAgVkBY3Py+rGpkL8IpdKmy5pd2fwJwQ+qUfQ4J9OZj32aAtwoo
         IlPQF2bvDUgPkgLtGWVev1F2SsdkG7+Mb1KvXWU/0jSVKcs8RW5wMk+uc40NXzOpqsi0
         UeHhRmfDvRmW1zMlRXDONyRnSZwp4O49sd4qLhdu3kKsXJN3LvcmWCmYqbOjgguA1VFD
         q4YCQ7liIWI/jg0FYszPZwAkxxp1zYaGt73+AezxMzyfxCANyKlO0edxeWnkY2RCQuPI
         JHUsMLnAIQb5YYwreu71OH8ER0jkezmoA14/HtEeB8hHbqNVoPkXagxgmULGtzGq0WjG
         t68g==
X-Forwarded-Encrypted: i=1; AJvYcCUwzRE2nE38bhZCmtzjri9LTVkkHnWvaz3ktkJqK5AGjcIIQyYJZGKHh+ICQWysuhuQNuKXWoS67y+b@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8jakrZkzlygbHzyAxZ7wQKDZFybPqn5MceJ4oIfQkA+71eN1u
	OOZQVgVv0pWyefa9QVqN9RknbOt+RsXFyvvwfM6/ZG5rPWZR4gcHyw87pkjNgkxP540=
X-Gm-Gg: ATEYQzw2ARSNQ8thZ4ymuBypcFeYdjM/JSlR9XNCz0ply9XLakwWQjQtLKk73E0vpXj
	RcqBOFnUPSOVrMFNQCoSLdp1JsfUWyZRjmzrpt6Pm1gTdXLnx/cpIjrxITG9SFhaIm2tVWdFqnA
	fwk2nlNdvOWg2XRjRCSABK4/KsxyGQnmkb4VOM/LakHYPhXem/CsusNHFtLZ2NGZsHQ4RcLBnxL
	NuXdimc4XjlqrYz6AXluMmt7tKPplV23suEHh4J5OaAmRV8nePtcLXlfdKDqrLQ3eDVHIqRmkwV
	kKumfomzqupk910NE05qzBSKcFL/Qd5g+uOrFsXbn/l8tRGY2jsg9fsdXSCeV2y0nLi3+axikIG
	ApiELXa5FqCCae/ToWn5yfWf7ci+2woH23TlJLfdJH4nyQOKm7DMOZoY/cQZ/rWXNjLRB1IppBH
	WiKmCk+fzeuzUQ4tXM40GhhA==
X-Received: by 2002:ac8:5848:0:b0:50b:41b7:d6c2 with SMTP id d75a77b69052e-50ba39353a2mr178029041cf.47.1774904220847;
        Mon, 30 Mar 2026 13:57:00 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb3df388dsm91004571cf.6.2026.03.30.13.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:57:00 -0700 (PDT)
Date: Mon, 30 Mar 2026 16:56:56 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH v3 7/7] mm: switch deferred split shrinker to list_lru -
 [s390] panic in __memcg_list_lru_alloc
Message-ID: <acrjmBx_hX-Aa_SH@cmpxchg.org>
References: <20260318200352.1039011-1-hannes@cmpxchg.org>
 <20260318200352.1039011-8-hannes@cmpxchg.org>
 <4d3f8d79-3593-47df-9de8-f94f7f09a403@linux.ibm.com>
 <acrf5_rS7hO5Ec0Q@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acrf5_rS7hO5Ec0Q@cmpxchg.org>

On Mon, Mar 30, 2026 at 04:41:16PM -0400, Johannes Weiner wrote:
> Hello Mikhail,
> 
> On Mon, Mar 30, 2026 at 06:37:01PM +0200, Mikhail Zaslonko wrote:
> > with this series in linux-next (since next-20260324) I see a reproducible panic on s390 in the
> > dump kernel when running NVMe standalone dump (ngdump).
> > This only happens in the 'capture kernel', normal boot of the same kernel works fine.
> > 
> > [   14.350676] Unable to handle kernel pointer dereference in virtual kernel address space
> > [   14.350682] Failing address: 4000000000000000 TEID: 4000000000000803 ESOP-2 FSI
> > [   14.350686] Fault in home space mode while using kernel ASCE.
> > [   14.350689] AS:0000000002798007 R3:000000002d2c4007 S:000000002d2c3001 P:000000000000013d 
> > [   14.350730] Oops: 0038 ilc:3 [#1]SMP 
> > [   14.350735] Modules linked in: dm_service_time zfcp scsi_transport_fc uvdevice diag288_wdt nvme prng aes_s390 nvme_core des_s390 libdes zcrypt_cex4 dm_mirror dm_region_hash dm_log scsi_dh_rdac scsi_dh_emc scsi_dh_alua paes_s390 crypto_engine pkey_cca pkey_ep11 zcrypt rng_core pkey_pckmo pkey dm_multipath autofs4
> > [   14.350760] CPU: 0 UID: 0 PID: 32 Comm: khugepaged Not tainted 7.0.0-rc5-next-20260324 
> > [   14.350762] Hardware name: IBM 3931 A01 704 (LPAR)
> > [   14.350764] Krnl PSW : 0704d00180000000 000003ffe0443a82 (__memcg_list_lru_alloc+0x52/0x1d0)
> > [   14.350774]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> > [   14.350776] Krnl GPRS: 0000000000000402 00000000000bece0 0000000000000000 000003ffe1c17928
> > [   14.350778]            00000000001c24ca 0000000000000000 0000000000000000 000003ffe1c17948
> > [   14.350780]            0000000000000000 00000000000824c0 0000037200098000 4000000000000000
> > [   14.350782]            0000000000782400 0000000000000001 0000037fe00f39b8 0000037fe00f3918
> > [   14.350788] Krnl Code: 000003ffe0443a72: a7690000            lghi    %r6,0
> > [   14.350788]            000003ffe0443a76: e380f0a00004        lg      %r8,160(%r15)
> > [   14.350788]           *000003ffe0443a7c: e3b080b80004        lg      %r11,184(%r8)
> > [   14.350788]           >000003ffe0443a82: e330b9400012        lt      %r3,2368(%r11)
> > [   14.350788]            000003ffe0443a88: a7a40065            brc     10,000003ffe0443b52
> > [   14.350788]            000003ffe0443a8c: e3b0f0a00004        lg      %r11,160(%r15)
> > [   14.350788]            000003ffe0443a92: ec68006f007c        cgij    %r6,0,8,000003ffe0443b70
> > [   14.350788]            000003ffe0443a98: e300b9400014        lgf     %r0,2368(%r11)
> > [   14.350825] Call Trace:
> > [   14.350826]  [<000003ffe0443a82>] __memcg_list_lru_alloc+0x52/0x1d0 
> > [   14.350831]  [<000003ffe044529a>] folio_memcg_list_lru_alloc+0xba/0x150 
> > [   14.350834]  [<000003ffe04f279a>] alloc_charge_folio+0x18a/0x250 
> > [   14.350839]  [<000003ffe04f34dc>] collapse_huge_page+0x8c/0x890 
> > [   14.350841]  [<000003ffe04f4222>] collapse_scan_pmd+0x542/0x690 
> > [   14.350844]  [<000003ffe04f65b4>] collapse_single_pmd+0x144/0x240 
> > [   14.350847]  [<000003ffe04f69ce>] collapse_scan_mm_slot.constprop.0+0x31e/0x480 
> > [   14.350849]  [<000003ffe04f6d3c>] khugepaged+0x20c/0x210 
> > [   14.350852]  [<000003ffe019b0a8>] kthread+0x148/0x170 
> > [   14.350856]  [<000003ffe0119fec>] __ret_from_fork+0x3c/0x240 
> > [   14.350860]  [<000003ffe0ffa4b2>] ret_from_fork+0xa/0x30 
> > [   14.350865] Last Breaking-Event-Address:
> > [   14.350865]  [<000003ffe0445294>] folio_memcg_list_lru_alloc+0xb4/0x150
> > [   14.350870] Kernel panic - not syncing: Fatal exception: panic_on_oops

Can you verify whether the kdump kernel boots with
cgroup_disable=memory?

I think there is an issue with how we call __list_lru_init(). The
existing callsites had their own memcg_kmem_online() guards. But the
THP one does not, so we're creating a memcg-aware list_lru, but the
do-while hierarchy walk in __memcg_list_lru_alloc() runs into a NULL
memcg.

Can you try the below on top of that -next checkout?

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 1ccdd45b1d14..7c7024e33653 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -637,7 +637,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware, struct shrinker *shr
 	else
 		lru->shrinker_id = -1;
 
-	if (mem_cgroup_kmem_disabled())
+	if (mem_cgroup_disabled() || mem_cgroup_kmem_disabled())
 		memcg_aware = false;
 #endif
