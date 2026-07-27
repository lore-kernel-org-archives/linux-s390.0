Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862283B47F3;
	Mon, 27 Jul 2026 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166989; cv=none; b=cXkzbv2NlcN9041LtSz6Q5bGABt/AR049Z01Yvzx7Geyb4uxaWWljh8dfu7WCgf1duLavW0qjqXA+3fKEVWGSGj1ttgaW2yvZCNDI/GoEE2iknanvJRSH4tkiQoGqzrOnN5PkUbBmVjdT+HD0zXSV3YFrzoMEIvKG2yINqYYCLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166989; c=relaxed/simple;
	bh=FxMkcw7DbaUP9l2w74V6Ht8g4rI7dYUlu1dpekfey/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cb/viq8KTagv4b0kgfOT6czMsNyiWieUk2fiQ47Ih9S8eN6IeqRoeK9wuObvOvdJdttjLJ2FvCCl4tUdAWuWFS504Siw/Rd09VeRfMH0RnalbL3V/uLVvlqgkk8uB+3k/41rLX8l7sskelqx631wwKVJlcHk7vyXeiDv4BEr1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmYnSdj/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmYnSdj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35761F000E9;
	Mon, 27 Jul 2026 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166988;
	bh=FxMkcw7DbaUP9l2w74V6Ht8g4rI7dYUlu1dpekfey/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BmYnSdj/eqdF3OrJ2oZRuz2mWfatzljbTciho8vp1m4Z6No+c8K+dZIY5tzOsmtK+
	 yrdaDso+HV3LQ7P2C23NhDGm8nUbzr8i2tseyIGaXWAsPIrxTjwugpxFB5/8+ZiZX5
	 oWIRn59Lxux3qpfF8GSqAKgUHuGUWN5dOWcBVwf48jxicfCw3rXmtgnGZjCqrraLSA
	 LW8AaSI2Sq8uOFWxge4FUywhuYb2FKeQRrbfPhm9oYYGgNFesMtasX+oI6QemnFu1a
	 wv6tbeJYDaDyxGpRdOdBsiO0zZbBlp8wZf7nsuIQ0I9vUnvXBWTJothdY7eG3C/WWL
	 mg++mKAkLS+Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/10] KVM: s390: Fix race in __do_essa()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727150254.236021-4-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 15:43:07 +0000
Message-Id: <20260727154307.B35761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> An unlikely race between __do_essa() and kvm_s390_vm_start_migration(),
> kvm_s390_vm_stop_migration(), or dat_get_cmma() was possible.
>=20
> Fix by locking kvm->slots_lock. Since this is not a hot path, the
> overhead of an additional mutex is negligible.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727150254.2360=
21-1-imbrenda@linux.ibm.com?part=3D3

