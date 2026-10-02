Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B43C3EFFC0;
	Fri,  2 Oct 2026 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946770; cv=none; b=TNshvZtNqJwEylEIg/7RrB2AO72go2r9cRzJBxXwBMQJEhlTaPQ6pNSl5C+eJCbM1pgZc2B+tgCbZwtUTO0Q01VCl+OWjlt7kKguKUnoIKibIJwrHIB3OV0obNIhB8Dja0xf+K+PSdsDPsSUmwpjEcTT+sfaWO+p06rRLwxLZfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946770; c=relaxed/simple;
	bh=xbfuGWEQ2ecShQl3GRMI7hfUjzSv8ye+WE+hKftm/08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awJk6U9NkR/hqVeNGdCToF2hZ8wS1ORjdzFn/8hVXb7+E82+xelR48/xuj64TggiE3P4nrNkAsCoqLdISXSM3QuxJka4N7n+2szLETduHaXoMlEShUsufGLrxZbvsaC+/1PJJEZ6nW6T4mhbw4qxOWLJWGjsHi0NrxMQQuiQr7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieMGCLHo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieMGCLHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146F21F000FF;
	Fri,  2 Oct 2026 13:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790946769;
	bh=aVf/lW0mxR5mXdPtanEkjzxn8Fb60gYR+l6Vjdu9n/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ieMGCLHoWcdWZqqVFKPKXIS0eM9hbG1CO7Dc+7PdoebGcn+t/bHl9TBQM31iVvvKH
	 sr6l9ON1qqrsQ4QD+q2zh6ZpqbK87lcUGEFjUxQpx8SShovUWaE4a8z7ueb6+gmknD
	 NPlt8vSsqGncCUfFU0sJanXwSEXDF4kuuKDFCNUgsJVblssmLNEtYVCPgKZYvhvaQF
	 E10xzk2JFaujiQhB9qemiQ70mRCz6twd561Pw5dPervZAYe73/tha+Z07Ie07NlG/n
	 XYTcGsdeCSMiqcmGA4xMLtT6e6E0QRnGha7Rvbwp9K2B3v4WIWn3B57UNJOeuf8r7I
	 Yvn+lZ6wx0gaQ==
Date: Fri, 2 Oct 2026 14:12:35 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Barry Song <baohua@kernel.org>, Hongru Zhang <zhanghongru06@gmail.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
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
Message-ID: <ar-o1TrOMGrrcxLX@gremlin>
References: <20260911025613.1220845-1-zhanghongru@xiaomi.com>
 <arFYRAa-i7CIwmHL@gremlin>
 <arF-E3Nsw9ZliH0t@casper.infradead.org>
 <arI_w2wTfA00Mgy9@gremlin>
 <armexcXDiG8ryZd6@casper.infradead.org>
 <CAGsJ_4xuFi7K+crAcFQ998SxXS0xPM6QeA34JV+6+Sy005rXLg@mail.gmail.com>
 <ar7MsOb6IJLt4eLo@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar7MsOb6IJLt4eLo@casper.infradead.org>

On Thu, Oct 01, 2026 at 10:12:16PM +0100, Matthew Wilcox wrote:
> So what I didn't realise is that fork() waits for page faults to finish.
> I don't think that's necessary, so we can just stop doing that (whitespace
> damaged):
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 4bf26b0f1e6e..e79555247d3a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1739,9 +1739,6 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>         for_each_vma(vmi, mpnt) {
>                 struct file *file;
>
> -               retval = vma_start_write_killable(mpnt);
> -               if (retval < 0)
> -                       goto loop_out;
>                 if (vma_test(mpnt, VMA_DONTCOPY_BIT)) {
>                         retval = vma_iter_clear_gfp(&vmi, mpnt->vm_start,
>                                                     mpnt->vm_end, GFP_KERNEL);
>
> I think this is safe.  I've booted a kernel with this change, and

I'm afraid it's not safe :)

We already actually did this (by mistake I think?) before. See commit
fb49c455323f ("fork: lock VMAs of the parent process when forking") - we shipped
that in 6.4.0 -> 6.4.2 and it corrupted memory all over the place.

Reports + a consistent reproducer:

https://bugzilla.kernel.org/show_bug.cgi?id=217624
https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org/
https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec2a34c@applied-asynchrony.com/

Also we have asserts for this lock in copy_page_range() and
copy_hugetlb_page_range() which will now fail (and possibly more further down
the stack?)

> My argument for why it's safe is that a thread which takes a page
> fault during fork() might have taken the page fault either before or
> after fork().  The faults will definitely happen in the parent process.
> They may or may not have happened in the child process, which can't
> possibly care whether or not they've happened.

The problem isn't the child it's the parent - copy_page_range() _modifies_ the
_parent_'s page tables in-place, on assumption that nothing else can access
them (for CoW).

And actually nowadays things are _even_ worse, you could also have concurrent
page faults, MADV_DONTNEED, MADV_FREE, MADV_GUARD_INSTALL/REMOVE, UFFDIO_COPY +
UFFDIO_MOVE (yikes) all of which might introduce new issues + would have to be
audited too.

So - it turns out a lot of stuff implicitly assumes VMA write lock now:

1. CoW - deferred TLB flush race

(The issue above)

https://lore.kernel.org/all/20230705171213.2843068-2-surenb@google.com/

This happens because __copy_present_ptes() does wrprotect_ptes() on the parent
without a TLB flush (that's deferred until the end of the fork).

But unfortunately without a VMA write lock something can then replace the page
table entry in the meantime and you can end up with data loss as a result.

Same issue exists with hugetlb wp too. And god only knows with uffd wp :)

2. THP - can destroy parent THP mappings

copy_pmd_range() does:

	if (pmd_is_huge(*src_pmd)) { copy_huge_pmd(); ... }
	if (pmd_none_or_clear_bad(src_pmd))
		continue;

Without the write lock, a concurrent fault can install a huge PMD via
do_huge_pmd_anonymous_page() or filemap_map_pmd()/do_set_pmd().

The issue is that pmd_bad() fires for leaf PMD (ugh) on at least x86 and arm64,
meaning that'll clear the page table entry.

I think Hugh left a comment alluding to this before:

	 * copy_pmd_range()'s prior pmd_none_or_clear_bad(src_pmd), and the
	 * error handling here, assume that exclusive mmap_lock on dst and src
	 * protects anon from unexpected THP transitions; ...

It's like the mess around pmd_trans_unstable() :(

3. copy_pte_range() skips the required pmd_same() recheck assuming write lock

It uses pte_offset_map_rw_nolock() with a dummy pmdval and:

	 * We already hold the exclusive mmap_lock, the copy_pte_range() and
	 * retract_page_tables() are using vma->anon_vma to be exclusive, so
	 * the PTE page is stable, and there is no need to get pmdval and do
	 * pmd_same() check.

(Probably needs updating for VMA write lock...)

4. The asserts

Mentioned above!

I suspect there's more as well.

Some of it could be changed, but it'd all be at the cost of behaving very
strangely (no VMA lock but mmap write lock) while manipulating things.

And I am not really happy with changing page table entries in the parent VMA
(for CoW) without a VMA write lock held.

I also wonder whether it would achieve all that much really - the issue is with
holding the VMA lock across I/O, anything else that tries to grab a write lock
is going to end up being the new thing that's blocked (mprotect, munmap, mremap,
mlock etc.)

I think doing something like this would need a very significant redesign and I'm
not convinced it's one that really achieves what we want given all the other
cases that'd get blocked by the VMA lock being held still.

--
Cheers, Lorenzo
