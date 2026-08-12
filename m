Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40FC2C15A5;
	Wed, 12 Aug 2026 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532460; cv=none; b=W9j3PUpHug58mH6XIfhEOu7j/D65zGzsARsE5/xWQqoPNQdU7nY4xYHIRQO9NyGpi/ZyO/T5RBXAY0lbWxstzfoGrml5BNf63T6PjUCUWqZxff69Ith5lOvlMsNzgkLWCFAuR9WANTW++IRTe13yuDJhrJ93js6ZM8i0/77apgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532460; c=relaxed/simple;
	bh=Hy5OhoCQtlxf1SVggN1QsxLu+S7cCSYA/jwou6dMdmU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UM6b2ZU1IpKGxTuw/LhEb49alkSB6Q81NQkJrzHzJuvYStFfcwlugs+RaSuJcv78b3JynwogdqbyFMYB+u5NyobIZP+YHxEvervn3dMSCe28VvVDfAEkkL0UyWpjtC4wMOWYo5wq3x48r2A9ZYbJOFTR5UnukqSeh2Vedcxzvzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxa4IMOj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxa4IMOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD3D1F000E9;
	Wed, 12 Aug 2026 11:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786532459;
	bh=rHy5qIgczVLfjHWy6ru4e7MmOCI+G2EMyPaetRy+LLE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jxa4IMOjFmnw9/8Y7WyOrT1/FWyWAQQTowQI0gafPkwDCL1ebmf+Ao4hwt3dNymmw
	 mW26Df5LW6FBHyIeSbJL1j0eGz2ai58pAYk84kj1waCP5c7ts47uSxpRj5/wqCeaMG
	 +5q/W3ENFfGeJQgJOuNcNeDArg6Qy72ukz4pedC3MIYrf28/SXjqNtNhqu5azbFl1o
	 0/+WPmNuwznbFXzimh3H5wbBOLgStUSlpjrpngwv3YfuDwm2E1NVNkpIrvYkzZO2EO
	 8z8k8LbzYB6myH9F6tolApG4OugP/DrAkWzu7O1Hvqry7hSeIdoto47cTkessaaqZd
	 nOpkoS+rO0C0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] KVM: s390: Fix dirty marking in
 adapter_indicators_set*()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260812104436.109741-5-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 11:00:58 +0000
Message-Id: <20260812110058.EBD3D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Replacing set_page_dirty_lock() with set_page_dirty() on GUP-pinne=
d pages introduces a Use-After-Free vulnerability due to a race with file t=
runcation.
- [High] Ordering mark_page_dirty() before memory modification creates a ra=
ce condition with dirty log harvesting, risking lost updates during live mi=
gration.
--

--- Patch [4]: [PATCH v2 4/9] KVM: s390: Fix dirty marking in adapter_indic=
ators_set*() ---
commit 8bb6adeda8416869b198540515723990915f8390
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix dirty marking in adapter_indicators_set*()

This commit updates dirty page marking for adapter indicators in KVM s390.
It adds missing calls to set_page_dirty() and mark_page_dirty() in the fast
path and reorganizes the slow path, replacing set_page_dirty_lock() with
set_page_dirty() for pinned pages.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 608ff95d53bac..e79f636c7544d 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
[ ... ]
> @@ -2997,21 +2999,20 @@ static int adapter_indicators_set(struct kvm *kvm,
>  		ind_page =3D pin_map_page(kvm, adapter_int->ind_addr, 0);
>  		if (!ind_page)
>  			return -1;
> -		idx =3D srcu_read_lock(&kvm->srcu);
>  		map =3D page_address(ind_page);
>  		bit =3D get_ind_bit(adapter_int->ind_addr,
>  				  adapter_int->ind_offset, adapter->swap);
>  		set_bit(bit, map);
> -		mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
> -		set_page_dirty_lock(ind_page);
> -		srcu_read_unlock(&kvm->srcu, idx);
> +		set_page_dirty(ind_page);

[Severity: High]
Is it safe to replace set_page_dirty_lock() with set_page_dirty() here?

For short-term GUP-pinned memory like this ind_page, the memory can be back=
ed
by any filesystem. Without the folio lock, a concurrent file truncation cou=
ld
unmap the folio and free the mapping.

If set_page_dirty() reads folio->mapping concurrently, could it dereference
freed memory when calling mapping->a_ops->dirty_folio()?

>  		unpin_user_page(ind_page);
>  	} else {
>  		map =3D page_address(ind_info->page);
>  		bit =3D get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->=
swap);
>  		set_bit(bit, map);
> +		set_page_dirty(ind_info->page);
>  		spin_unlock_irqrestore(&adapter->maps_lock, flags);
>  	}
> +	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
> =20
>  	spin_lock_irqsave(&adapter->maps_lock, flags);
>  	summary_info =3D get_map_info(adapter, adapter_int->summary_addr);
> @@ -3020,22 +3021,21 @@ static int adapter_indicators_set(struct kvm *kvm,
>  		summary_page =3D pin_map_page(kvm, adapter_int->summary_addr, 0);
>  		if (WARN_ON_ONCE(!summary_page))
>  			return -1;
> -		idx =3D srcu_read_lock(&kvm->srcu);
>  		map =3D page_address(summary_page);
>  		bit =3D get_ind_bit(adapter_int->summary_addr,
>  				  adapter_int->summary_offset, adapter->swap);
>  		summary_set =3D test_and_set_bit(bit, map);
> -		mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
> -		set_page_dirty_lock(summary_page);
> -		srcu_read_unlock(&kvm->srcu, idx);
> +		set_page_dirty(summary_page);

[Severity: High]
Similarly, could calling set_page_dirty() instead of set_page_dirty_lock() =
on
the GUP-pinned summary_page lead to a use-after-free if the file is truncat=
ed
concurrently?

>  		unpin_user_page(summary_page);
>  	} else {
>  		map =3D page_address(summary_info->page);
>  		bit =3D get_ind_bit(summary_info->addr, adapter_int->summary_offset,
>  				  adapter->swap);
>  		summary_set =3D test_and_set_bit(bit, map);
> +		set_page_dirty(summary_info->page);
>  		spin_unlock_irqrestore(&adapter->maps_lock, flags);
>  	}
> +	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
> =20
>  	return summary_set ? 0 : 1;
>  }
> @@ -3045,26 +3045,30 @@ static int adapter_indicators_set_fast(struct kvm=
 *kvm,
>  				       struct kvm_s390_adapter_int *adapter_int,
>  				       int setbit)
>  {
[ ... ]
>  	map =3D page_address(ind_info->page);
>  	bit =3D get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->s=
wap);
> -	if (setbit)
> +	if (setbit) {
> +		mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
> +		set_page_dirty(ind_info->page);
>  		set_bit(bit, map);
> +	}

[Severity: High]
Does calling mark_page_dirty() before actually modifying the memory with
set_bit() create a race condition with dirty log harvesting?

If userspace harvests the KVM dirty log between mark_page_dirty() and
set_bit(), it might clear the dirty bit in KVM's tracking and read the old
unmodified page.

When set_bit() then executes, the page would no longer be marked dirty, and
the change wouldn't be migrated to the destination.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812104436.1097=
41-1-imbrenda@linux.ibm.com?part=3D4
