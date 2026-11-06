Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979138;
	b=eyG5uosrcSYPS+9yfRP+k9VHQ2kj7jT4SW8/nv/UoVv2GIZFfrnqSbZ4ot1vOQr+U0ZB
	 1VHyKteLSEuVFAvN+D0gmBtjQSdT5agPi9V0sNwkcu7tRInrsoiyjFfYDLZPIYVAc/PcR
	 H/aJiM0s4eZMO/HLVvjZhWE3ti+hZXceC3w8xZf1CaQ3NMcY7890NK6/IVDTtJ1lzm1zL
	 OOeWnXkJ4aPP0HAtBSZPymMyXvcKez/GYC/QVnntSQvAgqsbqBs3KNWFZ0OT/H6C9GvYm
	 /q3QhM/jKpO1vLnC+jvTmc+ZBMwVr5devH81lDaaBNak+hW6AgNBn6h+s+FXCE2ExFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979138;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wpFivgcO5JIcF3pr8HjyXwqkMjmKJmtc1p0U7CWQ4eU=;
	b=reDSEqa9H2E9G0QMHEOckAaNIqf/tlli5GxD0zXzsVRAGSbpW9FY+StqMpnsYD7dau/u
	 HBssAbu/wP1mHnYZqQJ2gxeKg8MUGhjdeetxOJZ3nD0uYaDuIeTlrzI1AsvZCxGjgK13c
	 5UI1P0BrYA7ttjkLNrEW39wURYJEUdxQeTwWNFkzwKiwJ3LkgwyqleQ8NczOJMOl+spuU
	 wLItmmSNyUGZNNDfQJdY99ugZ/HxYHcHhGX3/rnHG8fqPVaWoQ61W24lQzdRmLAuZeIER
	 OIyuIWPWKWY/FJNOQfn/DJ0Vu7XyvdA+ZRfIa+qkJ9XK5rQV6Dw8M1fE5qAu13dnq7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBqW0hot;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2838606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBqW0hot
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262081F008A1;
	Fri,  6 Nov 2026 15:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979137;
	bh=wpFivgcO5JIcF3pr8HjyXwqkMjmKJmtc1p0U7CWQ4eU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BBqW0hotN6xHxyMw67XU8nGbgz67/ErUFHvVCcMXkOoUd33Kih1V7ZGSPnG4MXvhc
	 1vQ6oQS0k8kk1useczQYxgvP2VMUE2VV3jxI4xs15y+Zd6FmotialqVTLbHAz4heHq
	 nL58nAhwXHdpqnIeXPXX5nBgENJmpQRP4mPRGo0D8YaJvQhQYsb2d2AA8hgCWIodLw
	 T481IwmbViPfOX7U/jVkvxNP7wlN/6b2FPx01Yj4m2F6uI47vIcNjqNiWuJg3lMz6k
	 /5BEhf19u2ZtasVT49M0e65D77vxwzl6k1g/Q/Gq7d9WkNoQDazoIoqMvWjOTT69Bk
	 LoD9KilzXmeXA==
Message-ID: <sashiko-outbox-201698@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 04/14] s390/vfio-ap: Reset migration state on
 VFIO_DEVICE_RESET and device close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106152259.1360651-5-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:32:16 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106152259.1360=
651-1-akrowiak@linux.ibm.com?part=3D4

