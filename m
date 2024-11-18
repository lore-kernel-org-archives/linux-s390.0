Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F091B6D16;
	Mon, 18 Nov 2024 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942194; cv=none; b=O/34t1gLkrrisJpclOX529f/PKLxHGPWdrQKSoucg3K0BS7862NbK0fpZZFY+Kl8zU69pxDAeSP6kr0OfyRulVvnyjBPI2OHEW4MXGZAsYnfxxqb+3E4pBStmaw6jqSWdAVsQ+gJqw42l8bRAyKHFjhfAPd9TFVLaEnfF/DYSPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942194; c=relaxed/simple;
	bh=DmZT4xsI5doB1i+zhbofwrVYplHbfYJNLzwi59dygA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N7epqV0FCMgcSZkO77fAQxJ4BPJJWrTSyh60NUFF+3n6XCnN0FvCtG+oGjaA2OdPWSA8PmHPkyTdQhY8P/8iUDH54tjvLExYZki/8aVn7V+5vHUFqcg3CJHPhMqOR0LNB/+2B3Tjukjyyi2/Srj4jK1oftLzdsR7Xud1H9SbMWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Q+9LP9df; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Q+9LP9df"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731942187;
	bh=DmZT4xsI5doB1i+zhbofwrVYplHbfYJNLzwi59dygA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q+9LP9dfn8kPonnhF732Ezn1AnVV9P7LCFsyl88U4Cb91wDBnq5LvbUlvG3jHj4sI
	 tTHdpN4n308s6Pj2HWHILTyy8YMXhTIFtZSXjp1dJp194kD6P1PdPt8qCCNTSoTv0m
	 e0W/IVxeLtvVllE1O6epl+iGf4rLpoP5gkvqmtW0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 18 Nov 2024 16:02:48 +0100
Subject: [PATCH 2/3] s390/con3215: Remove spurious NULL in attribute_group
 definition
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241118-sysfs-const-attribute_group-fixes-v1-2-48e0b0ad8cba@weissschuh.net>
References: <20241118-sysfs-const-attribute_group-fixes-v1-0-48e0b0ad8cba@weissschuh.net>
In-Reply-To: <20241118-sysfs-const-attribute_group-fixes-v1-0-48e0b0ad8cba@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731942187; l=862;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DmZT4xsI5doB1i+zhbofwrVYplHbfYJNLzwi59dygA0=;
 b=nD8J4pvnXKQqclCRBHqCv4musA1VxnMDFKDJTUm5nofKnNucxbd0ZY+On/5h0gRTZDr8zrl61
 QZKOcDJ+kLgBh7upQgIT1XjiyHiveyxsrBJS1Bvs6BwcQmLSorg+l51
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This NULL value is most-likely a copy-paste error from an array
definition. So far the NULL didn't have any effect.
As there will be a union in struct attribute_group at this location,
it will trigger a compiler warning.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/s390/char/con3215.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index dcb3c32f027af6748448600bad51864f6ba5d9a1..c763c50d1454676f223e8b29a92f5fb45ddd7932 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -803,7 +803,6 @@ static struct attribute *con3215_drv_attrs[] = {
 
 static struct attribute_group con3215_drv_attr_group = {
 	.attrs = con3215_drv_attrs,
-	NULL,
 };
 
 static const struct attribute_group *con3215_drv_attr_groups[] = {

-- 
2.47.0

