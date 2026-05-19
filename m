Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405014D2EEF;
	Tue, 19 May 2026 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194757; cv=none; b=XsnDfOwXTlplBUmgcnVHIse4AB0OaZs0u2t9th9WqYb5XKZe2WnMGW3/CVD9lv9KWSLYXGwD67a76Tff6sPTbwZ0NPDVtiXpUNsAqhwVCvKUpxgwqXBRV8F3dewJrfiAjShN8AGpINqCVKhh/hO9PUVTsa6uaeCOiRkoP2OAEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194757; c=relaxed/simple;
	bh=0tEY/ViETcYWqMbew+LgZ2oRYOW85rqGc3tYxA7i0ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLnHJVB/tlEQHYf4YrBHV/IXaNcrNw1vtRcphGyqQdGBz0m5YSO1fUW++QTFaTryjVW6i62FJwLVcKh7SD6irsC1GNKLPT5uhQISEMfcLAERWXzmhboN524+vGfDZZIzBO77ug8Nswv2hL4fKfJg8Omav/18lKISGwk0tnDmUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfLpklXM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfLpklXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B010C2BCB8;
	Tue, 19 May 2026 12:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779194756;
	bh=0tEY/ViETcYWqMbew+LgZ2oRYOW85rqGc3tYxA7i0ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfLpklXMkKT1W9LjHbc6orFesNSR/WYbThmN3RY3KQ+Sj526oZ9knAqWz1hOSb2V8
	 dNS1B12b6zt9T5UOXQ1nrMbNWtECIR2msv6pUBdn/ZjxEPvXzm8/CRvLKqnqCU51sq
	 haxA77qodnAWypw1XScQZfjJLKwh9FciR3mqwcEzxbVxwnrLWlqLfHqEPk5J3o8Cmy
	 0Wlh1tz1PaNb1cIMkhcRqDoftNLeYh74seeYdw4fbd1+VoscIEyfDFSquLrWTQHUK9
	 L8E52Y782Q8/1j6v9de5qhI08YuU7rlNh8jgJpwnmYyrNumFGmR+cEYpT6UhTkfXca
	 +brOZETnCxkNA==
Date: Tue, 19 May 2026 13:45:46 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Barry Song <baohua@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <agxbJHfa6J2UAtSf@lucifer>
References: <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>

On Tue, May 19, 2026 at 05:14:45AM +0800, Barry Song wrote:
> On Tue, May 19, 2026 at 3:57 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Mon, May 18, 2026 at 4:26 AM Barry Song <baohua@kernel.org> wrote:
> > >
> > > On Mon, May 18, 2026 at 5:47 PM Lorenzo Stoakes <ljs@kernel.org> wrote:
> > > >
> > > > On Sun, May 17, 2026 at 04:45:15PM +0800, Barry Song wrote:
> [...]
> > >
> > > I think we either need to fix `fork()`, or keep the current
> > > behavior of dropping the VMA lock before performing I/O.
> >
> > I see. So, this problem arises from the fact that we are changing the
> > pagefaults requiring I/O operation to hold VMA lock...
> > And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> > is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> > anonymous and COW VMAs only while holding mmap_write_lock, preventing
> > any VMA modification. On the surface, that looks ok to me but I might
> > be missing some corner cases. If nobody sees any obvious issues, I
> > think it's worth a try.
> >
>
> Thanks. Besides the creation of processes via fork(), I
> am also beginning to worry about the death of processes.
>
> One thing that came to my mind this morning
> is that when lowmemorykiller decides to kill an app, we

What's the lowmemorykiller? :P you mean the OOM killer?

> want the memory to be released as quickly as possible so
> the new app or user scenario can get memory sooner.
>
> In that case, if the app being killed is performing I/O
> while holding the VMA lock, the unmapping procedure
> could end up being blocked as well.
>
> If we release the VMA lock as we currently do, we allow
> process exit to proceed.
>
> I haven't thought it through very clearly yet, and I
> may be wrong. I'd like to do more investigation. I hope
> the apps being killed stay very still, but who knows—we
> have so many applications in the market.

Yeah let's tread very carefully please, you're picking two of the most fraught
areas of mm, I'm not going to want to see changes there unless they're
substantially more convincingly argued.

>
> Meanwhile, if you have any comments regarding the death
> of processes, they would be very welcome.

As above, leave it alone please :)

>
> Best Regards
> Barry

Thanks, Lorenzo
