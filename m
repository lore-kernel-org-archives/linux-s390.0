Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC424A3F09
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210207; cv=none; b=tU3ARwT+61O6SvQPB/XL9xdGCVPN21kTF5+Jp6Z/zt4sLU8vAPqRWWnlsijxtkDcTf6MgeZ6wFIOC0x80D3fcXVHqa+wubRES+Chb/eL8pzhpm2nrMd2ktwNflyVH4Xz9VEGa40QHnaPTr2laYWEraEW/UWi1rT8r+vNefxkCXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210207; c=relaxed/simple;
	bh=rbxh2pS0Xw0kDZYXsTDzAGnXLkvgjs6mdGxO91Si4uc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i2CzjHDcrPtzVGdCGQOJ9hMyPNNnpDXhmPbgyV1t9E4D65oLo2EmfNl9FCgwDqMO6wu0QGEQaxgMbreJ3toEwkNI7dKPm+I02DS3l6mlXDtDMPbxv35SLt8ju9D/LtqVXu9DmLOqELzxgrp/koq1XHT4Tymjf1g3wUS7gW9pgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0rJAC5k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0rJAC5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39341F00893;
	Mon,  5 Oct 2026 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791210195;
	bh=rbxh2pS0Xw0kDZYXsTDzAGnXLkvgjs6mdGxO91Si4uc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F0rJAC5kgdG50dLfwXebf70ya2SXVOmXnnBJmP3bvApu7glk1Kob65W2I9OEVCT7Y
	 OwgVXbcNme12VPrl3zWwdsUBZKPzyRVO1qQLxvO+WvxZW8gCXol1xtTQ1TUSlzcoK8
	 AkJ+Ce1Pt0wt+S009YMeXMLEOLC6fphXg/w2NcovQXI+LqPzGpkdtVl9f3zID+HTgX
	 P0T6hVNpGl/Au9cg5hCGDrwhie2xfeAjf6eLZzcNsNxCiDI5zxnQGpbh3WC++K5TTO
	 BtSwr0yhqugbiwGwT2TVoyNxFfI9l6OAOau7clkKenQvuqzsI7LTmag0CGO4S3rfxU
	 mY3XQ0D6e9v/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] s390/cpacf: Rework cpacf_kma() to return
 condition code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261005141417.65822-2-freude@linux.ibm.com>
References: <20261005141417.65822-1-freude@linux.ibm.com>
 <20261005141417.65822-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 14:23:14 +0000
Message-Id: <20261005142314.D39341F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The KMA instruction can signal a verification-pattern mismatch (CC 1)
> when a protected key is used, or incomplete processing (CC 2) when a
> sub-block-size chunk is submitted without the appropriate LAAD/LPC
> flag. Both conditions shall be visible to the caller similar like the
> other CPACF instructions.
>=20
> So rework the cpacf_kma() inline function to return the condition code
> instead of void. However, CC 3 (partial completion) continues to be
> handled internally. Also improve the function to use the CC macros for
> better readability. Additionally add an kmsan_unpoison_memory()
> statement to reflect the updated memory by hardware.
>=20
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005141417.6582=
2-1-freude@linux.ibm.com?part=3D1

