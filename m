Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596610;
	b=RAM0365YXGVw8KqhP35TuZ2rgWDNYFeWUWM521eTFKVjWCPars42wI0ou72bQPluNmVa
	 ZNB4CHrKjuR3O792HSSKDO/7P9JJDZCPeA3PDpofAJhPdqpcUGfXa4pZJ5QH+sEWsQNj9
	 Ejxb6P9ouTcj5QtnPgf8oLUVMz9gcJrbXyaGV6Z/QrgGrtnO+kPeCre8+3MnY2QoStkrV
	 5w/6gBqxN3agXdYE1mpSwYJYGcVohcXaOOCTxHTTd6aUgDnA36uoLPblXiC90lruNxWGM
	 4+22wcMHX03ynTAsA4DFK4xPERs0Bc0aoOk2ChmBWBtDSIgNc4EXKH26+DJUXo5aO3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596610;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9nnN3VoZZ1Tex1ddD7eTT41gETUKBGwFja5LtsW23xk=;
	b=lyYr2xH4S44JBXaTUscMp7mmfkoDgiAS2q8GghC/h/ZaCCRJhNqyO7vUlX1alxetCieg
	 +Mzll85ObsHjUFHPJQpyubJ5ul4Ja40qute3sREYNvdjs+chkNleultduTmBIlWAm/FHm
	 cIkriaP0mPobJTB10eynxLPwNZNCvbOwv/CkN2hnfopS+0oEvA1YSOSGmAr/sLi96X2dy
	 QBQSlsH0l/3zgruNo1+yFEhAQUstbCvLYnP5Tj+PilfhkabNDDI00EB4MFXnRaJ7U6bdb
	 +e7BraCxKd41x0bKVdXQprEUsCXFn39hn0SaHwEUv748avjhRfRD4DDz14FWGWleTEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5WPn2Xq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284E606A330
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5WPn2Xq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81301F000C4;
	Fri, 13 Nov 2026 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794596610;
	bh=9nnN3VoZZ1Tex1ddD7eTT41gETUKBGwFja5LtsW23xk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D5WPn2XqUiyVt3UPNlvOktByXEV7eSq1uFzgqMtvOZSDqm1FdV3U5RE+hdH0q6Ei1
	 9Omz/6vLgYN6r29XWytuX5EiaJ9X2VrILzyOvUQb1wzfxoi4SZasGYYZkTZ5YXSbiy
	 NjVQ2lZyPlJpVb0BZKJnT60XG1vPxyFMxcQHLehd98BustJ1gw+FOITqnlCrqxXRD9
	 AbHncyrQRXhay22++gTKEnBFHzRxKG/nMaYqFKL/wujK27HEhvxanId9H/ZnUb017k
	 +sgKxgytWxxG7vnkqjAn9QXxA43JqABr+TJG1+Rj+1WyEzb4WzoVx6QqW4Lzp5L1MM
	 jgKI2YHv6AaxQ==
Message-ID: <sashiko-outbox-213495@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] virt: steal_governor: serialize sampling against
 CPU hotplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261113184257.621707-5-ynorov@nvidia.com>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-5-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:03:29 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Steal governor is not safe against a concurrent CPU hotplug operation
> because it can change active and preferred cpumasks during the governor
> sampling.
>=20
> To address the race, the governor would take the cpus_write_lock(). But
> that may be impractical for the loadable module.
>=20
> Instead, implement the following locking policy:
>=20
>  - if the code takes cpus_write_lock(), it's enough to write-access
>    the preferred cpumask;
>  - if the code takes cpus_read_lock(), it must also take
>    cpu_preferred_mutex in order to modify the preferred mask.
>=20
> The core scheduler and hotplug paths already modify the preferred cpumask
> under the cpus_write_lock(), so no change in core logic is required.
>=20
> This provides a common update protocol for multiple policy drivers
> without requiring writers to take the broader CPU hotplug write lock.
>=20
> Fixes: 27d47ebce4d6 ("virt/steal_governor: Implement steal_governor polic=
y loop")
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113184257.6217=
07-2-ynorov@nvidia.com?part=3D4

