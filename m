Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87C2302163;
	Mon, 28 Sep 2026 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599696; cv=none; b=ZeS32pZrGBJeL8ZAs5MNQBeu7FoxZGwv5GsNWd/4BhB+5CIwcHeJ7Q6jF5VqKQE+oQJ8tQ1+clwZTbRWUUVm0477QQJ2XZNnG7PeBGnh94WY6LiXnm//7/D1Zp6chVy3K9RfeFs4hm1UAlvk1cYsjTKgUg6wVd2WtGTSufzGU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599696; c=relaxed/simple;
	bh=9sLw+SAyI1vjoG6NKu06z0dP7M+J+d5pSygE/Gc98k0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NA5ZBqjx5gm3pSgpuj+Ew/IJ6/J9VXEQbL0FHV7JK154mTq0nHBW+liMo+2VxSUj2OFy3WV2BCKQ2NYh4+89q0V+lfONFSKrb4BberTTyUoHEdXb1OVaps4Fp5EOMR64yBTLc1VunUS2VLQO4SQWpz8z0ctd4NZNm3YFH8TDAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKSep4XY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKSep4XY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D54D1F000FF;
	Mon, 28 Sep 2026 12:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790599694;
	bh=9sLw+SAyI1vjoG6NKu06z0dP7M+J+d5pSygE/Gc98k0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OKSep4XYxXBq2GASF2JCUFOs5LToo7z+uwNlu/eJCSvDSWF0cew7yQ41m9cmCOO0n
	 7jH2PLPgBW8q/umOXJbPBrTV4R2gMqFyNaTYW8ZVJ8px6Mmt4ZjbDP3cd+8tQDrCk0
	 bUfMBs1WIZfZNupF36XQiCKwsRQtN9sPfoUNVwW8rpkr1UAXasgeSVAPe7fkaNymdK
	 Db3qL8K8KeETGtIS5ZJDihWq/+3HU+RRkk27iYiJIAm4GPIioIfEKYQ1FoD9Xiq+Vc
	 BmIH0hKeOkswrGD5iXM8t/VgBHrV5r/BrGB7cRtRTGGFjVWgHNaJJVF6oesTtoB6qS
	 lYkaQJ3jp1/fA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] KVM: s390: Kick PV cpus at the right time for
 service irqs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janosch Frank" <frankja@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260928123639.34226-3-frankja@linux.ibm.com>
References: <20260928123639.34226-1-frankja@linux.ibm.com>
 <20260928123639.34226-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 12:48:13 +0000
Message-Id: <20260928124814.3D54D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Service call handling is a two stage process for PV vms. First we
> receive the secure instruction intercept and then the secure
> instruction notification intercept.
>=20
> The secure instruction intercept (104) is analogous to the non-pv
> instruction intercept (4) with the difference that we're not allowed
> to inject an IRQ when re-entering SIE. We have to wait for the
> notification intercept (108) which tells us that we're allowed to
> inject.
>=20
> Unfortunately we never considered this difference and hence the IRQ
> injection code will try to kick on the secure instruction intercept
> where service IRQs are masked.
>=20
> It's time to move the kick to the instruction notification and skip
> kicking on the instruction interception path.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928123639.3422=
6-1-frankja@linux.ibm.com?part=3D2

