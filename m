Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA9398915;
	Wed, 12 Aug 2026 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535996; cv=none; b=Z6kuidLddQbaMyqtK/OPqUSBs03MwyVPgzd+C5IGMv3tfBGTcfJSs02d6m8SG347Vh+dC1VdktfHVqrBW6g7G/kz1Dk3oSHcBHXkJspyT5xlgHKHu7fbytsVsPhbotT7nbpjqruiRVXDDH+0B8AMO1UzGYb2iQooWFmajjiG7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535996; c=relaxed/simple;
	bh=FbehVE1ogbClmqj6OLWM1L06+QlXRDjlqBs/0OJJ8E0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ldEe9wyzJd2gVdxH+M5iL0wB7mEaTHoS2jpWOc/w1oaL7KbWLFa7POEqDYPDnAZ/GAGuO4AtR5g6af5w8u5Efv+BrIt/Vxw48w3S+o69zGkByhCulrV/IQF/cqlQkf8Oz41rqBWABgxLhl/r/rIdCjKVzkZZhYFHCk37uLNvDV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0osgZZs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0osgZZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1221F000E9;
	Wed, 12 Aug 2026 11:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786535993;
	bh=FbehVE1ogbClmqj6OLWM1L06+QlXRDjlqBs/0OJJ8E0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c0osgZZsFzxFG6stMpci8rlWBUZKQAcFoR8l7ZBsrducwdUXRFOBuldgWOTOaRGtW
	 PLz5QTF53OGG9btzCB1ztYofZjLAbHtpH7I7ZtzIy/7lakfPj1LWRXTgsBY3gpWQOj
	 cihiikw0Cf7JR73ClyqgeWMtQblwPJtUH7H4m59vBKQLoq7C8/LIcfGzv6LklYRK1U
	 ACLBpHbTkjgGqC3IlbEmbhPyafk7/dek5YCP5JrTwFPj1wB1TXzMy9Hl+Dlw2soD8h
	 VUC4dk4O1Sizhk25pLitWSb6Wy+dhog9fdgPTi25EWvS6btG0MdqSJfQLSd2mVwTAJ
	 Px89VoBGYNouQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] s390/vfio-ap: Fix hot-unplug skipped when last
 AP adapter or domain removed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org
In-Reply-To: <20260812115139.576303-8-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <20260812115139.576303-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 11:59:52 +0000
Message-Id: <20260812115953.3B1221F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812115139.5763=
03-1-akrowiak@linux.ibm.com?part=3D7

