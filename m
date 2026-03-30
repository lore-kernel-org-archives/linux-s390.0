Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E33A63F8
	for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2026 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880014; cv=none; b=lUQHAfMsGTSZO+oB+5Zvq1x7OQ0SzTtDOCHxbI2t1XNeGGyqcghwcPXV/7jVQqg8vWD/i4QAZCOdpPodbti41/SZV/GcBG4uNux0UfCcnm/R7z+6A2DfpFOg2JNAYBw/YN5FnNaWdx0Ym414xqFMTUFsFp9DfWQQqDCU4KJXpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880014; c=relaxed/simple;
	bh=jjLo/KYlHlqzqnNv0WJEH/7qGaF/R61RDSt36mroxZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkWNyoQ9iAQ0m3OGV558RNXcVipzCw8TP9Kg16HfuSAfmAdX8aUu5POe3iK3ncEZ2ef34wPnVBxc4D96Wv++KXyFBGeKz2zMKsGsV6FczoIYbdtyGuoFUr/jb4GjarqOjBWpIQTh2BTnh9itw4zz1DAfSrRLBuGhsjsCVAtqgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEAQK5d5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEAQK5d5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA157C4CEF7;
	Mon, 30 Mar 2026 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774880014;
	bh=jjLo/KYlHlqzqnNv0WJEH/7qGaF/R61RDSt36mroxZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEAQK5d5EB6gZI/XdoMH99WzaT0SQw895GgjMM2o44etPdaYMo8lRMr9kAZIY2NbA
	 SO1cMXJRYUD3+HH25DF5VFA3K6lJajLHMItJxSRCuxUdnN0xPtR+eW1GZOt32v3K5n
	 haVWFFlD7n5YHw0L6haPCVb1op2KzaUgV1N/sM4+inyRJ72UoikQsSQc6fn2Gftj3n
	 U+z/PfV7vd+S/IoeQr652CyiHomAgwZysEosPxXuPuja69XH7dAfBNDEiaNje84dit
	 9vKjC+d3cqFGeTzjNxwgoH11Wc1tuyuK6jno0RFy5X7VoBQ37f53sfWQY9bsbNhZN+
	 GMab29MMkExgA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id C1A88F40068;
	Mon, 30 Mar 2026 10:13:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 10:13:32 -0400
X-ME-Sender: <xms:DIXKaUNo8x6eNHbeeDZrPNKYYCYRt0OVrzAoJgh21Ck-T_Mfa_mBEQ>
    <xme:DIXKaRGBSKHVnr7Q9isa4JQgjjTUBwhCwPLDyGiwqzESPwEPO4X3jHpNkyc2z-90c
    oMToV8ClUtLNC0kkMd3LOW0y7P6Zh3PYQMBDylDpqJxbIoVHHS60bs>
X-ME-Received: <xmr:DIXKad-K24OQojUNBnEsHGs60TyyM8zE7h0c-5BRxWHRNh8Nq5ysCXjNmoLDAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeludelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepheekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehushgrmhgrrdgrrhhifheslhhinhhugidruggvvhdprhgtphhtthhopegrkhhpmh
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiuges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehfvhgulhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdhorhhgpdhrtghpthht
    oheprhhivghlsehsuhhrrhhivghlrdgtohhm
X-ME-Proxy: <xmx:DIXKaaiJLRt5GSlkdiUmhFjWhOZ4nb9mM6WyYioqjMYyVB3fjl7zZQ>
    <xmx:DIXKaRl6F6N-NclA9PKNuHMnKIzG0RWjBeD5UGuU8RQ0Qx9rcJZM2Q>
    <xmx:DIXKae0HwbXVQA6um0VLymaQDy3iQOYfdome4H8abIelI6UOy6KafA>
    <xmx:DIXKab44LkdEFCFeip0pHXR6ZwEiGVu3SbVO6ZjPwnvL1WhiQsIDEA>
    <xmx:DIXKaciiUno2X6usDVDLFhSMU3fWh6eS__6EOM0QIwEfusfWP-DriSDe>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 10:13:32 -0400 (EDT)
Date: Mon, 30 Mar 2026 14:13:31 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, willy@infradead.org, linux-mm@kvack.org, fvdl@google.com, 
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, baohua@kernel.org, 
	dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>, 
	lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [v3 05/24] mm: thp: handle split failure in zap_pmd_range()
Message-ID: <acqC010JLTfjHF0y@thinkstation>
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <20260327021403.214713-6-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327021403.214713-6-usama.arif@linux.dev>

On Thu, Mar 26, 2026 at 07:08:47PM -0700, Usama Arif wrote:
> zap_pmd_range() splits a huge PMD when the zap range doesn't cover the
> full PMD (partial unmap).  If the split fails, the PMD stays huge.
> Falling through to zap_pte_range() would dereference the huge PMD entry
> as a PTE page table pointer.
> 
> Skip the range covered by the PMD on split failure instead.

Ughh... This is hacky as hell.

> The skip is safe across all call paths into zap_pmd_range():
> 
> - exit_mmap() and OOM reaper: the zap range covers entire VMAs, so
>   every PMD is fully covered (next - addr == HPAGE_PMD_SIZE).  The
>   zap_huge_pmd() branch handles these without splitting.  The split
>   failure path is unreachable.
> 
> - munmap / mmap overlay: vma_adjust_trans_huge() (called from
>   __split_vma) splits any PMD straddling the VMA boundary before the
>   VMA is split.  If that PMD split fails, __split_vma() returns
>   -ENOMEM and the munmap is aborted before reaching zap_pmd_range().
>   The split failure path is unreachable.
> 
> - MADV_DONTNEED: advisory hint, the kernel is allowed to ignore it.
>   The pages remain valid and accessible.  A subsequent access returns
>   existing data without faulting.

Em, no. MADV_DONTNEED users expect memory to be zeroed after the
"advise" is complete. At very least you need to zero the skipped range.

And are you sure that the list of users is complete?

I am also worried about a possible new user that is not aware about this
skip-on-split-failure semantics.

I think it hast o be opt-in. Maybe a ZAP_FLAG_WHATEVER?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
