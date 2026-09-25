Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EDF481255;
	Fri, 25 Sep 2026 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340722; cv=none; b=bS7XG5QEyfZ3h51qCwqMSpp0/OfMAkbNIUVdXQQoCTBqHfJ9AgCIghuO/aUSUplBLSFGyKdcQ9Uo/JVcNkKgKvtKInxDc1+GLVHAw6epVMSf6Fv6Vn5sROFwBOItlUjW7Seuxz53p9lqS+W+V6azOXqv2hixrOdxBtg9pX+s3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340722; c=relaxed/simple;
	bh=yjbeZ0Ns7P6q4XSm3jl07hfV2G44kN7ubjLgSRNVKtA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J8X3IJ3Q0NWGmHHICtQsk1vJNoVaPIS7PV3Z2iA/mZS7z3BL7joVTM9A7mwN1syOKVmnXGgqhG24m/W+6izhAr1pwreOsjeSUWEr2LKyb/mYp6i03n6P3uEof7SA4WY5XeJlSuuVxjTwTjNnwTRMe7/sX+w6A1XRN5ktuEWgH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXSB+pj0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXSB+pj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB831F000FF;
	Fri, 25 Sep 2026 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790340720;
	bh=yjbeZ0Ns7P6q4XSm3jl07hfV2G44kN7ubjLgSRNVKtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aXSB+pj00YPoAU7NVv4vJ68F4AgIcNhJTnCB9QBFmVVEtnPcOpaoFCakPcnZtN2WS
	 8w51XXHfN0kBq3lXmI/Ek4a6oO7Rz1NLMPouBsPG5eLtaDTBmzUdyv9wc7+1Z6mwUA
	 xCpR6XDu9+WGqJg4Z83IYpHPiARfl2HNtXkCGhOhhjeN7l3LeKULQd4r/khJiOdI6+
	 CSMsjtGvVk11rTGMuPdSGKMPFSO3qpWP5Aq/ENWM8qJoEsS5O9crxX7JxAnCmCedwj
	 MuEVfrbPP82D5wqywQrNH+bPplK6Sr8nd0lHCl2w32zkRYEI/4V7Q/Vc34EpMunzcq
	 sGnnKYJgrC1jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/6] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap
 size in vfio_ap_mdev_cfg_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260925124551.665448-5-akrowiak@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
 <20260925124551.665448-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 12:51:59 +0000
Message-Id: <20260925125200.4AB831F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Domain and control domain bitmaps are sized by the AP_DOMAINS constant, n=
ot
> AP_DEVICES. The two constants are both 256 today so there is no functional
> impact, but using the wrong constant is inconsistent with every operation
> on aqm/adm bitmaps.
>=20
> Use AP_DOMAINS to keep the code consistent and correct in case
> the two constants ever diverge.
>=20
> Note:
> This patch was submitted in response to a sashiko review comment pointing
> out there are other functions besides vfio_ap_mdev_cfg_add(), so there are
> fixes included here for those also. The subject line was kept the same
> since this is in v2 of this patch.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925124551.6654=
48-1-akrowiak@linux.ibm.com?part=3D4

