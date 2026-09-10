Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4903E51E4
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033414; cv=none; b=dohtgbpZmBGS6qJBmggcHOZ6XuBiGIZWUarhwVtt+aGzkZcj1BAB2ZP09MBrThwTILOzF1t532rIoVWtI8xXP/NF153vRz9y6VLrHD3pbw2AQL/CU28/uL0D2mM8oOG81mnlviyuk2A98mTbRKBKKpFpABzSKWZIY6UKJ7jggzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033414; c=relaxed/simple;
	bh=Cln8jbXy8otjv7rA/YE4xqTbkXBg1wZRbd12iNvAcVw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X3tPVBnweMOn/w1X3fFRMBX7ORZUuMwh1GUJlflEqvqqUAaCTU7Qj3Xnd2pFSoSL3DBalz4B34uZ7HGW5apYa3HWY5xMtADhSLqVL4TIXoGdsN2LiWvmscwQ7pJ/Zc7K4gDbYsjPQ1YmB9b88cby5cwpp210To4LJReM2xWmsYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwQfsEFv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwQfsEFv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E541F000FF;
	Thu, 10 Sep 2026 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033408;
	bh=Cln8jbXy8otjv7rA/YE4xqTbkXBg1wZRbd12iNvAcVw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WwQfsEFvbyUQj96BpnhLQ8pOthuUbhnWa3QNLUN3IJ2IItcmAmu77R/VGVCQNBhd+
	 0jF9Yy1PGntZSd8Oz3XQdcfGV8W+YZORYZKSPViBPP9gjV9V/zD2P4BRUkbN1Pm59+
	 KGujHbY5RdAUGeji+Ab24+7sYVsnCl6kKAsLdIwtTNeUNsveFLvfeHLyJK4uX/GKZy
	 OhsaJhp88wlaGeZDXkimJ9ES3W2FSV2rEMBbmiNsLi6AF1eUxoChBLR9scFmFb4Ldb
	 QPTsTXw2oUCf55flbUw40OX5U7pZrP/4uI3Jp0AHqDb5kb4hoY+LXAkwRbelj+Oaa6
	 noyR6BIrUyAOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] s390/cio: Check pmcw.dnv before pmcw.ena in I/O
 entry points
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineeth Vijayan" <vneethv@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260910093205.3357827-3-vneethv@linux.ibm.com>
References: <20260910093205.3357827-1-vneethv@linux.ibm.com>
 <20260910093205.3357827-3-vneethv@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:43:27 +0000
Message-Id: <20260910094327.A7E541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The device number valid (dnv) bit in the PMCW must be checked before
> acting on any other PMCW fields for IO-type subchannels. A subchannel
> with dnv=3D0 has no valid device number associated, making it meaningless
> to evaluate the enabled (ena) state or issue any I/O instruction against
> it.
>=20
> Reported-by: William Bezenah <wbezenah@linux.ibm.com>
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910093205.3357=
827-1-vneethv@linux.ibm.com?part=3D2

