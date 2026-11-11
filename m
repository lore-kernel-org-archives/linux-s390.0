Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418593;
	b=VJsnEb3IkTXdZiVEeTHv5cyNyVPXqHlo+Oq+pgXlx3OQzpzUE+xgboZisM5fZuOaDxpA
	 4nLOMtqww5EGyMXT0L78tAF0dPGYBtdI2uAFfmFYC4fPR1mNynHSrMM4DFePQ4qrg5pKr
	 nqcC7PwCUZDjI6OVyhlda0Dsf0z+OJb53GjLD2tj4Oy/xLsRt0t0xWXx1lPVKNYYVh8eP
	 0NF1Xus5/kSrsP+wCMX0Xl0G9+cyMZEMoZaIyx46HkNjvjmMvqnC8DP2mKUEckMvtoplC
	 8vrOOEAuOvgclnhG1UJ7Ri1ZLbqidETPrh8U27VwfHOvBs7G3Ip4BU82IqSLv+lY1+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418593;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vmfAY/utTC21Xke8G/BtbtuvSG6zizmCdl20fZax2h8=;
	b=Jo+R3Amdkl/VbYP7oqCstaZlDCtLjd+apFUlAR4mDutndmC86xx7z2s247hKRdscILho
	 4q3Ng0Kk4eaR/StfKqPJZoIgfhPsif3ZbNEsFAccvVAGPPUU2dZQMCgVWS4QeD4aU/6On
	 RpLtDhcbshROG9aYCiWByf3q/X5+mDrrarAMkWO5v77T9GBwn2XyOJgK4AXFfDhzOO2ZQ
	 mLSEUJ0pn5jI0OrnteNWIrjRWhrYtw7WMJFVE/qnOUY3skc7C8c5ppdI++GixpJ5Dekot
	 YaMcW9Sg1AYH5bITkFTkDdFvi6v7X3Oc6S7BDfgbIXZlj+nciEjTSHZ/P130LP2rJqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ds3VVQvE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237AD606A31C
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ds3VVQvE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF461F00A05;
	Wed, 11 Nov 2026 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418593;
	bh=vmfAY/utTC21Xke8G/BtbtuvSG6zizmCdl20fZax2h8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ds3VVQvEHO+F8/vIWH7Gg+KT2hQxy74WCqKn9INT5Bq09mLOVi6gles/LCZWACao/
	 elkvCjdBStJAPPDCn6b7d3FD9DCv0PwyKoYng5mfuo/y2b2LcVsaoNM3H3aKEJz0Dd
	 mA3O+egP9AXgd1zbapgZYzW3kuvIFOt0RZJIM++dlpRqhla/L5jKNs8bG24FcTxFAn
	 zOO1N98pD5l2yOWrIUwoNgM5gzV+KT06g0Rgo2EAR+3zobfH0Puz7ZR4vdqiuMwPEP
	 kypmDDfxcSTd+abxdqJjQwNc8nDm+1CUhHNz01Xufr4lbJbnkc56zTXbSdkwKcB2BW
	 hUlSasd8ge9Hg==
Message-ID: <sashiko-outbox-209422@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 4/5] s390/pci: Fence FMB enable/disable via debugfs
 for passthrough devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111162758.9792-5-oelghoul@linux.ibm.com>
References: <20261111162758.9792-1-oelghoul@linux.ibm.com>
 <20261111162758.9792-5-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:36:32 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Introduce a fence over enabling or disabling FMB via debugfs when the zPCI
> device is associated with a KVM. This will prevent processes on the host
> from tampering with the FMB while the guest is still using it, which may
> cause partial counter resets and inconsistent reads which have no parallel
> in the architecture.
>=20
> For VFIO devices that are not associated with a KVM (i.e., for userspace
> drivers other than QEMU), this fence does not take effect.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111162758.9792=
-1-oelghoul@linux.ibm.com?part=3D4

