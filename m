Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C43803E9;
	Wed, 23 Sep 2026 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147090; cv=none; b=I1ZnsI2EcJFkk9MzTxVMGvEz0BK2Nedk9Ay2MFeUDdpE0QK52AXGde87rcrGNOka2MGQYTeJsdEj8gTYD26Fzu5hUb7cg+TLPFajn0RrDYPRLJ4eJ63S0lI9x06efMKPKbtWRQ0Df3PsGDO3I4C9DXVOgdoKWJ1yvUKMN1/obU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147090; c=relaxed/simple;
	bh=fCyshOxPXkFEeMlzi8xkK2UXp9YDkuXLHcY24xSqgDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWJxH8EXOiFuYH/TLajBGwd39thYmeyLpj24cBYvCTXkUbLdhgJfH3/qnRqdEA/DwU1Jv56fr20I6M1s4D1XEV7GyPTdIqFG0U70It0x1x0MSZKocUxN5Hfmxb2su62ZDk2kQnzJ6s2Q8Hj4KfnGr6Wahb2Qv90PijRxVHbxIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8oyDQGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8oyDQGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0130B1F00893;
	Wed, 23 Sep 2026 07:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790147088;
	bh=oz5tjSOW6xs6i9tD5UOCcck5s2CW+80N4Q8wcMKT5sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H8oyDQGwjdSkW3glHIqkT28nkitvMUMujDtTwYtl7NQTMOYKIQgyBXIBx/3pBcxQp
	 OQx1IfM7QGlBJelJ3xjxNUlH8jpNUFnb0na487Y1eI8TwCVG7O+g9eVm696P4c9Lkn
	 aCl/OQhO8JIKOOGyXPjrtfuqIh3bXqO1m3IPe7xySJze9zoxTzoj9eqsqbwfNB2PPf
	 KZLSxApcdSOpZNedomZsma7BVhAHXnP9rgV0Ce68rLQVaFKnh48hNKmYa63LQnOWUm
	 E0o5KeQEcNqrGDR/FBqK5/X0rFNwJJhXI+RvWEPR42lgPqvGO9/t+gXs/3Tt6R2T/G
	 9FzYEi/Z4AjuA==
Date: Wed, 23 Sep 2026 08:04:25 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster <schuster.simon@siemens-energy.com>, 
	Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
	Stafford Horne <shorne@gmail.com>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>, 
	Vineet Gupta <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 00/12] mm: make userland page table freeing RCU-safe
Message-ID: <arN3iaw7VDIA-bWf@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922160021.a2fc65d05d9b867a141e5457@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922160021.a2fc65d05d9b867a141e5457@linux-foundation.org>

On Tue, Sep 22, 2026 at 04:00:21PM -0700, Andrew Morton wrote:
> On Tue, 22 Sep 2026 16:35:31 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
>
> > The majority of architectures in the kernel defer page table freeing until
> > an RCU grace period has elapsed, this series converts all remaining
> > architectures to do so too and eliminates CONFIG_MMU_GATHER_RCU_TABLE_FREE
> > altogether.
> >
> > This is important because it enables safe lockless page table walking under
> > RCU alone.
>
> Do we have reason to believe that anyone is seeing any effects from
> their arch's failure to rcu-free the page tables?

We have reason to believe that it completely blocks other work like
scalable CoW :)

>
> This sounds like a rather long-standing wart, yes?

Not really, if you read the cover letter you can see the history of people
working on this, this is the final piece of the puzzle and despite the
rather muted reception this change is a big deal (TM).

>
> The patchset is thinly reviewed and mm.git is bursting at the seams
> again.  I'll play wait-and-see on this series.  Feel free to cluebat me
> if that's a bad call.

Err, Kiryl reviewed the entire series, I sent it in -rc1 of this cycle, and
it's been in -next forever?

Lance is reviewing now, presumably maybe David will review based on the
fact I updated on his feedback to _expand_ some functionality here.

So I'd argue this is contender for one of the top priority series for this
cycle, actually! [and is CRITICAL for my scalable CoW work, easily the most
important this cycle]

--
Cheers, Lorenzo
