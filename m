Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792535628;
	b=vKacVFBS8veRBlHlPmzbMJamrdt5Ai1SUhtxupQT90f+jb8XELj8+xXCPrlOc0TGIwXB
	 vQmDELtkPSLiVixQlBmVwu4j9bN6fiFDMIrAVRQAUMg8PL4rKUL0JCfbn3dI/H4jIlb09
	 9FGoQxQBv4WtIt45RqYTLQd0peAopvyPoDuC3e9tT20WImWfKBUkCKnOA+4/PounD+kjT
	 kwV2ZyGo0hL9KSIA04ncKhTg9nGmIsTTf2BlcFa1LmM05GZMKHClk0C5KltkcZfti5sja
	 k6smrkWqPOi/trqn6H3hoUFpiKDrkrpTDdWmSnnN+UYpJ56qO5nZN2T2dZd5w6+litQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535628;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OBGyn+Lz/XTtHyU5kB7rncGw2+C6heJccoZJeCMXbck=;
	b=FMh+YKDQQdOziXD8tO/WzcsWt7UXQkyXTNhCdHRUhGUJk6CNlbMEA/NS1HzkqaFxxhGb
	 K6/b4QjzCDp5NWRe3rilbc8zv0gIfHa20aUwwIFYCg6w4PYSQkvxY3kLqs0i06ZXfia0H
	 E/zdZ+XTC3HgeuvteA60NKWxoneV6iHtzM/+Rvpz7ase3a/y8ewfU6ZAfu4JGEp16gCHk
	 EuDJYoNL1/rRlXGOZdVDUA9iU3Dr2O8d5A3GwUHlmJOxbSZ1/HREJqiiYxcsd9+9x04xX
	 BDruvkk3WSoiDnVp4lLGN61zuzb54kzzJmgh07L6+7Wx9mOUkFGt6CsDcx7iTC92O8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9H4ekc2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2EE606A319
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9H4ekc2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F831F000C9;
	Tue, 20 Oct 2026 22:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792535628;
	bh=OBGyn+Lz/XTtHyU5kB7rncGw2+C6heJccoZJeCMXbck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k9H4ekc2jaS8sxyLBNCPTSZSLkqSw2M5u1KdcTJOCxkpZMEgk9LTBd6+3A+Czi6LX
	 yI26BewyqZT/3LosFWGHcgpaTPtvp5LAcCN1nSe5GNcePhdhjzkIaSXfWiKpnxioBS
	 a9Z/YHhfNz+xQ36jq+UutfNVkH7XmhfwL08o2flM5So6S6FM5DCjkoq7zP7fn9Wf9f
	 lk8E8PbK1U+i6V1pfyZScnNDZ8QmJPYVV1yeqCDqw0+7MU/P8Z5Itu/winZf9CqkaJ
	 aOqFRzc+TvxZwNv+X+0Siag307TCbXapbtzlWVuT4ERlVCg7QcAua/XMV3/pFHcoR+
	 5LNtI2cr6wq6w==
Message-ID: <sashiko-outbox-179533@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/5] s390/pci: Fence FMB enable/disable via debugfs
 for passthrough devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261020212427.2561-5-oelghoul@linux.ibm.com>
References: <20261020212427.2561-1-oelghoul@linux.ibm.com>
 <20261020212427.2561-5-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 22:33:47 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Introduce a fence over enabling or disabling FMB via debugfs when the zPCI
> device is associated with a KVM. This will prevent processes on the host
> from tampering with the FMB while the guest is still using it, which may
> cause partial counter resets and inconsistent reads which have no parallel
> in the architecture.
>=20
> For VFIO devices that are not associated with a KVM (i.e., for userspace
> drivers other than QEMU), this fence does not take effect.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020212427.2561=
-1-oelghoul@linux.ibm.com?part=3D4

