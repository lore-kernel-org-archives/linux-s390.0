Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163470;
	b=cY/dvcWpw1UfdlV09EISSCEv05dPOOfDyg3r4qWiTTGnV2/PsGVCg4GgXc8EWool5EhA
	 VRrTXFMYF2rkq4m+CnguoF3tXHUBDTHCDPYNsi+MLV/Wd6diXGf5wbrTvCuF2i5dlmeRk
	 p7otAzVflvV1r74Y81O9qOj8nlJoiuKBLcHY/vu7sIXQijjfw8mrKct2TveaFImhdUZ//
	 yas97Fxr95EIeOn9pQ9sbvgsIfC508VVeJYdUHyCn3L7cvyReQeIeUkxoXcOFFErwDMo2
	 2ey9fU7E5ON3n5qu719UmiJhUmJbZHgNDvyMIleAvlTvehepU20Yjz4049mLF5bb6OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163470;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6hpYFo14qzsd88d886EoC8iHUdhCc1EZJSmL0KC7jnY=;
	b=mRZvq28vmQNmcTbnY2sADVNfvpnvreZ+B/kpDquD92/rxLK/bi8Z6Arom4fOMeERYR2N
	 R7HKzB9/iNElkzJzh0g63AIZPckZkd8olJNL5iNjwocY7sTFPRd47JAfYMQ9uuCSU3X9+
	 ODgA1jeVpwdQqt+wVOTZCo66XP73546krKm02txC5VNBYJMA7ueaNic3KdK5kxouebF36
	 MEXC/gd6Gbg3u9VWuIN+bsOID0UIZm9OpYAWlkPMl/z2pVTjEIVb1reuvEL+Ni8DIxOIF
	 VrSXdVckAWBcFA5b5R9Jp3PtjKhHW0Bklzm771lNwxgx8NWpvBp+N+MCBGvYttdi+OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBcbAYeD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A758606A31D
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBcbAYeD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0B41F01825;
	Wed, 28 Oct 2026 04:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793163469;
	bh=6hpYFo14qzsd88d886EoC8iHUdhCc1EZJSmL0KC7jnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lBcbAYeDQBWz+w0qQYaPZ6Saww9EK3TCtrOfVGldPUsjaq4k65sUdRN3QGPDYdRhL
	 wcEhA4mhqYqzpdhKRblfkW/vYcProgKhsKavxD6jcNEK7z4Vp1cUCT28LqtSFvk/pW
	 DrDej9WxG81YYX33zUb0k7OpWRnbFZCLnlKt6YjOyLZqqA+OSl7agVdOBT0ibapL3G
	 pHwmOkRKVU0jnWS2S2vIWwkpmQ0H7qIU2w1J4hYRUw1JWUCNP8oMpk02ek9xZvl9cP
	 EZ3hZNMFEqKeX28DC58AjyXi4pg47yJIfd13ltyVLDtwbu+4I+Hc8Y7Dr+vJqynOHT
	 CvoU5nm9E3aBw==
Message-ID: <sashiko-outbox-187499@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] s390/dcssblk: initialize device semaphore before
 sysfs registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiale Yao" <yaojiale02@163.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028044828.96177-6-yaojiale02@163.com>
References: <20261028044828.96177-1-yaojiale02@163.com>
 <20261028044828.96177-6-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 04:57:49 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> device_create_file() makes the add and remove attributes writable before
> the device list semaphore is initialized. A sysfs write racing module
> initialization can therefore acquire an uninitialized rwsem.
>=20
> Initialize the semaphore before registering the root device and its
> attributes.
>=20
> Fixes: c369527f18f8 ("[S390] pm: dcssblk power management callbacks.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028044828.9617=
7-2-yaojiale02@163.com?part=3D5

