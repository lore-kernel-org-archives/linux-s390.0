Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095BF420E7C
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663189; cv=none; b=qQd5YW0nBiIbLswoUq9BjOKnKq3Kp9IH07upDShTy0V0YbCTmFxmHGclUlcor/Cjgq6Ao0U87jECF0Gm0QbHmpnZRFEGPPu25cLad2xgqKjhQnVxLKeVTrFRwFgz5XIzaaE9Anggr4/ky16nOyPzbSqfxmITF2O0jZB9epQYEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663189; c=relaxed/simple;
	bh=rcXNDVttZyKKjDpHyCl9GAO8jz9JxDpyNBFSoYGREgI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EdY1hmSuvNrYW/nOc28yF4/YoOjfYFrWYaQsY2KWTsabbq4VR/ririW89BrYKRKn+BwfF62EBUa/5RrptP5X5v6GigIbGWGoUjWxftkBc+uYm/MkPyDc8Zctw6RgH8lyRFaMHtyXTi9bGKrSwQ0QFf1K2daz7Scx4HUGFcD5yro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzFnXGt7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzFnXGt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AE21F000E9;
	Tue, 25 Aug 2026 13:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787663187;
	bh=rcXNDVttZyKKjDpHyCl9GAO8jz9JxDpyNBFSoYGREgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JzFnXGt7RB6Tu/edDZ/Nvl/ybDpO+XEg72Kn2mGz6JH9gw/V2JmUB4wjAiMBrWfUl
	 snlSMK4C04KAVbkVXyXtUr86OImlDrPhD0+oC3yFshfLqz+g4RZ6k0HZ+pF0rG5iCC
	 butB80K9M09UcCP+wE36r/FInax5jJOt741GHZXtEqiSQRBzWHbMOPbQX/SsiEVeyz
	 aDnw22tJ8n0CynIxVhgk/Ps79oRJFcFuLLX7cnczNPUUNlAMpEoUCsc7xRishXs7pB
	 mTH3r09F5nCuPXGTOh4LOt6nEFDwFc7zrEF4H99sX5yqvao0DM6rXKSFmAWuj1Rgqg
	 W3xFxo02Qjekg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/topology: Switch to common cpu capacity code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260825-common_capacity-v1-1-1cdfa3ad5e14@linux.ibm.com>
References: <20260825-common_capacity-v1-1-1cdfa3ad5e14@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 13:06:27 +0000
Message-Id: <20260825130627.88AE21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> s390 implementation of cpu capacity management infrastructure code does
> not do anything different than its common code counterpart. Switch to
> common code functions and remove the smp_cpu_*_capacity() functions.
> Make s390 code better align with other architectures which utilize
> cpu_capacity. No functional changes.
>=20
> Allow cpu_capacity attributes inside sysfs to accurately reflect cpu
> capacity.
> ex:
>=20
> $ cat /sys/devices/system/cpu/cpu0/polarization
> vertical:high
> $ cat /sys/devices/system/cpu/cpu0/cpu_capacity
> 1024
>=20
> $ cat /sys/devices/system/cpu/cpu40/polarization
> vertical:low
> $ cat /sys/devices/system/cpu/cpu40/cpu_capacity
> 128
>=20
> Prior to commit 6bceea7a1e07 ("arch_topology: Relocate cpu_scale to
> topology.[h|c]") cpu_capacity attribute was only available to the common
> arch_topology driver's users. Reflect the correct values to the newly
> made available attributes.
>=20
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-common_cap=
acity-v1-1-1cdfa3ad5e14@linux.ibm.com?part=3D1

