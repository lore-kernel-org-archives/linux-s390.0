Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586263B2D24
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944442; cv=none; b=LwRPgrN+6sglsZ5nO2GT5O6X5Ons52rxSfuND6SP57bFcAjR2Fpu1i7lcbKn+Mv9cSlUDOQNXxAotvQuVBuZU7PRanGdHAvHW4y8sY4zxJw51UZZwFCGSadGofO7m/07eLnkek73K6g86789w9ynJlocdd9y0eyJTRj+dLHjEsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944442; c=relaxed/simple;
	bh=ph4Q4pGDuJdiyKby4LJD+lHpC+McpYJfgd8sSJCedFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vnmkus6NcDFuoymWTk9RjpZiyR3u1592Zndg8S14D4g8QD5eCEyudU6cupA5NgoeWsF56hf334gM9+lZ+7zfRQlBonpc6+SRJ1XBUliub8sdqFHpcjhJcSAi9vKCSVTa+ITfRDceo3rCuCV7kS93tT8BkOGKFSRvX5Ez5ouTI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRcrW0bK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRcrW0bK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ABE1F00A3E;
	Wed,  9 Sep 2026 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944440;
	bh=ph4Q4pGDuJdiyKby4LJD+lHpC+McpYJfgd8sSJCedFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MRcrW0bK7IME9LE+52OiAOOUkyu6TxENbly6wUsGayOYT6OnVMQ3qifNH2shpbAJC
	 9WbJtGpwFMzxRGzlil2+TqszxdMHqamasW9fXlICkLI8COJV+PImGFA2usk8NEK4ar
	 1oSQULE+jIVE1zVg2ti8sN3ek1YDvryCJjAKyPFEATKBijZD7pWZHEkGto55QHyKgV
	 i0PNYT5cXtKZ0226NzVeHhpl3sVAl5romciVo03v7ToDJWO1OIF1Dv1EDYCh2fe2/Z
	 UZ7rBkoqNtpcUlzMEyHV+YlewcU+ffTX0zDCByrgHThS7dEhDX/FThCjfgMsY3hNED
	 vIyr8fspEsuNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] vdso: Remove __ASSEMBLER__ guards from vsyscall.h
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-15-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-15-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:00:38 +0000
Message-Id: <20260909090039.27ABE1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> These headers are only used from regular C code.
>=20
> Remove the unnecessary guards.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D15

