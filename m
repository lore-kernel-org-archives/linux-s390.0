Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072E40F749
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274346; cv=none; b=XIldi7CDCFTUJNkbxy/2qpfn5vBU7K4SrqeEXMwYuf/anUxTSDgJKm3HuQzFLXAFof948OwRMrQH4LxlYU80oKF0MofSSFw+WKWpJP4LErNBF1om0faV/glFp4uf0XKNhSD7gv6qOyZOv4fIByaTNq9jjkBL+tV9PWMmsB/JX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274346; c=relaxed/simple;
	bh=aJvi9F0MSMrmfBnyNz5h25dwJB0c8DkIWVJBriIo1mw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sbuuy2oOT5buUpSmXCxZBLaf8uLhmPbeIZkbIUsPgAHyX2RB9M571OVB7IfuR6yf14rJQUuss7UVu2cVYfQuJUT/aBGBN6R4TNvKABnnaTXaiO19+48rhDjA7Vmk0zaz72nJYDZhqQEWSYw28dK37PgiP+3MZCT80eNhCvs/+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdR0stIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdR0stIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1411F000E9;
	Tue,  1 Sep 2026 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788274345;
	bh=aJvi9F0MSMrmfBnyNz5h25dwJB0c8DkIWVJBriIo1mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CdR0stILD0ehYaSVMQAC7Y8dmi07S1oSBHa/zYXmEL5NMA/jCkvo2Z/RIsdoIgmsa
	 ycWLZbLkchCWtZmq24JfMPgg3FEyansxDbj7iLl40/n6WaWtrNMeFTkg2H7oLko6vt
	 zqVmrKxNsok76X87hkDP6VlfnBGS9nBqkGw/7JVPZF1o2Ry2tiMObsNI3zc9EhMvBn
	 xr4UUZLSce7QTaK9G1UIiIy+zuc7JO9ruv/vww/dD5o+9khGME9rXJQl9T9n/ZMU1y
	 GXaMfgP5Y+32uGXWPeYr7SRizPj7IdYMlTSVdcatkO1yEreKF6rLO0XG5ASlVbN9wP
	 UX3YKNF1uaIKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/topology: Enable ASYM_PACKING to establish cpu
 priority
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260901-s390_sd_flags-v1-1-6755ba191d5a@linux.ibm.com>
References: <20260901-s390_sd_flags-v1-1-6755ba191d5a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 14:52:24 +0000
Message-Id: <20260901145224.EA1411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> On s390 LPARs the hypervisor assigns varying CPU runtime capacities
> under vertical polarization, making CPUs unequal. Add SD_ASYM_PACKING
> into topology level flag callbacks so the scheduler keeps busier
> scheduling groups packed onto higher-capacity CPUs.
> Implement arch_asym_cpu_priority() using smp_cpu_get_capacity() as
> the decision factor. Subtract the CPU number so that the CPUs with
> lower ids are prioritized.
>=20
> Only enabled on LPAR level as other guest levels either do not have
> vertical polarization (which causes asymmetric CPUs), or machine backed
> topology.
>=20
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-s390_sd_fl=
ags-v1-1-6755ba191d5a@linux.ibm.com?part=3D1

