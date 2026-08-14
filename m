Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB50349CDD;
	Fri, 14 Aug 2026 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719870; cv=none; b=GmDpXMNae/G9xTByQKWjzFuliPdM0Nm5INQbDOpo6ZYSTZFRVE5lWrv+ENp8u7YxKBY0sT+bjQDSBETChlSEBJ2xzQsXdGnf4FzjBHyR62nyiK6rMbRascif0pj5UyF+Crc6bcOKBF6AQkoSxuP1kS0YESblAm12Hd4pvJWXVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719870; c=relaxed/simple;
	bh=g0AIZkSslezYBDEK+qrQefCQGUI+idOb9Iy2hAHjnzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hu5KRNGz96osp/b7yJUoyYVVSD8+XCe5kA3JMQlflhervw8nm4Duk6HAj8w1CweJfiyIHyBeDw+iGQm1D9CgYZNqqcrURbsQ4CX0MhvJR5ZlFpT8zmQYl0dodfJoJqHEPGp2LN0/LTy9ZCRHGFRTLWBpvUbsbGN4rrUo1di6HXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPSp3CNK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPSp3CNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FCC1F000E9;
	Fri, 14 Aug 2026 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719869;
	bh=jjHWApxHeC41WBwSc4owswwF+UTuqKsLId0lLQw/57o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EPSp3CNKLP4/His82LFwK06CjHrC02ST3H2LokhIqy427jIh2uyLN/SZlWnqzAk6T
	 Xg0iq2wjCBRaMyBn7ME+ahwGBTsNnCnKhyrKU9A8LkDjgQuBq5AcgSFG7EWjQzq0tY
	 mVqEuOBwC78ApPpiuFOHemFXe/qb85u8z4N9PoKQpsl6KYVhqCy7/OonhseEYdp4zY
	 GNbJhphj5ZB82E/IRHfnQSo2Sk+lG82vDa49uZ6Q/E43Ku+Rce4ZL8c+YBfyyHV6mB
	 8jkIS8Vn5lVTaTRLRfqJGXUT/8BmMxUhJ0Vh4a9YKS+3QKxDeCc1ASu6OvfLWk7v7L
	 DAfwBDeKqqqQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/6] KVM: s390: Fix _gaccess_shadow_fault()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260814144041.169025-3-imbrenda@linux.ibm.com>
References: <20260814144041.169025-1-imbrenda@linux.ibm.com>
 <20260814144041.169025-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:04:28 +0000
Message-Id: <20260814150428.E2FCC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Accessing `sg->parent` outside of `children_lock` leads to a T=
OCTOU NULL pointer dereference if the shadow gmap is concurrently unshadowe=
d.
--

--- Patch [2]: [PATCH v1 2/6] KVM: s390: Fix _gaccess_shadow_fault() ---
commit 64108760233a08b4a69c94be48f33b269ea23a85
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix _gaccess_shadow_fault()

This commit addresses an issue where nested guest memory is not present in
the parent guest gmap, causing dat_entry_walk() to return -ENOENT. It fixes
this by manually calling gmap_link() on the nested guest's memory if the
mapping is absent.

> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 36102b2727fbf..0d5d46d4c66fd 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1593,12 +1593,25 @@ static inline int ___gaccess_shadow_fault(struct =
kvm_vcpu *vcpu, struct gmap *sg
>  	parent =3D READ_ONCE(sg->parent);
>  	if (!parent)
>  		return -EAGAIN;
> +retry:
>  	scoped_guard(spinlock, &parent->children_lock) {
>  		if (READ_ONCE(sg->parent) !=3D parent)
>  			return -EAGAIN;
>  		sg->invalidated =3D false;
>  		rc =3D _gaccess_do_shadow(vcpu->arch.mc, sg, saddr, walk);
>  	}
> +	if (rc =3D=3D -ENOENT) {
> +		struct kvm_memory_slot *slot;
> +		struct guest_fault *entries;
> +
> +		entries =3D get_entries(walk);
> +		slot =3D kvm_vcpu_gfn_to_memslot(vcpu, entries[LEVEL_MEM].gfn);
> +		if (!slot)
> +			return PGM_ADDRESSING;
> +		rc =3D gmap_link(vcpu->arch.mc, sg->parent, entries + LEVEL_MEM, slot);

[Severity: Critical]
Could accessing sg->parent here lead to a NULL pointer dereference?

The scoped_guard block drops parent->children_lock before this code is
reached. If another vCPU concurrently unshadows sg, sg->parent could be
set to NULL. Because this passes sg->parent directly instead of using the
cached parent variable, does this risk passing NULL into gmap_link() and
causing a host kernel panic?

> +		if (!rc)
> +			goto retry;
> +	}
>  	if (!rc)
>  		kvm_s390_release_faultin_array(vcpu->kvm, walk->raw_entries, false);
>  	return rc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814144041.1690=
25-1-imbrenda@linux.ibm.com?part=3D2
