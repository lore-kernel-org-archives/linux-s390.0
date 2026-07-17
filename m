Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3062C43F085;
	Fri, 17 Jul 2026 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784246553; cv=none; b=FMHy7xItZywMvj5xybEYXEy4X3GOcREG3Tt9JwBlYap8UPlbz0SXmlB7S0SbE9Jm4g0ZdLRShIM+IaaCK8icsF4dWZ10n6t1MGAYN8TclcEyCo3wlG69hyN0lSm2GvQQPfClcQdHzpgQIycBNaPFBgABdzHNSvfOPInSun0XE7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784246553; c=relaxed/simple;
	bh=nMUQ0jOVV2Lu461XGccPFkHA35rCW2upwEHN1j/qOIY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I6DIEGyxUUGE3bN94dKidPe/kjAcvzGghacIvrN+pZubbvcFNwLps/4o8N5qKCdWP+asOsXWw67V1QWs/1DYXW77EC/L8TAruxppYMAis9gpWFVvopHITnwzN5pjYy/W2il9a8NZM3gS60kxr7oG79v/WQS/Paf6/cutut/O30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fmEtPKcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fmEtPKcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D799B1F000E9;
	Fri, 17 Jul 2026 00:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784246551;
	bh=uUBv9as3tW3uUAln9/yTNbic/gN2hcU01VGeGGZcyfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fmEtPKcrev90Stii5CY3aRxQ2gLP4zaPKHNJIIwG+7sPLuxFb1lOrGs0pfT57eqnE
	 RSum1nwGN0TZmS0YwOS55//MdcssX0PnXU1fMgNJXuQMY6S7gpvKhWz6Jnt0ExiUbI
	 GNPJlN7EzC8bOEg2raencUGEo/wfZn4MmxW5+aIA=
Date: Thu, 16 Jul 2026 17:02:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil
 Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan
 Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
 <osalvador@suse.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 00/10] mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE (Part
 2)
Message-Id: <20260716170230.643f2f3abf78150ca4528fc6@linux-foundation.org>
In-Reply-To: <20260716-bootmem_info_part2-v2-0-4afc76c73d61@kernel.org>
References: <20260716-bootmem_info_part2-v2-0-4afc76c73d61@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jul 2026 16:50:59 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> Let's remove the remaining pieces of CONFIG_HAVE_BOOTMEM_INFO_NODE,
> performing some smaller cleanups around freeing of reserved vmemmap
> pages on the way.
> 
> Tested on x86-64 with hugetlb vmemmap optimization in combination with
> KMEMLEAK. Heavily cross-compiled.
> 

Thanks, I updated mm-unstable to this version.

> Changes in v2:
> - In patch #2, reverse the order of setting the page count and clearing
>   PG_reserved, and modify the patch description accordingly.

Here's how v2 altered mm.git:

--- a/mm/page_alloc.c~3
+++ a/mm/page_alloc.c
@@ -6410,8 +6410,8 @@ void free_reserved_pages(struct page *pa
 
 	for (i = 0; i < nr_pages; i++) {
 		clear_page_tag_ref(page + i);
-		set_page_count(page + i, 0);
 		ClearPageReserved(page + i);
+		set_page_count(page + i, 0);
 	}
 	adjust_managed_page_count(page, nr_pages);
 	__free_frozen_pages(page, order, FPI_NONE);
_

