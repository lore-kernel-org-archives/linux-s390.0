Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0327C31AF07
	for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2026 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101309; cv=none; b=oqrm7kxZlHduc2lXIgT9kWDOqPTf8Vr5aX8+iB+/4xZ8ULY80jyodwL8uKM/oiXP+yNAA0Ztny1bsA7i4oVXbVgxHNQexB/xwp/nBupt166QvqH3YEN1n/4mC+f1uPUq8gRBOZDUXdzuCttNN+F3SJKHEcunJ3QkmPHNE4hzE8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101309; c=relaxed/simple;
	bh=corx6aDMNeoBJ131aiv/wrqzHkJMcBZGF7fsTi4jxnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lhLYZ1XJsZodvqFsLEWdHJvusFRUa/oV5gkgDxBz+b11BThgvr82RRD5Oy6UB36bRxCYokTHU8wFGQHeEKZCWVPM8qZX53ecYbSEteJKuu/jcQftETApDGniuSevtq7+Bg5Th8yvNCSgpy2p0J46k5lVByC2ueyUsd0WLy8Vqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWRr5mgb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWRr5mgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5352C1F00898;
	Wed, 10 Jun 2026 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781101307;
	bh=4bcRm34Lagjt0lrDpXxT+Dz6Pk+1GGV3nz2pscBQ/jI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BWRr5mgbrqZL3csnzWZlsygmgHPe7Yra6fVA3VuWga8cLdx5hjxHqHACDaQuQzfYJ
	 5nD8vA/1GDJvXLVChWwWWMYy9xrCoyz8dVohfK1uGqyvObtwEwmuzYi97m+yLoPCD/
	 kxxWjhFz99kQ5bqRPDaTNU8HHap1Ee4wnIx2XzpFlZq5Lyak0oyRRSoNmECGVzDvfp
	 Uwk7/bNkIHUx0Ovro9bPmbaAaAlEsoQga8hPSxBKZtW2wVk1+y86OqPx+234yKyWR6
	 NmNl/4+ULuZDcEaAt/gjrth7yaTG+ArJRYII6u7NAxjQgpoMjcTU1xcpzAOVGS/Ttr
	 smej5/jLvir5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/2] tls: remove tls_toe and the related driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sabrina Dubroca" <sd@queasysnail.net>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <c3c9ae09580a5c1d36b32b5ab3a5db398feddfe3.1781013810.git.sd@queasysnail.net>
References: <c3c9ae09580a5c1d36b32b5ab3a5db398feddfe3.1781013810.git.sd@queasysnail.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 14:21:46 +0000
Message-Id: <20260610142147.5352C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete removal of the `tls_toe` feature leaves behind dangling =
feature flags (`NETIF_F_HW_TLS_RECORD`) and upper layer driver references (=
`CXGB4_ULD_TLS`), leading to dead code and false feature advertisement to u=
serspace.
--

commit 9a055c5cc4ab72cb186cfa373957ed0d0080f2d2
Author: Sabrina Dubroca <sd@queasysnail.net>

tls: remove tls_toe and the related driver

This patch removes the unmaintained tls_toe feature and its single user,
the chelsio chtls driver. It removes the related documentation, Kconfig
options, and source files.

> diff --git a/net/tls/Kconfig b/net/tls/Kconfig
> index a25bf57f26738..4f4d5973a28f4 100644
> --- a/net/tls/Kconfig
> +++ b/net/tls/Kconfig
> @@ -27,13 +27,3 @@ config TLS_DEVICE
>  	Enable kernel support for HW offload of the TLS protocol.
> =20
>  	If unsure, say N.
> -
> -config TLS_TOE
> -	bool "Transport Layer Security TCP stack bypass"
> -	depends on TLS
> -	default n
> -	help
> -	Enable kernel support for legacy HW offload of the TLS protocol,
> -	which is incompatible with the Linux networking stack semantics.
> -
> -	If unsure, say N.

[Severity: Low]
Since this removes the tls_toe feature and the chtls driver, should we also
clean up the remaining references to the hardware TLS record offload?

For example, the feature bit NETIF_F_HW_TLS_RECORD_BIT is still present in
include/linux/netdev_features.h, and its corresponding ethtool string=20
"tls-hw-record" remains in net/ethtool/common.c.

Also, the cxgb4 driver still unconditionally adds NETIF_F_HW_TLS_RECORD to
netdev->hw_features in cxgb4_main.c:init_one(), which could lead to devices
falsely advertising this removed capability to userspace.

Additionally, CXGB4_ULD_TLS is left behind in enum cxgb4_uld
(drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h), and there is dead code
processing it in drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
inside sge_qinfo_show() and in drivers/net/ethernet/chelsio/cxgb4/cudbg_lib=
.h
inside cudbg_uld_rxq_to_qtype().

Could these leftovers be removed as well to complete the cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781013810.gi=
t.sd@queasysnail.net?part=3D1
