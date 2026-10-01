Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E4D533588;
	Thu,  1 Oct 2026 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889148; cv=none; b=u/wp13QfXl+OZpmwpf8qKhLKBQBnfDNSyyVj2OvjaVdLCcApa7gREXTXfGBIonoP1Zj99Mx9CgUENC2iJ44SnRd0pdDPoiwxyIqNw3HPib1zh+Nr0QLELbQECEfdfndomKk2GHmx0FhNbNIj2QfhKP2G8w8Vxt0gnF7HF1FW8bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889148; c=relaxed/simple;
	bh=ByJYRNs/FCtsobJF+WoAZvVdL5F7+r8bTWjj8PMgqVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtR/qAZ+f5LqGEh2l6fvzdxVYXWbR50ZxWlvLMIJBoceC6IOtWEQLNGABLf6kq5CSA45uzJn8uxLn5oZSffNuCd7lkLyPCAnze0QfKfXKYoXJ0Gmi8hx9+SZGaScxmv0JfNIrLFMzy0ihZncryMr3SvmRT3lHMc4X5PzvkTGDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N3eGFqkw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N3eGFqkw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=yV3OoqhhTOyvLfdzMAWwmTNQmt2i01UTi3FCUoHNWiw=; b=N3eGFqkw2bH2ZVrnw5+je4uWhZ
	J+5Vt4ELsqK0nd7/5K0Dd3phpnJ11mcwHS9Ckj3NnVfMsk3pJIqKyXmFaO6aqqA1wUOjjbfAe5arF
	TXtggCg1hUKUMga2W9gTs9o/sg+Zks2X3RF48SVs0T94Jmo+mUUucCvXppgBF7+LGEeIqIZshggBe
	Uj12hMsorknpIKgwpTe1E0upzf6OQpQnfPN4W6l1K6OQ73Y+dEepsFpKQcPnSMS5u6W9c74ZrdYyK
	xX8PEkyeFYpBoW7g/MrJJK8Xb3/ePcA+lpljARA7IhJfalxxtq5SGY3d0Y5fDh4Aq7VYWlkLzvhKy
	s/2qqAIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCO4e-0000000A0JS-34rA;
	Thu, 01 Oct 2026 21:12:16 +0000
Date: Thu, 1 Oct 2026 22:12:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <baohua@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Hongru Zhang <zhanghongru06@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	david@kernel.org, liam@infradead.org, mhocko@suse.com,
	rppt@kernel.org, shakeel.butt@linux.dev, vbabka@kernel.org,
	zhaonanzhe@xiaomi.com, linux@armlinux.org.uk,
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, chenhuacai@kernel.org,
	kernel@xen0n.name, loongarch@lists.linux.dev, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	linux-s390@vger.kernel.org, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
	Hongru Zhang <zhanghongru@xiaomi.com>
Subject: Re: [PATCH v6] mm: retry page faults once under the per-VMA lock
Message-ID: <ar7MsOb6IJLt4eLo@casper.infradead.org>
References: <20260911025613.1220845-1-zhanghongru@xiaomi.com>
 <arFYRAa-i7CIwmHL@gremlin>
 <arF-E3Nsw9ZliH0t@casper.infradead.org>
 <arI_w2wTfA00Mgy9@gremlin>
 <armexcXDiG8ryZd6@casper.infradead.org>
 <CAGsJ_4xuFi7K+crAcFQ998SxXS0xPM6QeA34JV+6+Sy005rXLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4xuFi7K+crAcFQ998SxXS0xPM6QeA34JV+6+Sy005rXLg@mail.gmail.com>

On Mon, Sep 28, 2026 at 10:48:41AM +0800, Barry Song wrote:
> On Mon, Sep 28, 2026 at 6:55 AM Matthew Wilcox <willy@infradead.org> wrote:
> > So while doing my slides, I realised that what we need to avoid doing
> > is (a) sleeping while holding the mmap_lock (b) returning RETRY while
> > holding the VMA lock
> >
> > And that turns out to be as simple as this patch:
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index dd09c438fa23..94ed2333f8d8 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -723,6 +723,8 @@ enum {
> >   */
> >  static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
> >  {
> > +       if (flags & FAULT_FLAG_VMA_LOCK)
> > +               return false;
> >         return (flags & FAULT_FLAG_ALLOW_RETRY) &&
> >             (!(flags & FAULT_FLAG_TRIED));
> >  }
> >
> > OK, this is a hack.  The function is spectacularly badly named, and
> > needs to be renamed before a patch can go upstream.  But this should
> > fix the contention on mmap_lock.
> 
> Thanks for your suggestion.
> This is exactly what we did in Android Common Kernel before we had
> Lorenzo's proposal (bypassing `fault_flag_allow_retry_first()`):
> 
> https://android.googlesource.com/kernel/common/+/1b9b045a586245cc1c29b2747c6586234c7f5bad%5E%21/#F2

Looks like that one didn't cover __folio_lock_or_retry(), but that
doesn't invalidate your point.

> Note that Lorenzo's proposal avoids mmap_lock contention without
> introducing any new VMA lock contention. It also doesn't require a new
> flag that would break KMI. So this is clearly the preferred approach.

But it does retry multiple times in cases where we know the fault
will always fail (eg the fault is on a device-private VMA)

> > Could somebody try it?  I've verified it boots and runs some userspace
> > fine, but I don't have the workload to test the contention.
> 
> Both Nanzhe and Hongru tested it before and reported the fork issue.

So what I didn't realise is that fork() waits for page faults to finish.
I don't think that's necessary, so we can just stop doing that (whitespace
damaged):

diff --git a/mm/mmap.c b/mm/mmap.c
index 4bf26b0f1e6e..e79555247d3a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1739,9 +1739,6 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
        for_each_vma(vmi, mpnt) {
                struct file *file;

-               retval = vma_start_write_killable(mpnt);
-               if (retval < 0)
-                       goto loop_out;
                if (vma_test(mpnt, VMA_DONTCOPY_BIT)) {
                        retval = vma_iter_clear_gfp(&vmi, mpnt->vm_start,
                                                    mpnt->vm_end, GFP_KERNEL);

I think this is safe.  I've booted a kernel with this change, and
everything seems to run fine.  Of course I don't have any multithreaded
applications which call fork() because that's a stupid way to write an
application, so it's not really tested.

My argument for why it's safe is that a thread which takes a page
fault during fork() might have taken the page fault either before or
after fork().  The faults will definitely happen in the parent process.
They may or may not have happened in the child process, which can't
possibly care whether or not they've happened.

The only difference I can think of being observable is that the child
may observe some later faults to have occurred, while some earlier faults
to have not occurred.  I have a hard time believing any application can
possibly depend on it.
