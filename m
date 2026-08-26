Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E4379C33;
	Wed, 26 Aug 2026 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757850; cv=none; b=OG6D6DTwvV23Phv1M8aq8UCsvami3izJHXR7y90G5Ph/8xymetj76O8GDGWZxrQUHjjnqLAQmku6DOs3PlbwB1PpHg242GhB4gG2MvomW9QaJ2TkzesZglRuMz5HyGTMmJAbhzG8OiNMU+6MdX5DbE42at69ExIjU7fUeB37Cuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757850; c=relaxed/simple;
	bh=RomDJLjJcvd/b+56inOAOKMSpYKpJxMlbf0v0i012zc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CaC0ZHfz83g4kV85DZ2y0ECUo5oMbsMmv4D4s1ZRdOdHkVu1Ky9AanfhVIyrcG7T3mneYrlgLCsRrKIoq6pQL4dvg/DAZncfhxk/aYIvlX104sLDM1rgij30a1tTUa+1JYWyYzahNWqq8CSRzT9hWCJDsvWiynhLejyjGoMwEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb9sd9C5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb9sd9C5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C311F000E9;
	Wed, 26 Aug 2026 15:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757849;
	bh=Cwn2jJatWTlihT5RbYB5CWFolbSaGQKLE1CxqrVcywU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eb9sd9C5iwmCounfb8HIDeiP0DRc2WOFPTMRqDeFA68v9cvh523Aa4pGvXvh0teIV
	 qvpcy7VmkeU0OPK+f+yL1uwONRV8n50ybWKlX9oBOFADc0mIyA9Pby/sNGy3Zxh5gW
	 ecJGTElRdTNMH+s5VIGIosXIOf2rBxNRTTvYSZbdZDiRkCGWb5xyMBUhh8MxAIYSWo
	 znTnp8zGkJSdLQUdcQK3Eji4BKi/OnzVMef5cUngYYh7/cXyCB/5fhH+E/9y3mxP1F
	 cT/ceG9htA1dSoAp3CLbsJ8iVt+DntF6mQGlDqbfTBgwhdNf1s9MpO4JmsHSXAM/8I
	 DcUjSqjWMfUFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/21] KVM: s390: vsie: Add VSIE max shadow
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-18-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-18-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:24:08 +0000
Message-Id: <20260826152408.C0C311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded memory leak of XArray nodes in `addr_to_page` due to mis=
sing `xa_erase` when reusing a `vsie_page`.
--

commit aeb8317597460836fd64fcf59420cb809c866f05
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add VSIE max shadow configuration

Introduce two new module parameters allowing to keep more shadow
structures

[ ... ]

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 6e42b00206bd9..fe94587511b03 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c

[ ... ]

> @@ -1962,7 +1973,8 @@ static struct vsie_page *get_vsie_page(struct kvm_v=
cpu *vcpu, unsigned long addr
>  		put_vsie_page(vsie_page);
>  	}
> =20
> -	max_vsie_page =3D atomic_read(&kvm->online_vcpus);
> +	max_vsie_page =3D min_t(unsigned int, max_t(unsigned int, atomic_read(&=
kvm->online_vcpus),
> +			      vsie_shadow_scb_max), KVM_S390_MAX_VSIE_VCPUS);
> =20
>  	/* allocate new vsie_page - we will likely need it */
>  	if (kvm->arch.vsie.page_count < max_vsie_page) {

[Severity: High]
This is a pre-existing issue, but does reusing a vsie_page here lead to an
unbounded memory leak of XArray nodes in addr_to_page?

When the vsie_page pool reaches max_vsie_page, get_vsie_page() recycles an
existing vsie_page:

arch/s390/kvm/s390/vsie.c:get_vsie_page() {
    ...
	} else {
		/* reuse an existing entry that belongs to nobody */
		while (true) {
			pages_idx =3D kvm->arch.vsie.next;
			kvm->arch.vsie.next++;
			kvm->arch.vsie.next %=3D kvm->arch.vsie.page_count;
			vsie_page =3D kvm->arch.vsie.pages[pages_idx];
			if (try_get_vsie_page(vsie_page))
				break;
		}

		unpin_scb(kvm, vsie_page);
		kvm->stat.vsie_shadow_scb_reuse++;
	}

	rc =3D init_vsie_page(vcpu, vsie_page, addr);
	if (!rc)
		xa_store(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT, vsie_=
page,
			 GFP_KERNEL_ACCOUNT);
    ...
}

Should xa_erase() be called for the old index (vsie_page->scb_gpa >>
SCB_ALIGNMENT_SHIFT) before the vsie_page is repurposed?

If a nested guest repeatedly executes the SIE instruction with continuously
varying scb_addr values, the new address is stored in the XArray via
xa_store(), but the old index appears to never be removed.

Since XArray internally allocates memory for nodes as new indices are
inserted, can a malicious guest intentionally trigger unbounded allocation
of XArray nodes, leading to host or cgroup OOM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D18
