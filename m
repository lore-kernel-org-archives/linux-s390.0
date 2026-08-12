Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2C359A68;
	Wed, 12 Aug 2026 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554165; cv=none; b=e+V7ZDj98TkBMrgsL2wtRq7l3YItCPFBlHvKBu1tG5AugJVabOCuRpGEDXaqr9QqYW0GVhPPS6braSNURokl/lyFlqR/ThGkoLPI88dgK3cW/WNWP6AwxQsmY/FTs2vwEActHLq7U+gzg9Ij79VgGVIUFVs7x7nC1tp4rvFW0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554165; c=relaxed/simple;
	bh=6VOJNswuY6WkTHqE/hhD52A3XG+51+b8E1UzxLQGgm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lEMdRkrkh6ZEqVMzYpi5bMDDFzoXv4OPbXYlSxzGeK5ai6/9uUrBV5+DHYu+rG3RNpe/JxOeFbHddFmPNeheAgv4DeQwnURxa9jUL8CElae61J3Bpx1k/E+rRZoiBjLfp/ByBACzCW04WTpQ4u189dvqROZjnQuK1bDrs1pwh3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCFw9RdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCFw9RdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8088E1F000E9;
	Wed, 12 Aug 2026 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786554163;
	bh=HoNx70rDm0mHuzbLOF5mfgWsRSVNWaTC1Uw0GbmVGkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZCFw9RdEDGwqOr2iPY5uWJ0GgI9OWzpXl+5QsgmxVe+6W5O4kkazK7Uint2hRoxJI
	 BPG1NZGYNA0IVHsDNR2oqnLXuGV6nszf9ebACEp9sfbpMX+lXG5KRy/SQwlG1HtYQz
	 rrYBPL4dxH8MKz/1L63TsDMPq9rmlyUv4Z2DuxjuT9H8d7Uh8OnS+nCT7cvmuYKxgS
	 ELbdk77HhUwJdhRksJ2P/6dOdvWx1AEK6dHWNoyEkOMhyCLp0dvjJL0NFAmvhJvNgk
	 wrqum0KO1nkccosz2s+HGyxQzbR7MA+JKSkkxwlXVKvx8hx8J/A6xN1zlryb2QteJm
	 oYYYoV+nnd0tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/20] KVM: s390: vsie: Add VSIE shadow stat counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260812-vsie-sigpi-v4-18-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-18-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:02:43 +0000
Message-Id: <20260812170243.8088E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `vsie_shadow_scb` statistic undercounts allocated shadow SCB=
 pages if their initialization fails, and incorrectly categorizes subsequen=
t uses as reuses.
--

--- Patch [18]: [PATCH v4 18/20] KVM: s390: vsie: Add VSIE shadow stat coun=
ters ---
commit 30e90ae4cab73ef72cfd191918cda52ff46f4c0c
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add VSIE shadow stat counters

This commit adds new statistics counters to track the allocation and reuse =
of
VSIE shadow SCBs and SCAs.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 5f6dd4b9e9fd7..a1b679b4aa361 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c

[ ... ]

> @@ -2042,6 +2047,7 @@ static struct vsie_page *get_vsie_page_cpu_nr(struc=
t kvm_vcpu *vcpu, struct vsie
>  		}
>  	}
>  	if (vsie_page !=3D vsie_page_new) {
> +		vsie_page_is_new =3D false;
>  		if (vsie_page_new)
>  			free_vsie_page(vsie_page_new);
> =20
> @@ -2059,6 +2065,11 @@ static struct vsie_page *get_vsie_page_cpu_nr(stru=
ct kvm_vcpu *vcpu, struct vsie
>  			put_vsie_page(vsie_page);
>  			return ERR_PTR(rc);
>  		}
> +
> +		if (vsie_page_is_new)
> +			vcpu->kvm->stat.vsie_shadow_scb++;
> +		else
> +			vcpu->kvm->stat.vsie_shadow_scb_reuse++;
>  	}
> =20
>  	return vsie_page;

[Severity: Medium]
Will this lead to an undercount of vsie_shadow_scb allocations if
vsie_page_init() fails?

If vsie_page_init() fails in get_vsie_page_cpu_nr(), it returns ERR_PTR(rc)
and skips the stat increment here.

However, the newly allocated page is already saved in vsie_sca->pages[cpu_n=
r]
earlier in the function. The next time this page is fetched from the array,
vsie_page_is_new will evaluate to false, causing vsie_shadow_scb_reuse to be
incremented instead of counting the initial allocation.

Should the vsie_shadow_scb counter be incremented earlier upon successful
allocation, or should the page be removed from vsie_sca->pages[cpu_nr] on
error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D18
