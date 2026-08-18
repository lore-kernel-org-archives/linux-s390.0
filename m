Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35DF239E80
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787095397; cv=none; b=OcSmkRBKaYMgsVf7LQzLPCN/ct1cQaecDzWd3MA+FossSne3Wu06s/a8xR3zdUWSHTOf3JGwmn4CpxRowFu4HhrX7koHL+Cg8+qgOxJZGKaNyqq9/M2izgkZ3iDN8Hs+IH2XdfDVEF+ddy5FntqbbFKT9V5l4owV7/DzmwZmkMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787095397; c=relaxed/simple;
	bh=m/OUWnEvSebqd3L8nG+IHsD0fFmOely+Z0k0eJ10J4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Evw+trGjSxHAhNb7SiG4T/3MuxJ1FopGMsaFRzVC1ryztAUSPaQglkKVowtJd1lcKzt+3bJKtg/ikh6jCEt1NffltJATO5IN6kmqLV/QvUiKLxcwoqGyhWkz+0aXqi43Opw2fhZZTZmTP+5B7tryVCOvGvpsWk6Jx8KbmW9naJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohVLzluA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohVLzluA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F631F000E9;
	Tue, 18 Aug 2026 23:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787095395;
	bh=m/OUWnEvSebqd3L8nG+IHsD0fFmOely+Z0k0eJ10J4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ohVLzluAVT+0CE2HvaA9drYYXswCWVVq/N2m42tbzZ1NYxf58nLRr30b7ItbNHXIU
	 rvRXnoXeDlEODpxp0C79UUPQ3NGkybVjUPhzRbLnSUfy4CjgA/SJulX8KQ3Jxm0rV/
	 nhPdDNSMrFppnsW6zxrSUgVAVj3mprRx+u7MgWMnhd9XShSHQ742dcVkU/NccwkNAq
	 1SibimJrOMuFo7FnO6m6INEG1Xq5zYSAs6fmI5RtsJI5yUZfyx2SJqJzNI/huJV3zc
	 mrdnnyaq0Aw56DA2IJX3xeVaMG80safDMSAh4ht2hBOvyOl1wd87f8QnC/jUso9TpP
	 6asdPA+LJv0ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] init, arch: make CONFIG_COMMAND_LINE_SIZE
 globally configurable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wilson Felipe Pereira" <wfelipe@google.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818231646.804507-2-wfelipe@google.com>
References: <20260818231646.804507-1-wfelipe@google.com>
 <20260818231646.804507-2-wfelipe@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 23:23:15 +0000
Message-Id: <20260818232315.99F631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Currently, s390 has the ability to configure the maximum kernel command
> line size via Kconfig (CONFIG_COMMAND_LINE_SIZE). Other architectures
> define a hardcoded COMMAND_LINE_SIZE macro in their setup.h headers.
>=20
> In some use cases, such as netboot kernels, rootfs configurations, or
> larger initramfs setups, a larger command line size is required. While
> for embedded workloads, it can be reduced to save memory.
>=20
> Move CONFIG_COMMAND_LINE_SIZE out of arch/s390/Kconfig and into
> init/Kconfig under General setup, and update every architecture's setup.h
> header to define COMMAND_LINE_SIZE as CONFIG_COMMAND_LINE_SIZE.
>=20
> For user-space API (uapi) headers, wrap the definition in an
> `#ifdef __KERNEL__` guard and retain the historical hardcoded default in
> the `#else` block. When user-space headers are installed via
> [ ... ]
> architectures are capped at 4096 bytes to prevent unreasonable
> allocations.
>=20
> Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> Signed-off-by: Wilson Felipe Pereira <wfelipe@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818231646.8045=
07-1-wfelipe@google.com?part=3D1

