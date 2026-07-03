Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD13BBFBF
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073004; cv=none; b=KBElT5FGp2zCllM2tXZB2sxrGdHYOrZND1nQID9rfwTaDi4c1C584vTSKC86VR4rTAcm3vVucB0IkZo/c+fN+klloZwZLlRdQdmLYmeW11tHoI6him+2n/yHXFsS4YsjJy6p2ERoX23UYtVib0MhaEW4bNxGM1xaVGyrXLGFJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073004; c=relaxed/simple;
	bh=PxavhaJRuFmxG1IwKzPW+rwdDyNvvPmpaNgI2Bb9Mjw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nskp7eka/mm0rbqgENIBGDYEGJMHG3fZ7U1vkkLRwERitmFmGu7qKGyrYh7Ytcc7gFOd0i+2uGBOnuQGHYEDhAY9I0qJfP95D50jGvmnheeu6rCP9Z8UnEBzGAJbWNaUSJNDRzVh2U/nOVrHyLtdsKDpTfMTOEGFo+KcgaUwMEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fAI6VRdL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+CX76KXT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fAI6VRdL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+CX76KXT"
Date: Fri, 3 Jul 2026 12:03:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783073001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QYmRaiV8oeov3wzngWSTjPOMEzTQOQCAhf1r9wryG/4=;
	b=fAI6VRdLaAWU6yHvkzSmdbok9Xh6Os13PigmzdqGMpk+MNuFoT4ENbnkUwf52apWC8MJT3
	WBtiNqqgKOQZUXCg9JR96s/LgjjN1Fy21A9zM4Ue8Wrr9rYK0zuqV9Fl/THKdFNkN6oFLe
	EpQtsLly/7LH4ztwBwKWrKxf0GsQtZNKypjOkN1sTB0SppJ9411kTlcXaCIKLdh3merIMk
	tv7Yr+2DZr3o+VsOx9AzwgOeuohlxGGHSZ7qw7KYHHiI7Lh/FQgxU6mUVLPdNodv4OLEDH
	6jk18I4l0ql93q8hGfYN39o/ypF184tFTYb+o3+Tn6zbm4WcBRTHKBR7h9+7kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783073001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QYmRaiV8oeov3wzngWSTjPOMEzTQOQCAhf1r9wryG/4=;
	b=+CX76KXTZ14Zqaps4c+stGW6PMTqoolDyrKueM1GjeMn2EndmaQQVvh0oqAaCMMeh5KTdA
	HO1e+Gqv8RUuGoBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH] s390/zcrypt: Delete CEX2 and CEX3 device drivers
Message-ID: <20260703100320.qvFoxNbp@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The two driver were removed in commit 5ac8c72462cda ("s390/zcrypt:
remove CEX2 and CEX3 device drivers") but not deleted. That means they
are still around as zero sized files reminding everyone what once was.

Let's delete them now.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/crypto/zcrypt_cex2a.c | 0
 drivers/s390/crypto/zcrypt_cex2a.h | 0
 drivers/s390/crypto/zcrypt_cex2c.c | 0
 drivers/s390/crypto/zcrypt_cex2c.h | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2a.c
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2a.h
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2c.c
 delete mode 100644 drivers/s390/crypto/zcrypt_cex2c.h

diff --git a/drivers/s390/crypto/zcrypt_cex2a.c b/drivers/s390/crypto/zcrypt_cex2a.c
deleted file mode 100644
index e69de29bb2d1d..0000000000000
diff --git a/drivers/s390/crypto/zcrypt_cex2a.h b/drivers/s390/crypto/zcrypt_cex2a.h
deleted file mode 100644
index e69de29bb2d1d..0000000000000
diff --git a/drivers/s390/crypto/zcrypt_cex2c.c b/drivers/s390/crypto/zcrypt_cex2c.c
deleted file mode 100644
index e69de29bb2d1d..0000000000000
diff --git a/drivers/s390/crypto/zcrypt_cex2c.h b/drivers/s390/crypto/zcrypt_cex2c.h
deleted file mode 100644
index e69de29bb2d1d..0000000000000
-- 
2.53.0

