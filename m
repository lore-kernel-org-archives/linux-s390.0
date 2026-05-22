Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08644CADF;
	Fri, 22 May 2026 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464565; cv=none; b=fW891joJJicsqfw3LuAU8XKSocwOskQRseBPHcmHp7rskO+pFL/AwnQHsZsKl3uX/ju503+mfwO7Tzzn09FENMiI2ushMaims8FJg2549ublP5e/IZI4EcxHCOSrXtsIqFkLg6eLxXjfiG8KYxOzfhUTS2wXKT5HoiIxDWbU3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464565; c=relaxed/simple;
	bh=JCpY0JkuhcYxNLRV1IUbXIozIjXdostYdAAnrNS61cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvsZD4Ce7pFFLsVri72n/wyzAf2PE7Eh9fGLCueXh3TZJkjPSRsVq6YfkHK/AvdUbuJDh4//qNCXSxaPlxn28PTapMmSVRXu1LJNfIx6F0KVayYNYm72ELbz8baRXf5nda4TCxTCBTsYrw1zTkzMnEJ93fTHlwqQXTEnXSVylK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fevBbZWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fevBbZWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E9D1F000E9;
	Fri, 22 May 2026 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464563;
	bh=JCpY0JkuhcYxNLRV1IUbXIozIjXdostYdAAnrNS61cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fevBbZWW+amNTaTyKMVEGcATHJGI5beCyHSrNicjKpiIEwqwkPh/z0cIoe3sMBOEF
	 9KpGqhtEFq0bU7LJzRPro+xlky95JCucz80W5KK1l7KFP6+a4UbvOddg/RjiUMRrBc
	 TnJmst4YvoB1b0exji4XGaiDzIYHqxZdQizL+lY9YRCXPqsiUNa4Iwizpjdil6w8kp
	 avB7IiJOReUiZACrj/lPByfzfPgo+MU9KSfdz4bAzD5EbUs+mS2HRvW6EaIzmE8J07
	 jvv3I3rp4Q5xcvMk2ehvO5RHd+1nyNoGg6Bez7jfcnci4AcbssWI275h4ttA7+QWrP
	 1r5bMWvNKzJAA==
Date: Fri, 22 May 2026 16:42:34 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Barry Song <baohua@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	bhe@redhat.com, chentao@kylinos.cn, chrisl@kernel.org, david@kernel.org, 
	jack@suse.cz, kasong@tencent.com, kunwu.chan@gmail.com, liam@infradead.org, 
	lianux.mm@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, liyangouwen1@oppo.com, 
	loongarch@lists.linux.dev, mhocko@suse.com, nphamcs@gmail.com, nzzhao@126.com, 
	pfalcato@suse.de, rppt@kernel.org, shikemeng@huaweicloud.com, surenb@google.com, 
	vbabka@kernel.org, wanglian@kylinos.cn, youngjun.park@lge.com
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ahB4_m6H37K7kDdO@lucifer>
References: <ag4kj84EcKqamdB-@casper.infradead.org>
 <20260522023305.98223-1-baohua@kernel.org>
 <ahBVh4NM2uoyhPNm@casper.infradead.org>
 <CAGsJ_4zQuJx1reJxgV387Gh0AqWF0KdoFn9KahQ1BNLPRm57TQ@mail.gmail.com>
 <CAGsJ_4zrm3sCp8Uz0Gh+sAwRcdtNF8rDLqX250sFVG3rZy9HNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zrm3sCp8Uz0Gh+sAwRcdtNF8rDLqX250sFVG3rZy9HNw@mail.gmail.com>

On Fri, May 22, 2026 at 09:48:35PM +0800, Barry Song wrote:
> On Fri, May 22, 2026 at 9:36 PM Barry Song <baohua@kernel.org> wrote:
> >
> > On Fri, May 22, 2026 at 9:09 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, May 22, 2026 at 10:33:05AM +0800, Barry Song (Xiaomi) wrote:
> > > > need to touch `filemap.c` at all (probably because you are already
> > > > maintaining `filemap.c` perfectly):
> > >
> > > I'm going to give you one chance to apologise for that.
> >
> > Apologies if my wording caused any misunderstanding.
> > That was not my intention at all.
> >
> > What I meant is that filemap.c already has a very
> > solid design.
> >
> > For memory.c, I had to touch several places for the
> > blacklist; otherwise, the kernel would hang.
> >
> > But for filemap.c, I basically didn't need to touch
> > anything, and preliminary testing shows no issues after
> > moving it from the whitelist to the blacklist. This is
>
> Sorry, I feel I may be causing some misunderstanding
> again.
>
> By "whitelist", I mean I used to allow certain cases
> to use per-vma retry.
>
> By "blacklist", I mean I am now moving to disallow
> certain cases from using per-vma retry.
>
> Right now, I have to add several cases in memory.c
> to the blacklist; otherwise, the kernel would hang.
>
> But it seems that everything in filemap.c is fine so
> far based on testing.
>
> I'm not sure if I've explained things clearly. Please
> let me know if anything is still unclear or insufficient.

Barry - this thread is completely out of hand and getting _rapidly_
unproductive.

It's certainly about as clear as mud where we stand right now, so here's my
suggestion - let's just stop adding to the noise here :) and instead, you
take the approach suggested by Suren at LSF and send that as an _RFC_
series.

That way we can look at that and hopefully actually circle in on a solution
rather than have endless sub threads and sub discussions :) It's far too
sunny out in the UK right now for that ;)

Thanks, Lorenzo
