Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE98485519;
	Thu, 27 Aug 2026 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846783; cv=none; b=mqaf15pDXYB1z7XQF8edyx0PkDWdMENyIby/yS1LPxwZN5+sqlJ6NueR8r2ejWowVltA+r5hnqdP4Y4dyjHWokRnQr+CvP3o7ahU27xwiBO7HetccLni1HlJOHSqlMFiPHCEMjLbH9oFv5/T/REEvdx3lNBuo8Y6VhJ/hAhVckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846783; c=relaxed/simple;
	bh=dec7Hvz6NYWjvcBUCdfb33umTXWlvDgXpVDZE7/YyMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gtOgjc8C/dSV0MDHVeMGxLnI8HXfXBy/ZxMEuRi1wZ+nUiirs4yqzSKINHUArQwOwQA29IyFraJDYlXhJvAq0OP5+KJi8O8MXeH9ZII6oIies02iscR1wnRxJctW9m6o25x621qNcOTvm2lwluHHKcO2s4QIfVrdG4fJTCEWfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5bnuqU3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5bnuqU3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AFE1F000E9;
	Thu, 27 Aug 2026 16:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846782;
	bh=kpH7ZeL7+zg1RVHCWsWzRbTcSbpaU9eDFu+3tJge294=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e5bnuqU3YRQedLymefxYrD8Zfo3yUjvjgeB6eO2x0iSKWSQu5F4lgEq/IT0bloYsc
	 Oh/kg210xYRYg0vTcS0COTqo5yzM1E+Vx7prhH31PVQavtHOukbqdiT5jAFdgnbOcD
	 LNfvC3w40gBQNO5OKUPrP7dgki0FdXbiysK+MX9iRJHLwhn+mQGpu2ou0BBSDBd1oF
	 irUEL/SbTvskIVeQaXtFA0A4qucbzbiU+X9Cbgh+ajTL2PNEd4z78CzJK0ZploOJHF
	 PQTZZVzwsdj5vPIFLX+5dSfp0gxDtz1AH9vKX1x69TFv8Aiz/4SrMQUoZwhXmXLLWn
	 TLkLpH7/fFhWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/21] KVM: s390: vsie: Lazily keep original scb
 pinned after vsie exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-13-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-13-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:06:21 +0000
Message-Id: <20260827160621.C5AFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The guest physical address (GPA) of the SCB is clobbered before un=
pinning, causing KVM to lose dirty page tracking and corrupt nested guest s=
tate during live migration.
--

commit d9924cf112f75fbd55bca14e9ac133f8ed7fdde0
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Lazily keep original scb pinned after vsie exit

This patch changes the original SIE control block (SCB) to be lazily unpinn=
ed
only on reuse for a different SCB. This bounds the number of pinned SCBs by
the number of vCPUs and reduces memory pressure while extending pin and unp=
in
methods to track status.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index c42e2df4c0abd..cdce4b3b25251 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
[ ... ]
> @@ -774,14 +775,18 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct=
 vsie_page *vsie_page)
>  }
> =20
>  /* unpin the scb provided by guest 2, marking it as dirty */
> -static void unpin_scb(struct kvm *kvm, struct vsie_page *vsie_page,
> -		      gpa_t gpa)
> +static void unpin_scb(struct kvm *kvm, struct vsie_page *vsie_page)
>  {
> -	hpa_t hpa =3D virt_to_phys(vsie_page->scb_o);
> +	hpa_t hpa;
> +
> +	if (!test_bit(VSIE_PAGE_SCB_PINNED, &vsie_page->flags))
> +		return;
> =20
> +	hpa =3D virt_to_phys(vsie_page->scb_o);
>  	if (hpa)
> -		unpin_guest_page(kvm, gpa, hpa);
> +		unpin_guest_page(kvm, vsie_page->scb_gpa, hpa);

[Severity: High]
Does this code rely on scb_gpa to correctly mark the page dirty?

When reusing a vsie_page for a different SCB in get_vsie_page(), scb_gpa is
set to ULONG_MAX before unpin_scb() is called. This causes unpin_guest_page=
()
to fail to find a valid memslot and silently drops the dirty page log. Can
this result in stale nested guest state being migrated during live migratio=
n?

>  	vsie_page->scb_o =3D NULL;
> +	clear_bit(VSIE_PAGE_SCB_PINNED, &vsie_page->flags);
>  }
[ ... ]
> @@ -1575,51 +1608,79 @@ static struct vsie_page *get_vsie_page(struct kvm=
 *kvm, unsigned long addr)
[ ... ]
>  	} else {
>  		/* reuse an existing entry that belongs to nobody */
>  		while (true) {
> -			vsie_page =3D kvm->arch.vsie.pages[kvm->arch.vsie.next];
> +			pages_idx =3D kvm->arch.vsie.next;
> +			kvm->arch.vsie.next++;
> +			kvm->arch.vsie.next %=3D kvm->arch.vsie.page_count;
> +			vsie_page =3D kvm->arch.vsie.pages[pages_idx];
>  			if (try_get_vsie_page(vsie_page))
>  				break;
> -			kvm->arch.vsie.next++;
> -			kvm->arch.vsie.next %=3D nr_vcpus;
>  		}
>  		if (vsie_page->scb_gpa !=3D ULONG_MAX)
>  			xa_erase(&kvm->arch.vsie.addr_to_page,
>  				 vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
>  		/* Mark it as invalid until it resides in the tree. */
>  		vsie_page->scb_gpa =3D ULONG_MAX;
> +
> +		unpin_scb(kvm, vsie_page);

[Severity: High]
Since unpin_scb() now relies on vsie_page->scb_gpa to mark the page dirty,
but we just set scb_gpa to ULONG_MAX immediately above, will the page actua=
lly
be marked dirty correctly?

>  	}
> =20
> -	/* Double use of the same address or allocation failure. */
> -	if (xa_insert(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT=
, vsie_page,
> -		      GFP_KERNEL_ACCOUNT)) {
> -		put_vsie_page(vsie_page);
> -		mutex_unlock(&kvm->arch.vsie.mutex);
> -		return NULL;
> +	rc =3D init_vsie_page(vcpu, vsie_page, addr);
> +	if (!rc) {
> +		rc =3D xa_insert(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_S=
HIFT, vsie_page,
> +			       GFP_KERNEL_ACCOUNT);
> +		if (rc =3D=3D -EBUSY)
> +			rc =3D -EAGAIN;
>  	}
> -	vsie_page->scb_gpa =3D addr;
> +
>  	mutex_unlock(&kvm->arch.vsie.mutex);
> +	if (vsie_page_new)
> +		free_vsie_page(vsie_page_new);
> +	if (rc) {
> +		vsie_page->scb_gpa =3D ULONG_MAX;
> +		put_vsie_page(vsie_page);
> +		return rc;

[Severity: High]
In this error path, the page is left pinned but its GPA is wiped. Doesn't
this mean the next time the page is reused or destroyed, it will suffer from
the same missing dirty page tracking failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D13
