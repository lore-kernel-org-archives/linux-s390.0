Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F237F308;
	Fri, 24 Jul 2026 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784918314; cv=none; b=ibiTO3Wg12vkYljw44wX/AG2QcmMnbVQbNPU0dmi6JhHpoDirZ1i3OtNmLbQh28zfb6LixOY8sjSk7McU+8RbYPnaza26xkkT+LW3+nP/AIO7mNgVk6/mkuF00SYtB7ChAVlUVz32n1ZU9II3BovEP9ZkXaSTOdjcGS6JmrOVec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784918314; c=relaxed/simple;
	bh=NnYUaHSfGbt3zysy7yXOiF0KNabynj9DoqXcYD7yiD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WkbXNFaV14IAbn7bdtCI3w860akJ+RVDIYpB5orzzc5zbXL1Hmo6fek5wjcaI+kJg45O8zU7dh2jDBsqx/1AAhhL3NCWladEJxBbOUzd/92r03ulOYxDF1BQAIUgmi5zKTLlQ0vRhCnt58kglOf/qpCyO0jT0Q8PxV6YetyJHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHGLqn9T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHGLqn9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190FF1F00A3F;
	Fri, 24 Jul 2026 18:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784918313;
	bh=NnYUaHSfGbt3zysy7yXOiF0KNabynj9DoqXcYD7yiD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GHGLqn9T2zQ9nZm5pKwfxrlV770DCNSZVD10n/aGh9G1fA8w2Y4mCCbmHn/ybpzks
	 Pmb22BmIPS21JWOkWoV63QyuaX0eEpVs3f1uF+cXwCtDdJA8lf7ev3rKptP9XWRsQ0
	 eAEJ/IUm8qo43fP4SOZ2HlnsGQ11cxVyETxTrrVcPHimV4GX+l0YdappHhilLwpoih
	 dypR/oCxbwd8K82EyqwtQxAKy+SRGGBUJx+cAbsWv62OZ98AC+/o6TwB2y924F6tG9
	 qhtORVapzq/wgzvf2h77TKd20/naSGOEFp//G8utrcEs5/4LbbgrpI0ZCEVBthD7sr
	 DZqi+I8AzJwMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/15] s390/vfio-ap: Add live guest migration chapter
 to vfio-ap.rst
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260724161351.1802644-16-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-16-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:38:32 +0000
Message-Id: <20260724183833.190FF1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add a 'Live Guest Migration' chapter to the
> Documentation/arch/s390/vfio-ap.rst document to describe the details for
> initiating live guest migration for a guest to which AP adapters, domains
> and control domains have been passed through.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D15

