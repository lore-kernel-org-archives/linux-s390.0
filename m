Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5D0329E55;
	Thu, 13 Aug 2026 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786662200; cv=none; b=VoeaEATh7xWFxARogAFOEtIg/IbOciC1IaMQ2sNWxPDgFxAtCQySgjS/On7gQJx+XloPkgZjMkEMrd3uRkP3CNObJLbpjSbzLbZlR7E9tIJayIA1zDsdnwy9R61VUyJrwVKzRhy9q2MV1eyDBWcBuclxJsP77KERUMop4fvHx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786662200; c=relaxed/simple;
	bh=syMWGcz+ujfjAPeME/DLpnRtK21TSryRpQr2l5yVB/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=im4UF4c8MIFKgr6RGbfDxnrDv+dRH0+8Msgd+ZGZKlFduSF5sGSb1xRLy296q0h3au3Ag7JzivtWo3FlpvgseM4b6JRjlHcb5wDZx+O098Vra/OleB11GVKGsTmlBZTYuq5lN35+JXYpMASfgj9868bMpV/x/dRbx7/bS93x/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba4QfRiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba4QfRiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87491F000E9;
	Thu, 13 Aug 2026 23:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786662199;
	bh=bVtGflV63UhwOhybQadQ9fVabzrwDdQSHBSTFq57zFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ba4QfRiKp2IwE/G80O1GIPCrJg049MnivMt66il2UzmQSP+pR6rHwmZkJ1KFfcs+Z
	 nwkDl7+DxCNBhHr4gTcx+FVNnXXaHqxGw/kMZHgm0fkboEj/eCt9R6bgAr81ZzeX5v
	 NiB8Mtw8DjVeicW7VsokQ6FTBgz3nVr0gKS9hgT7iPtLx+1iC+ZtJqiJmqiz4vZAcq
	 Yjt1elHrvL+ugKmyaw+lwmC1qGnFJMv1yAGt+3pKwHMmka45924hxnOTm4jY11O99U
	 fZqjP/FyJvJ+DKlNZa9wB6H1BjuBlrPENK5bJILMwLRNuKrQO+4RnwDw/n1ZEcbXAl
	 XUAxwY3ZLbw8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/28] xor: move to lib/raid/
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-raid@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, dsterba@suse.cz, yukuai@fygo.io, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260327061704.3707577-6-hch@lst.de>
References: <20260327061704.3707577-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:03:13 +0000
Message-Id: <20260813230318.A87491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The MAINTAINERS file was not updated to reflect the new location of=
 the RAID XOR core code.
--

--- Patch [5]: [PATCH 05/28] xor: move to lib/raid/ ---
commit 521ed07e83a1bf1233d2291dd851539fa8fc5883
Author: Christoph Hellwig <hch@lst.de>

xor: move to lib/raid/

Move the RAID XOR code to lib/raid/ as it has nothing to do with the
crypto API.

[ ... ]

> diff --git a/crypto/xor.c b/lib/raid/xor/xor-core.c
> similarity index 100%
> rename from crypto/xor.c
> rename to lib/raid/xor/xor-core.c

[Severity: Low]
Should the MAINTAINERS file be updated to include the new directory?

Looking at the SOFTWARE RAID (Multiple Disks) SUPPORT section in MAINTAINER=
S,
it currently includes:

F:	include/uapi/linux/raid/
F:	lib/raid6/

The new lib/raid/xor/ directory is not covered by any maintainer entry. This
omission will cause scripts/get_maintainer.pl to fail to route future patch=
es
touching these files to the appropriate subsystem maintainers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260327061704.3707=
577-1-hch@lst.de?part=3D5
