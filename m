Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118574;
	b=Pg9pRwBWZ/yKVCnYAK3Ln+YrQ6h2HuiwtcZfAJIos4L3htXx5vaI2J4PN3jw0azYLx4r
	 zwlV1Gu/aT/Qf6es6xRd0vFjNADQEjKLHN0rdWO8bazpXvVhtTgGIhrZQfuf/xUgeh7B0
	 R+RvIYI206l3PW0OvNCLyU3LjeTgIamBZadDy5vNC2qY5bVNy9EvcXSpdxlf18Olsamc3
	 M4nq+DrnrdqhlOXl8EC0+5hTvpGDMO2m+ZGZdqZYiLs+JMJK29DEBr99cI2TjkKFwWdF/
	 piQeoPKDGif9XbmUVDf6UkN7gkJ+Im06mLbZ3Sflfy9J1MapP5aG8NmYqdwdQBLOo/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118574;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kAcnFFHoGCaLIkdfu6vQlgxivqnlgRGe6B2VS1ojrEM=;
	b=39fsP0O5OClAF5qPLhbDDAr/OmBo+56QG+5FHfgeUQ4vwjePrWTF/KgYsLUqMi0pKGrU
	 oW9Y9F1Qajggy/ZhrXuhANpCbzA5FYTyhMBNir/3n397Nctk70sH7PTHIbq/XlEWy6prg
	 5pzfC6tYKwq/KIzg+yeN6+qzfRzBjDP2ddHnBQ4vgmAWr5troopSVIMw/yi4MWcSOKTR2
	 SvYYIC5mJYxa5z5GjVYS7sZSNIXv20vxRmJJxBwvf6gMXwxIdN2n5RiPuFwWxiN5NFsK+
	 tjXyGKMzIIoE9ft+IMOiBL4gdHYPeFCPV9na4SiNbBkR7frVwJ3IbSZHQGGnu+chqgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bbsz9qDk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751B606A31B;
	Tue, 27 Oct 2026 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bbsz9qDk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F061F01828;
	Tue, 27 Oct 2026 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118573;
	bh=kAcnFFHoGCaLIkdfu6vQlgxivqnlgRGe6B2VS1ojrEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bbsz9qDkyDs8H77dSEWFVVoSrMeEk+WXm5r3OPWiNyeYoBpxmsOCn5CmGtRqVetHo
	 mcFkRLPNplY4m3ig1H1ERqm+PaSGY5Qy91L8YocM14s/zdxHBU39CJJs+LR0NjqRUy
	 HYaZ+qVnsrkUB90AOxXitaTHRIDzbW2nZQKAt2axcvSGr90/Ecy4aiZxxfFFZPczPN
	 a6bkSOpR33GdMYXlejOZDAznosukKn1HJsw8fzq1fezE3Gnm3ptrKyXX0qKJZIsYvz
	 +AJX6Eljxg3TrZYEEkkyIT2+mZGLlRxnvv9SjcB2Q0e4+EvEqvROnMfyR4IutR6Tvb
	 hVXHbkO+pwc3A==
Date: Tue, 27 Oct 2026 16:29:21 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Barry Song <baohua@kernel.org>, Hongru Zhang <zhanghongru06@gmail.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	surenb@google.com, david@kernel.org, liam@infradead.org, mhocko@suse.com, 
	rppt@kernel.org, shakeel.butt@linux.dev, vbabka@kernel.org, zhaonanzhe@xiaomi.com, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	loongarch@lists.linux.dev, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, linux-s390@vger.kernel.org, dave.hansen@linux.intel.com, 
	luto@kernel.org, peterz@infradead.org, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	Hongru Zhang <zhanghongru@xiaomi.com>
Subject: Re: [PATCH v6] mm: retry page faults once under the per-VMA lock
Message-ID: <auDRAEofBdqZy36y@gremlin>
References: <20260911025613.1220845-1-zhanghongru@xiaomi.com>
 <arFYRAa-i7CIwmHL@gremlin>
 <arF-E3Nsw9ZliH0t@casper.infradead.org>
 <arI_w2wTfA00Mgy9@gremlin>
 <armexcXDiG8ryZd6@casper.infradead.org>
 <CAGsJ_4xuFi7K+crAcFQ998SxXS0xPM6QeA34JV+6+Sy005rXLg@mail.gmail.com>
 <ar7MsOb6IJLt4eLo@casper.infradead.org>
 <ar-o1TrOMGrrcxLX@gremlin>
 <ataDTEZIKOYtwhUF@casper.infradead.org>
 <auDGPs8jzC-90-_y@gremlin>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auDGPs8jzC-90-_y@gremlin>

On Tue, Oct 27, 2026 at 04:26:39PM +0000, Lorenzo Stoakes (ARM) wrote:
>
> Thread A (Parent)          | Thread B (Parent)       | Thread C (Parent)
> ---------------------------|-------------------------|----------------------
> < Fork >                   |                         | < has TLB entry >
> copy_present_ptes()        | < no TLB entry >        |
>   wrprotect parent page X  |                         |
>   -> 2 mappings, refs      | *ptr = x                |
>                            | < Page fault >          |
>                            | do_wp_page()            |
>                            |   < shared, so CoW >    |
>                            |   wp_page_copy()        |
>                            |     copy X -> new pg N  |
>                            |                         | *ptr = x;
>                            |                         | [ OOPS! stale TLB,
>                            |                         |   lands in X not N ]
>                            |     ptep_clear_flush()  |
>                            |       < TLB flush >     |
>                            |     parent PTE -> N     |
>                            |     [ X now child-only ]|
>                            |                         | ASSERT(*ptr == x);
> flush_tlb_mm(oldmm)        |                         | // fails! N lacks x
>   < far too late >         |                         |
>

Sigh, I drew this entirely manually, then had the LLM overlords 'correct' it,
but it also made it less clear :).

Thread C ends up writing to what-becomes-the-child-page X, whereas the parent
ends up with page N after CoW.

So a thread in the parent writes to a page of ordinary memory and then it
disappears under them, and the child ends up with corruption in their page.

--
Cheers, Lorenzo
