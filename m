Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C465367F59;
	Wed, 12 Aug 2026 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565386; cv=none; b=de9V2/sBpk/hac9R7h/H1oINzn3VbjQuZPe8TNFXsrulnamp6oBG+WNnwv2+9eVgVOU2YCkNolsONc1brFM/OWxmY/dERDjnk5qSTGbLvmr522cUsuIU+vcBI4mC9M5/PwAZ9dVrK6PSOVbOCqcBu40i80XDcqi+Ev3Js+sX1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565386; c=relaxed/simple;
	bh=1Rz1GmSc06simQuIkrWCpraD8KgXtcjSc6fdWMz2jIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EihvZklWgxfk1dng+CzPoohMKhjnc5urEKL7HVRZeHetzebYKlswi3A8ZvN+UxJnNDQ5MwWr8GMAKXXglQoe3WkYrIxdS9P/Gqzv5DOQw1D3GvUsDN10hgryoPNMCJqoM7ymKhOablWe2WTO3aeZaNbJuJZIfEEOgj6IkuF/0Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsRrlfoD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsRrlfoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9060B1F00A3A;
	Wed, 12 Aug 2026 20:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786565384;
	bh=1Rz1GmSc06simQuIkrWCpraD8KgXtcjSc6fdWMz2jIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VsRrlfoD5y/WBwQUmS1wTyqDQxz2zkhZWJyDc2IRc6MaQ+eBdgYI99v8B7WAGVold
	 kKspnO+CJBx7qofHV5vS+N5IGYJJ17DUfo5InSag+LAISN2lTXKP73EJVrP0MKuWED
	 lfuZYPubARdfRn4zDuKA4+UMnnjoQLFCWfy/VPnlwKvGrNiJxaR48HC6NOiMsdDFMp
	 2dxwHIZ8feHYqycXzrQ4Q4a+G0c8z7eP0kiK49KLk5X6pF5EfuVHVDvo8UTGl2VCrx
	 /WPfWZ424cqPRHUfLLSaQS93C+WXrAAh5gD2AR/dSlqGWk5z2MO15iORBYpT5LRqLK
	 x/FuZ1n+bH/bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] s390/vfio-ap: Fix hot-unplug skipped when last
 AP adapter or domain removed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260812200240.818004-8-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
 <20260812200240.818004-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 20:09:44 +0000
Message-Id: <20260812200944.9060B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The vfio_ap_mdev_hot_unplug_cfg() function uses the return value of
> bitmap_andnot() to determine whether the guest APCB needs to be updated.
> However, bitmap_andnot() returns false when the resulting destination
> bitmap is empty. This means that if the only adapter, domain or control
> domain assigned to an mdev is removed from the host's AP configuration,
> the bit is correctly cleared from the shadow APCB, but bitmap_andnot()
> returns false because the result is an empty bitmap. Consequently,
> do_hotplug remains 0 and vfio_ap_mdev_update_guest_apcb() is never called,
> leaving the KVM guest with stale hardware access to the unplugged AP
> devices.
>=20
> Fix this by replacing the bitmap_andnot() return value check with
> bitmap_intersects() to determine whether the shadow APCB actually
> overlaps with the removal mask. If there is an intersection, call
> bitmap_andnot() solely for its side effect of clearing the bits, then
> unconditionally set do_hotplug to trigger the guest APCB update.
>=20
> Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan compl=
ete notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812200240.8180=
04-1-akrowiak@linux.ibm.com?part=3D7

