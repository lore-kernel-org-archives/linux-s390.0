Received: from mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD2C3C4171
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969327; cv=none; b=kxhxMwMfjp/2VIXkUWXHLZiFBzRyiFu72Mq2pJ+YP8MBP4AuLkHSEyYzMpeN+B180h2YWMq5KDCR59A7ppbEgWEw23PhEygOwo3OnQ+RptXa5ljJkwm9Nog/ZxiWXfjmnRugImFG/LrENOQv/jsIMgt/88bOBD/ort4wvf3RL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969327; c=relaxed/simple;
	bh=XUz20HjX88HKc3zhTmA9XIj0WBNTBdnuMyd7s0rygf4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dOe04pf0t6Ahdo8Mx+PB0x5RHQ0efTnaUAco+oOOKk/A2/tmJyiFSkhbUvSAaQ+5OA6npmP5Z4SYw6ykDHoEz9wLbg4KdJJMQDpD4U/a0WqDnLgMkRmJ+kOJEDRMvlIXB37WYoQbOr6K2AH/vPMP6AcOUfXJW/oh2BsrlPRvtL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XkldS3CH; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XkldS3CH"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XUz20HjX88HKc3zhTmA9XIj0WBNTBdnuMyd7s0rygf4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786969322; v=1; x=1787574122;
 b=XkldS3CHg9hCBivEOhkQQzkmUhdPITkRmMuNYQi3cCkftCjtJWWLDRiDP/+pw18b1esq4lNP
 slbcZxty0whFStgDGAoQnHGUK2wfA2IpllM//lyHcu35MfQ6dkOPY6w42V/iiNp8rSh+jXtT66Q
 Gkbjx9DvRnQfiagSi2bv5dsQ=
X-Envelope-To: linux-s390@vger.kernel.org
Received: from localhost (185.201.63.253)
	by smtp.migadu.com with ESMTPS id ac101bf52cfc1249;
	Mon, 17 Aug 2026 12:22:02 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 14:21:41 +0200
Message-Id: <DKR7R0BECQXX.2FCNF36EFETS8@linux.dev>
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, "Albert Ou"
 <aou@eecs.berkeley.edu>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Andy Lutomirski" <luto@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "David Hildenbrand" <david@kernel.org>,
 "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>, "Heiko Carstens"
 <hca@linux.ibm.com>, "Huacai Chen" <chenhuacai@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Len Brown" <lenb@kernel.org>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Paul Walmsley" <pjw@kernel.org>, "Pavel Machek"
 <pavel@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "H. Peter
 Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>, "WANG Xuerui" <kernel@xen0n.name>,
 "Will Deacon" <will@kernel.org>, <x86@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
 <loongarch@lists.linux.dev>
Subject: Re: [PATCH 4/6] mm/vmalloc: make set_area_direct_map HUGE_VMAP
 friendly
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>
X-Mailer: aerc 0.21.0
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org> <20260816-execmem-set-vm-perms-v0-2-v1-4-90944a3ad43f@kernel.org>
In-Reply-To: <20260816-execmem-set-vm-perms-v0-2-v1-4-90944a3ad43f@kernel.org>

On Sun Aug 16, 2026 at 12:59 PM CEST, Mike Rapoport (Microsoft) wrote:
> set_area_direct_map() always updates direct map alias permissions in
> single page increments.
>
> For HUGE_VMAP areas it's suboptimal. Not only the loop in
> set_area_direct_map() needlessly has more iterations (e.g times 512 on
> x86), but it also causes fragmentation of the direct map that could be
> avoided for the HUGE_VMAP areas populated with large pages.
>
> All pages in an area are always of the same order: either same-order
> large pages when VM_ALLOW_HUGE_VMAP is set and all huge pages were
> successfully allocated, or order-0 page when VM_ALLOW_HUGE_VMAP is
> cleared or when huge pages allocation fails and fallback path is taken.
>
> Instead of updating the direct map permissions for every order-0 page in
> an area, use the area's page_order as the loop increment and update the
> large pages in one call to set_direct_map_{invalid,default}_noflush().
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  mm/vmalloc.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index fc7993db4152..11170d1ee5be 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3361,12 +3361,15 @@ static inline void set_area_direct_map(const stru=
ct vm_struct *area,
>  				       int (*set_direct_map)(struct page *page,
>  							     unsigned int nr))
>  {
> -	unsigned long i;
> +	unsigned int nr =3D (1U << vm_area_page_order(area));
> +
> +	for (unsigned long i =3D 0; i < area->nr_pages; i +=3D nr) {
> +		if (page_address(area->pages[i])) {
> +			int err =3D set_direct_map(area->pages[i], nr);
> =20
> -	/* HUGE_VMALLOC passes small pages to set_direct_map */
> -	for (i =3D 0; i < area->nr_pages; i++)
> -		if (page_address(area->pages[i]))
> -			set_direct_map(area->pages[i], 1);
> +			WARN_ON_ONCE(err);

Nit: Maybe worth a comment on why this is expected to always succeed?
I.e. I think we are assuming the only failure mode is allocation but=20
because we know vm_area_page_order() there shouldn't be any allocation?
