Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87923D7DF
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851152; cv=none; b=HavU0tzHZfddFqgnm7Es2udjUVidj0k45GCYsVj5XA0a4QQx9yDuhonEeRj7+FYR0Jf0YTvaFgso/NFMXUOrVcCKpb5upq3ccyNNKGr/zKvW8YM4X3tonny2Gk5aQ96klbFwP608VwdwUEdx/lv5+xDYpS/YE4WHx8Tw4+KHH6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851152; c=relaxed/simple;
	bh=CMnDZ0vPqI8i/BtkTdqbqw2/FNd7kiSYb3QPcmM8P6I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uCoV1mlrCJczsAQa44LSpIdxycJmE+C84OjRZKaH+PRU4qj/CB5Sa7YzuK3UlD2079mh+Uxdr+/5drJc9oeePKq2vyF80MQhjzwnsJn/q73FoMe2G45dbjQrU4zEwArKKp9XTn45es0LnWXrj7ggpWW9sjd6eZB0NeMcM2mw0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYoIFhoZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYoIFhoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F241F00A3A;
	Tue,  8 Sep 2026 07:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788851149;
	bh=CMnDZ0vPqI8i/BtkTdqbqw2/FNd7kiSYb3QPcmM8P6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TYoIFhoZaV+x1dGKD7dMmrXHF1TMaYLaClPsjbU1982gpTvkCFWdPKuk+nRH+f3Ul
	 FGVjyXk+gfYZ0ePnhKUZh44J/S9Erxoscg9lnqUNgRMhR34T7xRIjVq51L+KEZlE2c
	 HFb/J0wJ+fp0mcONJLc5e3dLYGje5RiALmdLFH8wczjVtVWe3Nx33i4gqkFhGkCbD2
	 HuufYQgH1fYyE+CcKhf3lyz0KZ4tA9om2CIKbg3u42ywvVZ5uVC068HSe7FBh/t3kC
	 aKlcrhWn1nPofZaszwroR+o6poi3RLW1O5Q70v2C7X7eeuSr2AkfLQfLDuKPIotssQ
	 uZ4abAYvrz5Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/24] LoongArch: vDSO: Enable the vdsocheck tool
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, ojeda@kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260908-vdso-absolute-reloc-v5-19-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-19-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:05:48 +0000
Message-Id: <20260908070549.14F241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The vdsocheck tool validates the object files and final .so library.
> It can detect if the compiler created relocations which are incompatible
> with the vDSO which need to be worked around.
>=20
> Wire it up for the architecture.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D19

