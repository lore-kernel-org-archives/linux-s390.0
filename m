Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69D84A2F;
	Mon, 14 Oct 2024 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885029; cv=none; b=nwakcY3ix+L8z0TCRp+HOFHpBkAPRIzAM94uFLrpRdKwUrI3x1ZduXFp5jbzLMz71wFLkwEo49EMcbNhLsNjdb+2g4N3B1Heravt8lsMDUELGAUWQorGSwSHsk3vin5OFfp+6u2yqcxRYq+sUDZ3XtX/qwfvdXigsgjuCwf/z6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885029; c=relaxed/simple;
	bh=g34NTi7BBFOiMr07nkao8FQYjEaAA2Lpy9px4Le9YSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+Pm8CbNtzh13g1Hy+cYZY5KfyUZ8dwmbK4NGpP7XYlaZY6bRWB2uzPuAGAShMeK7N89eNFpVmA4w1sQgMm1mHBroAeoqDCRMkiBbJM4N9Hg7pVTYXDDBvriFolmiTGJRzKW52rP+ASTPCSU8SZKp82j5K/bMbV5cHPxs6soPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ngnQux4b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XYvk6PS6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ngnQux4b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XYvk6PS6"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728885025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVR1HXOpKM8GhGNQSQfDyXEpXah9awzsBuZahyVEE2A=;
	b=ngnQux4b3Ppr5x1KEZezYl2Ezhl5M5ySDeAzvcwqfPZmj8/PUl+y2w4/7A4KrdT8x4rXM0
	69/pVbAMfxniQhrLgQOwnAXEttkcpGDTBE0FRi0BQUuu+BxaU5Gw+PWcauhxDhHAbUP3YL
	SVdrAlGmy9DzKtPTH5Rz6bAcY0hZv+jaFClvXu6aYbMm0+dnPb2lS5jbpBTsVtRap/lswK
	az+SbMBwuBxwlhoE9BrhImFkFeJyfY6xaKdFtgO2P+/7MWLBl6YhnbJwizo3fzVePFOv3g
	yMDMN5P9us40U5HTa6fJaFt9nfoaBmZPEZiD2YtcsmDyEfvE33fVnLNQM4xKMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728885025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVR1HXOpKM8GhGNQSQfDyXEpXah9awzsBuZahyVEE2A=;
	b=XYvk6PS64lVx1onEiUXi8jqZJK+RtRiqp7Jp6mbLoPdoPUrqyn3LjmT56MmbC0Ephk5xpW
	69RnOmiW0hQZClAQ==
Date: Mon, 14 Oct 2024 07:50:06 +0200
Subject: [PATCH 1/2] s390/sclp: deactivate sclp after all its users
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241014-s390-kunit-v1-1-941defa765a6@linutronix.de>
References: <20241014-s390-kunit-v1-0-941defa765a6@linutronix.de>
In-Reply-To: <20241014-s390-kunit-v1-0-941defa765a6@linutronix.de>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728885023; l=1299;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=g34NTi7BBFOiMr07nkao8FQYjEaAA2Lpy9px4Le9YSs=;
 b=zas6keCWN0kU6LW6lBcmnH4oLgegs3QdVQK9ceFA0wmgKQJpzQxAFVqPjFKaxPvbFNoG5rPtS
 UblB7aXXWzrBt/yTmR+Nkmnc1YWd/AwXZfgGA0IogWrIt3syQYaaQRb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

On reboot the SCLP interface is deactivated through a reboot notifier.
This happens before other components using SCLP have the chance to run
their own reboot notifiers.
Two of those components are the SCLP console and tty drivers which try
to flush the last outstanding messages.
At that point the SCLP interface is already unusable and the messages
are discarded.

Execute sclp_deactivate() as late as possible to avoid this issue.

Fixes: 4ae46db99cd8 ("s390/consoles: improve panic notifiers reliability")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/s390/char/sclp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index f3621adbd5debc59d2b71fc1be2790e0cbd31f76..fbffd451031fdb526d9b802da50df7f3eba5c48e 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -1195,7 +1195,8 @@ sclp_reboot_event(struct notifier_block *this, unsigned long event, void *ptr)
 }
 
 static struct notifier_block sclp_reboot_notifier = {
-	.notifier_call = sclp_reboot_event
+	.notifier_call = sclp_reboot_event,
+	.priority      = INT_MIN,
 };
 
 static ssize_t con_pages_show(struct device_driver *dev, char *buf)

-- 
2.47.0

