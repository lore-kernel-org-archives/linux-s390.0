Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F472E5429;
	Thu, 28 May 2026 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977650; cv=none; b=ekilB7ovEhWbkcTdo9VZscbRumYLN71XmS9MAckf5kP4utBCaQjKXOUJKiySUWyT9iqcHVMUFxIn5cnm1Ys8zn9yDAIozzQ5wYbNlhi3m04Qbzsk+Zyzavei3DDYKFZ9ThmhQvzuYSaJJ1g+1r7+lw7vpt+HjImIsOhJLDn+Lic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977650; c=relaxed/simple;
	bh=t5eIzvrJIIKPbx3MnTJlfVJV6Boe8HxFGvNkB8T1zro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zq+wzKyznfciqgZ8SMvPjP1ZYjn7gQpO9w7Lte0HuxQL6VeB6oocX/ZTIuVPcmFGolTTXjaUq7Y2btjqL5ecTgcXyZzQkCqpw+FzXeEQ3nu5obL7g8nD0hD7I738yhqH7DTw4nUNi3D3dTXV8TEbDSZKfCVNpmR9GlWppAkBt/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwXIR2ne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwXIR2ne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AB51F000E9;
	Thu, 28 May 2026 14:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779977649;
	bh=ekle48cxY3BXDJBVeyxwCTDse2Cq0o5JDJn8AmmX8a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UwXIR2ne7qIEdQieKjg2fk0ArW6TCOdBh6pDCicZUiTQMTn8zUfuwKpyzz79+ZAOc
	 J5LNaa8pycGGpXjpb8vmu9SrBxYpeJVvQwETKbMlVpou2QDvaG0pr+52oOBCA3Uj1q
	 aIBysXOesDEjZp/tW2gzNZtRskQpwGH/pcvII8QIOwcRLKo8BaXtvod3NtgOwEtNhf
	 YoD7cKL98m7iqwH1GgvEE40WcgNZKFFY+azFmtztq27kw0BKnop75mmhEtMoJOz1s6
	 YxDUIacv9uC2uD0qaU3PIPNQdB8pQNn9XiDnmgKhhhUrteIEnctGScyokHsN/HkZ+3
	 AhqvdH+EN9bBQ==
Date: Thu, 28 May 2026 16:14:03 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Wei Yang <richard.weiyang@gmail.com>, linux-s390@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_vma_mapped_walk: Use ptep_get_lockless() for
 lockless access
Message-ID: <ahhNq0pFKvSKZQbR@localhost.localdomain>
References: <20260528075507.1821939-1-agordeev@linux.ibm.com>
 <ahglqif-I4TjFK9X@lucifer>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahglqif-I4TjFK9X@lucifer>

On Thu, May 28, 2026 at 12:24:35PM +0100, Lorenzo Stoakes wrote:
> On Thu, May 28, 2026 at 09:55:07AM +0200, Alexander Gordeev wrote:
> > Switch from ptep_get() to ptep_get_lockless() accessor for
> > PTE reads when no lock is taken.
> 
> This is an insufficient commit message that's just saying what you're doing,
> which isn't very useful.
> 
> Please explain why you're doing this and what the benefit is please.

Maybe something like

"When not holding the lock, there is a chance that the pte gets modified
 under our feet, so we need to use the lockless API to make sure that
 the entries remain consistent during the read."

Only arm64 makes use of it though, due to the contpte stuff and being
unable to do it atomically.



-- 
Oscar Salvador
SUSE Labs
