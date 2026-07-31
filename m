Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE547175D53;
	Fri, 31 Jul 2026 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505412; cv=none; b=Tmq/QRIc1Etx7pN9FUyEJ+OCCQ5pTy3L+gDh00EGyzhtCm91abvt8PFwmHnG70mLIV4JuBgL+ueh4hjfYBFcUmVKBRE0FhlG+9XIThi/5B68ZIU6vIQQ+U6dw3pi6Y4qUHyO3nvlmS0n0qlqbYRnSlch11gnFsSJlgeZTZRjvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505412; c=relaxed/simple;
	bh=YawuTsiv02GnBP2qFLLdljyGjsSzKX/beby3VebcGfc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tgQTTzVHytV53EQVe3VpNGgqD71i1bMd80MmgNPS56QM1gfl17aBcachQ4+sZVXLKwKZ9P2cF9kJLYMLm+r+QeZ6NSFGo9Zi6HdfmFzWbhtm663C5L0VV4KwAQsm3QBZI9TyN4NAo1pATS7g/YarFPtkFSJqPtmZYhamV+FoU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjZTUlnE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjZTUlnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071BF1F000E9;
	Fri, 31 Jul 2026 13:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505411;
	bh=YawuTsiv02GnBP2qFLLdljyGjsSzKX/beby3VebcGfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JjZTUlnEgswhbjPEAbxpqaxkQ0Ki8d50QvLQwT7ruP0BPqdPY1MvytWPnU7C63zcA
	 N/QWmIeClaD7OmfwzLdo5dVSqujVAORKcrhQZZIcuQCLdbOCe811dr6bwzjQYY1bYf
	 QMmeSkL6t4QFZIikbnFqTeBbXq2sOi5Rm/v3o24XAyGnKmBpFNpnXqnFJQHOzWhYGP
	 SxPzWiPu6wUCKMUC5pL6XK7rPuRyH/Ee20h50LTTAY6hMj9z54cewlItyeToklbzQo
	 knUFuI0auKz7JIfZxmjNfbESC3XXJY+iTNv1awuGDCabcWoJMpxP11Vv7W7KOO7yw+
	 yItxGXCqPEEPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/31] KVM: s390: Move s390 kvm code into a
 subdirectory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260731130902.654679-15-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-15-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:43:30 +0000
Message-Id: <20260731134331.071BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move all the code required to run s390 KVM guests on s390 to a s390
> subdirectory. Move gmap related code into a gmap directory to later
> share gmap code between KVM implementations.
>=20
> Update S390 VFIO-PCI MAINTAINERS filepath.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D14

