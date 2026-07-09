Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E9637C906;
	Thu,  9 Jul 2026 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610797; cv=none; b=bqKGhzRM4tyQnYa0RtnIv4qBteHKisV6/uwz+OE7Xc6xPyyndkY4xyZK/gyKRChbCTm2f7DPWmPcVF9sa4iK4QJS4Ys6ADUYFrfZu3CGPOJ6Ch+y76cguYYLSS6dv2cQRFPuZ6mDvna8kt0izq0rNNGP9mq6yMOrtFvC0lQ/T74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610797; c=relaxed/simple;
	bh=Zk/5gehJNTtNOZcW1+Cp2mfXbgoDt8oKRMNBfT0xcWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t6dvOrWIaGdB05Uk67LeyXo4osc3VGNpmtCZ5bzXBB6CuSfNcOO0skcGf0wVXv/euqVbteHYht913A+BZ4FE8DckhRV8NpKtE799q/0GN5OBLhcplRPjjDWK5CIUa+Pevjp6l070Vdis0Gmjwv8uAgGuoJcsKw0z2JSqipf/WHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIXW+F9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIXW+F9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0761F00A3E;
	Thu,  9 Jul 2026 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783610794;
	bh=ZMQo3dQxijluTAK+Yp6GRzDyBvIL6p4wN6lzJgbEU/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lIXW+F9qLfAaTBRs37Zl6iq7laiLZVKa18k1A3bS9qXSIH+NuyN8naOM+smZLaJ2c
	 vveD3qcPCY5unvvMc+90EPd6GmUYnsEjfInjCehCKoU5HuRp4cc/PW6JxnLp2UUZY5
	 vySw43/32wvXv+IZElas3zBfvKB+ry9QTYxGLk1UgBCwSOTguVYLDyaJnbMg6nk+hd
	 8u9TzwUc3uNfIyOtOeMpC9TVVT5IYwY9a8gzw9+6LH8Z0o0C7l0zwsVhn0A8QektAE
	 aPvmMNOv+xzfTwl1Aygk/utRj/sKQL7KY9ZFpLfgJKJlMZmyMVqiG1ik6EmUXihBmV
	 W6jTN08BXpRog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/21] KVM: s390: vsie: Move SCAO validation into a
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260709-vsie-sigpi-v1-5-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-5-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:26:33 +0000
Message-Id: <20260709152634.5A0761F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The validity intercept for an invalid SCAO is written to the origi=
nal guest SCB (`scb_o`) instead of the shadow SCB (`scb_s`), causing it to =
be silently overwritten and lost during unshadowing.
--

--- Patch [5]: [PATCH 05/21] KVM: s390: vsie: Move SCAO validation into a f=
unction ---
commit 617161c9be47e700da98b253966f2dd2c1dfcaeb
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Move SCAO validation into a function

This commit moves the System Control Area Origin (SCAO) validation logic
into a new standalone function to improve readability and allow reuse. It
also adds logic to validate both BSCA and ESCA origin addresses.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c

[ ... ]

> @@ -788,20 +812,14 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct=
 vsie_page *vsie_page)
> =20
>  	gpa =3D read_scao(vcpu->kvm, scb_o);
>  	if (gpa) {
> -		if (gpa < 2 * PAGE_SIZE)
> -			rc =3D set_validity_icpt(scb_s, 0x0038U);
> -		else if ((gpa & ~0x1fffUL) =3D=3D kvm_s390_get_prefix(vcpu))
> -			rc =3D set_validity_icpt(scb_s, 0x0011U);
> -		else if ((gpa & PAGE_MASK) !=3D
> -			 ((gpa + offsetof(struct bsca_block, cpu[0]) - 1) & PAGE_MASK))
> -			rc =3D set_validity_icpt(scb_s, 0x003bU);
> -		if (!rc) {
> -			rc =3D pin_guest_page(vcpu->kvm, gpa, &hpa);
> -			if (rc)
> -				rc =3D set_validity_icpt(scb_s, 0x0034U);
> -		}
> +		rc =3D validate_scao(vcpu, scb_o, gpa);

[Severity: High]
Does this mistakenly set the validity intercept on the original SCB (scb_o)
instead of the shadow SCB (scb_s)?

The previous code correctly called set_validity_icpt(scb_s, ...) to write
intercepts to the shadow SCB. By passing scb_o to validate_scao(), the
validity intercept is now written to the original SCB.

When unshadowing occurs later in unshadow_scb(), the uninitialized intercept
data from the shadow SCB will overwrite the original SCB, completely erasing
the validity intercept:

unshadow_scb() {
    ...
    scb_o->icptcode =3D scb_s->icptcode;
    scb_o->icptstatus =3D scb_s->icptstatus;
    scb_o->ipa =3D scb_s->ipa;
    scb_o->ipb =3D scb_s->ipb;
    ...
}

Should validate_scao() be modified to ensure the validity intercept is=20
correctly written to the shadow SCB?

>  		if (rc)
>  			goto unpin;
> +		rc =3D pin_guest_page(vcpu->kvm, gpa, &hpa);
> +		if (rc) {
> +			rc =3D set_validity_icpt(scb_s, 0x0034U);
> +			goto unpin;
> +		}
>  		vsie_page->sca_gpa =3D gpa;
>  		write_scao(scb_s, hpa);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D5
