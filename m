Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74038D3F4
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973113; cv=none; b=fB75K37Yhgiv0VyMg3DZBTS+8xJinLymOZ6WSnF+tSAXNSH5BEubVb1Yh7ngkLEZkgbCztS0SlU2usbZPsXMB2p0H7GBrsFh308ASr3fS1Ut58Ki0NKDDxWgBLRtqRdu78ls6/nMUC9XLIFlT+rzIsyg3XEnijMIIAXdnizdgWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973113; c=relaxed/simple;
	bh=8N8D0/a++jaonvplNRiDxV/LNd4OVfvLZCwmH9sLuC4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gTRJIG1m7AyGV+Y3ZTtJOvhLwIE7whH++Y2WK8a+c+MngoSOgiJl/GdUrZbhRwfjknt4hmI9c4iF7yjc7vQuz1Ai6Yjr3oR2HaxlYRm/KzmxtOv0JquS7mIfgvknb5sKGUIdH377zTahqqKywYlxdnrSMjZTOnkhbeXhORDegb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kvip8xTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kvip8xTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6211F000FF;
	Mon, 21 Sep 2026 06:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789973112;
	bh=8N8D0/a++jaonvplNRiDxV/LNd4OVfvLZCwmH9sLuC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kvip8xTmoDISYeMSNRoG405K/ceC70cpR3uU9m+TgWhoArw2MCZ8vLMc28uwTGW6v
	 COLLHjCNTiplR+vA7f0Ha77Tlx2jG62pPNurMiCs0sY7g7X/AumituDcW4nGUzE4we
	 X0X2J6V20t4p4roXJIJdSe2Dqn+e3qV3D1n/1Gtqmm4w1mOqCc/oDJNCpfuCobwfiE
	 E7av3WS2nEETGe1YogYlexsHhvN8Ejlnh+OW0w6G2hv8ufEmOKJzJYw8nOr9plrJ+2
	 myBQgVxcjrNQXC4w63d4g1C7z4RbZRqtCsPe9VNC4DlqPSgIxSFsbbSAtg9nppptya
	 osHJf5RNwYefg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] dma: swiotlb: Centralize minimal pool sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260921063628.362078-4-aneesh.kumar@kernel.org>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-4-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 06:45:11 +0000
Message-Id: <20260921064511.CB6211F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> A default SWIOTLB pool used only for unaligned kmalloc bouncing can be
> smaller than one required for limited DMA addressing. Arm64 and RISC-V
> currently implement this sizing independently, using 1 MiB of SWIOTLB
> space per GiB of RAM.
>=20
> The SWIOTLB core now identifies this case with SWIOTLB_POOL_MINIMAL.
> Size that policy in swiotlb_adjust_pool_size() and remove the
> architecture-specific adjustments.
>=20
> Explicit swiotlb=3D sizing remains unchanged because swiotlb_adjust_size()
> preserves a user-configured size.
>=20
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921063628.3620=
78-1-aneesh.kumar@kernel.org?part=3D3

