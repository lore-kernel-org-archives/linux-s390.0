Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602277;
	b=l/7ulMsHxw3hE93CRrl3oXet0lP2e9LX/DR7TgtZHb45YCavDnSztI84jFl/Qq4XvqWL
	 dqoZjaTQnFZYLf/b2SO3mCfJpGij+lmGpvVgIhYPI0KZIV3O8pacyGf8fYUmJKYFdP5eH
	 M/hAX3MsOXMVQ87wlPgs0O0IMBwFnN690+KCCZD3nuoIst/0/7c7du9tu8KtJ+n48brI9
	 0Z65/18zlytNuXkDFh5hypVjOwYILzpxBPT/IZVXtFCoLQqEt2D1XAVekCCH5e1JJOwNR
	 DWuJ0pYip0LIKczqu8hEs//yq8ZJvRVGAYTFX+i3Mw0yW2XIxFjd7IAZ0mA0T2QgDkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602277;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=AvlalDGclbf9jbvk6fxMo0zLcUfRP1nU9XgrjQZVQsU=;
	b=qzyiVc8zw5Fyt3UIcyifT7FBaS/q/nMdCdx/GXItSFYXfwtGdAe0Zoy0N5C/ISvD3wLC
	 Uch9EA+XR7haxweva+gaiePgeowqRhNJQmWpHKV15Pv+N7NGw4he1TBLqKTFOBoiPFxVf
	 JBPEqVnP9i5lswKtGRvxvxP6o7TyoSULvzpBnw8JdT+yuiKJ7opeUrroHRlcOwsis+hv7
	 sjRk7bgzZKMILTDhvFEcYHMHlJuZwhDaPszHBkhiLRsbBzMTSYiIZ9TWrozo8K/twZFru
	 mnjGvYVlHhesB29huT7DoPh2Gw+qcNAtV67gVryM1+l3wE1os5NSpKkwlZxSaDp1VNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSMFgLfD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFF606A339;
	Fri, 13 Nov 2026 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSMFgLfD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49121F000C4;
	Fri, 13 Nov 2026 20:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602276;
	bh=AvlalDGclbf9jbvk6fxMo0zLcUfRP1nU9XgrjQZVQsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fSMFgLfDA/Ou58ytoSDg+1mflt1C7sWfR/W+ACkbe1dn9am4k5kJZgDhqDYpp0Nt0
	 EaI5rLObsWfuzFn5sTkAdXrZTPZEOpgzZMmRyDRvvWgX5LUQ7U5rqM0s/9Lhy2n2iO
	 YWKyKRkJOYrhOtqCRb2/2i02fzf4vW8jb0PlxlNLpBkgx09vD8+B+Wt97/Ys9H+6+l
	 fX145SXiGWNPCodaqf//AhojDtXtDD6IR3aLabRjw+Ztxi0EdDViMwKG/qjkIKS5XJ
	 PU9Sx0DZki7JpzFZRqIWWzYvt8C9VphFjKVogQHq88kV0ThjxG70bvz0ukpSgbufbj
	 ChhdqKcPkXVrQ==
Date: Fri, 13 Nov 2026 20:37:49 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Carlos =?utf-8?B?TMOzcGV6?= <clopez@suse.de>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, seanjc@google.com, 
	pbonzini@redhat.com, akpm@linux-foundation.org, david@kernel.org, peterx@redhat.com, 
	imbrenda@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v3 5/9] mm/mprotect: add MM_CP_PERM_UPGRADE
Message-ID: <avdw0O4rWi4WrTvy@gremlin>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-7-clopez@suse.de>
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
In-Reply-To: <20261112142039.907090-7-clopez@suse.de>

On Thu, Nov 12, 2026 at 03:20:34PM +0100, Carlos López wrote:
> Add a change_protection() flag for changes that only add permissions,
> so that MMU notifier users can keep their mappings and fault in the new
> permissions later. mprotect() sets it when the new VMA flags only add
> read, write or execute permissions, or VM_ACCOUNT, which does not affect
> the page tables. Any other change, such as a different protection key,
> is not an upgrade.

I'm struggling to comprehend what this means.

'Add a flag for changes that only add 'permissions' (not defined) so that 'MMU
notifier users' can keep mappings and 'fault' in 'the new permissions' later.

The rest of the message just states what the code does but speaks about it as if
it was already what happened.

This needs to be completely rewritten...!

>
> Signed-off-by: Carlos López <clopez@suse.de>
> ---
>  include/linux/mm.h |  2 ++
>  mm/mprotect.c      | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6af3b7008f1a..001829a61405 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3585,6 +3585,8 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
>  #define  MM_CP_UFFD_RWP_RESOLVE            (1UL << 5) /* resolve rwp */
>  #define  MM_CP_UFFD_RWP_ALL                (MM_CP_UFFD_RWP | \
>  					    MM_CP_UFFD_RWP_RESOLVE)
> +/* Whether this change only upgrades/adds permissions */
> +#define  MM_CP_PERM_UPGRADE                (1UL << 6)

What are 'permissions' exactly?

>
>  bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t pte);
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 84bcfe0281d3..8c0fcd10f5a3 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -767,6 +767,17 @@ static const struct mm_walk_ops prot_none_walk_ops = {
>  	.walk_lock		= PGWALK_WRLOCK,
>  };
>
> +static bool vma_flags_is_perm_upgrade(vma_flags_t old_vma_flags,
> +				      vma_flags_t new_vma_flags)

No comment, random abbreviation (but just one word). Not ideal.

> +{
> +	vm_flags_t old = vma_flags_to_legacy(old_vma_flags);
> +	vm_flags_t new = vma_flags_to_legacy(new_vma_flags);

This is beyond appalling and a complete abuse of the VMA flags API.

You seem to have decided that you won't try to learn how the API works, so
instead you'll just write deprecated code that I have to find time to come and
fix up later I guess?

And we're at v3...!

> +	/* VM_ACCOUNT does not affect page tables */

What does this mean? And why are you referring to a deprecated constant?

> +	vm_flags_t mask = VM_READ | VM_WRITE | VM_EXEC | VM_ACCOUNT;
> +
> +	return new == (old | (new & mask));

Ordinarily I'd try to help you use the new API, but the very fact you'd send
it like this dissuades me :/

> +}
> +
>  int
>  mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	       struct vm_area_struct *vma, struct vm_area_struct **pprev,
> @@ -847,6 +858,8 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	vma_overwrite_flags(vma, new_vma_flags);
>  	if (vma_wants_manual_pte_write_upgrade(vma))
>  		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
> +	if (vma_flags_is_perm_upgrade(old_vma_flags, new_vma_flags))
> +		mm_cp_flags |= MM_CP_PERM_UPGRADE;
>  	vma_set_page_prot(vma);
>
>  	change_protection(tlb, vma, start, end, mm_cp_flags);
> --
> 2.51.0
>

--
Cheers, Lorenzo
