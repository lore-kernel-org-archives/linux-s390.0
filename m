Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F447ECF9
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202676; cv=none; b=gHbLlc8QHyGTS945liqHqahLhE/XQ34tCL+YRL8k/3gh8SpUY12XosLwcanrXQqw+Gkv8plZmq/uB9g0ourfyS32Y7uzS5P24DkaqexZMi5dBoC0p6NkSM5QXfzy3iiF+ObDCHJpaEzOaqWHr7Anh80iaFj2G1gNsefxAdnchPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202676; c=relaxed/simple;
	bh=SuvS3Lo5oVw4uFY8CUv/WceMYBfeYJ62K+BXRYpi5U0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h8FKmOPS3fygTmsRQKi1ap2JIUDX/x1PAKNV0kkBrahmb0DBCFrqJMD/ee+rIqCg4sPPvtExuzdDqcDA6OYDN/wKtjeS8hPtJOp7hdBfCLydeZVzdJ/DH72oAo2NMO+Nf9owUxyT6uunGxyRYd9162aT25uCBQfOXSOl6KIiTeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9JHeAlS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9JHeAlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361BC1F000FF;
	Mon,  5 Oct 2026 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791202675;
	bh=SuvS3Lo5oVw4uFY8CUv/WceMYBfeYJ62K+BXRYpi5U0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T9JHeAlSpqkYorS8Zk5NQxHomHgJ5v5TVRfuHD9PMETeYbfux4q0xSl5lZoza/Cqo
	 uL0+IUFlynEfQaPdXGg7nYuL4MLH26IVkZ4tOFgAKsG7Yc771+qThSrPbtbk2RMdwe
	 FQRAtOqJNAm8SQDVcL5858R/nfPcZsOpBdRimoZ4RFCa5OPp1twA7Xhj9jN10xgq+J
	 Zf7bdz17F+yFnmPKzXbEbWcowG73cPGK7F2CwmyIcWFTxczE7afmeQGf92UT8qFnk9
	 oWmbA7FjHX3JR2gDy8VfvvCv2CSV9pKtVwY5T6i9SVgozhAex9GjJoddNSqVe6Ih01
	 ZGAofetRme7Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] s390/pci: Fix resource leak in zpci MSI setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261005-s390_irq_domain_fixes-v2-2-d45b824874c0@linux.ibm.com>
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
 <20261005-s390_irq_domain_fixes-v2-2-d45b824874c0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:17:54 +0000
Message-Id: <20261005121755.361BC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If airq_iv_create() fails in __alloc_airq(), the zpci_sbv bit allocated
> by airq_iv_alloc_bit() is never freed. This permanently leaks one of the
> ZPCI_NR_DEVICES summary bits, reducing system capacity with each failed
> device hotplug. In systems with repeated device insertion failures or
> under memory pressure, all summary bits can be exhausted, preventing new
> PCI devices from being added until reboot.
>=20
> Add proper error handling to free the zpci_sbv bit and reset zdev->aisb
> if the AIBV creation fails.
>=20
> Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-s390_irq_d=
omain_fixes-v2-0-d45b824874c0@linux.ibm.com?part=3D2

