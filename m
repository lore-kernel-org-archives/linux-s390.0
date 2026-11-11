Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428316;
	b=GQQMzGvZ0ml/znMsRwfVbDiyJZ2No0+baLYUiYZONMwDDaBLPkU6AtdMZPfI4cEpsUzJ
	 lPhWJlprG7igPLdcSBJ1dqmtcqN6fD2ZN2iQCacX7zJXwq2DZ8HkNY6+OUd3TwnJclYul
	 6zCx03IxtPE6SJg7xSlSrJL2bjSTExsaq7060ar60KmzbWJi3Q3VipV4iS4q9f87j0xzc
	 VkpA1xAKM+vl3DpjwbBDoCLFV1ZNpaVepVVlXOXncV7xmL+bnG3cPuWl+JNX8Lc+XUTjM
	 pZS8ZLnuPhaO665ZyaUnlXoCawIJr/IIeVlKNakw1XLKFVqwVh8QCNHpE8H1yLeWMog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428316;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K/XZMu6gVpzasejJZfIOiXxn6PQnwL6RTPVyXLRCab0=;
	b=HUlqhLdpxykcw2JYrqhmcWsFf4yFILE6OOq1yxtO+UvAiChR86ryCZH+UrlJNj52XuEG
	 BqXiNkHXj0I/ib1H1EljphNJzmy15ivam9/fzFssok5kEvF0WwNBZEATwKtk9bU681f0p
	 kTlulIrth1rmaDv2ByvbjSrKiNvlV8xsEZHaasjpj9XavXttfIC06EnjdcZTsXI+q/Dyi
	 YyYs9Ihh8d6RIN3K/WuLgWraHcikTm5t53bgtFm/flxJ92NzwpkNC62o+QunTyA/sI+Ks
	 mFBgJcIjzcWUrbl9mKZSLqmwJHx3qJUjDrj5Ov85glLd11WkKN3FYWre7HUANe6778A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdWfgVE3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C85606A31C
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdWfgVE3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A5D1F00A05;
	Wed, 11 Nov 2026 20:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428315;
	bh=K/XZMu6gVpzasejJZfIOiXxn6PQnwL6RTPVyXLRCab0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LdWfgVE3Ku6OgNut5Xv/vg+XysLy9WKhHK+Gp3QiAhmyogIUqJxAHMpGz9f2tlrZY
	 CfZSin7xbzc8k/lz8RH/3gTHWk0ywnWawxaDVRBWv3m736lVwORV1poll5lIyMw0Qo
	 t4stoQsVsiBiCX9t4/sK0C16KoSFErGrY0JOcWfs99vEUYQXSmhj9UBml+oYcgM0Kp
	 gC7kLuwSA0JlpA97mXastC5GZm4tiBEiQ5xaPxQfVIQSPtPIppC6mtUBKHTab3Y1Dt
	 +MvR3YDX14gWWVt0EZg5Pe8AXFsusImhFzHC1IDwsKx7jEO8gbMrA9ozMJWA5wNmUz
	 ep6jXBRZxHEeQ==
Message-ID: <sashiko-outbox-209632@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 10/14] s390/vfio-ap: Transition device migration
 state to from/to STOP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111192308.2585984-11-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-11-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:18:34 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> VFIO_DEVICE_STATE_RESUMING to VFIO_DEVICE_STATE_STOP
> VFIO_DEVICE_STATE_STOP_COPY to VFIO_DEVICE_STATE_STOP
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Terminates the data transfer session of the vfio-ap device state
> between the source and target hosts. Release the migration file
> state (ap_config buffers and file pointers) so that a subsequent
> migration captures a fresh AP configuration rather than serving
> stale data. Since the vfio-ap device does not virtualize a DMA
> device, there is no internal device state to incorporate into the
> vfio-ap device on the target, so return NULL since no file stream
> is needed in the STOP state.
>=20
> VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RUNNING
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Migration has been cancelled. Release the migration file state so
> that a subsequent migration captures a fresh AP configuration
> rather than serving stale data.
>=20
> VFIO_DEVICE_STATE_RUNNING to VFIO_DEVICE_STATE_STOP
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Migration has not yet been initiated. No migration file state
> exists to release, so just return NULL.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192308.2585=
984-1-akrowiak@linux.ibm.com?part=3D10

