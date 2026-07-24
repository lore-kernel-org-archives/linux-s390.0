Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DDC3812DB
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784891138; cv=none; b=BDWmUaxK9zWx00NFOmiVqQsb2VTjk3DxhMSHU+gMvUrnXjjRmGW4UsUz7K64bewk4Qn5H3YVvoK5D8dxUE+dnBDz+wdOP2D8bM3Gc36aIWcP3o/T+F2WXj7iWgamayaTdEUEo+Jy3q+Fgn9UL8FIBeKO1+wErg8CNImS5aQ7L1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784891138; c=relaxed/simple;
	bh=p85OlIoOhyQBaALtVBjgPbmZHMCuTiXnsjI3WLwwxE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mVcFVmyMQdDnJWCPwhzxcJLSObLafodP4el7J/aPsLbABDxvuvXbtuH+aaL1dk+eGIwCeYCJY+uTt4SgF5BAUjPxK392wRUCrOpni26VKy3nX81VcJsT9DweltzuyowFhGd5jMspQh7osKZsVSPoISQR0yGMyQFqS0pqtWVs87w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfUz6O6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfUz6O6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BF11F031D8;
	Fri, 24 Jul 2026 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784891136;
	bh=okA/Ise7DoMO9vuKz3S8mLBuQ2zpaXql/yCgn1pUV4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DfUz6O6QBmwdIdRDqk5w9BstoZDL3WX8QCPZ996NEd/wQnJKtrOOmgi5EbVGy7BVW
	 VcQtbEeS70EXOf1r0HE75OS1El21mH1Ob6JtFlkow5+o3jfqsPwoap3vpoIbL97chG
	 VM9l7/45bii5RjkBfMoRkn2R8u1qmhmYylcXEwYmDVN/ux53G4kIvo95hogxlJus7S
	 HWVJTRUHDAxAcKJijGI14ywo9jE68MG+Wujml94/0vtDxHET4WhLJ/Nc9LAZW6nF6G
	 D4Zm+6bSfRjENKhJPgFGTSdoMm7cLy/I0SUK5SDF9x2/z2NW9cwEWQ124xeyVyD0Wl
	 QY2sdVvEabnCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] s390/kvm: Add tracepoint for DIAG 9c directed
 yield operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciunas Bennett" <ciunas@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260724103959.14861-3-ciunas@linux.ibm.com>
References: <20260724103959.14861-1-ciunas@linux.ibm.com>
 <20260724103959.14861-3-ciunas@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 11:05:35 +0000
Message-Id: <20260724110535.B7BF11F031D8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add a new tracepoint, kvm_s390_diag_9c, to provide visibility into
> directed yield operations. The tracepoint records:
>=20
>   - Source vCPU context via the standard vCPU tracepoint fields
>   - Target vCPU ID
>   - Target physical CPU number
>   - Operation result (done, ignored, or yield forwarded)
>=20
> This improves observability of vCPU scheduling behaviour and helps
> diagnose performance issues related to directed yields in virtualised
> s390 environments.
>=20
> Signed-off-by: Ciunas Bennett <ciunas@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724103959.1486=
1-1-ciunas@linux.ibm.com?part=3D2

