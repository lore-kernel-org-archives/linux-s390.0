Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C6385D8B;
	Thu,  9 Jul 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611050; cv=none; b=UYRVjnGK+gIodQ7bznD1RqKeCMpJAdcJBY5AvmZOnkcvDXuyyBiCPu963xzlxrEyYCrvIpti1YT7SRANyXysF/w9vrhnp9LydXcK/PMFH60maSZtIo9UgpEAUsgeZ3FJkIkHHcGJP/TWjeBvZYSXxFE72nGGLKfpHC7aznYZon0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611050; c=relaxed/simple;
	bh=B+8Ylx9liHwg2gc+xRTqxaYjeOkWwakA571ZWjDPcQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XHLmxEPL2cFwblas9Wt8xKK8VzfIbbnJURbcYLSLw4zNgyhitMC45xR4cBHEsgllsoqRPNoxxVAnCojVF5tVCigE/UApBh7nyalpbBK3eJmvQfW3J+KpbjazmPdXYbdBGKSdEW8RaYGzzH2Q0mQeUuGODPwDjLJ3w0n2VLWLOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/E0QMsG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/E0QMsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4925F1F000E9;
	Thu,  9 Jul 2026 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611047;
	bh=PqT4s10dmSYYhmw50Pq2eN/J80XKy84EM2qgLDSdA2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D/E0QMsGb4XPuB6FxP3OXZ8gBfM6rD+k2sK97/YksG9sqHccIUH/SdAFTzkwBxH90
	 xG9V3SJ6AE8Fil7d+k96XIEXt3EkzD3j82I+EcLKfBRIPxXJyE65vHvUEaQIA9a+yT
	 J/N/fK1IAcmbgBrKLSRnfr+B9qDqrv5o/pACy2VwhptJUWzYGlRNQgK9yMCStsnTJL
	 jk9ezlwuA4YN1oczQDsSkU95gmP9pp2MAj6C1FSD5k2vbPOq+xTnfG4/HIo1z7+77J
	 LIIUro4hM7PmvIHSRcG/9ugiFxCDD0VfrgWNkHMNKPskb9Ht42INMrhRfsFtBJRlqJ
	 eAPe4hmGNcZdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/21] KVM: s390: vsie: Add VSIE shadow stat counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-19-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-19-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:30:46 +0000
Message-Id: <20260709153047.4925F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The vsie_shadow_scb stat counter overcounts allocations during r=
aces, and vsie_shadow_scb_reuse incorrectly counts cache hits rather than r=
esource repurposing.
--

--- Patch [19]: [PATCH 19/21] KVM: s390: vsie: Add VSIE shadow stat counter=
s ---
commit b0e742d7460b00786ba09124150753300ba413ad
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add VSIE shadow stat counters

This patch adds new statistics counters to VSIE shadowing to monitor
functionality, specifically tracking the allocations and reuses of SIE
control block and system control area shadows.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index c392f7afe130c..80050376eaab1 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c

[ ... ]

> @@ -2002,6 +2006,7 @@ static struct vsie_page *get_vsie_page_cpu_nr(struc=
t kvm_vcpu *vcpu, struct vsie
>  				vsie_page =3D vsie_page_new;
>  			}
>  		}
> +		vcpu->kvm->stat.vsie_shadow_scb++;

[Severity: Medium]
Does this increment the vsie_shadow_scb counter even when we lose the race
and subsequently free the newly allocated page? It looks like this might
cause the counter to overcount and increment beyond the configured maximum
value when concurrent allocations occur.

>  	}
>  	if (vsie_page !=3D vsie_page_new) {
>  		if (vsie_page_new)
> @@ -2011,6 +2016,7 @@ static struct vsie_page *get_vsie_page_cpu_nr(struc=
t kvm_vcpu *vcpu, struct vsie
>  		if (!try_get_vsie_page(vsie_page))
>  			return ERR_PTR(-EAGAIN);
>  		vsie_page->vsie_sca =3D vsie_sca;
> +		vcpu->kvm->stat.vsie_shadow_scb_reuse++;

[Severity: Medium]
Does this increment vsie_shadow_scb_reuse on every cache hit rather than
just on evictions or repurposing?=20

The guest-2 path appears to only count actual resource repurposing, whereas
counting every cache hit here will cause the metric to increase continuously
during normal execution.

>  	}
>  	if (vsie_page->scb_gpa !=3D scb_gpa || vsie_page->sca_gpa !=3D vsie_sca=
->sca_gpa) {
>  		scoped_guard(mutex, &vcpu->kvm->arch.vsie.mutex) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D19
