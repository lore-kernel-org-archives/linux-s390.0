Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7C3B2FE4
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578286; cv=none; b=Bpjkh6U162IlyXUm/X0SHLh21IJYAXyR0WGYv6jXIZsaymZXmpbUA+SiLrhV7an5F4GoGUyyYmU75NanWU+CVj3n0hyyBoE1LFh+y3z6I7o5zmbcG8MEoXBjbxog4mtVz3CqGDLC00f6l0vkQO/9zLIYTf6bpahW98qZmbV+m7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578286; c=relaxed/simple;
	bh=Ex72fnxR7OZENIYmQk72B4klljNFhnukNCd4DrH+WQA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MULIyJ5SsiqAEgv7ezCcv0Gg2RjVr+6glYI2KAYAwf7Xe37j+Z+Lgi22+eSA+fog8B8krREYXCLgmxMqwJbpDq90Wz42ozDtO6VW4EyVOprwH+xhF+MvsTo1Zq4HqfgM0s7s4PN6o4UNQbG1waMVSUfQs7oyfpK0nXWovBmkZ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TZAKPicL; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TZAKPicL"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783578282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPR8Y4wzyQDgs1UrfuCsKSlR5/a7t/3ZTJ5swVJfias=;
	b=TZAKPicLQvG4iCtdWX5qIm0Ta1ZyZMks4OYsriGOofIlXt5dzLZesv3etwdGUDh2U3Te7n
	PaIXroz/cy+D/dZ/oU3RvQMp99Xglul0WWReBqvxS+UkfSxSf7wenmWOA0uctrhA2Vbeq7
	KvGnvWgneSi5qsyMrMphlmCrBToemas=
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 04/10] mm/bootmem_info: allow calling free_bootmem_page()
 on pages without a bootmem_type
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260708-bootmem_info_part2-v1-4-156ce4986598@kernel.org>
Date: Thu, 9 Jul 2026 14:23:58 +0800
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
Message-Id: <4E28941E-03DF-403E-BB01-0AA5ACB3B640@linux.dev>
References: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
 <20260708-bootmem_info_part2-v1-4-156ce4986598@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Jul 8, 2026, at 22:10, David Hildenbrand (Arm) <david@kernel.org> wrote:
> 
> As preparation for further changes, let's temporarily allow freeing
> pages that were not previously registered.
> 
> This will allow freeing unregistered vmemmap pages allocated during boot
> through free_bootmem_page() from hugetlb code, until we fully rip all
> of that out.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.

