Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD83B05AB;
	Fri, 31 Jul 2026 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506226; cv=none; b=UBOuXrw1wTX7dYxgh6rRn7u41oboxcVjExVacYMrxnH6RWy4dcT+gRm+rDbZeha6RrVmcxuD9RYXDNpcMj5r+dFEaAmnO+2/cl92MF4rHNzUKsQHrqWGnqrLtlfgVNf8E/wsAufLP2oFreqNe9PRa8YPvi+odVNZxftn39714vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506226; c=relaxed/simple;
	bh=iN5b+JHM9br1YN/K9/eT8dBLeXcU5uEdJ1g7HFyJOuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n6dPDUYeBBO8qmuK+wKlz1vbV07nYvyjxSYF5JqvBDfQ0d+Sgdn4SzVEOicsY5vQeUSjJevR+ltTBbyaHDhAdWX6h8Lf9l2ldJyARreC8lFFJw6Riwe3M3NruoVIXQziC9dY77sArtCdyHRlsGoUcWQ3W7fZ+n8acuAtiUlp+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgoF1Gs8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgoF1Gs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AE41F000E9;
	Fri, 31 Jul 2026 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785506225;
	bh=iN5b+JHM9br1YN/K9/eT8dBLeXcU5uEdJ1g7HFyJOuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BgoF1Gs8qvD7OXXOkUQ5m+zy/LTw1rhqrJxLNN4cWWiEz5meqlRvSZTfIcN5HDv8y
	 eqeMUZeudttVXzg0v5WZenXZ0nLScQVUgpOly3aDSBEItrxz7ooOTf3ZzQn9KhEXJi
	 fVEflym+6ypBFVt4rSPRrOz4mkWt5W9igVPAmehyju9xsEU2un95vMAmh+ILIC+Egw
	 SKhc1s7k0J+a7kbb004CUWBm3WmmRBFwrMM9c9B4Xq2OFoiOqzwlk0ijjiSL3swJCS
	 FhVyImCWodFO0ev8UT3OIJO2FWlejvYcZchHI7rRD8Bp5GHIS1KENTXVXR/k38bfQj
	 64PodlK2ezYsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 25/31] s390/hwcaps: Report SAE support as hwcap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>
In-Reply-To: <20260731130902.654679-26-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-26-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:57:04 +0000
Message-Id: <20260731135704.C8AE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Hendrik Brueckner <brueckner@linux.ibm.com>
>=20
> Report SAE support as hwcap (and /proc/cpuinfo)
>=20
> Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D25

