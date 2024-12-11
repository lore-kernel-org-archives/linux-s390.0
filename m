Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E31FF1CB;
	Wed, 11 Dec 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939683; cv=none; b=cgvIJtb6V1Udnx1AFLGRUQVqtuPe8/x5j534Fm7/9UlumcWn5Z+75qxziD2vPAIbNHauKe8d148dl26gXLaer8Jzl66ZIzXkhafwq3hBKfTAZIqwJw6Pg3tjsxp6576zk1VWYrWiwgREefpoQ64zVVwHX66rB0HFGTBY7+GqvbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939683; c=relaxed/simple;
	bh=a+k4hV2xTJ37p8HqssBx9OAk45I4nz4hnYFF9s1nuKY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kyGIYfPp35UkBmFjag/u9Z/DGRbv1joRJ6/xwf6xpM+DO8MUZwNODG/yQ2j5wwsiRcWhj4+Rb4AGE/otKi0EE0utVC3ZLHBbUxmcf30hgUcWqo6hP02byT2aisWUzA9MFLtGD6qPqa4feGib04auonz77H4MVVlRNkfdkhfqWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=f9z8sX2j; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="f9z8sX2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939680;
	bh=a+k4hV2xTJ37p8HqssBx9OAk45I4nz4hnYFF9s1nuKY=;
	h=From:Subject:Date:To:Cc:From;
	b=f9z8sX2j0pCWggWWbG7IlwRYOuZPOUTMR1iZCaRaSEn/6cR82zjpNtikHJqHgdyMC
	 cPYNIVzUW9k966KiJaNznrtcrhrsBRtyQI/XNqo0Gz1Xgj1y8eyt8bA9jcaew1RyhX
	 zOgzfai3XrZrzsRhSLPr/E2crYDs1tQWpRr4XS/w=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] s390: Constify 'struct bin_attribute'
Date: Wed, 11 Dec 2024 18:54:38 +0100
Message-Id: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN7RWWcC/x3MQQqEMAxA0atI1gZsdWG8yiBSa6rZ1KEpooh3t
 7h8i/9vUE7CCkN1Q+JDVPZYYOoK/ObiyihLMdjGdsYag3ppUPR71IyzxMnlnFBbajD01JEjbsn
 PUPp/4iDn9/6Nz/MCPFlBK2sAAAA=
X-Change-ID: 20241211-sysfs-const-bin_attr-s390-f8949a9e39cb
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Niklas Schnelle <schnelle@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Holger Dengler <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939680; l=1267;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=a+k4hV2xTJ37p8HqssBx9OAk45I4nz4hnYFF9s1nuKY=;
 b=Ef4k7XzU2jzhW1+B22pe8RtnDVYkpIlwAtlAk/68VjlyDMlVOOgDbtp6O/QhGpIn+Khtah4kk
 lsO51Auh8/eDZqisTYTyCpYDCqHsgiPYhbOWNWP0iwuHiaSxLftdMqd
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

drivers/s390/cio/chp.c is handled in [0].

[0] https://lore.kernel.org/lkml/20241205-sysfs-const-bin_attr-groups_macro-v1-1-ac5e855031e8@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      s390/crypto/cpacf: Constify 'struct bin_attribute'
      s390/ipl: Constify 'struct bin_attribute'
      s390/pci: Constify 'struct bin_attribute'
      s390/sclp: Constify 'struct bin_attribute'
      s390/pkey: Constify 'struct bin_attribute'

 arch/s390/kernel/cpacf.c         |  36 +++++-----
 arch/s390/kernel/ipl.c           | 142 +++++++++++++++++++--------------------
 arch/s390/pci/pci_sysfs.c        |  12 ++--
 drivers/s390/char/sclp_config.c  |   4 +-
 drivers/s390/char/sclp_sd.c      |   4 +-
 drivers/s390/crypto/pkey_sysfs.c | 128 +++++++++++++++++------------------
 6 files changed, 163 insertions(+), 163 deletions(-)
---
base-commit: f92f4749861b06fed908d336b4dee1326003291b
change-id: 20241211-sysfs-const-bin_attr-s390-f8949a9e39cb

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

