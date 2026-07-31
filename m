Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2D30C60F;
	Fri, 31 Jul 2026 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505942; cv=none; b=gZTeT4xGwQqCsc/WWC4ZyijdFPBVLeB5jLrVAw/EdjBhvBo4iI7i9qlYSObVegk8Gke060DIYQNHk0DCsu/zNP+4z7oE0w4UncumoyrIS0wo4RwO/nLVhrNTANUHS1nkElL/yecZPqkL0pv5zIvsOTc7n7HQzEX/mxXSjOzYZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505942; c=relaxed/simple;
	bh=qveyOU6DRfiSe3PUoc/XtI4oV4tMhMv8CZKMWvqePG0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O1BH65u383DuCEcYIc3tmHOjRBvXgL+j4SJIt7ziDwjWZRwKngIYjVfVxQVGuAmXc1jesdx2DQE3epBECmNOoh4a5BOHRP+Glo9E6UiktoyoAJcXXvs4615Cx3z8yFyGmLTLC60RkxxmapmIO/4ceLPmz4gMQJ5upDRtDmmmtn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1woJgRM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1woJgRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19B81F000E9;
	Fri, 31 Jul 2026 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505941;
	bh=BTaFMK/HKXlDkNGl2ow1AEFVgmRP+DMU9Mp+AzAC+j4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I1woJgRMUiXAEgJhLHnsZCU1CwUJE9dnwIjbJFzq9SuyQZPQ1ULmEhmbkyDOP2FzA
	 XbRgsfv6w/onQtqg4enmgGe4LT+oAWccu0RCXhNKpcuuwsOxuDLUqzMFX7k6iNo7do
	 B+iFUtAP/NlT+04BE/Rr5W0umvBGpwnVE0oiqoqVjivW96nWvdugHb7e0O+fschzkN
	 3Di78DrQLydZJBlC6+BDMw6m3nu+PoHOrpoz7zNR9IPGxgZTq41NQSfyKoK60+4iPM
	 F/9JAzUfwHfO3iHixQE48OH1iPEuF3t5brZyQZtyAWtpA9QXqlMRlopD/lqDo9VkRF
	 VrIh8G2zxx2RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 22/31] KVM: s390: Use arm64 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731130902.654679-23-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-23-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:52:20 +0000
Message-Id: <20260731135220.B19B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The generated `#undef __INCL_GEN_ARM_FILE` is placed inside the `#i=
fndef __INCL_GEN_ARM_FILE` block, making it dead code.
- [Low] The awk script fails to detect unbalanced/duplicate end markers.
--

--- Patch [22]: [PATCH v5 22/31] KVM: s390: Use arm64 code ---
commit ae7db48a91d4b61d3d1ccc6f0b0c6c7d8f856a81
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Use arm64 code

This commit adds infrastructure to extract marked sections of ARM64 KVM code
into generated .inc files for sharing with s390. It introduces an awk script
and Makefile rules to detect start and end markers and extract the code at
build time.

> diff --git a/arch/s390/kvm/arm64/copy-arm64c.awk b/arch/s390/kvm/arm64/co=
py-arm64c.awk
> new file mode 100644
> index 0000000000000..6c4fd1f080982
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/copy-arm64c.awk

[ ... ]

> +	print " * This file was automatically generated from " filename
> +	print " * Do not modify this file directly."
> +	print " */"
> +	print ""
> +	print "#ifndef __INCL_GEN_ARM_FILE"
> +	print "#error included .inc file w/o proper guard definition"
> +	print "#undef __INCL_GEN_ARM_FILE"

[Severity: Low]
This isn't a bug, but is this generated undef reachable?

Since it is emitted inside the #ifndef __INCL_GEN_ARM_FILE block, if the
macro is not defined, the compiler will halt at the #error. If the macro
is defined, the preprocessor will skip this entire block.

Should this undef be removed, since the commit message states that the
consumer must undef it themselves?

> +	print "#endif /* __INCL_GEN_ARM_FILE */"
> +	print ""
> +
> +	file_header_done =3D 1
> +}
> +
> +$0 ~ start_pattern {
> +	if (copying) { exit 1 }
> +	copying =3D found_marker =3D 1
> +	next
> +}
> +
> +$0 ~ end_pattern {
> +	copying =3D 0

[Severity: Low]
Does this correctly handle an unbalanced end marker?

While the start_pattern rule catches nested start markers by checking
if copying is already set, this end_pattern rule just resets the state.

If a source file has an extra end marker without a preceding start marker,
wouldn't this silently process it instead of failing as the Makefile's
"unbalanced" error message suggests?

Could we add a check like if (!copying) { exit 1 } here to properly
catch extraneous end markers?

> +	next
> +}
> +
> +copying {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D22
