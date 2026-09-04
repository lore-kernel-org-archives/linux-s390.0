Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BED14266B2;
	Fri,  4 Sep 2026 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502980; cv=none; b=ChCSYVL91JGFTPy05Z4yCNDkD+EEo0I52su18fiCwo5QcraUW8jd+09VW4L2k2MMcAgl193SOzh7VUD0vLsGeuKprn9XXuV1OBefaZian+phTTZwFoJxcUAJ9bEEK325loSLtnihZQj3qsDpxdT5mqqeuzLRr+R6fNjiP1SF4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502980; c=relaxed/simple;
	bh=T0LhlU1QMVcS4luBoUixXELPuh5hhjhtLeKplKPmm/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OratAWudKv33TJEUgOjbO08LRYgqJUEQCSEmMqlNrRM/WidsnLmN+iY8z7rxGMkokyaqslF2wZt4ySuVVQ3cvhY6UteNoUTlkxatKnNOYYXuVq/SVpQgTkcRbDGwkJt63WHIMN+c7liDS/I1JjOz9MJb6i0MK8Ad7laAauwFqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUiogX0x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUiogX0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8973D1F00A3E;
	Fri,  4 Sep 2026 06:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502979;
	bh=T0LhlU1QMVcS4luBoUixXELPuh5hhjhtLeKplKPmm/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CUiogX0x5wg3FvtBQOmaAAtLNhVag2wAhb7LG5U49loPGfMkAyMCy0Hl+z9yZMDrM
	 AP89kxXq3cPV812yMHRIE1OyYj+0/+LuwgTVd2Ywmyk7UUEbAxDgqI4TScwN5b0xkF
	 CJZgniwhqJQbY9sbbLva/9Qk9KQkHcmwnOikvUAA9NEp0f7lnrnrymFc4FGpZn1UmA
	 HZtXm44RHNlVEV2P31bS/C03aS56H2yrhFMXzvAgoLybnw0xz2xY4X+OtN1ZuufKew
	 /iM8nq39E9Udm1Gzjb0EW/l/UOIYQLhKKPaVLjcAunZlg/Ihu4zdyN7om3U59P2B5w
	 ON4tWOBOeQd0A==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 09/11] s390/vfio-ap: fix KVM GISC and page leak
 when queue removed from host config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260904060647.562443-10-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
 <20260904060647.562443-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:22:58 +0000
Message-Id: <20260904062258.8973D1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Anthony Krowiak <akrowiak@linux.ibm.com>
>=20
> Three related problems exist in the handling of KVM interrupt and page
> resources when a queue is removed from the host's AP configuration
> while assigned to a mediated device (mdev).
>=20
> Problem 1:
> ~~~~~~~~~
> AP_RESPONSE_Q_NOT_AVAIL not handled in vfio_ap_mdev_reset_queue()
>=20
> When the AP bus removes a queue device whose adapter or domain has
> been removed from the host's AP configuration,
> vfio_ap_mdev_remove_queue() is called. If the queue is still in the
> host's AP configuration at that point, it calls
> vfio_ap_mdev_reset_queue(), which issues a PQAP(ZAPQ). Since the
> [ ... ]
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904060647.5624=
43-1-imbrenda@linux.ibm.com?part=3D9

