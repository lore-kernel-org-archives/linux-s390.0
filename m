Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265013C1F36;
	Fri, 31 Jul 2026 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505436; cv=none; b=fGYBxl3kKe6ykMm9u9oXEM5xS7eqhVMGFFXG3MBVXXqhLc0QUd7yHlzC3GNvi79fTmHB2vvarDor+BM0jfAWDi681xISdOlCbkVqvM2lYWSwXRcqI/LgPsNP/SEJAqbqyd/tkuMG5AxwUrqsJgqvLhcrNtrxzo8WoMVsv67ONEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505436; c=relaxed/simple;
	bh=rrhIFQBT/sUfkDYyXTCSI9HMG3ouCZkhRXOXAepgVjE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T39sEC/EyUOW8Yi9lKsNjVtO+VOrdzMtBlB4bS2ZwMYrG2U1w2QzjUD1KczdwmYx/ZDddeC8FmWJTeF9/NHrQtk/3Z16HAxdE+apz/BgUVD4QkpBhH7koMl6OIfZ164x3gKaE6F4bP70iNdFVYjpidNC+8UDukniMPIysL0C8GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gub8wNAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gub8wNAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520811F000E9;
	Fri, 31 Jul 2026 13:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505434;
	bh=rrhIFQBT/sUfkDYyXTCSI9HMG3ouCZkhRXOXAepgVjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gub8wNASgegUleXWxeZ/p2CDcQFEM0CiFHh1YdxFCIHVYBaI2U57CSfbfAacNu2oR
	 MFtbcweaL0Tkba8hNKrpgUZl7apxg9zxI6vG+b39Mnyq0OCTF6WyAWQRr5zI4Oaire
	 BE5QonIczFIFLFprTWjErrT833HwLTdzlvz+rvT06j5JgJPK48NzMHBg0CN2pntPWv
	 gGNpiIH3EtXikFIxHwID9S3C0WD5jF/93kcgor7JPit0BUGvbLOGLN9rMdat2hO9XN
	 t2wfzx/5iE+jVFRI5BbPDJ0+w34DiCmg137nqffEGwLNySc7Uz2Fokof6HHuzXdN7i
	 Pn8jrWrc9EMeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/31] KVM: arm64: Share arm64 code with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, linux-s390@vger.kernel.org
In-Reply-To: <20260731130902.654679-13-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-13-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:43:53 +0000
Message-Id: <20260731134354.520811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Mark functions that s390 can use to implement arm on s390 as shared
> functions.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D12

