Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC63A2E2B;
	Wed, 23 Sep 2026 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164175; cv=none; b=UIdoxQrx1HCHPOuew/dsVDK///iXRQCkoIC7Pty/wDqakaxWfRdg6btXdgR95snVmpCFItw/BHgbbMUYW1XhU4Qaj0TxeXyAV+r1sKthqEz0efA6k580UXpy4AsxT808Ah2Hslt8t0thIVmffuDjIAECUHKSI7/DHOBcPq1ZZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164175; c=relaxed/simple;
	bh=jwiqxrbsZtpA5Aylec/sBJv/MbEzwpdVd/4e2DbRM2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrtK7JSXbNmVSk0QTeF/3lXz+JCio45O5BVRXSxZkHdQD9ccEz2IzeGK6D7+eqESRlYIx7AsKYbS5nNegkdggTX6W+WXOk24QClP1uS2Wkc4e/hh7RG5Ga/uDoN6MbnWomkelw5xPlPJdbf/OMgFAXhdj8PffO6S2GCZIONeEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0HspulT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0HspulT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B941F000FF;
	Wed, 23 Sep 2026 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790164151;
	bh=Z18U4qa6LbbRW6yI1ebVsuAYdmDir8PYv46mTQmvxDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D0HspulTyBdCQX+9DDqdK27FApcPCCvh0cfa5A2rbZhHewxbqqnqFfAC7nocs+kP2
	 0mvVh8QH9qXFX6+3roRxbIQueQ3TPhzi292qpq9D3xRZZ5wrxeyaLz+2QvciRn8RF2
	 FVQ8S8jycXpuDyJ9rlAicpdmH0A4zO0K41QTIIgv5uUQwQu8Cyh3/fZ149W1dOnWWV
	 yYYskNeHf77UMMMQLOJF6vyT4QfBuWnpw9G3F145FYd/VJTxiJBTwTSUUZpHmcLZ58
	 JQgdeq38PegQ/KA2Ovq2zM3pjhtITbOaI5GbiIAo2djGnpsU4gEkvZ674V/u+BfhWb
	 OSemwb5O1SYug==
Date: Wed, 23 Sep 2026 12:48:53 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
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
Subject: Re: [PATCH v4 11/12] mm: make userland page table freeing RCU-safe
Message-ID: <arO7lSy71meks_sW@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-11-fe1ad1f1e303@kernel.org>
 <72d1548a-a4ee-4832-b2ab-4bc82f1933f8@kernel.org>
 <arOWZCeV8FrkAvhK@gremlin>
 <802d3999-95fe-4a09-89b4-d01b60f8e963@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <802d3999-95fe-4a09-89b4-d01b60f8e963@kernel.org>

On Wed, Sep 23, 2026 at 11:13:36AM +0200, David Hildenbrand (Arm) wrote:
> On 9/23/26 11:06, Lorenzo Stoakes (ARM) wrote:
> > On Wed, Sep 23, 2026 at 11:04:17AM +0200, David Hildenbrand (Arm) wrote:
> >> On 9/22/26 17:35, Lorenzo Stoakes (ARM) wrote:
> >>
> >> The patch subject confused me at first: that's not what the patch is doing, no?
> >> Previous patches did that, and now you're just removing the leftovers?
> >>
> >> Maybe I'm missing something that this patch does along the lines of teaching the
> >> code to be RCU-safe.
> >
> > It is the final piece that makes that the case, so I think it's OK to allow
> > oneself a nice subject line? No? :)
>
> Just took me longer to figure out if I am missing something important.
>
> E.g.,
>
> 	"mm: remove unused RCU-unsafe user page table freeing"
>
> would have been clearer to me. Anyhow, just stumbled over it, I don't care too much.

Compromise on:

mm: now userland pgtable freeing is safe, remove unused bits

?

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
