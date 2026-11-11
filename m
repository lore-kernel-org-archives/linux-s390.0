Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428208;
	b=Ih2tYgtMghOeHd3n3suHTR+szHdzlRJ0D/s+UkYutVjb1j3lc5UKFu5VBlAr+oibMTKb
	 v1slfnYYIJc5mV1rPZjROk0jO268OvgXTzsvz/3oaJT7ZAh1YxE9hHRvoj3rFEAFxR8+l
	 ImSBVJdKWVC9KkB+TSdR2HWldb/A/scDXpQ5xDB62IcrE12lkm/XsrflK/okdwRxnktuk
	 uUM5Iepc4Nt6/Zev9OSUKfbTFZEepY8w+/JNQYqMWptgyTUxN0jd6rsjT3bze1QfxuDOy
	 /7X9Xr/FI+eH+2HMB7P9j2faDW/aj5ZWqIVyLd+eFiQ/QuTjC9o+ftEogKJD4HOmiKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428208;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=El9pXNvAMBzPXswnF/yOgLb1O5VXDOo61/yziFzHD3o=;
	b=K/9JDdzIt79Xwc2c9geRJP/mbg5nV7G4Njwdt0Tg3w8x1b81E21xcvRN0VGugMIusY3B
	 pslHc+TKkzB0ATdON0VzaxUpO2w3uEQAjPMQqV+3LC/HYHqtBHU4qGuuxgmJFiJHPx3NB
	 49C12KJdDZ1Qw2M/ssZ2TpR0oSGcN4AYG3d5iXww9tO2YjS+R+eQ7RbQFZrq9hbCrvTfO
	 lQgcUKEBKoUUxWz+7JCzUtVuHTdhygjBKCMyEyeMij6XPNDK4rokPfa5l7d5znxxJg6zX
	 a+hLf4pK2e3MXt6JeJ8BvPHXQq3sdhXY3OqeZT7BHfQNzBC0kRoJqJJPtVRF35x59wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZViHC5Uu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA5606A31C
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZViHC5Uu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C1E1F00A05;
	Wed, 11 Nov 2026 20:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428208;
	bh=El9pXNvAMBzPXswnF/yOgLb1O5VXDOo61/yziFzHD3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZViHC5UuaY05Pcmud7m+KOc639JA9O3ZSE2q0czbsR6XfXNzSomterIf3ZCw8wlo3
	 BVkFM6hkIIzwEa8cr2u8Uc+Jf+WTBhLx0U/HoOeDq2UfNeZFC/UA0V0dOaCYdC1fUE
	 DRw3R5rt3Yce9xbn2yxeEakWobtfSwGIWpWzTjkekWtvPbuvqLiZ0WmauYCTGR1NRt
	 pHGN1t9vVvIXxVtTUkRDa0Inx1sTAyVn3OY2NPEX5MkrJrvh4NRkrSk4yF5sLzT4Hy
	 M9SbInOWMfFsnX/NvftsZGH5LA+6j79FoIJrhO1E4jCV520FIxSlX3U/HiWXrK3/dH
	 HPnEuptnQBIxA==
Message-ID: <sashiko-outbox-209628@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 04/14] s390/vfio-ap: Reset migration state on
 VFIO_DEVICE_RESET and device close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111192308.2585984-5-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:16:47 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> According to the VFIO migration specifications, userspace must issue a
> VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
> state transition to recover the device and return its migration state to
> RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RES=
ET
> is issued that releases any open migration file buffers and resets the
> migration state to RUNNING.
>=20
> The same function is called when the vfio device is closed. The migration
> data is not freed on close because a migration file descriptor can outlive
> the vfio device file descriptor, so the state left over from one open must
> be reset for the next. To do so under the locks required to detach the
> guest, vfio_ap_mdev_unset_kvm() no longer takes the locks itself. Instead,
> vfio_ap_mdev_close_device() takes them using get_update_locks_for_kvm()
> and calls vfio_ap_mdev_unset_kvm() and vfio_ap_reset_migration_state()
> with the locks held. vfio_ap_mdev_unset_kvm() asserts that the locks it
> requires are held.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192308.2585=
984-1-akrowiak@linux.ibm.com?part=3D4

