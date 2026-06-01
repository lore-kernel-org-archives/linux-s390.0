Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A430E0DC;
	Mon,  1 Jun 2026 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306599; cv=none; b=m9SHyhqZSv/aa0VNG+Jrod7DYakR72BAJgi0EYwOd24Hb92nelzaICABiiOYio94jVzG+NOVpHOLgCu4GdimkzZBV9ruzxVs+FxpilIjZIOwOxPcgnC4BOtkWuoMdv+BIMYP1bmu4CZyk8tpaVPWlvGx8WHsMaPwYlpfaCogiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306599; c=relaxed/simple;
	bh=OKQJ5h2ilWnqSM469omCurIeXicioGZrBscwMvVlK0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkjIs7LbKIKZWfvX5F8R7e2USrybvnsZ+MRjD8bPAbqV7BmA54h//RY1Pun/VmfZDUcdUVOc7x2JHRC3l/ypg7bqW2H+v9Fi8zI6wcXgxLjIfmH93MJIJXZQX4xZAKKP5+IB7MDENlYKB50FQhq3S0PmeILo1Iij2b1w9WkZmSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY86iIMc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY86iIMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF18F1F00893;
	Mon,  1 Jun 2026 09:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780306598;
	bh=Q964EmR1sb0D+k4HDOGBDHSQElTuA68Eo3PT6Fx+5JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UY86iIMcGikyN9u59oMpD3SPoWCDezq083xPacS+VXEBGVM0Lf5REGc9Geud0VJMd
	 wz5dPm+uXnDuXxLBZCE0sM5/ks5eENPD8c0ki6Ad0H1BjivPl3la7dVLMD28shem8B
	 9YyqNliA6iyYU3qZQsPzqxosOKnQuKz37S1O24AHoy8rl2UKjdLWMC8LlI6RiAnkmy
	 nMmpe3XTaxZ0ql3iyP+uJIqh8J/aWVdijHVSnn9tMTcMeseOc9cYfvoxbusgwfN5TT
	 FHSpcMGeULWL/66IrJQHtK4bgI9OOAKqSECrKDsm+XCANmsF35O697XETEu6ZhRhAt
	 TTzrHtzvna0Yg==
Date: Mon, 1 Jun 2026 10:36:33 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: "Oscar Salvador (SUSE)" <osalvador@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Oscar Salvador <osalvador@suse.de>, 
	Wei Yang <richard.weiyang@gmail.com>, linux-s390@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_vma_mapped_walk: Use ptep_get_lockless() for
 lockless access
Message-ID: <ah1SmDJFAcGdBVvU@lucifer>
References: <20260528075507.1821939-1-agordeev@linux.ibm.com>
 <ahglqif-I4TjFK9X@lucifer>
 <ahhNq0pFKvSKZQbR@localhost.localdomain>
 <07baafe4-7d1c-42b0-9103-3e5666770061-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07baafe4-7d1c-42b0-9103-3e5666770061-agordeev@linux.ibm.com>

On Thu, May 28, 2026 at 04:30:36PM +0200, Alexander Gordeev wrote:
> On Thu, May 28, 2026 at 04:14:03PM +0200, Oscar Salvador (SUSE) wrote:
> > On Thu, May 28, 2026 at 12:24:35PM +0100, Lorenzo Stoakes wrote:
> > > On Thu, May 28, 2026 at 09:55:07AM +0200, Alexander Gordeev wrote:
> > > > Switch from ptep_get() to ptep_get_lockless() accessor for
> > > > PTE reads when no lock is taken.
> > >
> > > This is an insufficient commit message that's just saying what you're doing,
> > > which isn't very useful.
> > >
> > > Please explain why you're doing this and what the benefit is please.
> >
> > Maybe something like
> >
> > "When not holding the lock, there is a chance that the pte gets modified
> >  under our feet, so we need to use the lockless API to make sure that
> >  the entries remain consistent during the read."
>
> I would gladly use this, if it makes sense for everyone.
>
> @Lorenzo?

Sounds good to me! Thanks

>
> > Only arm64 makes use of it though, due to the contpte stuff and being
> > unable to do it atomically.
>
> Thanks!
>
> > --
> > Oscar Salvador
> > SUSE Labs

Cheers, Lorenzo
