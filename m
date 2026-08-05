Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4E4322F6;
	Wed,  5 Aug 2026 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928515; cv=none; b=uAPxXUJvF43EBRdRLysSX9q74B1Hu1JfHEabZDbsi1f1nAhEO8DHc5Wpt6XE8DM3tsUXH4uuYODEJZl6h2Y6+HEIERDDQJELPco0fMAPK09XKr8lePA5wnyyTlz29PLG07rexaTrZyR3oADbqEA06oAxbIk0q5Q4Ij6/6vuQ3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928515; c=relaxed/simple;
	bh=H4t/9kixMBa0z3h5v7DH1H1LxU6xoIa+FBTDDXvH5+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GCaW3zq0+IDeo+uJ9UYpsYQtRM9M2Z2wbjdrkDfgccPl9vnZ1G+jvlziMRcvGB6FLKEqL9jFPB2KAjbE+kZNhIkTxW0zdoi619y8+cpRMDs6SqenF6450lbthpGqt4HLsL7nPfwCHNQVdM6Azw/BOtsswo/L5qd38u1uNcQIVu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE6gyaec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE6gyaec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555B41F000E9;
	Wed,  5 Aug 2026 11:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785928513;
	bh=H4t/9kixMBa0z3h5v7DH1H1LxU6xoIa+FBTDDXvH5+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WE6gyaecEZK6mxpf2aunvSU9nMUWe1uGF/ICfnQZcbwD62xj58yYMRgHmh7r0o5XY
	 vol5Q4LU2QDx+LAkJFz4lLH1oOLXteG6NOc39XKSrbzC+BSnqxmJ+H0gnXcrDxJ804
	 AXidTTqlisi3Y8NkqdHDrNaSPXjIxoot2uk2tnCKEy9PW6q6LwJvp3MdFEL2XNuQRj
	 p0LUWszzpVv2bxYaoDDNkccHcvgTeMFKZOn+FVUnZW7hrv0+90XKbtWys2+JOFw9v6
	 pafMwb+18ZQkFeTUwq3+IwqRqKu+WcPsLSMmOaPHlzM/Y2gzokgnc3FGYWDkSOOx69
	 Er5weHE0dN1wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] KVM: s390: Remove user triggerable WARN_ON
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260805110455.7200-2-borntraeger@linux.ibm.com>
References: <20260805110455.7200-1-borntraeger@linux.ibm.com>
 <20260805110455.7200-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 11:15:12 +0000
Message-Id: <20260805111513.555B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> pin_map_page() fails legitimately whenever the userspace mapping behind
> the adapter route has gone away, e.g. when the VMM unmaps that memory.
> As this can happen without a kernel programming error, remove the
> WARN_ON.
>=20
> Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use map=
ped pages")
> Cc: Douglas Freimuth <freimuth@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805110455.7200=
-1-borntraeger@linux.ibm.com?part=3D1

