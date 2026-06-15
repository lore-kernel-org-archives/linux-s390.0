Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D963B3893;
	Mon, 15 Jun 2026 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529672; cv=none; b=ElzmjyebPLWDQFdS+a8xPndWkBy+qscK4CAit7C8Ge6qOoJmE/Lah5g+qADMTUwxPi7OPazANewe3BmVHGH5qJN0FFjOJQfSAhAY4Od9yLdKIM44Tz6cgLII0g5YA6QRTw6rea2ZSYFiHnNCYGhNKUlOq0XZWdKT5id9oiGA5k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529672; c=relaxed/simple;
	bh=cPegwXTMfEWMxhoepngK8waWDe4dq+gw/msJA+k7oF8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YnaTgE+Z2kH3E2W6CQuVyJpUKV+fSypqVRQsiWwD1iwDFXWVdsItTOFTrr5G8L2Kgd82FlcEedWVI2Xn5I3+s1yLTWH3oAv4tBO4x+vfSuqUu0RWLUAM8/0PkSJjsTQFV1bwJFSBzKVf9c5pc2U3quhkJoLV7LyvUXlkn6dRGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4Yn7b6q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4Yn7b6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184341F000E9;
	Mon, 15 Jun 2026 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781529671;
	bh=TI+XMXJqgiaWQmAdYTDboDClYBvpFaQ+M7Bkt7ms9EY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C4Yn7b6q36OL31uGqfQTuZaDlxGLf19nFg4IywVrm9ZcR75Xa1JrTaP3Lt7/8ZS82
	 7LiO6ZY0uWPmcc2d3kIZCRooHowz2yAsy0y+WzNQir7n2Nk8cOSABM5P0/DBvWvLZS
	 zJvK8fFTkhJQRlYD9hVoLP+DGBDHrY2+ATFzCJ8c7LdDUq8stAjLbRk8jIUS/xn253
	 k02+w495psR+3qvLxsLyb1bjAKoEoEP55ju584w8tJlle8TczNHR+DWG1P0wpkJq2u
	 hkPDDAa/TA3iQu3qgGdIj5kp7meTS801XPNJVTps7dGgJ1Wld3YmRiN3aw3Sh8pnXw
	 gMbVRICMW4VGQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 16/17] KVM: s390: Enable adapter_indicators_set to
 use mapped pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260615124243.187614-17-imbrenda@linux.ibm.com>
References: <20260615124243.187614-17-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 13:21:10 +0000
Message-Id: <20260615132111.184341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing KVM dirty page tracking in fast path for mapped adapter in=
dicators breaks live migration.
- [High] Atomicity violation when pinning the summary page fails leaves the=
 guest hardware state inconsistent.
- [High] Host-side denial of service vulnerability via unprivileged userspa=
ce-reachable WARN_ON_ONCE.
--

commit 65f7550eaa09f7cd9feb26fff5319f4be6fecb0c
Author: Douglas Freimuth <freimuth@linux.ibm.com>

KVM: s390: Enable adapter_indicators_set to use mapped pages

This patch optimizes the s390 adapter_indicators_set function to use
long-term mapped pages when available. If pages are mapped, it processes
the interrupt on a fast path; otherwise, it falls back to the slow path
pinning.

Message-ID: <20260604192755.203143-3-freimuth@linux.ibm.com>

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index d066a282271e2..b5304816aaa04 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
[ ... ]
> @@ -2892,41 +2892,80 @@ static unsigned long get_ind_bit(__u64 addr, unsi=
gned long bit_nr, bool swap)
[ ... ]
>  static int adapter_indicators_set(struct kvm *kvm,
>  				  struct s390_io_adapter *adapter,
>  				  struct kvm_s390_adapter_int *adapter_int)
>  {
>  	unsigned long bit;
>  	int summary_set, idx;
> -	struct page *ind_page, *summary_page;
> +	struct s390_map_info *ind_info, *summary_info;
>  	void *map;
> +	struct page *ind_page, *summary_page;
> +	unsigned long flags;
> =20
> -	ind_page =3D pin_map_page(kvm, adapter_int->ind_addr, 0);
> -	if (!ind_page)
> -		return -1;
> -	summary_page =3D pin_map_page(kvm, adapter_int->summary_addr, 0);
> -	if (!summary_page) {
> +	ind_page =3D NULL;
> +
> +	spin_lock_irqsave(&adapter->maps_lock, flags);
> +	ind_info =3D get_map_info(adapter, adapter_int->ind_addr);
> +	if (!ind_info) {
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +		ind_page =3D pin_map_page(kvm, adapter_int->ind_addr, 0);
> +		if (!ind_page)
> +			return -1;
> +		idx =3D srcu_read_lock(&kvm->srcu);
> +		map =3D page_address(ind_page);
> +		bit =3D get_ind_bit(adapter_int->ind_addr,
> +				  adapter_int->ind_offset, adapter->swap);
> +		set_bit(bit, map);
> +		mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
> +		set_page_dirty_lock(ind_page);
> +		srcu_read_unlock(&kvm->srcu, idx);
>  		unpin_user_page(ind_page);
> -		return -1;
> +	} else {
> +		map =3D page_address(ind_info->page);
> +		bit =3D get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->=
swap);
> +		set_bit(bit, map);
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +	}

[Severity: High]
When updating the mapped indicator page in this fast path branch, does this
skip calling mark_page_dirty() and set_page_dirty_lock()? Could skipping
the dirty page logging cause the destination VM to resume with stale memory
state during live migration?

> +	spin_lock_irqsave(&adapter->maps_lock, flags);
> +	summary_info =3D get_map_info(adapter, adapter_int->summary_addr);
> +	if (!summary_info) {
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +		summary_page =3D pin_map_page(kvm, adapter_int->summary_addr, 0);
> +		if (WARN_ON_ONCE(!summary_page))

[Severity: High]
Since summary_addr is provided by userspace, can an invalid address
intentionally trigger this WARN_ON_ONCE()? Should this return an error
instead of asserting to avoid spamming the host kernel log?

> +			return -1;

[Severity: High]
If pin_map_page() fails for the summary page and returns -1 here, does this
leave the indicator bit already set in guest memory without its correspondi=
ng
summary bit? The original code pinned both pages before modifying memory.

> +		idx =3D srcu_read_lock(&kvm->srcu);
> +		map =3D page_address(summary_page);
> +		bit =3D get_ind_bit(adapter_int->summary_addr,
> +				  adapter_int->summary_offset, adapter->swap);
> +		summary_set =3D test_and_set_bit(bit, map);
> +		mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
> +		set_page_dirty_lock(summary_page);
> +		srcu_read_unlock(&kvm->srcu, idx);
> +		unpin_user_page(summary_page);
> +	} else {
> +		map =3D page_address(summary_info->page);
> +		bit =3D get_ind_bit(summary_info->addr, adapter_int->summary_offset,
> +				  adapter->swap);
> +		summary_set =3D test_and_set_bit(bit, map);
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
>  	}

[Severity: High]
Similar to the indicator fast path, does this skip calling mark_page_dirty()
when updating the summary bit?

> =20
> -	idx =3D srcu_read_lock(&kvm->srcu);
> -	map =3D page_address(ind_page);
> -	bit =3D get_ind_bit(adapter_int->ind_addr,
> -			  adapter_int->ind_offset, adapter->swap);
> -	set_bit(bit, map);
> -	mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
> -	set_page_dirty_lock(ind_page);
> -	map =3D page_address(summary_page);
> -	bit =3D get_ind_bit(adapter_int->summary_addr,
> -			  adapter_int->summary_offset, adapter->swap);
> -	summary_set =3D test_and_set_bit(bit, map);
> -	mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
> -	set_page_dirty_lock(summary_page);
> -	srcu_read_unlock(&kvm->srcu, idx);
> -
> -	unpin_user_page(ind_page);
> -	unpin_user_page(summary_page);
>  	return summary_set ? 0 : 1;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615124243.1876=
14-1-imbrenda@linux.ibm.com?part=3D16
