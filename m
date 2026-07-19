Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B3D1F91E3;
	Sun, 19 Jul 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466487; cv=none; b=Jz6BCB/psJMDppFzKonVe7Cu/mPOjj4fLj5pH72J0BM2MDjDq8qTd7spKsrzA52NxclGhvflEogc4wm6UNWDBBCtFg/uFk9cHbNWUcBGS+K/EL/O3cfPICi4eyAYvxq+raET6R5yvUdySBOii9BbCgfIYvoRyq36mV1MhCZTJoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466487; c=relaxed/simple;
	bh=g3I2b4p59Blr5hoM9qBlXsoBsGM9bAlLchaGvLkwB4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ys01T0eVvMV/MMnmc9kzqcRrDP+2M8YqGwvEH66fRjWMZIQJ3WiLVwvcd+cx1i6zA6WGjR6jxIQUVWsRmjjx6YblOlltjfqKIfBYZmUoEkxrRRGCKf7CqgtLODX4Wq5XJ8oU6/IyEdvx1Gp0p3FqVLZwWkiJYUvxx0tFXRPSERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SagKhUCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SagKhUCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CB31F000E9;
	Sun, 19 Jul 2026 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784466486;
	bh=g3I2b4p59Blr5hoM9qBlXsoBsGM9bAlLchaGvLkwB4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SagKhUCOjzdY2VHQ4EOO1wOoHkpNjP+Xxma0pbGRA1ZZ2MajkIzMTGJ/Z9MfGDmP/
	 ANojegDl4HebdVzi6brEZrq1FvTXzXYwvh5c1lP5b6B1llCPS+7w5eDUYGP6n8gNXR
	 NKVEvwWAnMb9/ULF51mcPFYXpg6q21WY1VNNTUfK1i2j6YRWSZ8m8rj9VdRwFJHE4Y
	 mmu0SAoAvzfm82ZBgYndCdJk+5ZOx1Z+aS2RVLo/7dRfknJlrjzQMIo45OCKbhyrmS
	 jpdxzNMApJ7xLXYzCGtM4A68WR9JVVnvQWdQvi4B7Wq/cq6XaC/dgb1B0jgXMVeVkO
	 SIXFekYzDA3LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] s390: Add support for DCACHE_WORD_ACCESS (again)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260719130006.3882764-7-hca@linux.ibm.com>
References: <20260719130006.3882764-1-hca@linux.ibm.com>
 <20260719130006.3882764-7-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 13:08:05 +0000
Message-Id: <20260719130806.00CB31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Implement load_unaligned_zeropad() and enable DCACHE_WORD_ACCESS to
> speed up string operations in fs/dcache.c and fs/namei.c.
>=20
> With the secure storage access exception cases addressed, add support
> for DCACHE_WORD_ACCESS again.
>=20
> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719130006.3882=
764-1-hca@linux.ibm.com?part=3D6

