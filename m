Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741937;
	b=KlqTxEq3gsXZS8LqN1Ok8alOx3qnzoP7WLemxXmg7YqKBiMRYEM5tQRcXkQdP0ejAJzp
	 FQ4CiCE/RalBboO5fETRBCgXa9A2BzfKynS04Rh/DcHTJe22RAHxSnz5jj0bwB8eTNvbe
	 ZcJcGIOsthUO6cgqAeC6pE5oVGvvUPFJqbfa+whl2SNNV+1IoJOG2Dc+h+QUkyx/+x5FX
	 +pGACoACvL7DsiIdQ97OL6zTjnm7qiyBNvTdTC9vdtToK2+EbfC2ufFicLPh3n5lEyri/
	 vnH6t+rV2OPR+10nhbYCfZiTGVmKaMjxDAQqbUcAfVD3atcRpQpVwwJagwlS/5+OQ4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741937;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IxeJs+PlG6y6WMgJAfXUAaFziE/spmhLsHfGAYOnmUs=;
	b=TsH3dU+PjwLlOw1GNlpRr6qH+j8kg/8C7RfRCPXcZG3bUE5NX0isr1v8GRpPl/IUIicd
	 uiM8svRG4yI9ICjt7S4kLviXJyt1bgpX+fuAJhf0xJNm0F5G0O0i1G8j6mF9DjpUj2SJV
	 zUHscdcGQQAyg2fzZZt6EQEQF/xyxA+9kXgMjWcgwv48yWVlgIhJtWIQdOxch9aSLbGeG
	 i8Si/qfjGG1dOwQOnWOxxVE0fAibTKwW/p93o8JrTl3Ar/6DGlXldGNPOEfa+RFYzxGLY
	 aoIshXLaZgGGy8ysg3K2Wm5JzkXO5SUy5LW1myI59ZVR28fIb2W25G9neLbwkOfADVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ov26F6Ki;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB21D60A2604
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ov26F6Ki
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603611F01825;
	Fri, 23 Oct 2026 07:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792741936;
	bh=IxeJs+PlG6y6WMgJAfXUAaFziE/spmhLsHfGAYOnmUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ov26F6KiGG+LncVyr+Qs4WU4RBMNnolRzJTYjm2v2wSr8oAO3pGRgTvJjLlODWH2a
	 it78kbNCKpAQanqhgQCGjsQEH2t1XEAPzMq9SdpgKbij+9YzJ52Bk2S3sFSCOxzHd1
	 qtTFkwzJt8zWO2/YoM9z/6MqRz+q5Ii7tABPitZPbwyOLIwbVVJPQSEH4gnPC4hn2R
	 dgYdK4hN+K3C0dAy6N0AcA9fve0NsjxAlPOXnegXcr8L40ezzOkTJHZukmeyPaFPJv
	 BnLUpDQVIra9vagEg4ttq2Ug/ivFUQ+JmrMd2GML0eIJNh8HwLOQvbQZAUShdUaDeQ
	 1RzBVReZ+AcGw==
Message-ID: <sashiko-outbox-182462@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/13] treewide: Stop defining __ASSEMBLY__ for
 assembler files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Huth" <thuth@redhat.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023064908.66707-14-thuth@redhat.com>
References: <20261023064908.66707-1-thuth@redhat.com>
 <20261023064908.66707-14-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:52:15 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> All spots have been changed to __ASSEMBLER__ (i.e. the macro that
> gets defined by the compiler), so we don't have to manually define
> __ASSEMBLY__ anymore.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023064908.6670=
7-1-thuth@redhat.com?part=3D13

