Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFF552E057;
	Tue,  8 Sep 2026 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866469; cv=none; b=py8HVMB4RMjN3hm/NFJ4IX453X21Tg70Ltoe1nmG6YyxQP5m290Rlt4HifSSxRKN6cCzXfOxZ/4hPUEzM316Xjcl1/8QNMM55pfVmDS5cmpeNI0EMisi4kTCNmw+0MO4gFE9ng5RXVlbK7n27uoA62lY7GpSTDmeIuWn45ixbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866469; c=relaxed/simple;
	bh=ULIBRC4d5jw36/PLdQBRzSg+X3VatAol/skFzcE4GHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEoVkO8fK8X/GJNehl57sJ3uTl0EIwVPI723RxYaSwrLgYqp2GMkQquUeXk5LNQdN3GnYo4QZzGvlNLNidN5NIjU25mRpC1sjPT5GuBT68pBzd+Ich1OolqehOiJWBQ6GAKAiyZUOG0pgnX9ewaliRqK8KkZftN/jN/+7ITeaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrB21XYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrB21XYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB5F1F00A3A;
	Tue,  8 Sep 2026 11:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788866463;
	bh=IoqTyL+G5O6+fLL3cVLfgraMEyoqxgqBpPotfBdVQqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GrB21XYOLGrBo6gxEF8O+VDQ8P6Z7IJTIEyPD1wG1Gw99Ip3jQphLMVskjjJ/q1Ia
	 NbKynFOkclfWFGjzL/ZGOj6A9B0MpoII6bIk2IMQMeQDRYFtKMRU9tUxJ1xQ8R6XhN
	 wy+hJ5Tgq+0qcKo/HXlbIKH3KURAlURNS462V+YZ3LJlrToDIY9DtyC4wV64/AhYYL
	 F15CVr74IcEypm11lfsqKgyCfH6d29iy96Wyv6dN/8FLMchUrk+YzXSYPL0GlxRixZ
	 hhPGyoW5IRAxaXfGXElFzqrAoW5JwJ8z3PYtqX0rXQUBb6XRR5zCWyXaB9s0M98V+f
	 qbnt/MWTQnd1Q==
Date: Tue, 8 Sep 2026 14:20:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Len Brown <lenb@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vasily Gorbik <gor@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v3 1/6] set_memory: add number of pages parameter to
 set_direct_map APIs
Message-ID: <ap_vkSK_efv7ab90@kernel.org>
References: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
 <20260903-execmem-set-vm-perms-v0-2-v3-1-949b64a9f755@kernel.org>
 <a98df077-3e97-4eea-8bfe-470bad9ff9e0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a98df077-3e97-4eea-8bfe-470bad9ff9e0@kernel.org>

On Tue, Sep 08, 2026 at 12:38:44PM +0200, David Hildenbrand (Arm) wrote:
> On 9/3/26 11:28, Mike Rapoport (Microsoft) wrote:
> > When set_direct_map APIs were introduced by the commit d253ca0c3865
> > ("x86/mm/cpa: Add set_direct_map_*() functions") the single page
> > parameter made sense because the initial callers (vmalloc and
> > hibernation) had sets of unsorted struct pages that required changes of
> > their mappings in the direct map.
> > 
> > Since there is an increasing demand for direct map manipulation and it
> > is also desirable to be able to update larger physically contiguous
> > mappings, for example an entire large folio, extend set_direct_map APIs
> > to receive number of pages parameter.
> > 
> > As there is still only a handful of callers, change the existing
> > functions directly and update all the call sites rather than adding
> > wrappers for single page case.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> In general, LGTM.
> 
> But regarding semantics, is it well defined what happens when an update fails
> halfway through an operation?

Just like other set_memory, it bails out in the middle if anything bad
happens.
 
> I'd assume such a case cannot currently get triggered, but there is no
> documentation on what's supported and what's not. Or is there?
> 
> Imagine someone performing an update on an area that partially spans two PMDs.
> While splitting and updating the first PMD could succeed, splitting the second
> PMD could fail. What would be the end result? Rollback? Does the caller have to
> clean up?

There is no rollback in any of set_memory implementations. It's up to the
callers to cleanup the mess afterwards.
 
> I'd appreciate if we could add proper documentation with expected semantics.

I believe it's more in the scope of  "arch, mm: create a generic
set_memory/change_page_attr core" [1] work than this patchset.

I can write (or maybe even slop ;) ) a doc about set_memory/set_direct_map,
but I wouldn't want to hold this because there's not set_memory
documentation.

[1] https://lore.kernel.org/all/20260721-generic-set-memory-v0-1-v1-0-2c1fc62306b3@kernel.org
 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
