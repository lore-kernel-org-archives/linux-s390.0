Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B2D226CFE
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149744; cv=none; b=iUYMvKvpXGEdqxtTwMqDkYnTHDx1luXpbQT3YWXp2/3YVJ+niHIWj0EXVSwV5UOd670cCyqvTCCY+GJ0s1GKWOZLKSGb8j3wDQv5kQUIFuZ6bIyc9TMvySNt2JrlsJ2176t0KpuOyTJfMU4etH2ih0I0fraGKY2CFfbXhh4LwLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149744; c=relaxed/simple;
	bh=ymyLar3bMsdVzFCCWkYXZFqnASyxsgqlBWI/3BFyly8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IPxAasI64ow7O+TCSFkmYhRdqBtDos2wo/c6FyR0N6OHXI7J9G80nUev7v5b9w1Pneb+C4Pje7uRBOpvvfVgjq1rL8E6vUx13yGcu0/wqJDG99vkcQy4Dom4UEb6d9wfMNSFYiaBxdcfbZK6HG17/CD6l85YO+lWohpdZwgTCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh8BbAzq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh8BbAzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF7B1F000FF;
	Wed, 23 Sep 2026 07:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790149743;
	bh=ymyLar3bMsdVzFCCWkYXZFqnASyxsgqlBWI/3BFyly8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uh8BbAzqnYBpnHA+/biMdYv5dBoBo6ufi0w/7gIeeuExAxdk+bLifNm9WCMwQ0vi1
	 VxgLFx4YlXfXcS3Vc8Uxjx1heYm34etcRhU8RNzKAkkvUs+zKtYcJGrWZApPypmI3f
	 OvMPVBDdCl+L12xqWZCkWywoX4/z37iXWLriw/T5Lo6rGcTLyD17kwDY6UxIwN0MRu
	 3IYXZN3Nho7+91GuvQVtRP82GXtWvXkMp49SPbLX2w3dBsSKdDynq+zMHsgm+hfETz
	 PC6WB8GLBWdlBXCBezpPqEwDcCKOPwT6Vktw8d1PfRMhzph+3LUVNQPTs4nUiqWaS6
	 YXIEH8wmXrfaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/5] s390/sclp_ocf: Fix computation of length of GDS
 values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260923074006.3962077-5-egorenar@linux.ibm.com>
References: <20260923074006.3962077-1-egorenar@linux.ibm.com>
 <20260923074006.3962077-5-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:49:02 +0000
Message-Id: <20260923074902.CEF7B1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923074006.3962=
077-1-egorenar@linux.ibm.com?part=3D4

