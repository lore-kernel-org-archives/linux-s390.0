Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302864;
	b=fuZB5CIm165Bbrt3mhVYl3O0norsVWCPBXj9mDf3UNj+sDL4njoB9nXXNpH6H5+iuOit
	 EFyojsWl24vGudN9AlUgO1juM0IJQA3GzQ3ykkzJ05q25UuZTEiPEH8H3YomFYe1lmWL3
	 VczoGdmRgbOFajtBifzekjK5+dAhfpkWmVF+DNHEKv2FqB6HmsYXtBFu7H/jsl3PV22uh
	 7LFoXyJ7T+PYBKOv9IhBB3LcoEh38iCa/YlhKpGbEXMX1FAUvkp+ji1YtRmJEHZImRUQH
	 XCcipQTLeBVKBxPVLI4mK4CMTvhnak2/PFbS4qAy3CGcG8yZ94uMw3+B/GItPOiMgqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302864;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=px+3H8h9W/LwNIKKVPDepBU38tIt9AurqCcTVa75l6g=;
	b=W0nz3lBs1TbAPFqmKBZ3Gvy8+cI70xQjQJlkCBgsBs3cFrm/ccNgPYETjGpps9P/e1vp
	 cJHMYeCmY9+wAUZGeXJPm5zKH5D5hlA8JGjDsaqc5C6N3JieUTWZ63rpSod4fsaZtUH/t
	 BSxAtS5tJpBsltmsj9K5Mpkqdx7VuNgKq1CmeCfRBPZiii+hNTWbiv8guVBjk/VnHb6XV
	 bsJWqKMy6kuEeNP3OCbezyTCOGJufSnwB6BjWB2EvRxraSRyw6luuHdiNj2bdRZcsOVms
	 0XEmLPrSG40djOzUZ03rHZPfHJhFI6ADC9aUMZ2ns4C5B5Yme5QJU/Wug9F3XAu9fyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XeMF8UBo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E5606BF05;
	Tue, 10 Nov 2026 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XeMF8UBo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928061F0089F;
	Tue, 10 Nov 2026 09:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302863;
	bh=px+3H8h9W/LwNIKKVPDepBU38tIt9AurqCcTVa75l6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XeMF8UBoMAoJ6+MEB1NaQ5MZqhsJC8eISS0yrZVIcPHGVvJ86fQtvX7m72rGkR1/m
	 f3Z6t7t1Mz+R9vEwYhfpHC3PmrQOHvRJUoseLGShH9XfB9bQipnPpt4ZciOpfrLXeL
	 RdbwooxiwTfICuvTbEC8c+bZNiUAPTuh7BEKd/uu3pyKq5xntL879kpZWmgndeAo8p
	 eAqJleiKUrnD0Hp6yHio6jUkoi+qIOII/F1+mOI/TjNe9VbNWR+rheKilOgqFCm5+o
	 FMVgAX4Hhju/XlPniKHMCXY07bOrRhAXvK6y5T/FZd2tYwVr7UuiK4s7ew355Dy4a5
	 Lxh+LYfr22rGA==
Message-ID: <sashiko-outbox-206755@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 32/41] usb: gadget: gadgetfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-32-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-32-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:27:42 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize gadgetfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. gadgetfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D32

