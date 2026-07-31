Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7C430C371
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517573; cv=none; b=suOfJReh5XN4QX8A2FxMNlHDnx6qJTZCFov0fQmv3zWrCYyf5kvvEOYaUOLnGBMyVfRBMKWJZQcNRbYhhTkiAmMlyN/yXX4lEe5Jz8xJurbkOfsHffNfFGUmwAXk2AfrXuzD53KdfeWUGXzUw4CetXzhY3IZXWvniv2ZZ+IRIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517573; c=relaxed/simple;
	bh=aYo5lnEp61VGDsqCz37fDLk6/+oAbR1nC+9Fj4soVao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pcjzU9Z5iLo2OPz456j0Ccr+uciFpVu3/9WydXfq/PSmcfusV2uYCHSLoPivIBxPkUEqPYJ86ReWAU5zWKkvts5wGF5lkSaMlAfEq3HfGUzU0wmWWI8VSMBWw5G819Dz2nRQANvJIJBE6JFy8Hq+PFkjOZkHn9cDB2OhyhQf8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0QmnZLT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0QmnZLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82901F00AC4;
	Fri, 31 Jul 2026 17:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517572;
	bh=aYo5lnEp61VGDsqCz37fDLk6/+oAbR1nC+9Fj4soVao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K0QmnZLTQ+d/AwR1lHS4Pi8aT0SILAAB+pi6naC6VD5wzabjkoqwWynp7ASpr20uH
	 hE4wihBuJWiOyRtt/r14Nxrld9WkoBn9dS4MgDfme0gDpU7MrBvRDTpufnPH/g4V1T
	 1oouCJk/zr2Ww+aPHvEtCieK6o2r6FSfzi4semM0aUmQClyWhy03Z8cD3luhS3u05x
	 Chxk8RSTQZ5V/HUKzkXELedNfzavRJWE3Zrdj9HmaYh2YHc34aReGujcgw1A0HnnbK
	 D3TLdRWK4BSZLigbyhPgpgTWJROV1Mjnozwv0iOE2I2zmOtuToo1xdH+4/SBu5dcrU
	 U/uus5hhk7+Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] s390/crypto: Replace cond_resched() with
 msleep(1)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731165004.2758105-2-hca@linux.ibm.com>
References: <20260731165004.2758105-1-hca@linux.ibm.com>
 <20260731165004.2758105-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 17:06:11 +0000
Message-Id: <20260731170611.A82901F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Peter Zijlstra <peterz@infradead.org>
>=20
> With [1] cond_resched() is always compiled away and becomes a no-op.
>=20
> The comments for all cond_resched() calls in crypto code however indicate
> that the current process should be scheduled away to avoid instant
> re-invocation of a callback. This is not what cond_resched() would do or
> did.
>=20
> Instead of just removing the cond_resched() calls, replace them with
> msleep() calls, as suggested by Holger Dengler. This forces the current
> task to be scheduled away (sleeps) like originally intended.
>=20
> Holger provided information why this intended [2]:
> "
> [ ... ]
>=20
> [hca@linux.ibm.com: took Peter's patch [3] and provided commit message]
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731165004.2758=
105-1-hca@linux.ibm.com?part=3D1

