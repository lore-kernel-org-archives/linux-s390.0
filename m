Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B414EB85A;
	Fri, 18 Sep 2026 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750184; cv=none; b=LAZo1c4SeR3Ob8eOaJzoJ692oXgvMR03gRkE0f2LMKiMLyY+oypOU9mlz43bJ5aP2bFsbJvbOSbjz5l4L0Fy1GwGrUtm1XH2tVxjCSeK1WkYj/xyqMXHYiOHRbE7Oyozw0vhyq9De9CYyl9/wwFREcBCmSiwn5W2CCIVQwz9x5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750184; c=relaxed/simple;
	bh=DECoAcem1KjTSuaILmdFPgdXgzCZgomMAvQL4WwnFZI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lxf3PZvdf82AsqUaftDe7oifFnIi8E3u4RS9SQwHkAyS2tSCflakrk2TUZ+ZQk+y/oJ4cr7l9PofCrRWb8XxyCmrdOso1PaY1IKMLUI5ez3FHDok4ih3KHxWSzZP+ghiGEh29Uae0ABGqGKJb4INJx9mLa6VziBILyyAs74wPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db58IBJN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db58IBJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E5A1F000FF;
	Fri, 18 Sep 2026 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789750183;
	bh=DECoAcem1KjTSuaILmdFPgdXgzCZgomMAvQL4WwnFZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=db58IBJNlRYPpQAGHL3ksmoV0txnxSssl6QlZ5LZ7FWzuOx/bX2+zMSrJ939IHPhP
	 12hSMVR2ug07FCcnwRViIuQpqCjgYR3OauryLevbsu+otYq5tlj4MoYVODeEL+KFFW
	 x7m1GRu1dGwa2srlhZl8ull6yuHuAFV0e5zl2rdxN1WpQFmfkuoTdGdXfuGMkh6zq/
	 apnClKvRwmq8ZqncgxD8WDRZSLdXaRB5mOimfAhWctCtuID3VYMmNmBFcXC2EDnUxF
	 1fAsMidvsbAMfubwIpZpL3oI71d/HbOYiwz2vmDgnNCAvfJcCD5kKZYXYaSNcqVWjC
	 W3FO+0ygwucMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 22/29] s390/hwcaps: Report SAE support as hwcap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260918133107.1042730-23-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-23-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 16:49:41 +0000
Message-Id: <20260918164942.63E5A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Hendrik Brueckner <brueckner@linux.ibm.com>
>=20
> Report SAE support as hwcap (and /proc/cpuinfo)
>=20
> Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D22

