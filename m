Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CFF3FC5D9;
	Wed,  8 Jul 2026 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545897; cv=none; b=QMJAlnvqaaxqq15O6KyNkg7auSB+d22htns6cg2nnFaYmzgjEJ067+BHf80p22gOI8eeIPisgzGPYieb+ScEMrL3rJm3paa2uzMmunmKCzeQKX78jjNln+EAJE9Zu1xv+Gg3JmQQmTOvfr03pUpbGO1X9JRp++Y++0MlIcN3STw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545897; c=relaxed/simple;
	bh=6BQ03FdvLwvdm6K08gmzhzdmje1HwQ8ICfIZmg8fUpE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iX2VUbTckkZTfEWt2pLq/73k3QyC6F8P57Amh9oUGRSkvuQfy2Zx5+a9l8WYzRwUYhWjSoR/Xb1dH00SiRFvZ9KDieVrY5/nfilG7uqyx9ytOWzQ47tu7WcMDCJOBF9k8movUIOdSHWxLIGIJSWqc99CJ4M9qFPhdscJz5JQCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f9q8IM11; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f9q8IM11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354441F00A3D;
	Wed,  8 Jul 2026 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783545896;
	bh=QHVYNoMQA0BhF9UmwrbZnACd7dxHrgpxo3RgAW0uzE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f9q8IM11qE8X9+BfI6N1CjNBm3AQU7pEkZNUuV4Cl3yOhQv4CeYXe22CypVW+3bS/
	 pE13Yn5jTc+bK9brIzcnZHoNdr30zsDRo/NY8NvsKtJiG8XaMHp8pUCm4aE4kAVw+O
	 aCJrVof2nQdsv8zTXFlLKEfjwTr7D4lk/H+YiaUg=
Date: Wed, 8 Jul 2026 14:24:54 -0700
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
Subject: Re: [PATCH 00/10] mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE (Part 2)
Message-Id: <20260708142454.fba56ae6372b473c0f2ef05a@linux-foundation.org>
In-Reply-To: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
References: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Jul 2026 16:10:55 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> Let's remove the remaining pieces of CONFIG_HAVE_BOOTMEM_INFO_NODE,
> performing some smaller cleanups around freeing of reserved vmemmap
> pages on the way.

Thanks, looks pretty simple.   I'll add it to mm-new, along with a note that [02/10] is to-be-updated.
