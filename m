Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8249845198D;
	Wed, 29 Jul 2026 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350030; cv=none; b=cV9JBUdM5B21Xq68pt7jOkAMUCktih4w/UQFN8J/c/YMvmb68dCyVWzagKSm0q3K3LCzLMId71Y70cx1qwpdPxgnJorRwTmyxf+tL8wADeYBc/hWGC0DxFroEm1rEmIRcYsn+ChFGQDZA+c7SFxRoipYWzh+yKpEW1+PlfdRUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350030; c=relaxed/simple;
	bh=cImXgBa0m50NJW8pNAJuDnpaG6AFhLXGnurQK5GEe6s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YZk2WXetxP0PGDRbcU/o/igk8plxJmFwbwfzm6d4M8Wb+VQ0m+60S+bC5WjXEGYST5BhligRpDLpv2BFPbvM8MysTXODoBmjxlvzAMWktijFNgGbtbnEEt83/g1/FFmY78H2v+ujzykSHsxtIKnAwLYQwDIFS2bvezVGLSd5s+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4XpVUns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4XpVUns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4BE1F000E9;
	Wed, 29 Jul 2026 18:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785350025;
	bh=cImXgBa0m50NJW8pNAJuDnpaG6AFhLXGnurQK5GEe6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K4XpVUnswVuPchPIat0IBPXXZlv82KaZDPQJsCWzxaJsZRYal1sMiwOnfeYrmWeCq
	 phcZr9c5mmDpbEt2uC8dy8MFc1+K2v4i6n5Ghvgk33IawqxUkMQcmsDZJEcJ4vg0lt
	 bL7O3bDeBwbSrJL+DOuOwBNabmcI8FAZ8Gl6EKqKh+R2yY57Jz7i2/O4C10uGK5qxM
	 4s1f1jC+eWgq0cJofjKgV5E5XVtEVNXw1l6y8OTj2W0roVjQxl3Q2uSXo0IZV6X5cO
	 JIa6Evw1fjrtf8FD8HPA6qqA+FYtzRtsTvgViUZLRqtvRaK07uMm+CA9fESXIlTM3h
	 lyaxoiNjsHXIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/13] KVM: s390: Fix ordering when adding to SCA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260729152938.782383-12-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
 <20260729152938.782383-12-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 18:33:44 +0000
Message-Id: <20260729183345.1D4BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When adding a new vCPU to the SCA area, the validity bit in the MCN was
> set before the pointer to the state description, potentially allowing
> for a race.
>=20
> Fix by setting the pointer before setting the bit.
>=20
> Fixes: 14542a0a54c5 ("KVM: S390: Remove sca_lock")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729152938.7823=
83-1-imbrenda@linux.ibm.com?part=3D11

