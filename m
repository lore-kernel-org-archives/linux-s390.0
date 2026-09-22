Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E138752843B;
	Tue, 22 Sep 2026 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067341; cv=none; b=s4dY3HuMdr/Jc/SMa+QevsERfOElLF2f9XZtaj9K7g31DGAYhCBX93YN9oUVadDG1mq4A3WBbwYSXOqbwCcK0HTpNAXHV282P9/ZXZbLt8109T7sWR0FTiovi6JY+0Jpq/xUDkZ/fMYuvVdsyAUqm++66ut4ZhzleFsFAD97ink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067341; c=relaxed/simple;
	bh=/+3rL4FSFPXm1DFKDQwh8ngI00RRyxMZKByJ2WW0RKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fb/uc3ywjdLaL6uf2bALj/PjlCXG6ly3u3xgU0V76FIPl7gW664wCJFCeXM6rWZmQrGsy146PaI4YQq8DRMejDlVh90XWf1Z3I3owg1Iyit3IEbDUYyqwplLatsELPom2myChtdhXgFWAGE5szyCgKhFE1cAkeRXX58GCTmRhQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7ZVn+jd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7ZVn+jd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0851F000FF;
	Tue, 22 Sep 2026 08:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067338;
	bh=+orkzDIqK/pEOoLPGb/HU7OFzGJNWH5FbBn2kzEBiZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g7ZVn+jd+//1IZVyIYgfhlRXNBORAuHQuo/EM/eaGKtubcE8cGUkWCVdiSlDIcPlH
	 tlDNUg7XpTlPSCVBvVywYy7W8l9MRrAUBXbnf5kU4Tw96pgyMJJINzpPp7YMQr8od8
	 RwYRyt89FVR7vMcCmv9b4j/cSPwlNwlJGaUXaZ25kULbBOfuxw1HOa7lsYRI4msMt1
	 CsOGjkzVlxkVtemkEWWOfn8xofPBn/U38nRtHYB4Zn42QF41kD0d+TfekGdw8TinVL
	 SSpW85unloC1B4rwPlK3pxWdBdb6JyzINbMNJniaRmhtyZXW7SbLjh62jlGLG2ViRH
	 c94x2A2qWGJ3A==
Date: Tue, 22 Sep 2026 09:55:23 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hongru Zhang <zhanghongru06@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, baohua@kernel.org, 
	surenb@google.com, david@kernel.org, liam@infradead.org, mhocko@suse.com, 
	rppt@kernel.org, shakeel.butt@linux.dev, vbabka@kernel.org, zhaonanzhe@xiaomi.com, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	loongarch@lists.linux.dev, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, linux-s390@vger.kernel.org, dave.hansen@linux.intel.com, 
	luto@kernel.org, peterz@infradead.org, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	Hongru Zhang <zhanghongru@xiaomi.com>
Subject: Re: [PATCH v6] mm: retry page faults once under the per-VMA lock
Message-ID: <arI_w2wTfA00Mgy9@gremlin>
References: <20260911025613.1220845-1-zhanghongru@xiaomi.com>
 <arFYRAa-i7CIwmHL@gremlin>
 <arF-E3Nsw9ZliH0t@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arF-E3Nsw9ZliH0t@casper.infradead.org>

On Mon, Sep 21, 2026 at 07:57:23PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 21, 2026 at 06:54:25PM +0100, Lorenzo Stoakes (ARM) wrote:
> > OK I finally got to this...
>
> Brave ;-)

Or stupid? It's a blurry line ;)

>
> > I fear we're going to go round in circles on this/have endless revisions of
> > the same thing.
> >
> > So 2 things the patch needs to answer, more or less right away:
> >
> > 1. What are you actually optimising for?
> >
> > 2. Where does the hurt happen?
> >
> > Your patch does neither, then goes on to arm wave away all the complexity
> > and presents a 'simple' solution that I feel brushes a lot under the rug.
> >
> > Answer to 1 is 'cold app startup time for a specific set of apps'
> > 2 is filemap_fault() AFAICT.
> >
> > You should definitely be stating this upfront.
> >
> > And I also seem to remember that zygote + multi-threaded apps = fork
> > blocking is part of the problem here, which is why there was push-back on
> > just holding the VMA lock over I/O.
> >
> > Looking through filemap_fault() makes me want to cry and looking through
> > the other retry logic in the fault code makes me want to live on an island
> > with parakeets and coconuts forgetting any of this even exists...
>
> I think that's the right response.  It's why all the feedback from people

I mean, it's the instinctive move when you dig into all this again :) my eyes!
Burn it all down etc.

BUT. The other thing that came to mind was 'fix this bloody mess!'.

And I also worry with this patch that we might end up deferring NECESSARY work
to do that.

> who haven't even tried to follow the fault path (eg the session at LSFMM)
> is completely useless.  The fault path is WAY TOO COMPLEX.  I'll have

Yes. YES YES YES.

I was thinking honestly I'd look at this patch and come to the conclusion that
yes it is this simple and now I'm going to have to argue with mm people but
fine.

But no, I was just reminded how bloody complicated it all is.

> more to say on this in two weeks at Plumbers.

I look forward to it :)

>
> > VM_FAULT_RETRY can mean a million different things:
> >
> > 1. I dropped the lock and waited for the folio to be unlocked.
> >
> > do_swap_page(), remove_device_exclusive_entry() -> folio_lock_or_retry()
> >
> > 2. I dropped the lock to start I/O it may or may not be ready when you come
> >    back.
> >
> > filemap_fault() after do_sync_mmap_readahead() or page not uptodate
> > synchronous read with lock dropped <- what you are optimising for, or
> > shmem_falloc_wait() waiting for a hole punch.
> >
> > The maybe_unlock_mmap_for_io() stuff.
>
> I think these two are the same case?  At least by my reading, case 2
> also waits for the folio to be unlocked (ie the read completed).
> do_sync_mmap_readahead() doesn't do that, but we then call
> __filemap_get_folio() which shuld return the appropriate folio,
> then we call __folio_lock_killable() or __folio_lock().

Right yeah.

>
> > 3. I dropped the lock and nothing was waited for, OOM me on retry!
> >
> > filemap_fault() allocation failure, gotta retry because we dropped the
> > lock!
>
> Oh, yeah, that's icky.  Hadn't even crawled onto my list of problems
> with this function.

Yup. Man.

>
> > 4. I can't do this under the VMA lock, use an mmap lock
> >
> > vmf_can_call_fault(), any vm_ops without ->map_pages, __vmf_anon_prepare()
> > when mmap_read_trylock() lost, also hugetlb_fault() horror shows.
> >
> > Also device-private swap entries.
>
> This one really is my fault / Suren's fault / your fault ;-)

Mea culpa... We-a culpa?

>
> We should not have overloaded VM_FAULT_RETRY for this case.  We should
> have had a distinct VM_FAULT_NEEDS_MMAP_LOCK code.  But I am *scared*
> to try to separate the two at this point.  It was hard to make sure we
> got all the cases as we pushed it down, and now it's going to be worse.
>
> But I don't think that hugetlb_fault() deserves any stick here:
>          * We must check to release the per-VMA lock. __vmf_anon_prepare() in
>          * hugetlb_wp() is the only way ret can be set to VM_FAULT_RETRY.
> is the comment on the only two mentions of VM_FAULT_RETRY in hugetlb.

It does feel like we should just have

>
> I do have a plan to get rid of those two mentions actually ...
> but let's talk about in in Prague.

Yes, indeed.

>
> > 5. Userfaultfd! Because of course!
> >
> > Userspace has to do something.
> >
> > handle_userfault() after sleeping for uffd handler, retry should succeed.
> >
> > ctx->released -> yield to releasing thread.
>
> I find it really hard to reason about uffd.

Yeah me also.

The 2 fundamental issues with uffd (aside from code quality) is that:

a. It's the exception to a lot of rules
b. It duplicates its own logic

Similar to hugetlb.

And these problems grow as we add more functionality to mm.

I fear the device private stuff is becoming this a bit (albeit, not as bad).

>
> > 6. Fatal signal
> >
> > Arch handlers rely on this, so retry also means 'check signals'. Fun.
> >
> > 7. Some driver insanity
> >
> > It means all things to all people. Used for waiting on stuff like
> >
> > LLM says:
> >
> > - TTM at drivers/gpu/drm/ttm/ttm_bo_vm.c:62 and 144, dma_resv contention
> >   and GPU idle wait. Consumers in amdgpu, i915, nouveau, radeon and vmwgfx
> >   re-derive "was the reservation unlocked" from ret == VM_FAULT_RETRY &&
> >   !NOWAIT.
> >
> > - xe_bo_cpu_fault_fastpath() at drivers/gpu/drm/xe/xe_bo.c:2021, where
> >   RETRY is the default return value, including for "runtime PM not active".
> >
> > - panthor at drivers/gpu/drm/panthor/panthor_gem.c:831 onwards, where
> >   dma_resv_trylock() failure is RETRY and the same error is NOPAGE, SIGBUS
> >   or RETRY depending on mmap_lock_held.
> >
> > - sgx_vepc_fault() at arch/x86/kernel/cpu/sgx/virt.c:91, EBUSY from
> >   __sgx_vepc_fault().  All of these call mmap_read_unlock() directly rather
> >   than release_fault_lock(). They are only safe because none has
> >   ->map_pages, so vmf_can_call_fault() bounces them before ->fault
> >   runs. The VMA-lock design rests on that proxy.
> >
> > So yeah. All that. Wow.
> >
> > 8. Nothing!
> >
> > LLM says:
> >
> >   - page_mkwrite() returns in fs/exfat/file.c:951 (inode_trylock lost),
>
> That's just wrong.  It turns the pagefault path into a spin on
> the inode lock!

Oh lord. So it's... worse? :)

>
> >     fs/nfs/file.c:699, fs/netfs/buffered_write.c:576 and
> >     fs/orangefs/inode.c:635 onwards, including the combination
> >     VM_FAULT_LOCKED | VM_FAULT_RETRY.
>
> I think your AI is confused.  I don't see how nfs_vm_page_mkwrite()

1st rule of LLMs is they can always hallucinate/get things terrible wrong.

But yeah this was me being lazy but in my defence it was nearly 7pm and I was
still at the office with a long drive ahead of me ;)

> can return VM_FAULT_LOCKED | VM_FAULT_RETRY.  Nor netfs.  Orangefs
> is wrong and needs to be fixed ... once I figure out what it actually
> wants.

Well volunteered :>)

>
> >     do_page_mkwrite() at mm/memory.c only
> >     passes through ERROR and NOPAGE, and do_shared_fault() and
> >     wp_page_shared() then ignore the returned value entirely. The write
> >     fault completes as if page_mkwrite had succeeded.
>
> That's probably OK.  I think?

I think we probably need more flags, honestly. 'Retry' is too vague.

But on the other hand do we want a flag for every possible weird specific caes?

OK OK I'll wait for Prague for the simplification :)


>
> > And maybe I'm missing some stuff too.
>
> There's also the VM_FAULT_COMPLETED insanity ...
>
> > But I worry a LOT more that it's just a HACK (and I know Barry was nice
> > about the idea and I appreciate it but I have to be honest).
> >
> > Instead of dealing with any of the above, we just leave the mess in place +
> > just retry the operation under VMA because we happen to know, for this ONE
> > workload, it works out better.
> >
> > And PROBABLY it doesn't add too much overhead to anything else.
> >
> > SO.
> >
> > I've written too much again, let's sum it up.
> >
> > 1. WE HAVE TO DECIDE whether we want to accept the hack because it
> >    helps in a known case and probably doesn't harm any other cases.
> >
> > 2. WE HAVE TO FIX THIS DAMN MESS. Even if we take something like this WE
> >    HAVE TO FIX IT.
> >
> > I'm inclined to rip out the whole retry thing altogether one way or another
> > but I leave that to Matthew to figure out :)
>
> I think there's a bathtub with a baby in it over there ...

Yup as above, instinct to nuke from orbit etc. ;) but something (TM) needs to be
done.

>
> There's considerable scope for simplification here.
> lock_folio_maybe_drop_mmap() makes my eyeballs bleed every time I look
> at it.  But we do need smoe kind of restart-the-fault mechanism.

Right, yeah.

It does feel like there's a solution lurking here in the undergrowth, so again
Prague etc. etc.

>
> > If we decide we DO want the hack, then DEAR LORD can we not have this
> > horrible duplication across arches? I seem to remember you agreed to take
> > that out ([0]), and maybe it's pending what Matthew wants to do, but is
> > there not a way to avoid that?
>
> We desperately need to move more of the fault handling path out of the
> architectures.

That's definitely part of the solution!

>
> > I REALLY want to hear from Matthew on all this, I don't think we can move
> > ahead without his clear feedback.
>
> Thanks for dragging me back into this ;-)

No worries ;)

Though I do have to ask again - do we want this patch as-is as a temporary
solution? Or maybe just for x86/arm64 (god I hate the duplication of the arch
code)

I'm not sure that it does all that much harm?

It's not necessary either/or it can be an and. But I'd want your OK on taking
this.

--
Cheers, Lorenzo
