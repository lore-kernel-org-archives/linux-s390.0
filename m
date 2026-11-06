Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945402;
	b=r88YaZ9ZO6vRymiA/CsUK/6YuwQfM+kojdGkDu1y/f3hzfaZHjwEmbDMxNIpV3EInZIm
	 v3E/Xd1ZGv4szrrHo3wEQxV56Tp9WYSraXzLCrvohlzrAEoV57xqdH4ZxIqdCh6/9xJWV
	 QqxRwvSW+KFJoBl0aGfw7Hl6rbhg9wDMRapFrE7VsN+dCplYCgq3hGY/f9xW2tW9o5/ej
	 7B4KjdB6Gh9a799HxLOd9ltMEzhWqXWAxtEsybiYr7jlezmJ/GPNqcaBcJIsjcFTB3Jwv
	 bNZoQhDJvyqrt12MRvdae51WFsYKAykrlo4N85Y2USmkzkBTYz6qafz4bcGgo4fklfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945402;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=odu5xQIFS9JlM9FDfnwszB/Td3i57T5yLrDAwemp88g=;
	b=NSl7R2W9Gqtsp6YWXK2oSoRAbk95gUo0YHTgHLPww/9Ujp774H9Rjzwgq7fox+ui0VJx
	 1t6I6m/YBzhtN3YPahs3Tx1eibj7baDz0mxdUI1UsE2njMrhUHbURYSH8lLtwLdEQSb3x
	 YVFB/mFou2HEzi6SzxrBbK90yahrT4fhoBHbbPvIL5IsCrUKZ1Xrwn9FXSAsRFJ0xNi8A
	 N7hiEXEOOwQQX0RRVrVZt3Gj7HcmUAv7DNTURJn+b88qQXpWkIu64fRXgPBeTp+0TH01B
	 jyxD7lmv3uuSBypN0IBGq7igaD2ByV5nGIv9sKdU4AUSDifKZfa/KFNYVbiCyyIHccQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LPUwG9DY;
	arc=none smtp.remote-ip=91.218.175.60
Received: from mta0.migadu.com (out-60.mta0.migadu.com [91.218.175.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C5606A33A
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 06:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE8C5606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LPUwG9DY
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=96w6STjHwYkE35n2l9bpIcIdDPfklnzi3TLMb74lvdA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793945400; v=1; x=1794550200;
 b=LPUwG9DY+37Mw47I04qtDylr24akTAUKpuuHl+5P9OIhn0B4ba2SW/p0v/RPgl3W/VAkN+iY
 rArmYPbQoJE9dqX9LLgkA3iiCQ63d16uVHTV1yKiy/l7mkcFE5gJbU6PQ0Ouh1XS6bxXoTYFMM3
 d9L12BGO6tLvlABqfAArRQKw=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id c4f90aeb3fa4551c;
	Fri, 06 Nov 2026 06:09:59 +0000
X-Mizu-Trace-ID: c4f90aeb3fa4551c
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v2 2/5] powerpc/mm: drop powerpc vmemmap_can_optimize()
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261105080241.57241-1-lance.yang@linux.dev>
Date: Fri, 6 Nov 2026 14:09:39 +0800
Cc: Sashiko <sashiko-bot@kernel.org>,
 Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>,
 maddy@linux.ibm.com,
 Mike Rapoport <rppt@kernel.org>,
 akpm@linux-foundation.org,
 mpe@ellerman.id.au,
 npiggin@gmail.com,
 chleroy@kernel.org,
 ritesh.list@gmail.com,
 sshegde@linux.ibm.com,
 osalvador@suse.de,
 Qi Zheng <qi.zheng@linux.dev>,
 chenhuacai@kernel.org,
 kernel@xen0n.name,
 linux-mm@kvack.org,
 x86@kernel.org,
 linux-s390@vger.kernel.org,
 hca@linux.ibm.com,
 gor@linux.ibm.com,
 agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2AB0A0B1-1613-44CC-A007-2453F6206D77@linux.dev>
References: <sashiko-outbox-198652@kernel.org>
 <20261105080241.57241-1-lance.yang@linux.dev>
To: Lance Yang <lance.yang@linux.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 5, 2026, at 16:02, Lance Yang <lance.yang@linux.dev> wrote:
>=20
>=20
> On Thu, Nov 05, 2026 at 07:16:48AM +0000, sashiko-bot@kernel.org =
wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
>> - [Low] mm: undeclared vmemmap in =
section_vmemmap_optimization_disable()
>> - [Low] mm: define vmemmap_optimizable_order() before =
section_vmemmap_optimizable()
>> --
>=20
> IIUC, on LoongArch, asm/pgtable.h includes vmemmap-optimization.h =
before
> defining vmemmap.

Yeah. Really nasty.

>=20
> How about taking a PFN and page count instead, and leaving the =
conversion
> to the callers?

However, although this can solve the compilation problem, for the =
caller,
it is not very straightforward because they need to calculate nr_pages.
section_vmemmap_optimization_disable is only supposed to be used in the
vmemmap population path, and in these paths, the most direct parameters
are start and end. I think this function could be moved to
mm/sparse-vmemmap.c, and that way the compilation dependency problem
would be solved.

What do you think?

Thanks,
Muchun

>=20
> ---8<---
> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> index c91afce46136..5a3a225135be 100644
> --- a/arch/loongarch/mm/init.c
> +++ b/arch/loongarch/mm/init.c
> @@ -143,7 +143,8 @@ void __meminit vmemmap_set_pmd(pmd_t *pmd, void =
*p, int node,
> int __meminit vmemmap_populate(unsigned long start, unsigned long end,
> 			       int node, struct vmem_altmap *altmap)
> {
> -	section_vmemmap_optimization_disable(start, end);
> +	section_vmemmap_optimization_disable(page_to_pfn((struct page =
*)start),
> +					     (end - start) / =
sizeof(struct page));
> #if CONFIG_PGTABLE_LEVELS =3D=3D 2
> 	return vmemmap_populate_basepages(start, end, node, NULL);
> #else
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index 4d6928f717cf..43c98aec29aa 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -283,7 +283,8 @@ int __meminit vmemmap_populate(unsigned long =
start, unsigned long end, int node,
> 		return radix__vmemmap_populate(start, end, node, =
altmap);
> #endif
>=20
> -	section_vmemmap_optimization_disable(start, end);
> +	section_vmemmap_optimization_disable(page_to_pfn((struct page =
*)start),
> +					     (end - start) / =
sizeof(struct page));
> 	return __vmemmap_populate(start, end, node, altmap);
> }
>=20
> diff --git a/include/linux/vmemmap-optimization.h =
b/include/linux/vmemmap-optimization.h
> index 9d9f7a67d195..0501234ab16b 100644
> --- a/include/linux/vmemmap-optimization.h
> +++ b/include/linux/vmemmap-optimization.h
> @@ -76,11 +76,9 @@ static inline bool =
section_vmemmap_optimizable(const struct mem_section *section
> 	return =
vmemmap_optimizable_order(section_compound_order(section));
> }
>=20
> -static inline void section_vmemmap_optimization_disable(unsigned long =
start,
> -		unsigned long end)
> +static inline void section_vmemmap_optimization_disable(unsigned long =
pfn,
> +							unsigned long =
nr_pages)
> {
> -	unsigned long pfn =3D page_to_pfn((struct page *)start);
> -	unsigned long nr_pages =3D (end - start) / sizeof(struct page);
> 	struct mem_section *section =3D __pfn_to_section(pfn);
>=20
> 	if (nr_pages < PAGES_PER_SECTION) {
> @@ -119,8 +117,8 @@ static inline bool =
section_vmemmap_optimizable(const struct mem_section *section
> 	return false;
> }
>=20
> -static inline void section_vmemmap_optimization_disable(unsigned long =
start,
> -		unsigned long end)
> +static inline void section_vmemmap_optimization_disable(unsigned long =
pfn,
> +							unsigned long =
nr_pages)
> {
> }
>=20
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 5777f2e29684..64bc346d0fc5 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -474,7 +474,7 @@ struct page * __meminit =
__populate_section_memmap(unsigned long pfn,
>=20
> 	/* Altmap-backed vmemmap pages cannot be optimized. */
> 	if (altmap)
> -		section_vmemmap_optimization_disable(start, end);
> +		section_vmemmap_optimization_disable(pfn, nr_pages);
> 	r =3D vmemmap_populate(start, end, nid, altmap);
> 	if (r < 0)
> 		return NULL;
> ---
>=20
> Cheers, Lance

