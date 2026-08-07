Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A03546CF;
	Fri,  7 Aug 2026 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142177; cv=none; b=qVuip7iuGB6CKJoqxV5Q4UL0davDrcrMbJ6+Q1RbXZxHNl4cjXJsTyXay4a4eo4f41qOliOm8rTVWQOchsqS3m7khe6fXDykOdFiC8iLF1alVpkbIZqCTsHRT3iiOdTH56b/6OeZPRYcr7YuawU2IwweLbL7bFEJzJwUc2w5xg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142177; c=relaxed/simple;
	bh=Z8BIcwzXNpoIjXUgWqwEcdzxLD7MbDjiIRg3GuMS8RE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gEXLn/F5WzFExc1nRurMk3sKqNoOUMIRKGT3VSWPggu9EMknxDqEMGe/7BUesPzbRO874ZyQ0aOAbMHff7rrqXChsMciWjN+Gw/DszAKFu/UVdZ8u/7ATCtTprALNWz5Hz9B/6qWxc3rJF/t0JDRRIoZuCSqHzFYqT0N5w2QxB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXSBtYh4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXSBtYh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EB51F000E9;
	Fri,  7 Aug 2026 22:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786142176;
	bh=Z8BIcwzXNpoIjXUgWqwEcdzxLD7MbDjiIRg3GuMS8RE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FXSBtYh4Z7ycGQplOH1TWr7E+z2XXtJEd9Qu+5hBywwiR+qSBzH64hE3li3V9mDAO
	 oT1YjA0jZIlPmqQDOyYJpDyzV5CxZxf9npypBFpszjVflSBB+ylItTqjy/ht7oFood
	 E6klpsW/Q+w6xaT7+fuwL0VIsZh/SrMVc4qkxvfnw48I7RYvb4EnOUayUAcNLy95Ij
	 79XZHgocDiqsb9D0kCzIx9dnR+eYRxJav56M8KD7H+VJaGS8rNNLTRBoNagRNz77XP
	 XQ9V8raZBjYwI0eu/DNMe+LDyAYWnx7rGJESdxLeR82op9l5T9AT+x50nHDGxoUbdS
	 SV8noFgMJkRBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/15] s390/vfio-ap: Add 'migratable' feature to
 sysfs 'features' attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260807221834.562851-15-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-15-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:36:15 +0000
Message-Id: <20260807223615.D2EB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add the 'migratable' feature to the features provided by the sysfs
> /sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
> of vfio devices is supported. Since live guest migration is not supported
> for SE guests, the 'migratable' feature will not be included when the
> feature attribute is displayed.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D14

