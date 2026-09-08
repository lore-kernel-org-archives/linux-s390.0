Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835DD47142A;
	Tue,  8 Sep 2026 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902149; cv=none; b=ek1TGR33pUB7SYyguri/IAehunStxepYD9RhAMNoGBaUbW7W7stGGj6epvA7HXURc9IpWjBLqxByFF92TvVVWLgrmX5ei3KT6J+6xOrjKUlfuuziQEhr75eAzjDr58q4jjpXG6LkKiYZc8A0nRBm0Tj4gXtd59+4+/++nNaUks0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902149; c=relaxed/simple;
	bh=zc0dRxXkAKZOT6fy9WXzVz+99ipKkrk9hWcPiEzdJAA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mCY7PWkUvP8KLIrcBlbWX34hx1AtDxKaheICrOpuYAM9k5mS9VUkn51BV84CWDhJzXQymStDdvsGMkfjTPVV/P/sG+PUKTODywU0iRIi4zmQqDZU11aIZL0Q09mdfFFvwW4RoWUg9Ud6/z87UInG0WJ8dHpJncb9AdJ40Hha47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S61FQutZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S61FQutZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1EB1F00A3A;
	Tue,  8 Sep 2026 21:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788902147;
	bh=eVg9GefJyoXHHA5a69mXqnQLyloUJ4YxIPGGpLvgyr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S61FQutZ9GAkmusTuBm8tba1mRd5os9NdWI1OcYUdnUCilKfQqRFUpY9X0910S1CM
	 WZ7yUO067yRvIkgkaa3uP271RNhAevtq90hMdQ5fuv0628aYooJ26Y2LotuEU39MiY
	 QQuRFXCkF1Dzu+58mWFPPcGHJySDbzaovnewoTOY=
Date: Tue, 8 Sep 2026 14:15:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Guo Ren
 <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster
 <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne
 <shorne@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich
 Felker <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>, Vineet Gupta
 <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>, Chris Zankel
 <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Will Deacon
 <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick
 Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge
 Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, Qi Zheng
 <qi.zheng@linux.dev>
Subject: Re: [PATCH v2 00/12] mm: make userland page table freeing RCU-safe
Message-Id: <20260908141543.8180b60400d38b70d249949b@linux-foundation.org>
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Sep 2026 13:32:09 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> The majority of architectures in the kernel defer page table freeing until
> an RCU grace period has elapsed, this series converts all remaining
> architectures to do so too and eliminates CONFIG_MMU_GATHER_RCU_TABLE_FREE
> altogether.
> 
> This is important because it enables safe lockless page table walking under
> RCU alone.
> 
> Doing so allows for reduced lock contention, avoids lock ordering concerns
> and enables fast, efficient and correct page table walking as a result.
> 
> Additionally it removes a bunch of code and architecture-specific behaviour
> which is always a beneficial thing to do.

Thanks.  It's early and unreviewed, but this is mainly an
if-it-compiles-its-good thing, so I'll add it for exposure to the
build/checker universe.

> However some arches required extra attention - sh-X2, m68k-motorola and
> sparc32.

OK.  Please lmk later if you think additional reviewer/tester attention
is desirable in these areas.

