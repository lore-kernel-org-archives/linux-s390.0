Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3CC48E0FA
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944218; cv=none; b=KBXlWvoQhOHNtKr7x0m/FdFHiMTBbjn0JZzWPoUJZDvVREKtmPwio6eDCQYL4I9cwd/aNlVTp2/fy5ZsBiAaTXqMV3dqsk5rNRb9LloH6E2uFQZRjmlT1rmwXKCVjzEreWgJEDD6gEdLyQ/5j7n5EFyX9NOxNwZWtjN8BNuxIvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944218; c=relaxed/simple;
	bh=LBQQzTGzws2VvRI6OKls8q58iQN/e+4db+rCpOXzgaM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f0xanA13cvh29C0Q5SFh5zYE5drLEo4D/yiS6Lq07ySKBMDi/5tnbAsPJ574NeYB1RMkOyZbBX6Vk6rcBJmPkaYhicQC6Zrh2nAWqghtObv0AbdmmzCLMefE8xuLTWUDNSu89v0cUzvZLi6LITmCY7Xhk/P4/QKLnwdEVE4wgA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyqUdQuQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyqUdQuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CA81F00A3E;
	Wed,  9 Sep 2026 08:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944217;
	bh=LBQQzTGzws2VvRI6OKls8q58iQN/e+4db+rCpOXzgaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IyqUdQuQFCcYmvFWUNMu+4SXuu83BkNI8hWF5JfahQxcMZqtUkjP+MXN4D3eQI9dZ
	 yYFY9b2zGImGN+R8cgQxq8I5aH8efkcy++F5cJQPU7wINeKxhymq2N2yUEBcrLOkNu
	 ZwfbMKpBjcr81Kg87Sf93Jh7Dyc3sEjF++UgG25o1DDHqaavdfCmq+ciChuUim5INi
	 ZKTaHaK8TVhIFYQsTEYMPn7KleZqoPZi0ac9jmbqXvXTY17p/Om3k2qdQT8xfmNEg2
	 V52O7MmDC7VI3uo1oh7HxGWmcej8q5z0c2fWkTKqOrQjUBGql3J5zBsVGbCTAf4WLO
	 WNxrKLDy6Nxwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/15] s390/vdso: Delete asm/vdso/vsyscall.h inclusions
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-8-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-8-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:56:56 +0000
Message-Id: <20260909085656.E5CA81F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The inclusions are unnecessary, remove them.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D8

