Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834233AD526;
	Fri,  7 Aug 2026 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096840; cv=none; b=NxgC/5IIwN1DmFA8JuxQnGXc2SRFhH5RvyyoWUomM/ohmfDKOXdWIXpg9lNXRyla2o6e3OSIoCKrpClz4I0rrfbgjFqOY/1tlRr4oSXcI5FbVj4kyCrC7HnC4OB06DSFZ007o6wZqO2yDYCOSGw1rcbYVXsfrR5F2PcqfATpF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096840; c=relaxed/simple;
	bh=EX63Izh987EltuRecj/dS25EgymDuPQ3YmpzZFcRI7o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FHc12C3hQVaQnynBhoahZVfnb/12E9U5/g4eHBHjFeJbvX3CxN2CkzXBqXX7hnkuawv7eczl5wcaRyHNiELHOaiH+Uzsj3Bk6JY4b3RRgCD8EfMNnakImHFTNteDoNwyPdE+b4GLLrkVFnqHmOdIESg/Tj0l/LDhJuXfiGZq4zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXMHFQ2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXMHFQ2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8111F000E9;
	Fri,  7 Aug 2026 10:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786096839;
	bh=EX63Izh987EltuRecj/dS25EgymDuPQ3YmpzZFcRI7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LXMHFQ2dy2th9vLfVUeLXwWtu0gu1oimFrVPv4azicIHDlExSOlAbsBbdQYyKdgmR
	 6TQf3TChQmSq9ntVGaVPVYQojIWezPIlF4cdJAAxXsz7mgmqVoT1KtjuVlkHy6Ysp0
	 mIvOORgv0nHmXyQrhS/jQ27xj4l1XXLDP7fMM55oQ9s8X4EUjMWXxto5T1RJUPRH7R
	 cMZ+Y3SDWrVjCWCBaVX7ykTpqDXagr3ufswhAVxt6zu0x803nNGq9IqkUqsriNxFY7
	 fjIqK7GZL7A2bpvuJEXA3Avim73OqUK83rvL/UAuGGjf374UQEu2iPHKXlB2OXs7ef
	 WUSjqA7MHLAZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] KVM: s390: vsie: Assert crycb alignment in
 vsie_page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-5-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
 <20260807-vsie-cleanup-202607-v1-5-b18659b55e3d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 10:00:38 +0000
Message-Id: <20260807100038.CC8111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The crypto control block address is required to have double word
> alignment.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-vsie-clean=
up-202607-v1-0-b18659b55e3d@linux.ibm.com?part=3D5

