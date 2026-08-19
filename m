Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5A440639;
	Wed, 19 Aug 2026 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164011; cv=none; b=BKtUcEGyFt2Q+pTpQ9emusQ5J/HEVs2gDeChQSlNuEjhJbuVBeknx/dWszPZqpLYd0hDKWcEPERiz79TCU9W4V+eueBbGaoxgtwyIyLv3lw1GNrHyjjt/QZeQwMuAjbF2k1LnSS6/kRfJCRD7IrqzNLuHGeKkZVN1xZ6qOUs0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164011; c=relaxed/simple;
	bh=n4xgh04VNRhDd3Lxub1x8Lx+z613LpWVMr3I7UdWN+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=li3UUeq5cG3lB4ZCB9cuL8j3kXSsj7VmMMOPGD7oOpilIGta3n9JtdQRgPBggKLtEehJIhJHtqQgHtBbYsfojiaCVNPSTy4XEOhlvg6GBPFWNOgHLEpDoIygE5+BTujdehsCM4edjk1kQ+c2ryTc0Kp9zd3NeSq3lRcAc/2tiok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcGQygRD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcGQygRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F531F000E9;
	Wed, 19 Aug 2026 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164010;
	bh=n4xgh04VNRhDd3Lxub1x8Lx+z613LpWVMr3I7UdWN+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fcGQygRDE5IKrvgDDMCENgEbS1dO3cniGI1e6lZsfUQv0DJq9ARaJ0Om7F2+Wt72S
	 5lAjkwtn1fvUtBAJXCebWe6phrzpkzUCEOD+FfzZOw0vK3blYnRL+pcvsqq4QEZWKx
	 oI5chh/oj1SfTGji59yITCfEJtbB+ZwqaV80JaI0axuFl/p5RA5UKwrtoTaT7o25sA
	 QdJOJj7VTyW1obbpeHEPHBVDaPOu2AOp/yIVkuaFvITdeXUp3joxFQfw0bFj/8B2qB
	 7GuaSdGcKGUa+cZNRU9NW+CWT942/WszOaiExlwPS3P6QPKdWSaZoE/Xw7rN+6ddxK
	 dWnk9GDYSoxhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 11/13] sysctl: unrandomize struct
 ctl_table.procname
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, bpf@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, mptcp@lists.linux.dev
In-Reply-To: <20260819-sysctl-module-aliases-v3-11-aab90569365d@igalia.com>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-11-aab90569365d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:26:49 +0000
Message-Id: <20260819182650.34F531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The 'struct ctl_table.procname' field (sysctl filename) cannot be accessed
> by scripts since it is defined in kernel headers (see "don't include kern=
el
> headers into userspace" in file2alias.c) and its offset may be randomized.
>=20
> Unrandomize '.procname' as the first field so its offset is always zero a=
nd
> match the 'struct ctl_table' symbol address, which can be found by script=
s.
>=20
> Originally-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-sysctl-mod=
ule-aliases-v3-0-aab90569365d@igalia.com?part=3D11

