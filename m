Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33885470456
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932399; cv=none; b=Ivk38pg3ZejrgIQkfQgSwev4DOPuMh+AnNP+ItOIUSAdmijkXjC5qwsTxHBK19me0ytGtMU8/QnbMPh4EMxFtFJOSx55x0Sk5326O2dfxjGVBE/snRZD8yr6WRDHvzqaw2tZIYt9YlbIPJ91fL3Vz+9zOwYEJzrSd21Zt/8K3qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932399; c=relaxed/simple;
	bh=gT3MVzes3eaBPjMEmXiTcoFVhf+xvFUnJoM9DWDbDyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YZCvaz4Rf/T0lN68w1h+Jno+9mOiifJbhPRro+rn/r31zSXxxt3w3trzich6RJNu0PWRwhL1abwWK5Xbn+f/m4icA5g51tzA6sf2u8tk8RufrZA6rEP/Y44Bvli17WUDhLiQFzRMra7kb1ZR3b1nA1wpBIYQRgvoIwuoazvB5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vj7LDRFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vj7LDRFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F7C1F00899;
	Fri,  2 Oct 2026 09:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932398;
	bh=gT3MVzes3eaBPjMEmXiTcoFVhf+xvFUnJoM9DWDbDyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vj7LDRFjCryXZs7URDfVD4Kjuk6D+2XlWyDuNcY5jFla+Pt6H6UInM/OpNiU/1kKU
	 NS4QEi0M090mbe0r2dVxUKizSKIM+eCUKaNsiEvvg/PueM6Qra0G17t59wNFxYmpdw
	 W7z4yglfFooQXqCm6j1jYZGOvKWkujrP4+Rlp5OieSAN0GS47ocwCF/U4mro/3T30E
	 ZGPNFLEizYe1ylG6WA4dGVJ5Y4W/SJDkjnIZSVnIt/53FpzhH0ExdhAQqEAEgR0yKO
	 LY5s/hFRQAC0l4lRP2rjUWZoBgtw1OiJdKrPZ7ckaXK1npOB35GQHRICgzcZiymilF
	 ztsN/bIyLFxmQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 01/13] lib/sbm: Introduce helpers for
 architectures to configure LLC properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20261001192849.74788-2-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-2-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:17 +0000
Message-Id: <20261002091317.C5F7C1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Subsequent commits will add arch/ hooks to configure the sparsebitmask
> (sbm) topology - number of sbm instance and the maximum CPUs that a
> single instance can represent.
>=20
> Introduce sbm_set_topology() that helps architectures configure the sbm
> topology. Also add arch_sbm_cpu_instance_id() which will be used to map
> CPUs to the sbm instances during init to keep CPUs on the same instance
> on the same sbm leaf.
>=20
> Individual arch/ users will be added one at a time in the subsequent
> commits.
>=20
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001192849.7478=
8-1-kprateek.nayak@amd.com?part=3D1

