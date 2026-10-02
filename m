Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C678D1C2324;
	Fri,  2 Oct 2026 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969448; cv=none; b=Kc0GIsK9N7rNc3UrnXE+2UXTQqkFDoTG5IJOhVNhYf8Y0vuo97YKCt60ROuPTwCOEr+7E+jT3rnMEOI97nXNH1AOBBwY6UUDV7GW9SYdeTBLVmfO74XQaAYW9S3panVj81EkfIjeoUCyNWSo5CGG6OuD4BZOYIFWl5n+gSrkaDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969448; c=relaxed/simple;
	bh=UvxOFB0IbE8KIM4WIMe8P7WoA3vIDhkx8lQlM29Phbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBBAhRbwnyDHoqZHPBLugLf8Vaov7IDFJ/ERouMzpKXnYQtCmY5gRGBPhRzzXD3gQnUT3Af6Za0fcrD+JRysoPIF6/eq/s7vetdrdH1Y04WvfU3WsXTLimMyfk5pPRKaOk84VgwUh7M1AaSib06zodHcAA8NvDryrtWHgJg9gHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2r2hK5k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2r2hK5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748A01F000FF;
	Fri,  2 Oct 2026 19:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790969446;
	bh=ekKUYOby3c2j+NEGwfq/n/16hDsQN2mSgzvQPgHiWWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d2r2hK5kCljTlCYwbBufk/wivX4jkvPY5GtMgJLcUIUGT4ktspgfRBivcG57guSh0
	 hmkWr9NCuIzN8DuY1j8dpdZ4MIgpfoMkhqfwhFne9TUTm7tvkDIkyqcyp6gifsaedU
	 mNrCV965QKAOpjo5mT0u9456Q2feFcLsrcpn4yK2t79qy6ksjZH9IjiJABakb9YbL5
	 heJGGdWiGwwTNHAPJgbj/idVxDZSAeMzL3J8SODqqJovLo/2+7RpFWIqHOSOxNi79y
	 Uw9DHbuSk9BoX3hzMhPL2bfOom2XjyLWZ7KwO9IQVaU87sthIFLqZfHTTSxGRCaWc8
	 PWPWsigErZcDg==
From: Barry Song <baohua@kernel.org>
To: willy@infradead.org
Cc: agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	baohua@kernel.org,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	chenhuacai@kernel.org,
	chleroy@kernel.org,
	dave.hansen@linux.intel.com,
	david@kernel.org,
	gerald.schaefer@linux.ibm.com,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	kernel@xen0n.name,
	liam@infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	linuxppc-dev@lists.ozlabs.org,
	ljs@kernel.org,
	loongarch@lists.linux.dev,
	luto@kernel.org,
	maddy@linux.ibm.com,
	mark.rutland@arm.com,
	mhocko@suse.com,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	palmer@dabbelt.com,
	peterz@infradead.org,
	pjw@kernel.org,
	rppt@kernel.org,
	shakeel.butt@linux.dev,
	surenb@google.com,
	svens@linux.ibm.com,
	tglx@kernel.org,
	vbabka@kernel.org,
	will@kernel.org,
	x86@kernel.org,
	zhanghongru06@gmail.com,
	zhanghongru@xiaomi.com,
	zhaonanzhe@xiaomi.com
Subject: Re: [PATCH v6] mm: retry page faults once under the per-VMA lock
Date: Sat,  3 Oct 2026 03:30:34 +0800
Message-Id: <20261002193034.86218-1-baohua@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <ar7MsOb6IJLt4eLo@casper.infradead.org>
References: <ar7MsOb6IJLt4eLo@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Oct 2, 2026 at 5:12 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Sep 28, 2026 at 10:48:41AM +0800, Barry Song wrote:
> > On Mon, Sep 28, 2026 at 6:55 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > So while doing my slides, I realised that what we need to avoid doing
> > > is (a) sleeping while holding the mmap_lock (b) returning RETRY while
> > > holding the VMA lock
> > >
> > > And that turns out to be as simple as this patch:
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index dd09c438fa23..94ed2333f8d8 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -723,6 +723,8 @@ enum {
> > >   */
> > >  static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
> > >  {
> > > +       if (flags & FAULT_FLAG_VMA_LOCK)
> > > +               return false;
> > >         return (flags & FAULT_FLAG_ALLOW_RETRY) &&
> > >             (!(flags & FAULT_FLAG_TRIED));
> > >  }
> > >
> > > OK, this is a hack.  The function is spectacularly badly named, and
> > > needs to be renamed before a patch can go upstream.  But this should
> > > fix the contention on mmap_lock.
> >
> > Thanks for your suggestion.
> > This is exactly what we did in Android Common Kernel before we had
> > Lorenzo's proposal (bypassing `fault_flag_allow_retry_first()`):
> >
> > https://android.googlesource.com/kernel/common/+/1b9b045a586245cc1c29b2747c6586234c7f5bad%5E%21/#F2
>
> Looks like that one didn't cover __folio_lock_or_retry(), but that
> doesn't invalidate your point.
Yep. `__folio_lock_or_retry()` will make the same thing true for anon
VMAs, so we intentionally made the hook valid only for file VMAs.Only touching the file retry path seems to involve less VMA
contention.

>
> > Note that Lorenzo's proposal avoids mmap_lock contention without
> > introducing any new VMA lock contention. It also doesn't require a new
> > flag that would break KMI. So this is clearly the preferred approach.
>
> But it does retry multiple times in cases where we know the fault
> will always fail (eg the fault is on a device-private VMA)
>
Right now, these might require a single extra retry for device-private
and `__vmf_anon_prepare()` cases. The commit log also mentions this.

"Some faults may
retry unnecessarily, for example, those in __vmf_anon_prepare() or
device-private fault handling, which require the mmap_lock. However,
these cases are expected to be infrequent and only add one cheap
per-VMA lock attempt."

If we do want to remove the extra VMA lock attempt, we might still
need an additional flag such as VM_FAULT_NEED_MMAP_LOCK:

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2cecf6ba6df7..2821e3bd7462 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -620,6 +620,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	struct vm_area_struct *vma;
 	int si_code;
 	int pkey = -1;
+	bool vma_lock_retried = false;
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -688,6 +689,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (!(mm_flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+lock_vma:
 	vma = lock_vma_under_rcu(mm, addr);
 	if (!vma)
 		goto lock_mmap;
@@ -734,6 +736,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 			goto no_context;
 		return 0;
 	}
+
+	if (!vma_lock_retried && !(fault & VM_FAULT_NEED_MMAP_LOCK)) {
+		vma_lock_retried = true;
+		goto lock_vma;
+	}
+
 lock_mmap:
 
 retry:
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6141160ec652..baadab598d98 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1734,10 +1734,11 @@ enum vm_fault_reason {
 	VM_FAULT_NOPAGE         = (__force vm_fault_t)0x000100,
 	VM_FAULT_LOCKED         = (__force vm_fault_t)0x000200,
 	VM_FAULT_RETRY          = (__force vm_fault_t)0x000400,
-	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
-	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
-	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
-	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
+	VM_FAULT_NEED_MMAP_LOCK     = (__force vm_fault_t)0x000800,
+	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x001000,
+	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x002000,
+	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x004000,
+	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x008000,
 	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ddc631a388b9..64e08c6153cf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1480,7 +1480,7 @@ vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
 
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 		vma_end_read(vma);
-		return VM_FAULT_RETRY;
+		return VM_FAULT_RETRY | VM_FAULT_NEED_MMAP_LOCK;
 	}
 
 	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
diff --git a/mm/memory.c b/mm/memory.c
index 1f83a26f8733..89c8c8a52c16 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3980,7 +3980,7 @@ vm_fault_t __vmf_anon_prepare(struct vm_fault *vmf)
 		return 0;
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 		if (!mmap_read_trylock(vma->vm_mm))
-			return VM_FAULT_RETRY;
+			return VM_FAULT_RETRY | VM_FAULT_NEED_MMAP_LOCK;
 	}
 	if (__anon_vma_prepare(vma))
 		ret = VM_FAULT_OOM;
@@ -4937,7 +4937,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				 * under VMA lock.
 				 */
 				vma_end_read(vma);
-				ret = VM_FAULT_RETRY;
+				ret = VM_FAULT_RETRY | VM_FAULT_NEED_MMAP_LOCK;
 				goto out;
 			}
 
-- 
2.39.3 (Apple Git-146)

