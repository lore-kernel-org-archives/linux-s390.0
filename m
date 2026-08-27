Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5CD4457BC
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832578; cv=none; b=tio2vW8mDCzfHrZ/lf3LL8MQBBfd9Em1xDsi1Pl2mNKwMrwe6ac9E55hiw2icFkX5oA1bMQ5HmyEIvvHMyizKB8/EUEHbNiKB6nUQBJx4i4GHYHaSsP0942Y12Q+qKq/EovQmJ5yOsewZ+76Hg4yx0y+9yP/7j1RWGZqL1aubJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832578; c=relaxed/simple;
	bh=xOh7XArIbiUnCf1vaACQeM2LLLFFLszBHq/wErXZI2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kLRKSldYQeQ9/N6pEsE6L+z5GQImD4XBOSje38FWJLVXjOp/pHZ3WjIgoCfiMedcLS5DHJGDIk+nw+3IVzg/pXFDx4dYtqsRROtnpCUc9N4/ZAOPu7f8iWlIFAIq+CTz70fcczXZ4vPDkJ2pZ7V5z/1+HBUlCpPX3CY06mrzgfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ/+gCBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ/+gCBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA311F000E9;
	Thu, 27 Aug 2026 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832576;
	bh=xOh7XArIbiUnCf1vaACQeM2LLLFFLszBHq/wErXZI2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TQ/+gCBcs9CmOl9dGFykv293ud4Fo8BK090R+8w2TI4s7enw1n79aroNCwWWGSNkQ
	 85pJUcEz0KkQYWFJbY4Gzoyb4GB4781P7p5wFdOPVVw9EUZzU/VvZjyexOKp5SnTYb
	 VRKUpLtq29gzpRQw0gSqmhAYKsAjTdefvefXOhL9qW3XmRuLnnpo4c+R/N805R2HZA
	 /cnPowESDYSxjTZQnbNSmffFUVgfqImSRMg8JDOpCdWvvTeahZt6cAWNvYF85TFBzD
	 EXAFkV5Km52HAp+wRuix2z20n5wD6gfrewsGTRPU5fs43yi4yHP/yGBRbE5uhGblz3
	 MCwzjiaH5DbfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] s390/boot: Bound command line facility ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vasily Gorbik" <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <p03-03.gfb54656967a2.ttkffvj@ub.hpns>
References: <c00-03.ttkffvj@ub.hpns> <p03-03.gfb54656967a2.ttkffvj@ub.hpns>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 12:09:35 +0000
Message-Id: <20260827120935.BBA311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The facilities and debug-alternative command line parsers iterate over
> inclusive numeric ranges. If a range ends at ULONG_MAX, incrementing the
> current value wraps to zero and the loop never terminates. Large finite
> out-of-range values also cause unnecessary early boot iterations even
> though the bitmap helpers ignore them.
>=20
> Stop each loop at the size of the bitmap it modifies. This preserves all
> meaningful range values while guaranteeing termination.
>=20
> Fixes: b5e804598d59 ("s390: allow overriding facilities via command line")
> Fixes: 15c33a5bc9b8 ("s390/alternatives: Add debug functionality")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/c00-03.ttkffvj@ub.h=
pns?part=3D3

