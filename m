Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602830;
	b=2994UthmMelttJTzxxhua6H2gSh5YjDhEekjpwf+cJxWieVniyTnNg+Por1eRinULKDe
	 pEsd/E6jZ6Zcfzy9h3ue5WAoz80quwpPzpTBefXys0NwOlzFGOeOoh1wStMBpsRQ4DHlS
	 nAmlEEGhXTKPgRdQXIuAoLrRwfAuJndg2LhYQ6y74s9bpcOd77IC+7Eei9w94aFsNsHR/
	 jtraG64WuDfrgI3F4U49oUqkYTUGJsfXrBjnGQBe9bg/AHbu/jlH62rlZehnm+XbjCYwk
	 leA5IaCIXETblNYG4QQlELxow6hE8rY8iL5h7ktLrO0NM8WvU2gen+J7WRfipjTf/EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602830;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=kpuCbiqHWI22jSKEai65DFEmOF/zcUZ3fQHI3h+jGcY=;
	b=d65YsZnjrsrlRZtef1fJ+6UK2c2GhH4rYoCVI4HPT0Fu+vq0LNzJDoGzKwpTDn7GYGXW
	 Y3O4WxjsgWa+opBoTFbg2ECyUVYKXK1pql+u6tbI2DXL+Afd8r66ZuVehyu3y8uDHy2nd
	 GLyW45Z+6B9rN2KcKOeCPB/vJ9+v8uBXSV1Pv5VHDC+gBwuUBCaJbTbQaLyawXFTzCb1q
	 ayhXNADkFHJXN3Mr+WYnW154jdYie/yIOGTjUBTXESZJ+KOpBy98bltKESr3dPHwWwBIW
	 0pNHmTYMyZp6pL+e3khP+8mr/7JDLPI26PyvpGACPglkGlYzNXe6HOjEbqf9lPRcVcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kt6+iD3k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90C606A323;
	Fri, 13 Nov 2026 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kt6+iD3k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D781F000C4;
	Fri, 13 Nov 2026 20:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602830;
	bh=kpuCbiqHWI22jSKEai65DFEmOF/zcUZ3fQHI3h+jGcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kt6+iD3kp33fAUiGtW76c1GSpii1p1VDfXhRdlDU3CsFPxJAsgoPl0sBkAqvej0I+
	 ohh1q/Rtzqd5XQ8L4QZhuZDHwSj9xEZlSnPEHenDFWwufhl2aw3NE6nZaI2MziW2Nx
	 9Y6/YI808p2Yh/KlQvrxkzUSfSUA/Ia6b1GvttzhslG9fZ6Qj4GPnNYS+07c7K0wNU
	 8kkzMUs3yw6GTu2bp7DMAIABUCS8aPaUrGuemktnBP8+/z2Zd0AffjGkS4l7bivqNn
	 /78CICqNX9bQ5gtxyE1N5u2o6u6dDb7bzZdRqWVegNlwCj4shP7odI+5R4w3A3uIax
	 a2hQAGC5UypPg==
Date: Fri, 13 Nov 2026 20:47:03 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Carlos =?utf-8?B?TMOzcGV6?= <clopez@suse.de>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, seanjc@google.com, 
	pbonzini@redhat.com, akpm@linux-foundation.org, david@kernel.org, peterx@redhat.com, 
	imbrenda@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH v3 1/9] mm: fix eager write-bit restore for
 write-notified shared mappings
Message-ID: <avd12eMWaTl87uL0@gremlin>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-3-clopez@suse.de>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112142039.907090-3-clopez@suse.de>

On Thu, Nov 12, 2026 at 03:20:30PM +0100, Carlos López wrote:
> change_protection() applies vma->vm_page_prot, which lacks the write bit
> for CoW and write-notified mappings. Callers set
> MM_CP_TRY_CHANGE_WRITABLE when vma_wants_manual_pte_write_upgrade()
> returns true, so that entries that can be written without a fault, such
> as dirty PTEs in a shared mapping, are made writable right away.
>
> For shared mappings, that function passes vma->vm_page_prot to
> vma_wants_writenotify(). Once writenotify is enabled, this protection
> lacks the write bit, while the vma_pgprot_modify() result it is compared
> against adds it back. The two never match, so vma_wants_writenotify()
> returns false before checking for soft-dirty, uffd-wp and writeback.
>
> As a result, write-notified shmem mappings never get
> MM_CP_TRY_CHANGE_WRITABLE. For example, commit 931298e103c2
> ("mm/userfaultfd: rely on vma->vm_page_prot in uffd_wp_range()") made
> uffd-wp unprotect set the flag so that dirty shmem PTEs become writable
> again, but this never takes effect. Unprotecting N dirty shmem pages
> still leads to N faults that only set the write bit.
>
> This dates back to the commit in the Fixes tag, which moved the
> equivalent check in mprotect_fixup() before vma_set_page_prot().
>
> Fix this by passing the protection recomputed from the VMA flags, as
> vma_set_page_prot() does.
>
> Note: this only affects performance, as the next write fault restores
> the write bit anyway.
>
> Fixes: 64e455079e1b ("mm: softdirty: enable write notifications on VMAs after VM_SOFTDIRTY cleared")
> Signed-off-by: Carlos López <clopez@suse.de>
> ---
>  mm/vma.h | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/mm/vma.h b/mm/vma.h
> index 3fc3b47a954b..e83700e248e4 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -589,6 +589,14 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	      unsigned long addr, int new_below);
>  #endif
>
> +#ifdef CONFIG_MMU
> +static inline pgprot_t vma_pgprot_modify(pgprot_t oldprot, vma_flags_t vma_flags)
> +{
> +	const pgprot_t prot = vma_flags_to_page_prot(vma_flags);
> +
> +	return pgprot_modify(oldprot, prot);
> +}
> +
>  static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
>  {
>  	/*
> @@ -596,19 +604,16 @@ static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma
>  	 * if we can't do that automatically for all PTEs in a mapping. For
>  	 * private mappings, that's always the case when we have write
>  	 * permissions as we properly have to handle COW.
> +	 *
> +	 * vma->vm_page_prot lacks the write bit if writenotify is already
> +	 * enabled, so pass it with the bits restored, as vma_set_page_prot()
> +	 * does.

We don't write code in comments.

>  	 */
>  	if (vma->vm_flags & VM_SHARED)
> -		return vma_wants_writenotify(vma, vma->vm_page_prot);
> +		return vma_wants_writenotify(vma,
> +		       vma_pgprot_modify(vma->vm_page_prot, vma->flags));

You mention vma_set_page_prot() but then implement it differently from there and
make no effort to abstract it?

And so both callers now do the same thing, and both open code it... you should
abstract that.

>  	return !!(vma->vm_flags & VM_WRITE);
>  }
> -
> -#ifdef CONFIG_MMU
> -static inline pgprot_t vma_pgprot_modify(pgprot_t oldprot, vma_flags_t vma_flags)
> -{
> -	const pgprot_t prot = vma_flags_to_page_prot(vma_flags);
> -
> -	return pgprot_modify(oldprot, prot);
> -}
>  #endif
>
>  static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
> --
> 2.51.0
>

--
Cheers, Lorenzo
