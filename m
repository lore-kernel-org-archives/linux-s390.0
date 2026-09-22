Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3353839A3
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060087; cv=none; b=Qj8sr1gEh+nFXS5GyaOyEVkk7gwBLDXhXkmcQWGJg9ZNfqwg7i4oZuql5AlZDLp1t2bo3Fi1RvcV24b2l1TEfQxht+BVBqKJRgNyo1GGYtXLbHT28dO3v62OYlMRWN7BayU31EkONZOzo76bHeNSCd+BxQJE3xIXGHTo4fam6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060087; c=relaxed/simple;
	bh=TPg2dlNpl+5LaSRxdLS80lSMHbjvLZbv+a5KzbGhehA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iuHmkLiaY743IxeqXaq2TnyMR5OCN1qdndJUfdShGhQfMFpusF744w96RLofFlYSpV0I/steNP6kfkOqzP49OWqyZCWA7B016xLAXZ4yU/aByKhCU5G5MdpqpZJNFgC8YqIAwN0jHhZWvnlTUqa3nu9uETRtLD5qGJ/cdOubR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqtfpvL8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqtfpvL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBCC1F000FF;
	Tue, 22 Sep 2026 06:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790060080;
	bh=TPg2dlNpl+5LaSRxdLS80lSMHbjvLZbv+a5KzbGhehA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZqtfpvL8/GIkNQ5vP7Im8Mm5k7MD6tAWJe+oS9I8/6hU6yc301lWTnN5Zpz6J4AjI
	 uR/7dvyn4WPH3yqKz3sWoEyep+zDFvd59psHVECxnv513kcO6YASGEKzL6+ril7yyF
	 OTwbL1uTGjz1I05/cneEe4Sotd/fNP4zTLhO3O+MEPhfLOAE5lhzGLxPtqc+wIqRRB
	 HyiSrEOkNsHAtLUd+FTt0mKmWkCccZqbFiM9N4H/9HSLRF9cRI4opCNkgfcpqleWE2
	 YMq3FFOxMmyGV6Sc+vr7rIhHULSqTRF7lnzUitrdGNpH/+3mcdaR8zhdfs36HbpDEE
	 vOJO1SGWFr8ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] s390/sclp_ocf: Fix computation of length of GDS
 values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260922064303.524293-5-egorenar@linux.ibm.com>
References: <20260922064303.524293-1-egorenar@linux.ibm.com>
 <20260922064303.524293-5-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 06:54:40 +0000
Message-Id: <20260922065440.8BBCC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Fix length calculation for HMC-network and CPC names in OCF event data
> by excluding the GDS subvector header size. This prevents a potential
> invalid read access beyond the available GDS name data.
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922064303.5242=
93-1-egorenar@linux.ibm.com?part=3D4

