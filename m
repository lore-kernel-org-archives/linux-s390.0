Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D886448B83;
	Wed, 26 Aug 2026 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757302; cv=none; b=P/Nz1Ot6mYUiY0+l1ewbCHk4DeAdKFrUuK8li19idB6JmvCNWejrvZqijdS9kTRMvvnepYT6zC/dsFE3dv3MfNjuir1ssJ+BnvdFIQdMaYOeoA39655KAGM6Ae+AioWLQ51XIkIyzIhZwyuxPSAJZemHEQWlkSoqnhc9opASuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757302; c=relaxed/simple;
	bh=hWseFmZx9E9Th2F0Smtl5btM1TW8txWweTO4GJ4iaPg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JZiNlYDbWzknWAX+hGYz+SWYvRieULMYHu2ItjVFz+FO1zfQG5GTT1UXiVPg0wSG+bkRkmLVZyNCDmVh7bP+3Rfaf3Uf7MAhHeV8UWaL0//l+g6y3H/naru0n6bvTUJb9XvqmjS634r8abx92BY47MTja6fIgEPaZUu42WlhTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRyD6koi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRyD6koi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F0D1F000E9;
	Wed, 26 Aug 2026 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757298;
	bh=OgiyrSY9j37CGi62bYXVpHDdKTwp12u32tM16JM0AjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iRyD6koiHAgz6qdgw/P25++KQHk9/HAmk2qQqclkikVP5anZib+ykzXB6TwFJZvd+
	 /O8QaKUCqc/QXV6sJzw1MmaNiBXYnqrthOCd5RSlDfyCcXxgKTpT3MdDTei8C/nk2g
	 B2z/VXx8B8RjxPqJM1Niz6pC6YmzUJGoZQXXvOLc+nw7PqxQKfJ9iuavRDa5gnNZVr
	 qb6tJ85bBAIfEg+P/w1aunFmNZxG/Y1a//XvbALjpHo4yx6c+u+MxSNdFsoLYtBsRd
	 IiSFapXi3XB2H8HT8QnMdSCyaJXF4MBADQADz49JdtzlPUqckXCuhS+KPAA77CK8Bd
	 9id4F9S9vIO7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/21] KVM: s390: vsie: Add helper
 unshadow_intercept()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260826-vsie-sigpi-v5-12-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-12-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:14:57 +0000
Message-Id: <20260826151458.52F0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] unshadow_intercept() writes uninitialized or stale shadow SCB fiel=
ds (gbea and icptstatus) back to the guest's original SCB on early validity=
 intercepts, causing guest state corruption.
--

commit 065588b108c97fdd6441ebcc560b6bd343203830
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add helper unshadow_intercept()

This commit extracts the unshadow_intercept() helper from unshadow_scb().
The new helper only copies intercept information and avoids clobbering the
timer and guest-state fields, to be used when the rest of the scb is not yet
shadowed.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 5c4f13777178b..988370f491bf5 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
> @@ -565,18 +565,27 @@ static void prepare_ibc(struct kvm_vcpu *vcpu, stru=
ct vsie_page *vsie_page)
>  	}
>  }
> =20
> -/* unshadow the scb, copying parameters back to the real scb */
> -static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_p=
age)
> +/*
> + * Only write the interception fields back; avoid clobbering the timer a=
nd
> + * guest-state fields in scb_o.
> + */
> +static inline void unshadow_intercept(struct kvm_s390_sie_block *scb_o,
> +				      struct kvm_s390_sie_block *scb_s)
>  {
> -	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
> -	struct kvm_s390_sie_block *scb_o =3D vsie_page->scb_o;
> -
> -	/* interception */
>  	scb_o->icptcode =3D scb_s->icptcode;
>  	scb_o->icptstatus =3D scb_s->icptstatus;
>  	scb_o->ipa =3D scb_s->ipa;
>  	scb_o->ipb =3D scb_s->ipb;
>  	scb_o->gbea =3D scb_s->gbea;
> +}

[ ... ]

> @@ -755,10 +764,13 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct=
 vsie_page *vsie_page)
> =20
>  	prepare_ibc(vcpu, vsie_page);
>  	rc =3D shadow_crycb(vcpu, vsie_page);
> -out:
>  	if (rc)
>  		unshadow_scb(vcpu, vsie_page);
>  	return rc;
> +
> +out_validity:
> +	unshadow_intercept(vsie_page->scb_o, &vsie_page->scb_s);

[Severity: High]
This is a pre-existing issue, but does calling unshadow_intercept() here
corrupt the L1 guest state by writing uninitialized or stale shadow SCB fie=
lds
back to the guest's original SCB?

When shadow_scb() fails early in prepare_cpuflags() (e.g., due to an L1 gue=
st
setting an invalid CPU flag), it jumps to out_validity and calls
unshadow_intercept().

However, because gbea and icptstatus are not copied from scb_o to scb_s unt=
il
much later in shadow_scb(), unshadow_intercept() will write the stale values
from scb_s back into the guest's scb_o, explicitly clobbering the L1 guest's
changes.

An L1 guest could potentially trigger this trivially by forcing an early va=
lidity
intercept.

> +	return rc;
>  }
> =20
>  /* unpin the scb provided by guest 2, marking it as dirty */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D12
