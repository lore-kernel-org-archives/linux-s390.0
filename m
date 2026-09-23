Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FB51C5D72;
	Wed, 23 Sep 2026 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147146; cv=none; b=T++GKFS9AWj3OIzNvRJPlHMPV/FhwBSUy4Pj61eipy36xwnnBxTPNhrWSV/v0NPfYBJDempL0QEH6HlHiYla2rFIWq9QXMIwLwTjgW/mHlEvu6CpmbtpG3znIWjdzdUCtNlrW+T+xMbF7S7mNMbtd2uPHiqeQK2RwmGURZHx2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147146; c=relaxed/simple;
	bh=WmR3kOZB3ACXfNo3laV3NfaLUopFF9HlVbP149Haq1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7feX+h9OdeZFi+QeY/9GE2YgwTU9jCJ1S9cZ7uzG9/dY9Nr1Pxhd/UcjBnpFiA24Fc31qUchxiPKKUjN+VcFsitC4TpoFgBiJgbTF2p9uerFjljGednZY2po179XQhCGt3Ug5rT+6uivjpJSDVR1ls+kOLkGUaxv4Ygn3jAaKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAnwJUiA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAnwJUiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321A21F000FF;
	Wed, 23 Sep 2026 07:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790147144;
	bh=WmR3kOZB3ACXfNo3laV3NfaLUopFF9HlVbP149Haq1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EAnwJUiAqyojRKJf9KNQTwXny7L+XnGgJ0trGGXwGUbbfY4A9uWcu9K0SsUiWOgmc
	 yb41CHhlT/HBuBnzVyYR5/fQuSR3XjSBl9uXtd/UfutbvMg5gyAst3woO5CUYyXhGy
	 AD976W51iwZLDg5mT7WlRmgWnW6l1yj7+OPvlJqhBDwYsyITZldKacOLPw8X3r5iwh
	 xdzP0DsHgF0BxH20eqFZEB0DFdFfRS+stF04cj498KEixAmiiwoIiMX7fOO4v2ki3T
	 qJvjlyssz0DhAO2ce9/8NcZk01mVg0oHHUpA2uecyxQvoQ0UuWqDvbZALG/EIOlt5M
	 hZKVkk39Tca+Q==
Date: Wed, 23 Sep 2026 08:05:21 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org, 
	guoren@kernel.org, bcain@kernel.org, geert@linux-m68k.org, dinguyen@kernel.org, 
	schuster.simon@siemens-energy.com, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, 
	shorne@gmail.com, dalias@libc.org, glaubitz@physik.fu-berlin.de, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, linux@armlinux.org.uk, 
	vgupta@kernel.org, monstr@monstr.eu, chris@zankel.net, jcmvbkbc@gmail.com, 
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org, 
	davem@davemloft.net, andreas@gaisler.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, catalin.marinas@arm.com, mark.rutland@arm.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	arnd@arndb.de, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com, 
	ysato@users.sourceforge.jp, shakeel.butt@linux.dev, corbet@lwn.net, rdunlap@infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, hughd@google.com, 
	qi.zheng@linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 03/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU
 riscv
Message-ID: <arN6JBJixHUjX2CJ@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-3-fe1ad1f1e303@kernel.org>
 <20260923061551.84398-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923061551.84398-1-lance.yang@linux.dev>

On Wed, Sep 23, 2026 at 02:15:51PM +0800, Lance Yang wrote:
>
> On Tue, Sep 22, 2026 at 04:35:34PM +0100, Lorenzo Stoakes (ARM) wrote:
> >Currently riscv gates MMU_GATHER_RCU_TABLE_FREE on CONFIG_SMP and
> >CONFIG_MMU.
> >
> >Commit 69be3fb111e7 ("riscv: enable MMU_GATHER_RCU_TABLE_FREE for SMP &&
> >MMU") enabled CONFIG_MMU_GATHER_RCU_TABLE_FREE for CONFIG_SMP, CONFIG_MMU
> >riscv builds.
> >
> >This is expressly for the safety of GUP-fast walkers (CONFIG_HAVE_GUP_FAST
> >is enabled if CONFIG_MMU is enabled).
> >
> >Naturally a single core system does not encounter issues with software page
> >table walkers being correctly synchronised across cores, as there is only a
> >single core.
> >
> >However, CONFIG_PREEMPT_RCU is still available on a riscv UP system, so for
> >a future RCU-only page table walker, this guarantee is required to prevent
> >concurrent page table teardown.
> >
> >All page table freeing is already done via tlb_remove_ptdesc() so the
> >conditions of CONFIG_MMU_GATHER_RCU_TABLE_FREE are already met.
> >
> >This forms part of an overall effort to switch every architecture to this
> >mode.
> >
> >Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> >Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >---
>
> Yeah, for RISC-V, page-table freeing already goes through
> tlb_remove_ptdesc() :) Tested on QEMU, no issues seen :)
>
> Tested-by: Lance Yang <lance.yang@linux.dev>

Thanks! :)

A cheeky A-b tag possible too? :P


--
Cheers, Lorenzo
