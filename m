Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793428;
	b=iDkigNcXDAdpFD0fLm3NV3sejPF8Ya9vzWuf5EbzLY1jDqYssry6sXicZ+8Hh8f2PnFN
	 AR2yiqNAsauTj30sEaz47Id2zG1b09VORgzLJHWr+Z5LBQl9Yt8ngPU5ZiDp2eWmTXYLJ
	 Xpd52vtLdKnh2uSdHfiRHHNydN03v5xV3iaEDy8h7e9n1SdwDm1n3SeK9ZOjEomH2TiW2
	 /Fa5BMBtHiZ3d0I2IxZXnVi0TTScJOs0Q8RMw0FIrRRHfZg+5mEQ8KlNChUsZqEJYQvDw
	 pDsG2h5AJL1+jVw8JPsSFvGMFZgxqC7gAHRwVX8WZ94PWULW/eK43Prz8m60RH7h2wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793428;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hjKKqCrABc69i95dlZmHpkqI5VCv/djrCGS0VW6tCuY=;
	b=zC13TXP3BuTua+AV9ykDO5nUQWY4x2KkigXvtuZPkWVXypW7BSsk+yTAGGADElwA+9N3
	 D/TDRHkXevyZCDbIgKtY9u+5ksJiDhz3R0xms6WW8CfqHGUOZ4PEShMRJA2YUUFeVKbMa
	 2X6y5w3XDMzIPqzy9yiAx391CpaDKwsc4ultr+cDKPouckBf3+vIdveRlW0i7t/UJzXRz
	 g09jMh6tZxzoHoVsx0pifEQMgOnqDvrdG6fBR9vHMFPmlf1mTVjwOWSx/bzqXODQ5KNSj
	 /bztQXxqI2pj3FaevErVSt2wtZtxo1yZpXY73g6CcPULpw+ZLmKqtHKJq7GCrsyCDfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=avUzoNj9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85692606A32D;
	Fri, 27 Nov 2026 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=avUzoNj9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E00E1F000C1;
	Fri, 27 Nov 2026 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793427;
	bh=hjKKqCrABc69i95dlZmHpkqI5VCv/djrCGS0VW6tCuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=avUzoNj9vImbuTqmy4l1YRBqF+0nQolUGW10Mf+uEeWB7D1HT70uOWf5VlYrlvn8b
	 c3xDAvcma5d6RBVXxj2uNg94+qR7zU4ckU9cwweAlZrlbixJbl3L8IJGBYDVOqho8Y
	 5QGHnhzMzxFR8WIoyGshnH73MH0VTj+yA0Bd6fm6VwKkazrc/2FOzgTs3pVPJbe6rp
	 rBdLaPsi3hEVRNJy+vZdvH+v93cb+cpMaz9yAyz7dT3wjgdM4q1+bJ/UfyCzRLcwMP
	 ivoFxbmrPHcTX60CkR0PqfdZT0+r7rh8IWu6dUpXkC/OL0wP8a1tkAR+Th5T5uoAio
	 yB4Uxhof1R9ag==
Message-ID: <sashiko-outbox-237738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/12] KVM: s390: Fix *_test_and_clear_softdirty()
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261127150411.221072-10-imbrenda@linux.ibm.com>
References: <20261127150411.221072-1-imbrenda@linux.ibm.com>
 <20261127150411.221072-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:30:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] KVM: s390: __pte_test_and_clear_softdirty() clears pgste.zero
  on invalid PTEs
--

commit d9b61cfa531bfdb9496d9935489a88705ec5abb5
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix *_test_and_clear_softdirty() functions

This commit updates __pte_test_and_clear_softdirty() and
_crste_test_and_clear_softdirty() to process non-present soft-dirty
entries, check the invalid bit alongside the protected bit when skipping
clean entries, and avoid setting the protected bit on invalid entries.

> diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
> index 5a40f411bcc15..ad2d815cf9c47 100644
> --- a/arch/s390/kvm/gmap/gmap.c
> +++ b/arch/s390/kvm/gmap/gmap.c
> @@ -585,7 +585,7 @@ static union pgste __pte_test_and_clear_softdirty(uni=
on pte *ptep, union pgste p
>  {
>  	union pte pte =3D READ_ONCE(*ptep);
> =20
> -	if (!pte.s.pr || (pte.h.p && !pte.s.sd))
> +	if ((pte.h.p || pte.h.i) && !pte.s.sd)
>  		return pgste;
> =20
>  	/*
> @@ -593,7 +593,8 @@ static union pgste __pte_test_and_clear_softdirty(uni=
on pte *ptep, union pgste p
>  	 * running, do not reset the protection, leave it marked as dirty.
>  	 */
>  	if (!pgste.prefix_notif || gmap_mkold_prefix(gmap, gfn, gfn + 1)) {
> -		pte.h.p =3D 1;
> +		if (!pte.h.i)
> +			pte.h.p =3D 1;
>  		pte.s.sd =3D 0;
>  		pgste =3D gmap_ptep_xchg(gmap, ptep, pte, pgste, gfn);
>  	}

[Severity: High]
Does calling gmap_ptep_xchg() on an invalid or non-present PTE
(pte.h.i =3D=3D 1) clear pgste.zero?

arch/s390/kvm/gmap/gmap.h:_gmap_ptep_xchg() {
	...
	pgste.zero =3D 0;
	return __dat_ptep_xchg(ptep, pgste, newpte, gfn, gmap->asce, uses_skeys(gm=
ap));
}

When a dirty log sync clears pte.s.sd on an invalid PTE that was
discarded via ESSA (pgste.zero =3D=3D 1), zeroing pgste.zero while pte.h.i
remains 1 causes subsequent ESSA operations to report the page content
state as preserved (2) instead of logically zero (3), leading to guest
memory corruption if the guest relies on ESSA state to detect discarded
volatile pages.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127150411.2210=
72-1-imbrenda@linux.ibm.com?part=3D9
