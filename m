Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9253B47D0
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932408; cv=none; b=Oxys/HCc/aEBHYDMKs7j5RNTQQj28NbW/vCGyK1ucDsxLWcpfq53rK3u03RamCm1kTfE/mSHedW9xrAivbMTKwjaehqXa3ThFqM7tqKmxLoJNpa0Pf2vCb1aZH19xW0AW0oZ6ZYumie45QFW7iEIXrWAHqOTGUOvC4MTdo5HECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932408; c=relaxed/simple;
	bh=XkqUVhs+UtWsWV3d6i5GRbncWoPMrSFWXXaJ6+fYfVA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AsxEkrFqANstXbMXp+wk+SqQnGa6Xr8xWeTYZOmJH8+LPCL0UmESkeyiu1uxv8jNJ8aaT+CJQthsgmaWsQgq1AAv2UZMp2o0Ce4XrmfNB3sFpWWc1lqDsHuSPn3jq0/8gUT98q8ZpF6N1BIkmi1VQSsEuZKL72jDxvGbcrzRrmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2QRkaPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2QRkaPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2141F000FF;
	Fri,  2 Oct 2026 09:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932407;
	bh=0m2OzXlXcb11jcoPfEqN1jT1RNmghEbUbOKrXLKjmiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q2QRkaPzQ+r8fJwCiImfdsBlU8p6V1BFNoeuh7QDWcQC9XE9axmMyP8TCKPReUwAp
	 ZKgRp8NFg6hucnsmfrr4sCMyJ5jpF2scfVuX/W70Bp+zTsNrvsfHZ+8Uokj2zs3/gN
	 mQqMUESunlfxGtcLMhA4612kMsRg26MI1kg9dth1MbzDZSRH3I+IYVvmcnfd7lmJMK
	 73kf5YZBoQIvsmK7J1Up3K/bsZe5NH4N/i+jGndnRaxkj+p9btw4FUL0QfshXxc/4s
	 1mhtycMsf35+YLy1PSQahK9nRsF26+gev0EJX7rRb3lLlZODv43EXoTF8/K2pPVD9W
	 fRfIvM84Hl7Mg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 09/13] x86/cpu/topology: Initialize sbm topology
 after topology parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261001192849.74788-10-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-10-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:26 +0000
Message-Id: <20261002091327.2A2141F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/topology: UB and incorrect topology IDs due to out-of-bounds s=
ubtract in dom_shifts
--

commit c4055a2c9b6199a420263b5bc2ed2a987d466f5a
Author: Peter Zijlstra <peterz@infradead.org>

x86/cpu/topology: Initialize sbm topology after topology parsing

This commit initializes the sparsebitmap (sbm) topology on x86 after parsing
the CPU topology. It uses the maximum APICID and topology domain shifts to
determine the maximum number of threads per LLC instance and the maximum
number of instances.

> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topolog=
y.c
> index 4913b64ec592d..150e098f0ef8f 100644
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c

[ ... ]

> @@ -449,13 +450,45 @@ static __init bool restrict_to_up(void)
>  	return apic_is_disabled;
>  }
> =20
> +int arch_sbm_cpu_instance_id(int cpu)
> +{
> +	u32 sbm_shift =3D x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN] - 1;

[Severity: High]
Does this code compute the wrong shift value by subtracting 1 from the
shift amount instead of the domain index?

If x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN] happens to be 0 (such as on
CPUs without SMT or cores), this evaluates to 0xFFFFFFFF since sbm_shift is
an unsigned 32-bit integer. This would lead to undefined behavior when
evaluating apicid >> sbm_shift later in the function.

Even if the shift value is non-zero, this subtracts 1 from the bit shift=20
value itself, which calculates the wrong shift, inappropriately halving the=
=20
max threads per instance and generating incorrect SBM instance IDs.

Should this instead be x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN - 1]?

Please note that this bug appears to remain unfixed at the end of the patch
series in commit 0b0c43c6e4d9b31b812d8407b146c5dc13783dc8.

> +	u32 apicid =3D cpuid_to_apicid[cpu];
> +
> +	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD ||
> +	    boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_HYGON)
> +		sbm_shift =3D x86_topo_system.dom_shifts[TOPO_TILE_DOMAIN] - 1;

[Severity: High]
Is the subtract from the value rather than the index also an issue here
for AMD and Hygon systems?

> +
> +	return (apicid >> sbm_shift);
> +}
> +
> +static __init void init_sbm_topology(u32 max_apicid)
> +{
> +	u32 sbm_shift =3D x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN] - 1;

[Severity: High]
Could this also lead to undefined behavior or incorrect shift calculations
during early boot initialization, for the same reasons as above?

> +	int num_sbm_instances, max_threads_per_instance;
> +
> +	/*
> +	 * On Intel systems, memory controllers are present at TOPO_DIE_DOMAIN.
> +	 * On newer AMD and Hygon systems, LLC is at TOPO_TILE_DOMAIN so use
> +	 * that instead.
> +	 */
> +	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD ||
> +	    boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_HYGON)
> +		sbm_shift =3D x86_topo_system.dom_shifts[TOPO_TILE_DOMAIN] - 1;

[Severity: High]
Does this code also have the same issue with subtracting 1 from the array
value instead of the array index during boot initialization?

> +
> +	num_sbm_instances =3D 1 + (max_apicid >> sbm_shift);
> +	max_threads_per_instance =3D (1 << sbm_shift);
> +
> +	sbm_set_topology(num_sbm_instances, max_threads_per_instance);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001192849.7478=
8-1-kprateek.nayak@amd.com?part=3D9
