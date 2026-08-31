Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257753BBFDA;
	Mon, 31 Aug 2026 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216230; cv=none; b=O8EXjwsmooEQYpcAgdt+eSCqyoQ8Z1tgzf99XEkIyvraqKKa0uY2PIsMutCl3nDmzO0EvNnUr9PzOvdJwOoc5QqM6aDfWohkNELqNWwG/iwfVP0ZNlfxcJwHzJKxpt1yt9bJ8+qhBh8fYTNZ24kuVODhY75UoPONF7fmyCkLZCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216230; c=relaxed/simple;
	bh=Nj798KNLId+PKgcBYI5L5rD2nBsqG81idaXAKLDeLK4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rI5HwR21RXGOIPaXVZGD0MjEu3tEl2sMiL+MfR9U0405HjpUMAqcRH3qFLElCn8Kz8MlLuuhBzFnO+8TZMUT/BpwCsWvKlLg788WrrLwhroXmlZfGWNxbX4D6h5pR4zoEATbYX1TNLShWg0Vd43UeE3lHKfq6PSDIjdtV4QFeJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWIJVwlH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWIJVwlH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C97B1F000E9;
	Mon, 31 Aug 2026 22:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788216228;
	bh=3lp1UoHl7Eenn877+drABP8g5bfhv+EY/CDkjFORSUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MWIJVwlH8cyA80a58objrWYZc54TfbF6TyPiQIhA+ip8KRL2uK5D4fiv8m9ExF18F
	 6eg3hv5uudm+ssnNW1GHLx2sYtv67OpWMmENDDoLtlCkhGCOsfQCD5mk7fGCAnYQox
	 PNTTTTHZ5m4npX7I08XbPNsaTt4JeE/OuUaMVzspGFWbWy/y+EcP+ihN3PeIkqaBu/
	 /lYGfqxjcLbh968rBh9fuXtOGLb8b33E/zGkOMMBz7SG3DTaPYs9CFdvoEaqmCNACM
	 j9URmxwdb8i70GwHwdKkZcEOhATqMzV+SNduzytAKECvOpYaWtcKY9v25mf02xeAK4
	 QsQXJWw6Fllwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/20] s390: Report AEF features to sysfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>
In-Reply-To: <20260831145536.913567-21-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-21-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:43:47 +0000
Message-Id: <20260831224348.3C97B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] aef_init_save_area() unconditionally executes the 'qaaf' hardware =
instruction without checking for hardware support, causing a boot failure o=
r kernel panic on unsupported hosts.
- [Medium] Missing error code assignment when kset_create_and_add() fails, =
resulting in a false success return.

Pre-existing issues:
- [High] The EX_TABLE entry in the qaaf() inline assembly incorrectly prote=
cts the non-faulting lhi instruction instead of the potentially faulting .i=
nsn instruction.
--

commit 90a00cf465554d5bd4e3bc2a83bb5b6d1a27209d
Author: Steffen Eiden <seiden@linux.ibm.com>

s390: Report AEF features to sysfs

Display various information about the Arm execution Facility (AEF) to
userspace. The files are located in /sys/firmware/aef/. Show if the
feature is available and usable for the host, which formats are
available, and how many arm vCPUS per guest are supported by the
machine. Additionally, provide the raw binary output of QAAF fc1 (Query
Model Capabilities) in the file qmc and fc2 (Initial
System-Registers-Save Area) in the file save_area.

> diff --git a/arch/s390/kernel/aef.c b/arch/s390/kernel/aef.c
> index 825e2643a8921..2691f1ac63dca 100644
> --- a/arch/s390/kernel/aef.c
> +++ b/arch/s390/kernel/aef.c
[ ... ]
> @@ -40,6 +40,66 @@ const struct aef_info *aef_info(void)
>  }
>  EXPORT_SYMBOL(aef_info);
> =20
[ ... ]
> +static int __init aef_init_save_area(void)
> +{
> +	int ret;
> +
> +	union qaaf_gr0_gisrsa gr0 =3D {
> +		.fc =3D QAAF_FC_GISRSA,
> +		.saf =3D SAE_SAVE_AREA_FORMAT_0,
> +	};
> +
> +	ret =3D qaaf(gr0.val, (union qaaf_block *)&save_area);

[Severity: High]
Does aef_init_save_area() need to check if info.sae_avail is set before
executing qaaf()?

If aef_query_info() early returns success when the AEF feature is unsupport=
ed,
aef_init_save_area() executes the qaaf instruction unconditionally. This
will cause a boot failure or kernel panic on unsupported hosts.

[Severity: High]
This is a pre-existing issue, but this call unconditionally triggers a kern=
el
panic on older hardware due to an issue with the qaaf() inline assembly.

arch/s390/include/asm/sae.h:qaaf() {
...
	asm volatile(
		"	lgr	0,%[r0]\n"
		"	.insn	rre,0xb9ad0000,%[r1],0\n"
		"0:	lhi	%[exc],0\n"
		"1:\n"
		EX_TABLE(0b, 1b)
...
}

The EX_TABLE entry incorrectly protects the non-faulting lhi instruction (l=
abel
0:) instead of the preceding, potentially faulting .insn instruction. When =
qaaf
faults, the exception table misses it, resulting in an unhandled hardware
exception.

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
[ ... ]
> @@ -95,7 +155,33 @@ static int __init aef_sysfs_init(void)
>  	if (rc)
>  		return rc;
> =20
> +	aef_kobj =3D kobject_create_and_add("aef", firmware_kobj);
> +	if (!aef_kobj)
> +		return -ENOMEM;
> +
> +	rc =3D sysfs_create_file(aef_kobj, aef_sysfs_qval_attr(arm_guest_supp));
> +	if (rc)
> +		goto out_kobj;
> +
> +	aef_query_kset =3D kset_create_and_add("query", NULL, aef_kobj);
> +	if (!aef_query_kset)
> +		goto out_arm_guest_supp;

[Severity: Medium]
Will this error path in aef_sysfs_init() return a false success?

If kset_create_and_add() fails due to memory exhaustion, the local variable
'rc' remains 0 from the successful sysfs_create_file() call above. The init=
call
will report success despite failing to create the sysfs structure.

> +
> +	rc =3D sysfs_create_group(&aef_query_kset->kobj, &aef_query_attr_group);
> +	if (rc)
> +		goto out_kset;
> +
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D20
