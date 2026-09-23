Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DFF46C844;
	Wed, 23 Sep 2026 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790163156; cv=none; b=TLznh68/5ZWjOJJx123tFY7+L7Sfi5jLomRZfK/Se7giwqQVMMezub898Ru6MvJBti3iPkZrTr9hd0x7WP7YPFVKqu7iQRVjtkGaEjeudkSZRue2d/ia4zS4R3c718OkKcG45xzDPz6WroouXHNWu2lGKbjyItxpNSr2tsgCmG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790163156; c=relaxed/simple;
	bh=7dRhUv5Cb6JfMfwHzinpOU3N/3JcKLHazA39ccPvV6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWwqWW8vlVGsOaBpW6dOwtQivaoCp1g37SQz+WLEkDoxu09kiOa6LuOTfxB07uujaLVl/9RzafMmqdmd+RuR4NizoBtMKcQ8Gv3Dyc0zqPA2xgqeAQ6aGtljCxoq+FAomwcsurRTdBtKLyDpubwzHb1z2yetGus1GbU8iSR4hxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polyxeno.com; spf=pass smtp.mailfrom=polyxeno.com; dkim=pass (2048-bit key) header.d=polyxeno.com header.i=@polyxeno.com header.b=FIU18tVw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QE45n4yH; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polyxeno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polyxeno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=polyxeno.com header.i=@polyxeno.com header.b="FIU18tVw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QE45n4yH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 7955C1381530;
	Wed, 23 Sep 2026 07:32:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 23 Sep 2026 07:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polyxeno.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1790163139;
	 x=1790170339; bh=RsXkzvKszGrRGCDlh+k7A1CegrFLd0BaszS3geZGuH8=; b=
	FIU18tVwQ7tQ5cgG5noVM1dFphFNotY2b+0oBSLLNZ4oIoe+8HuJ9mlKgO/GGRHY
	aPSkFjenSQmU/EZe67CINcqvhAbjSRbjYQrYey5IsmU/C5GK+7AGH8bL2xM+VsxK
	KEEgL3qKUP1ax5XJdddWQI0SdRLPjb/rrzE5LP1P/PAhluNIl0Gwn6/ZGlNitjW1
	Ny0h9FBjBCDLXPU6Gn9sNaToc66T4nsNUcuQNivF9ha5A0u/wd/EvSqhe6dW4+ED
	7Fb4Ympv+eKDyEz59MFx2s37dwyl7FapxfhWdfhmihF1IxAp8QGebSu17ttCcrFC
	DCNh/4j+IbhRNCApHSg1zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790163139; x=
	1790170339; bh=RsXkzvKszGrRGCDlh+k7A1CegrFLd0BaszS3geZGuH8=; b=Q
	E45n4yHCqrW8IlzRSzSnxNibm5ZdFG0VRsgwpq+gHiz9wuhG7gplwqlTfpu4YZUX
	jrKta1jfOnMmuKB48JBo/1UEKfg8gsLB3tCCsKo3QtCJQ9rS80tjvqGsFa16tHTs
	jEzOUC4svaw1rCJzrJpp3HyF5wysHcP+5TUYyN+qjOG1EXRicJcHtcJqvztCwuhj
	dkd+SydOpx7yrZhsHv1vVlWvUir2wouFqPHIX1LcNWPf43QW/J52IG9xIVg9W/te
	W0+ocKFUsJFzKD610ChoRqo+i66itHC5WBOl0C1Kaoi0zPQ7pCMN+aiaAN7lK0VH
	yL7NcKUSKDBDu7UjXoS/Q==
X-ME-Sender: <xms:vLizav20sKH2y4pao6lP-MUG-Nk2BgG8QLoegUP-KlGKEDejq5dZaw>
    <xme:vLizagZFBVUttqWlhgN3oOh5snNNI_umgi4xQFwFS1h3w_ZDpBouQAQj9IwGZ4eqA
    MfAHox64ejunzzmpavugDafLfwAeftAYx1i_w1US20agsEHtJLfLLOm>
X-ME-Received: <xmr:vLizaviwwEnPUtVYi-73amBVWWGf1G_rQxDTo_yH58aVtCxNwz5q9Lr0sC7r4lT0GLWvp3ASjUwtdR-hthR2mbEq6Q>
X-ME-Proxy-Cause: dmFkZTFauFHpdk6CRXyr0sNyjg5Q8lqSDpfGXQ0dNZO1X8Nwu1owiUGBTt5pcDU/oArVHw
    tow1i/xQQpDe1DYVLAcqQL38ZwvqGvVsi3/HEQ0C2Tk6IoekZoaauNG6wt8xAqZRiRmyPk
    FQyNwuhvVlF1CXMuv5K+MEk7imbG5TMe5tVGID2STX9i7WARmMQJ5ehbq7phGnUVuGU2i+
    7w5buj0Tunr2WfT78YiY62Abzn9xZvlFIvj7Ucv486mUbowhqnNQviyHNi9tWxt3SkssSQ
    8pVWQCbv2GdZzvAZxTL2BjC2dIiDYlMbW4A35i+8CjosKljeAMtvgm8Dil9gy0O39w/Esm
    9ooJmviJqxX/zw8VK/vRbPPPs/zOz1pyL/+UjjjVwfBcA0PPNwnJeVcDaFLdOuo50dODxG
    m1v8CodVwmm0HCIceRgikYmB4DspkcY7SklPPEsm3gvbekmaXfdX05CLYinrwRfogsHIIB
    LaHZYB7FplsHX+LsqJlCDr+xYF7lXrXE5A6lmvgve41PJoqGChfQYtPpsBxmhFgrg/s72n
    7ZUVXQfFjTNfzOxf/NzBxIREOn++Iw4GO2axZgieXvqCrPtLfEv2H0KH//gGKKcMY2+qkf
    DREqx+SNPaK2C8xTPwYUU7UR5ASaEsxM4lye/JQbTQXfpTBIctE57IFV2jEQ
X-ME-Proxy: <xmx:vLizas9WEVUzXca0498rI4duFEZw3grSo3xFJL0jk1GF3WHckM11yw>
    <xmx:vLizam87wEttGx001O3APoe2cYhUYqpBimRj8pLdosFammZDa__JYA>
    <xmx:vLizahtaJK-PbUnAUsd98esNaLxLkmlJ9hJNV2Ks1GT8IXFlBhTNEA>
    <xmx:vLizapIFlAiM_fCG1eFO4NU8MFxMRdMJmF-nDkiWtMArsCibMfYv6g>
    <xmx:w7izaqkT58Dn7pxVjr1mcQWSWKCweHvd_EoCcpOAFZHAqGma6BcwfGLs>
Feedback-ID: i09fe4b60:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 07:31:46 -0400 (EDT)
Message-ID: <3e6740e3-0515-4e29-9627-f554261daddb@polyxeno.com>
Date: Wed, 23 Sep 2026 21:31:47 +1000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-coldfire
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>,
 Qi Zheng <qi.zheng@linux.dev>, linux-doc@vger.kernel.org
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-7-fe1ad1f1e303@kernel.org>
Content-Language: en-US
From: Greg Ungerer <gerg@polyxeno.com>
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-7-fe1ad1f1e303@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lorenzo,

On 23/9/26 01:35, Lorenzo Stoakes (ARM) wrote:
> Similar to sun3, the coldfire variant of m68k uses 2-level page tables.
> 
> Update its __pte_free_tlb() function to use tlb_remove_ptdesc() in order
> that, with CONFIG_MMU_GATHER_RCU_TABLE_FREE, page tables are freed under
> RCU.
> 
> The page tables occupy a page each and have no odd semantics, so this
> change suffices to allow enabling of CONFIG_MMU_GATHER_RCU_TABLE_FREE for
> m68k-coldfire, so do so.
> 
> This forms part of an overall effort to switch every architecture to this
> mode.
> 
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Looks good to me for ColdFire, so:

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Tested and run with no issues I could see on a M5475 ColdFire system, so:

Tested-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg



> ---
>  arch/m68k/Kconfig                   | 2 +-
>  arch/m68k/include/asm/mcf_pgalloc.h | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index e29610fd1240..6b8ec67c86fd 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -36,7 +36,7 @@ config M68K
>  	select HAVE_MOD_ARCH_SPECIFIC
>  	select HAVE_UID16
>  	select MMU_GATHER_NO_RANGE if MMU
> -	select MMU_GATHER_RCU_TABLE_FREE if MMU && SUN3
> +	select MMU_GATHER_RCU_TABLE_FREE if MMU && (SUN3 || COLDFIRE)
>  	select MODULES_USE_ELF_REL
>  	select MODULES_USE_ELF_RELA
>  	select NO_DMA if !MMU && !COLDFIRE
> diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
> index fc5454d37da3..b53ff0950db2 100644
> --- a/arch/m68k/include/asm/mcf_pgalloc.h
> +++ b/arch/m68k/include/asm/mcf_pgalloc.h
> @@ -39,10 +39,7 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
>  static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
>  				  unsigned long address)
>  {
> -	struct ptdesc *ptdesc = virt_to_ptdesc(pgtable);
> -
> -	pagetable_dtor(ptdesc);
> -	pagetable_free(ptdesc);
> +	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pgtable));
>  }
>  
>  static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
> 

