Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180163CBE74;
	Fri, 31 Jul 2026 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506598; cv=none; b=MrXVD4PR5XLUbPrEZK5xIgqZqJHnaV9HSK/vqsXfvGBWL5tWLdDX9Bzx1j2L3NhcH1MJj3ZMktuuF8aiPrdSeZmxxLaynKnG9X4UymdIWttMjVU0qBMfyTMWAVpqoJwL3MXKjetT1xDINtCtwAnmHUn4A+99AlMJ0JusGa2LcMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506598; c=relaxed/simple;
	bh=iqKjLgRYmHlwOuW8hGqVVAUFHnQB9NhKq/73ycVrtEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tgCwvkrxWrhp0WnWrmOoXPv7UPG7Wieomr5/YoUo1OgctUTkd90ipKnNedHpsBf8BM5aODR7VTfv8VFOnTvwgSztg/HOjFrgkBFrI8AqA4DYT7oB9NSdIrqZBMIJZOrZSFtuWjBL/XRY88sna1hr2OWM9BvviA39m1mBPFrAT7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCNJdUxB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCNJdUxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE181F000E9;
	Fri, 31 Jul 2026 14:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785506596;
	bh=5tBJbHUh0PB6WKMLwn1Pi8CG+8Eps2pBZe3JHdQjbXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LCNJdUxBqGE/1CkOfytrAWPGcj/uPDdTFdLhDxkb9ORf+wEVc3RU0tzehVt7RjXtU
	 Fk2xjgwpAR63/hZFPgdTC12YTHoeR4TaI41TQYk8m6zlNS9FwxZDbmRAYKh+R+WDgP
	 G9i9oY6dkHig0lkkQD1DD9s1kSK2VSzPtAQjBSQgVCYVFFEgRLdPRx2pKaBCIiH4v2
	 Fss8DHNFJGooJSBsxrYuUiVfMzoDa+Nt+fhGV8RY2b5t14nkLQCZK5RshaGywrQQmk
	 lARYVEgado67ZxMJucC9BG4egzcAaVPCaaq1DHR4FdBlVpoE+cicdMtBTujWqtGDpL
	 2oNLImyJ8/jZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 23/31] s390: Introduce Start Arm Execution
 instruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, linux-s390@vger.kernel.org
In-Reply-To: <20260731130902.654679-24-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-24-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 14:03:15 +0000
Message-Id: <20260731140316.1CE181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The Start Arm Execution (SAE) instruction is the centerpiece for
> executing arm64 (KVM) guests on s390. Its purpose is, similar to SIE, to
> enable accelerated execution of arm64 virtual machines. SAE expects the
> physical address of a control block as the only argument.
>=20
> The host is responsible to save & restore
>  - GPRs 0-13
>  - access register 0-15
>  - breaking event register (BEAR)
>  - vector/floating point registers
> between SAE executions to guarantee host consistency.
>=20
> GPRs and BEAR are save and restores in the asm functions. The other
> register are handled in within C code. Access registers are handled in a
> later patch and SVEs will be handled when they are introduced in a
> future series. Most arm64 registers are handled by a satellite block
> called save_area. Some registers, frequently used by hypervisors, are
> placed into the SAE control block itself.
>=20
> Enlighten asm/kvm_host_types.h for the new header variant. The new
> header is chosen instead of asm/kvm_host_s390_types.h if KVM_S390_ARM64
> is defined.
>=20
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D23

