Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3148B3368A4
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578008; cv=none; b=dtnPI+u5YglZ+OPMHNRF8GAkxb6hcXkJXX33b8bft+ELWCQ74dekRR013qX/ILiusTSMgCSESBpio06paWbbtmjFhINOCfGdypYfsmHYg/fVNlLVb8of7mAwyDImno9TWUkDQ/i/zlXhVZGUOkbmUtz9sz+BAM0mRsJNU4Bfzbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578008; c=relaxed/simple;
	bh=8qVwWktxTz6gXQVrO6UEq7d6/qkHFBlpEUWBBjqfXHA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Qw2PnTbiAK+TzziWFJIqvGR/nhrafAa1M/Grpvu86EOe9bjEcoAWU3CcdHvwKgXY2k5YbsnAUrd1NlyhaMbBaogY7i3aKZx4nQnMkDVUSibHfvj3US4Hu0m69QWnrBsHa378mzjCiM8XtoE9AskRgBk0WKieuHoI3hRudD5Y+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=deA20KBL; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="deA20KBL"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783578003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCfbSPYkuXgQMKbs8/rTmLjbAoORspmCy2JKVmh+HMY=;
	b=deA20KBL4gs5pH8xMVS1j0msOIFOVHuhmvXwqHy4R8tcdNVF+S8N+RBPihPyQdVi7qqgKv
	lsG2BAJdabQKkMub6HZAOquGVjWJF1OkWu1I22i+CErtYyEoKW/qZqnA/+uzTWAtYt28tu
	eR26KQyGBnkFgtIMR2FAFMu3tF/QIzk=
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 02/10] mm: provide free_reserved_pages(), removing x86
 variant
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260708-bootmem_info_part2-v1-2-156ce4986598@kernel.org>
Date: Thu, 9 Jul 2026 14:19:22 +0800
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Oscar Salvador <osalvador@suse.de>,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-s390@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9667F817-DFD9-460B-B7AA-C9F551190F2E@linux.dev>
References: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
 <20260708-bootmem_info_part2-v1-2-156ce4986598@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Jul 8, 2026, at 22:10, David Hildenbrand (Arm) <david@kernel.org> wrote:
> 
> Let's extend free_reserved_page() in page_alloc.c to free_reserved_pages(),
> dropping the custom x86 variant. The common-code variant will consume an
> order, so adjust the x86 callers accordingly.
> 
> Make free_reserved_pages() assume that we are freeing ordinary
> high-order pages, just with the special "reserved" flavor. The target
> use case for now is freeing vmemmap PMD pages.
> 
> Set the refcount directly to 0 (instead of 1) and call
> __free_frozen_pages(). Add some kerneldoc. Use a single
> adjust_managed_page_count() call.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.

