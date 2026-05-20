Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4636EA84;
	Wed, 20 May 2026 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264694; cv=none; b=mTar5QIxbNeFl2mWwW/K5SEpBvVDlhtIvafSHZ1tMSvXjrQi8plBhqCOX0HsNRnyfGMkRh8e6CJlo7ETYR+z9izWlpZUNlF4qpbuShZ/0XpkXTfq4D4+2tkbS/8QwQRXcRqoVCE/lxa9Q/JlOiZ7cC9mtd8axckfkRfSMJS/8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264694; c=relaxed/simple;
	bh=x6tDiusKRz5rYh2YAwfbYhcbwARlCfAQDDayZ2k5yPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrLc2TOPd7/N0uSBocUCOTrCz8jHafYQKOijK3z7jcXMeav1xqb1hvOSSoWghwcl23ylHx2m3Z60PIj6rxzhXF5yfM8HsVd72u7nOUy8y1eM9RJu2oFtJUXX4FZPvSj05YN3mxWFexOGw9+Mwcg1V/W3iuxOAQQbpC9O53IEGh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnkpa3Fz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnkpa3Fz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B3F1F000E9;
	Wed, 20 May 2026 08:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779264690;
	bh=CXxzzbCeNo3sDfk3dzWGFhN8IehnqsFdAWbxh92ducY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bnkpa3FzKkUUdWFG0smRQZfU40dk46M5NgdqdIyfXEPD1h20NL7bKr72VFJoHgNPK
	 Zpt0f97bM5yOlAFtMWk1oRJvIjsf1+ECrk3QzWUIz/BWNXDJW0ZYJ2FFouGZZmuMrM
	 Wo4p0Vkb6/RLl4doyo6ixLI4oE7LpahGy1KRkeyMwou5u+LN+Sw4rNKaJQ+5yI6oFf
	 vB2uTeyCpF+Vdg78uiOeOk2xvyBn7mhcgugFMKCdMzmjrO0Fwf6NwhxUTUhIuawNn+
	 NrJZl4Ke/LYbTbo3EkZd4QjkXwxp4OdeRjoSgwxJx/swz4bFwcKMo8A4KVWXBu3sjy
	 W937Gs5yLpfaw==
Date: Wed, 20 May 2026 09:11:20 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Yang Shi <shy828301@gmail.com>
Cc: Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	surenb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ag1qo0q_bfePgOzx@lucifer>
References: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <CAHbLzkrOSoh-jmR=uaNvx73n_wn+vExoKY0UzH5zGcfdAiDbNg@mail.gmail.com>
 <agxfLNuLCAT3F4cW@lucifer>
 <agxnJ8R-G3CRjeTR@lucifer>
 <CAHbLzkpjOLrdRSUF3-G4d9uz6tn6QYwgB66UU9bud5WHr5FWEw@mail.gmail.com>
 <CAHbLzkrTF7w+T5mGsQuDRuhnTk6evTKBNRcH4oS=nRcUg2zpsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkrTF7w+T5mGsQuDRuhnTk6evTKBNRcH4oS=nRcUg2zpsg@mail.gmail.com>

On Tue, May 19, 2026 at 02:02:09PM -0700, Yang Shi wrote:
> On Tue, May 19, 2026 at 11:41 AM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > >
> > > > >
> > > > > Secondly, if vma->anon_vma is NULL, it basically means either no page
> > > > > fault happened or no cow happened, so there is no page table to copy,
> > > > > this is also what copy_page_range() does currently. So we can shrink
> > > > > the critical section to:
> > > >
> > > > Firstly, with no VMA write lock, !vma->anon_vma means a fault can race and
> > > > secondly copy_page_range() checks vma_needs_copy(), there are other cases - PFN
> > > > maps, mixed maps, UFFD W/P (ugh), guard regions.
> > > >
> > > > So yeah this isn't sufficient.
> > >
> > > However this is true...
> >
> > Yes, fault can race with fork. Basically this is actually the purpose
> > of this idea. We can have improved page fault scalability. In my
> > proposal (take write vma lock if vma->anon_vma is not NULL), the race
> > just happens on the VMAs which page fault has not happened on before.
>
> Sorry, this is incorrect. Page fault can't happen on those VMAs
> because page fault needs to create anon_vma, but it requires taking
> mmap_lock.
> If anon_vma is not NULL, vma write lock will serialize against page
> fault. So there should be no race with page fault. Removing vma write
> lock suggested by Barry may increase race.

Firstly, let's none of us be worried about making mistakes here, the anon_vma
stuff is confusing, and I've stared at it more than mostly, and even so I
managed to make mistakes (as corrected here) and forget details :))

It's a sign it all needs simplifying, but hey that's what my scalable CoW
project is (partly) about :)

Removing the VMA write lock would cause races with page fault which can result
in page tables being installed which are then not correctly duplicated for
ranges that must be.

And again I think the underlying thing here overall I think is:

1. Clearly many cases require serialisation (any that cause copy_page_range() to
   fire).

2. If we were to decide not to take a lock with concurrent page faults, that
   lays a trap for any future change that (reasonably) assumes that page tables
   cannot be simultaneously copied while being accessible to page fault
   handlers, which is bug prone.

3. As per 2, even if we were to only take the lock when we felt we absolutely
   needed to, we still cause risk through adding yet another 'you just have to
   know' risk to this part of mm.

4. The serialisation is quite likely relied upon by other things, this is often
   the case in mm, and we may only realise that such serialisation is critical
   at the point a subtle issue arises out of it.

5. Fork is one of the most sensitive, intuation-defying, complicated, and
   corner- case-problem-baiting areas of mm and I really oppose us changing
   fundamental behaviour here unless incredibly well justified.

On this basis, let's let the sleeping dogs lie and leave fork alone I think :)

I think I am far more inclined to take Barry's fault approach (as I've said to
him) vs. changing fork behaviour.

But I want to make sure there's not a 'third way' that could avoid either!

I am going to have a look through Barry's series in detail so we can have some
movement on this one way or another :)

>
> Thanks,
> Yang
>

Cheers, Lorenzo
