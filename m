Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F33FC5C3;
	Fri, 31 Jul 2026 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504418; cv=none; b=fo5KPwlxw3KxUv/SRIaUs0sZPe/km+OKBkL+Iw/sQV13vwr+QG3YAayee202q8lBgEpcEr0pk1WW7akDurbso6jl+DhqXq3+bKuH/R+b6wFOYFujGQJkRCtyN3CCrTg9u/AyAgYZ3a6zQzgJ8g/l7parhrzOVDKX3uwF6F2jtI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504418; c=relaxed/simple;
	bh=NVvne0+trw7XQIiAGjdh69BfonWhMQVg22FqFSzanPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RTDz+lhfFesS/gQoGB83WlA67pSlp3+l7/52D8oqYMchRq1Db2MKho6Ls/h1C7xASWBCyXtK/BkCLK3ZaTO1nvrATGFnq+vKj8jrlqQEBqxhT+Z0kMD+DLugBRnZREyJJ3lpzvACZr9Ld9dZDAgSfsEu71l8lz9O76OPPhpHLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw8F2pwn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw8F2pwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2644D1F000E9;
	Fri, 31 Jul 2026 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504416;
	bh=NVvne0+trw7XQIiAGjdh69BfonWhMQVg22FqFSzanPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nw8F2pwn+0FJDvz0gdpFPqKaPiGMN/m/IrWKK8gPEwoTj3vD0xXl3eigvYGyiTvwK
	 97XfUu+vwh+oeCZpcUvMnVNBoUfEnESZsjXxrxQZkLiomRVDXSj14nRwVVUeKBMONe
	 MGVlGDTqZLXouHX+govki6u50aPpAc5wiHjs3ILTR824aggybNDOOEVpnX6xQ/FDUj
	 a6NhWOViE24ngQzvr8IYBDKKY6IfemymTGNucGAMah/08dQGFFQek/z8Tn5hh1YYii
	 GQ7eWI9F9bHhDlD/PrLVqEwdmtEwyoz1dC4/QQdbU5XtyTACCdPOyjdjoDSsb4q1+I
	 fODiUp4fmdE1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/31] KVM: arm64: Access elements of vcpu_gp_regs
 individually
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731130902.654679-8-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-8-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:26:55 +0000
Message-Id: <20260731132656.2644D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> While for arm64 the members of vcpu_gp_regs are allocated continuous
> this is not necessarily true for other architectures implementing ARM.
>=20
> Let vcpu_gp_regs() no longer return the address of the user_pt_regs in
> the vcpu context but the address of the gp-register array field in the
> user_pt_reg struct. Note, this change semantically excludes pc from the
> GPRs.
>=20
> No functional change.
>=20
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D7

