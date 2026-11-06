Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984355;
	b=DngjPLs6ZYohW5G3C+sa2tIvbG4Pl7PngbijgYlEVwMgXXC72K4FKJl2CFYKhUxgMCgB
	 jzJ1GiqhHVFbOmS508F1lHlFnKKnwlv11bNgxluq83NP4CVBDCNt7cIoatPD+6VqJqgVO
	 aY71OoWb3i7XMz5trYtudE0bx2tt4uOKGqNqyhnAjXfUz3WQ+2kRs+lVzaq4dEIVUT8yo
	 Xt+PodP3ECrK+jj5fwmxoTOAjyEzsUTbVHfsva3HOA0SsDs/TfGbsvP6g4orkySmCXzld
	 nT2vhfipla1m/x0a7+341rpOf3MfN5JPPWcwGgeJye32UA9+9b3NwLqMoaRnupa5UJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984355;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=24rD7693bVROkRs2XeSiEYSfYU+sFP/vtS1c9KxtWI0=;
	b=WYCa/XCaA4ktFXa9bIHv84R78UrZVL0+JPsHkO8bNl9qgozqs/A+cG8TiPSLGiWsQ6wC
	 UyzV/D0zkOlfDq78yiX2LYg5bLMhLXUEt+/ITjOdb3+rRfcTlj3sEXCfYOToM74BaD5cZ
	 f+eG723NlRpRiLs/lstNBP2VzVBhZKN4CM0pfA8T8a0xjQW2i/oGS+5OaJSpPOvZ/ggy6
	 h7y+PCDD8uOCXixmfK1Jj+B8JAj5bj5TbJHiiHx9OgTDoL0JVcYgb/xdfRjfFpa25RArb
	 2vYZfzLgY7QIVrXIIyOzh1Zwx8i+WXtt0va222vCdR4zG5eF7ZIwLQOuULcXyWo+K+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jIty/Q+b";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305E606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jIty/Q+b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650591F008A2;
	Fri,  6 Nov 2026 16:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984354;
	bh=24rD7693bVROkRs2XeSiEYSfYU+sFP/vtS1c9KxtWI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jIty/Q+bzjjuciBvbqe2AbC76drarYB0eXax/OdhrFQmaogebjNkLK1GMbE6wSAu9
	 TAc98kVc3GQWjyGs44x53/F5rdjjMYLXw4I/sHQc975cquWLsZNI6mT8bJC+TpneLt
	 k6ctBG6iECq5Ce4Qa0W0gGD69CLBcY5HFekJ1Q29jNG083l7yVryhSGrXClrbipcYf
	 7r3fwMF9t/HArYOikNHA6MIQMxQyuXMePK95koyaYo7Ahtc4Dk6519lgNtgJdviBAW
	 s5CE67DpYBW0/GPyxSqEJdbFGSkXu/HNZfMEOm76Rpn6emnVEkJZh3iJUPUw8rAxQ2
	 qn8m4Tax41apQ==
Message-ID: <sashiko-outbox-201880@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 4/6] KVM: s390: arm64: Declare enum vcpu_sysreg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261106164958.431978-5-borntraeger@linux.ibm.com>
References: <20261106164958.431978-1-borntraeger@linux.ibm.com>
 <20261106164958.431978-5-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:59:14 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Andreas Grapentin <gra@linux.ibm.com>
>=20
> Forward-declare enum vcpu_sysreg in kvm_host_arm64.h. This should have
> been included in the first iteration of the header, since we will need
> it to talk about system registers.
>=20
> Since the definition of enum vcpu_sysreg is not shared yet, and not used
> on the s390 side, this should not cause any functional changes.
>=20
> Fixes: e6c329180d1d ("KVM: s390: arm64: Introduce host definitions")
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106164958.4319=
78-5-borntraeger@linux.ibm.com?part=3D1

