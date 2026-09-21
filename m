Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5284D4898
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008146; cv=none; b=gbF5ycwfJoZ/d16hYqgNG6NuS2aGYAqZ3w4v8nWytAuVHk0Cygvj8H5OajdWGKGEvjhz7RqShzEE7cSR8DEvB7H99k9rrEQ7x0JRX0SPgK9bxtumlTE8jmhJToqWR8igBDYmvwJQtRm0kDbbgrAwL6EXS5Mjw7B2kzN2kL3zvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008146; c=relaxed/simple;
	bh=ThvkCtFoXQoPhNEo6nUrAJgy/tuPv+/B2CopZkTNvZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RzI0T5NpihPfHIqga1MmgVrgZxDV9BKijO2pTo6pl5KV8SJRRHma28zgdXCJV/7tBcXtw0sseRwUzBXfjLevSoaVz27wqRJYknozvAQC2jJTuSDC/w/4lpEaC3mNQrptsNx/VLaEMNXYZfE/VmY9j5owmHIKneeVUH6p6Oe9Bco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Afe/fhdB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Afe/fhdB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F68F1F00898;
	Mon, 21 Sep 2026 16:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790008144;
	bh=ThvkCtFoXQoPhNEo6nUrAJgy/tuPv+/B2CopZkTNvZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Afe/fhdBirOmp8k/KBJ3VXQCC31QFn134k2F/J4mSdatVy3QKLRqcBo1RNBBrdCiN
	 E/xCjnPx4ZgAVQ7GDRog75ZHeL7R0UhhjSss5h9hkGKv6mwFa3b2k9+TJQmFWbbsSi
	 0GuaAYucAhWA5XpTPclmxz2X70Ca4Uzvnc/ShzgKdSiilhJGhXr/BIJUXfawPtWbmc
	 Nm6wX2xWbH5ojgOoC2HWWyu6xCi/YX0qflxpnmLyf6iLMKZEZtg0qC/OKdfJxe1Vsa
	 ZHx+EtW0oBSEUJx63B+ueWErLcft2ZcPGgrBLD5VbsGw1jaaqUnxHy9/9zDhoS+zZn
	 kb8zBCjJ6xVGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/11] s390/percpu: Use percpu code section for
 this_cpu_cmpxchg128()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260921155806.2447506-9-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
 <20260921155806.2447506-9-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:29:03 +0000
Message-Id: <20260921162903.9F68F1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert this_cpu_cmpxchg128() to make use of percpu code section
> functionality. This is just for the sake of completeness, since
> currently there is no in-kernel user of this_cpu_cmpxchg128().
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921155806.2447=
506-1-hca@linux.ibm.com?part=3D8

