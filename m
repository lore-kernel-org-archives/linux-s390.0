Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3191ABEBA;
	Mon, 18 Nov 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942193; cv=none; b=Kpzw64LXMsG0LPqwo2rb8BwDqwchvyCnqjeRKVnFNMTR/J9OR5GuNf3p9tJOAzs7YynTmNPsDVxmluRmNZtBZiFoLStcQnEFho3Ug8v1d1oV7vUSOkmvCic3B2aIJ3eHaCxbH9UY5rIp6lFNSZ/p0d2Ku2DrO6LrWMNiBMiX7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942193; c=relaxed/simple;
	bh=boi2kWZcFXn1Cqh2sijpEZUtPJc0dsQupk5k+Ae9Hvs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LUfcHQgnFuhjT53kYfCaDOg0aHt6xFoEKqOulhczAmmFPt16/PgkNytHPcsohvMPt+4Z68xlmGG7l04jI3JbESvNSK9EXEpWrNPQC7KQZXCLmTxNbTomf2fT5+f0H10xd0JtNTODsJPNfdglYr+cp9Iv3Qmxy4fL4TFl0aJvsoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Sn+IfcCQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Sn+IfcCQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731942187;
	bh=boi2kWZcFXn1Cqh2sijpEZUtPJc0dsQupk5k+Ae9Hvs=;
	h=From:Subject:Date:To:Cc:From;
	b=Sn+IfcCQSWEi9s1P7hgaX0mbdaYAz1WER/gh71/raMMqJVezGhuKLFSqkF6yxHpxZ
	 jocNYW+XMw7i9f9pRX9copGWGWQlFDwwChewT/3d4eaM2WGJBO7HsKOUJlwSL3TZqe
	 J6jdWgZr1PkuNveXhdgxEQmn9Xx398y/lTEuVg4Y=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] sysfs: treewide: Remove spurious NULL in
 attribute_group definition
Date: Mon, 18 Nov 2024 16:02:46 +0100
Message-Id: <20241118-sysfs-const-attribute_group-fixes-v1-0-48e0b0ad8cba@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABZXO2cC/x3MTQqDMBBA4avIrDtg/GnEqxQpMR3tbBKZSaQi3
 t3Q5ceDd4KSMCmM1QlCOyvHUGAeFfivCyshf4qhqZvOGDOgHroo+hg0oUtJeM6J3qvEvOHCP1J
 8knXW+q7u2x7KZxP6h7J5Tdd1A6E+lOxzAAAA
X-Change-ID: 20241118-sysfs-const-attribute_group-fixes-6e7a77c40535
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731942187; l=971;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=boi2kWZcFXn1Cqh2sijpEZUtPJc0dsQupk5k+Ae9Hvs=;
 b=Emn70sUKptVLprUGzrGhQIhMws5iTVsZsT6sIXqBblOAwgbP25Li6EdkgS3fIWtyLtapuXhcq
 0WwmEndaw1OCfYMU0kpVxuhdlIu4v6vaoH/X4hetb5kLc7ZybFfpgeX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Generated with the following coccinelle script:

virtual patch

	@@
	identifier ag, pattrs;
	@@

	  struct attribute_group ag = {
	    .attrs = pattrs,
	-   NULL
	  };

This series is meant to be applied through the driver-core tree.

See also:
https://lore.kernel.org/lkml/71fe4030-d6a1-47da-b8a7-28b899187168@t-8ch.de/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      perf: arm-ni: Remove spurious NULL in attribute_group definition
      s390/con3215: Remove spurious NULL in attribute_group definition
      cpu: Remove spurious NULL in attribute_group definition

 drivers/perf/arm-ni.c       | 1 -
 drivers/s390/char/con3215.c | 1 -
 kernel/cpu.c                | 3 ---
 3 files changed, 5 deletions(-)
---
base-commit: 5943c0dc7912210be1ab2732e0b663c1082ab543
change-id: 20241118-sysfs-const-attribute_group-fixes-6e7a77c40535

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

