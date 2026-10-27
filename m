Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140934;
	b=eHCWQmeb1JiR7ylXYoYXT3ynLwx5rCaGNQaaAytF7R5PMjT+7uxH8FomEMXir2oUcFDf
	 iWO8MCP5I68ixcW1K9yEGljG/VC3sCmEJkip4nAOy8tJoeWY5vHCAX2uT/dZCp4OD79Pf
	 SRxDJDutw3aDP0kGuZoi59Nx0/AfSDOUWxyxUORqqsYUc6C+tHqaQeHzOPx2/ggWEkIYY
	 9ZFxV36UY9tgOvsI37+B/Xfq4cQqVcGBRsbCDWs+H3NyK4iF28OX/YoRYiNxPdyohm++o
	 H3kq/nCh54aLZyTe4Sl5wckwcqSLYmC7eWWGuvoxAXHwkqVtS0tj82IaV0ekbNKl7HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140934;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HRL1HC3jykJwvLS7MTw3sJ/1NCVkPhmbeugKbJOpNTQ=;
	b=AEjCTt9GlUv7uvyhAU/7QcHeSMP28SPyDmZDgLoP61iiHbbm81OYEHjJivR46qQRZPIP
	 /Wy5g/tAyxfqYKIKN97OkDXqLXn00FZjb8V9b1IPUBxB0MUsxJTN6YcFUWNqWYgAkeqOy
	 ooH2hzznY6tAzZDGUGhKX48fRnAy0MdUCIusqxco6HyW8Plqmt5KxvvOHQ7ukSYibp4lK
	 vY/6CGS2svIHxbPsH51rHt9Alc34/+jOLxtZO3yjKfxBELd/uLlolirqxvQvTvxA5njW1
	 uggdxKpKBe4dNu2v6yWr+E3ZvJ0rF3eSndX6L0joyDFSoZ+G9MhWPhpib3TWL660xDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKAU88IB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A48606A31E
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKAU88IB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4C81F01828;
	Tue, 27 Oct 2026 22:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793140933;
	bh=HRL1HC3jykJwvLS7MTw3sJ/1NCVkPhmbeugKbJOpNTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IKAU88IBeGQbWYEDGx6944435p6x/YVK0RXPFdL0jEv7dMgeY2Qf4wV1YGt/JAhwe
	 a54rbaln9aQ/WBR/RgGfA/SaZSFuSEsFjag47fFqQLRlKRP9aO/ML0sRTo1KG4Bn05
	 5wQKaLpY0o0MXa/jfPKJH2+V/op1+gdnxVydA2yHOXhPd2uZHRTqpGNwpe4T/oTGAl
	 gQwmcQiv0/bjIx/WmR3jhPcMlWlSmcDstz5/wLJHAtYs24QplPNF0X/1zmminwwE/J
	 wZP3UgaOiqlKKIpUSqp6CDSrPruSLnL1uhjUEV/76+fSlfln7ZNZQsxx4/qaoX7bou
	 uHgl7yZiL8hYw==
Message-ID: <sashiko-outbox-187171@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] ubifs: sysfs: Use kset_create_and_add() for
 ubifs_kset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027223847.652884-8-irogers@google.com>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 22:42:12 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> ubifs_kset was a static struct kset using a custom ubifs_ktype that
> had no default_groups and no .release callback. With
> CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, unloading the ubifs module while delayed
> kobject release is pending causes a use-after-free on the static kset.
>=20
> Replace the static ubifs_kset and empty ubifs_ktype with a dynamically
> allocated kset via kset_create_and_add().
>=20
> Fixes: 203a55f04f66 ("ubifs: Fix memory leak in ubifs_sysfs_init()")
> Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027223847.6528=
84-1-irogers@google.com?part=3D7

