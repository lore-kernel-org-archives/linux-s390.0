Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D916F4A0157;
	Fri, 18 Sep 2026 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745125; cv=none; b=HO//s7ARgojkl1OfBGe/lC8oCzcSMPYeuj4DiKK7iF83zsjbMHGvv/1GMApvxSWB9WXwdjocZKNrQya8wX4kQI3pXIK38xaUEi7P0OvibGqOOpbncxxnHSznrdcWGlFNlPOw9H5JLmkvVnm+WuJbBZIcM7STPNf5IQBSAbBEvO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745125; c=relaxed/simple;
	bh=0ZXLyMVyZMK1Zz4bTVetUayx/5DjYMV8Iu68ptMC0Ds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SsLXLwm+8/7uc4tqQeMeQe32DKh/lN9k7QRHIA7OuUqRlevXggSJPRJHMGf+M2nY/i6eiHd/d2wWE65Bv9Odu4C2x6g8QhJbH3eBYHXPyv5T5IeJ4C3zENDBretiDdTvMHN2OL+rTdkT6oXqK1iB/hM4tIHBaeGAHtxT+vKWl1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEitdhIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEitdhIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D801A1F000FF;
	Fri, 18 Sep 2026 15:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745123;
	bh=0ZXLyMVyZMK1Zz4bTVetUayx/5DjYMV8Iu68ptMC0Ds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FEitdhIMLHb0kJpOJgBce8aC8dpDYUTk882naxRz2gp8+DhFt0QvcC8+HU140Lih1
	 9d2my0CMam3vop/w7N5dgMXnc+pSZkuaP38127yfqcMD9biDaku8WT8GEq7E78rbiz
	 xnuajDMsDBrZ0r7bck0wqShGAc20ebfryFH5Lfsdjcsd4Ap8K4XU4N2DrL/pEDXC5+
	 lQ0BTBP3D+VOmDiHKHw+VXWRE7yvVcdvEtxipeFoZaP322h/AThUmFX7KizD0DRXtF
	 cLBoVA3ISXzwJhRxF1EO8rmr3oPuv+orcKnz+7uQK30t3gkclrJchjP7ieau7F+U87
	 FpvuyOQhi/Yhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/21] KVM: s390: vsie: Replace radix_tree with
 xarray addr_to_page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260918-vsie-sigpi-v7-9-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-9-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:25:22 +0000
Message-Id: <20260918152522.D801A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The underlying implementation of radix_tree is xarray since v4.20.
> Changing to the xarray API directly relaxes some of the locking
> obligations and provides more symmetry with the next vsie changes in
> the series.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D9

