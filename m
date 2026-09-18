Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3A23AAF4F
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721652; cv=none; b=nQZCxFOm3qV55mef+a5d0QBZxd4deKPZjUEwUaWdPWB03UHoW9qcsyWY6mBi+adG/JYVRU0b94ExLF9DxrhjO5Z0z9AdlYS5SYCCoW7k/hB1wLfg8CV0N/q9g2NRLqiTgywu8CWr3QqB0DNeA7plSfz69kUPhqxfLq1dDI3ihxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721652; c=relaxed/simple;
	bh=/oIma8qAuD1QShijeIS/ji6tGHSb17xeqk39HtJKKb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NDwi1xNjCOm+Wb1HHpKfFBr634a3MRt02NrhSyHkvgHbHD/Sck4Fp2BPKPHg+rPtd3FzKX9Y59NEz3tNv8u76vxxtIShGnrbK9+Keijaqd621wou2N/5T2Kpz1KX64w7Qz+63vg55mpfQ3FlIWpNyqIx7sYkOun107xR4s8YT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZMumubH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZMumubH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E193E1F000FF;
	Fri, 18 Sep 2026 08:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721651;
	bh=/oIma8qAuD1QShijeIS/ji6tGHSb17xeqk39HtJKKb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jZMumubH2Mz3s0QjCtYTtlS6n1c8Us4GW0WIzJHd5NBHDVjBBE20PxR57HCd4JtRX
	 Kr7etk/vNtbf96WXxKk6kJGVG7HKV3SgZnzuPUYO5aSKoqMrvqUABMDM5vxsPYEXFN
	 hhPTXvSAG0vROfXyyiErPpMEEu1uqCglbsXoyU3x6aASlxA0VXCd/1675Zb0r1KN+1
	 dOJlTxDbFvVRQvF+YQ/3tDgkWINB8prSyq4lUkUkkfPPRR1ipmYZwYbydySuaWlADC
	 I2Vh7xahHzN2ASqpVf8QBwL4eyD4nTNy1K/8H9N3YI4AjSqNCOkoBT+AFeQcTPpWYP
	 X9Qsiuz0kh/uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/12] s390/percpu: Add sanity check to GEN_MVIY
 macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260918084842.2333237-3-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:54:10 +0000
Message-Id: <20260918085410.E193E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Emit an error if the GEN_MVIY macro fails to parse the passed register
> string. This will make it more obvious if something similar which was
> fixed with [1] happens again.
>=20
> [1] commit 101782f8945a ("s390/percpu: Fix MVIY_PERCPU() with older binut=
ils")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918084842.2333=
237-1-hca@linux.ibm.com?part=3D2

