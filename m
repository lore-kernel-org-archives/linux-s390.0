Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E067365A00;
	Fri, 24 Apr 2026 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058780; cv=none; b=Tde4C81jeHGva5Ph60sYXFOUBgd1qklkWc3iFF86uqDDiYpRB2NcWhBXfnRlcye8YsYn2H1KQsbdNBeotLe0kxReIMsZUW1XgOm4Q+jvdE08/PWVKu/VgUYXzDWQ4wGvMiyDgKxx+hp8n/GtKWXZhCVhtFKi5Xm+s2OabfdNwD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058780; c=relaxed/simple;
	bh=DWkMRzIlP/FCulKUdiF1Fu9vzPWL2Yx2UPbG01OJWhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVfs022DxZPj7JNSC2rNZvncUMlV8Ve8+gZ9JJL6xhTHEX2SMlG/CExI6UdhLHnvAhDojuS/aOY9w5IBxTTKoHtLQFhgqhVJipV3ThFUPOG2oniI9l/TW9kbuf96sz1ShJZpgOYpdEM/KUJ16PeYonhIvf5IcsMolNUeHfQ5U/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m19PBkcH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m19PBkcH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536A8C19425;
	Fri, 24 Apr 2026 19:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777058779;
	bh=DWkMRzIlP/FCulKUdiF1Fu9vzPWL2Yx2UPbG01OJWhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m19PBkcH3MjvyyP06bmauP0lmxSN/COgljVdoI+ldpXHQU0DtDimhU8PVacYX+Bo2
	 21pLVZGKSDmK0ObihtLemaCagvhphfyGcvLG/6WJEAkk9fBOQ9e/cAprEuiVcWRui4
	 hUD1BAa6CHaS2D9LcIcsRFxBUABxBro0F76eguF13ien5tNX2z1dhmTqPF4ZIzBCE5
	 2896KCE91Za+W4T5UgBiEvueRIAxp3U2Khr7RTsylHURbrTlDTFpVWUqkpzJQqvzSK
	 x9FUsCN2m2mX21Yu6ULCN8e75VXFWFkBTqRI9G53rhkmG9/xN1kJBN4PXoUZcv2lix
	 XPsYMFaNYOFiQ==
Date: Fri, 24 Apr 2026 12:26:17 -0700
From: Minchan Kim <minchan@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <aevD2USyVq0tKuwy@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-3-minchan@kernel.org>
 <aesg-sj6_VmXyqxb@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aesg-sj6_VmXyqxb@tiehlicka>

On Fri, Apr 24, 2026 at 09:51:22AM +0200, Michal Hocko wrote:
> On Tue 21-04-26 16:02:38, Minchan Kim wrote:
> > For the process_mrelease reclaim, skip LRU handling for exclusive
> > file-backed folios since they will be freed soon so pointless
> > to move around in the LRU.
> > 
> > This avoids costly LRU movement which accounts for a significant portion
> > of the time during unmap_page_range.
> > 
> > -   91.31%     0.00%  mmap_exit_test   [kernel.kallsyms]  [.] exit_mm
> >      exit_mm
> >      __mmput
> >      exit_mmap
> >      unmap_vmas
> >    - unmap_page_range
> >       - 55.75% folio_mark_accessed
> >          + 48.79% __folio_batch_add_and_move
> >            4.23% workingset_activation
> >       + 12.94% folio_remove_rmap_ptes
> >       + 9.86% page_table_check_clear
> >       + 3.34% tlb_flush_mmu
> >         1.06% __page_table_check_pte_clear
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> 
> As pointed out in the previous version of the patch. I really dislike
> this to be mrelease or OOM specific. Behavior. You do not explain why
> this needs to be this way, except for the performance reasons. My main
> question is still unanswered (and NAK before this is sorted out). Why
> this cannot be applied in general for _any_ exiting task. As you argue
> the memory will just likely go away so why to bother?

I revised the description to explain why I wanted to go with only
specific, not in general.

https://lore.kernel.org/linux-mm/aevBRh08X4UTMUj9@google.com/
