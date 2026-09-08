Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC752BE38;
	Tue,  8 Sep 2026 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867026; cv=none; b=YT92slRTrOMqfA87u6tfrJLNlf8NX88d+Y7qVh+4CWsMlHocx3v+v8BOajhTFGG3UlX+UmIFiQ+Y3iAHAp+9DMO8b5xUrVk5C4MrWNKGTMDR829HPiyyOmn+riD/vZS6jpWYkLEYO5kfj6uvCPblgcG5IB3HSagd8H4hhl3Xc44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867026; c=relaxed/simple;
	bh=ZdXaRe4HWFBmLd0LXW6U2l7QcS01R5ntbQH6pp65rHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qikEAugHdvTIsVkwics2AwHjF6julDNkV/CZvkS/mHdAzkfbxjU+8okx2w/cKFwyRTtEm1LSYP7mLrFAnmwXETJBdfPuRL/2n2xs5rohMDrCuqGCCeGTuQHp/MgYFZtkbB2DMfD03uT9a/xriseRuB/xUqDExZ8XLMDVhjvca+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbzZ3F73; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbzZ3F73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CBD1F00A3A;
	Tue,  8 Sep 2026 11:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788867009;
	bh=mB8nfc2dyoUj8MneI5XtqKUJWAX+H2A9jp3sF5M1qbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BbzZ3F73x9vlPWvAcrfnuEIBJXW3qsffsRXzmqRI35CWZGCBYksgG+FZ6D4aufx7+
	 sEVq9yImHXZGqNWFVp5OCg/tUPoqmbCnXM4gOVpEztvlmpfzA1qGnFHu5hqumBWzdY
	 N5H85H7ubmL/KpLoi3BPX0MUJ8xr61MTWOAacXoR48MSTMJ0Wfiiqe1Y/y4kuLcp+l
	 khOBR7+6+n4ltCTDSLtuvWLW78S/WOu2iBGYFFag5m3jqVXrl0QqQoIKHO1R75ph5X
	 Qb1cRBjIYoRUQrLjUPvWxDGa1pvp8BiecTbRNMlM0odqliUSIGX+UuU4BPhFAXN8b9
	 dTjdPKOeABgjg==
Date: Tue, 8 Sep 2026 12:29:46 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
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
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 12/12] mm: change the contract for free_pgtables(),
 update docs
Message-ID: <ap_xj3W3SjsnRBXv@gremlin>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-12-5456a81c8212@kernel.org>
 <apbUpMDJglS99_yK@thinkstation>
 <apbfzUwBQyxe3P9R@gremlin>
 <apcH74QsR5I-DIbL@thinkstation>
 <apcJhtvnd45EkjJI@gremlin>
 <CAJuCfpH_v4YU+hsQDU_yQ4HZDf-2C6DuiJU5PGL+uVAsTwkZug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH_v4YU+hsQDU_yQ4HZDf-2C6DuiJU5PGL+uVAsTwkZug@mail.gmail.com>

On Mon, Sep 07, 2026 at 09:53:43AM -0700, Suren Baghdasaryan wrote:
> On Tue, Sep 1, 2026 at 10:25 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > > > So, maybe something like:
> > > >
> > > >  * Note that free_pgtables(), used after unampping detached vmas, or when
> > > >  * exiting the whoel mm, does not take a page table lock before freeing a page
> > > >  * table.
> > > >  *
> > > >  * As page table freeing itself is RCU-safe, page table readers can safely run
> > > >  * concurrently with page table teardown. However, writers cannot, as without
> > > >  * a lock nothing prevents concurrent teardown.
> > > >  */
> > > >
> > > > Instead? What do you think?
> > >
> > > s/whoel/whole/
> >
> > Haha yup the inevitable typo...
>
> Also s/unampping/unmapping please.

Ack will fix on respin! I am the typo master ;)

--
Cheers, Lorenzo
