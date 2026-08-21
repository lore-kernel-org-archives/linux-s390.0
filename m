Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553A353A91;
	Fri, 21 Aug 2026 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343220; cv=none; b=ZY7hwDLBzHSmfrEz+CVoZ/gW5wi+Bnllumlc97rfdVXLdFJWfDv3AnPF/xZo+uWKGx/gjwZ8h32e/fYAXYxUdfzvlHEccDGvwM83wSM9aoN7iAz6V3gR1UZbj7BewxzRLPM+j9LTVILZf6UX3nvYAvS5EYplr6AMxXZN4bcU6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343220; c=relaxed/simple;
	bh=ynlUrqc3dY8P00mA3z+SbNe+S+mvotQU5mcQHOYtmZ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JETBrwq2HuWOcXNZsbtXKjWbz4TtQw0zSHsyT1FTxMlFLZnI7pTohUU2/j3XUMFEgIXrL9DCKAjvjzjPJxGvp2dQ4f/vd5OtYoRBtEKJacKuGDI1peg/n6mn34vnOcBjDNZahlvCd9Dx2CvrkEdqoP6+sZbgL6pUd2rkPmN66nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGbRfXKx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGbRfXKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FF71F000E9;
	Fri, 21 Aug 2026 20:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343218;
	bh=HxgBGrATYxO22YAcZVsj8yVFPx5my9CwVN/eMfp225Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AGbRfXKxiUv06nKNyfUNDabno/WUPggt6LbE2l+85efdZ/RwggMPbyOrBq98YcHpo
	 MdvEWkcHQ21uodX9SM2HnqX8qZ0DpkbsSScf6sattjlLPEtHQ6q0oPEETtMcerYH6k
	 tjjU1SmyveaO+br7CFeDy5UYZwYk73WQUp5QoYpa6J9KBrPcB2j1YatQW5hw8zMpCe
	 DZ/pY3QVDckK96RG1wZ9STwicMKjRrf34MZBsSjYvECWqS06rBAI4FBI5nFsk33hAF
	 PxckM6XnzUMCZo+t7Z35NP3fd2b+9hJXki6pz+Mf+rcRjuUqhagaINAVBwSQ/Rt4fG
	 keXnCwifn05ng==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 08/24] unwind_user/eh_frame: Store .eh_frame_hdr
 section data in per-mm maple tree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-9-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-9-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:13:38 +0000
Message-Id: <20260821201338.86FF71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] If mas_erase() fails due to an Out-Of-Memory (OOM) condition, =
it leaves the entry in the tree but __eh_frame_remove_section() still frees=
 it via call_srcu().
- [Medium] Mixing `goto`-based error handling with scope-based cleanup help=
ers in the same function.
- [Low] `efi_mm` is missing the `INIT_MM_EH_FRAME` initializer.
--

--- Patch [8]: [RFC PATCH v2 08/24] unwind_user/eh_frame: Store .eh_frame_h=
dr section data in per-mm maple tree ---
commit 428d78732477ec23211b2b4732a9923dae762c55
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Store .eh_frame_hdr section data in per-mm maple tree

This commit associates .eh_frame_hdr sections with their mm_struct by
adding them to a per-mm maple tree. The tree is indexed by the
corresponding text address ranges.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> index f25a0923e315b..8cf19c5298fde 100644
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c

[ ... ]

> @@ -352,15 +355,76 @@ int eh_frame_add_section(unsigned long eh_frame_hdr=
_start,
>  	if (ret)
>  		goto err_free;
> =20
> -	/* TODO nowhere to store it yet - just free it and return an error */
> -	ret =3D -ENOSYS;
> +	ret =3D mtree_insert_range(eh_frame_mt, sec->text_start, sec->text_end =
- 1,
> +				 sec, GFP_KERNEL_ACCOUNT);
> +	if (ret) {
> +		dbg("mtree_insert_range failed: text=3D%lx-%lx\n",
> +		    sec->text_start, sec->text_end);
> +		goto err_free;
> +	}
> +
> +	return 0;
> =20
>  err_free:

[Severity: Medium]
Is it intentional to mix goto-based error handling with scope-based cleanup
helpers in the same function?

The eh_frame_add_section function uses scoped_guard for the mmap lock but
retains a goto err_free label for allocation cleanup on failure.

The cleanup subsystem guidelines suggest that a function should either conv=
ert
all resources to scope-based cleanup or convert none of them to avoid
confusing ownership semantics.

>  	free_section(sec);
>  	return ret;
>  }

[ ... ]

> +static int __eh_frame_remove_section(struct ma_state *mas,
> +				     struct eh_frame_section *sec)
> +{
> +	if (mas_erase(mas) !=3D sec) {
> +		dbg("mas_erase failed: text=3D%lx\n", sec->text_start);
> +		return -EINVAL;
> +	}
> +
> +	call_srcu(&eh_frame_srcu, &sec->rcu, eh_frame_free_srcu);

[Severity: Critical]
Can this cause a use-after-free if the maple tree erase operation fails?

If mas_erase fails due to memory exhaustion (for example, during tree
rebalancing), it leaves the entry in the tree, sets mas_is_err(mas), and
returns the pointer to the entry.

Because it returns the entry pointer, the condition mas_erase(mas) !=3D sec
will evaluate to false, skipping the error block.

The code would then proceed to call call_srcu and free the section while
it remains linked in the maple tree, potentially causing a crash when the
tree is traversed later. Should this check mas_is_err(mas) instead?

> +
> +	return 0;
> +}

[ ... ]

> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index 3e792aad76261..25c26341fc4fb 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c

[ ... ]

> @@ -48,6 +49,7 @@ struct mm_struct init_mm =3D {
>  #endif
>  	.flexible_array	=3D MM_STRUCT_FLEXIBLE_ARRAY_INIT,
>  	INIT_MM_CONTEXT(init_mm)
> +	INIT_MM_EH_FRAME
>  };

[Severity: Low]
Does efi_mm in drivers/firmware/efi/efi.c also need this initializer?

When a new initializer like INIT_MM_EH_FRAME is added to init_mm, it usually
needs to be added to all static mm_struct definitions.

Leaving it out means the eh_frame_mt maple tree inside efi_mm remains
zero-initialized rather than properly initialized with MTREE_INIT, which
might lead to lock splats or crashes if accessed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D8
