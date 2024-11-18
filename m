Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546E1B21A0;
	Mon, 18 Nov 2024 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942193; cv=none; b=kufgx061UclKr8Gf3bxGLWW27FHIo3D5h+Ataxr2HFAOl7bKkuclPwoRQrGAHPTZWy0io5X3aohFtRON1cGHkNn9ePUdZ5xxb4z8tEBn6EHweXMqctbCWlC/YTdhJWg3xC/0Zu7PPTV42ZzY218+OMsmtitb/TKHYRbFd171+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942193; c=relaxed/simple;
	bh=wanikvVx55Q2iWKAifFPxcBSccEU3MSG8wjRU6lkedA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qnp0wfLV2LNMpZ0lwpSHCfF4AyTcSaE2uDE5jNZf+vWPDMS+rmmdibQ/17aRI2SYsjw2hEibabJw86SqiK2lUMuZaLrM6KQ94/HP7gQOH/CSUBNVUq8wHA0qesViNLZfSIsQ6g6hJ4UoOwAyc6fx95eRe1HRSGo+MUcqiXU3w5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=LT6ozaV9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="LT6ozaV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731942187;
	bh=wanikvVx55Q2iWKAifFPxcBSccEU3MSG8wjRU6lkedA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LT6ozaV9+SGX3smbiroyIdiAUyHy3jO21OkA7bT+dcEWMLfCSw7UPjd2DUcpnjWCB
	 q3ojNF4XT/+BdPuppdYcnTMF23KfA7q7Gxg8ZJYBoAcDdzPT1ExL/ygKqN2zLaBmrr
	 cnzpxA+/iatbg8lvXf99+zIdzWq5AiU1ODeV2ugI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 18 Nov 2024 16:02:47 +0100
Subject: [PATCH 1/3] perf: arm-ni: Remove spurious NULL in attribute_group
 definition
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241118-sysfs-const-attribute_group-fixes-v1-1-48e0b0ad8cba@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731942187; l=835;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wanikvVx55Q2iWKAifFPxcBSccEU3MSG8wjRU6lkedA=;
 b=dbOlKuFnLw2c05vLlE1Ltp5tRxeYtT2OdfOx1pn5ntPiIvPkYeOAOwH7VT1+GPF+SMEBqtiKO
 GEa0gd4UCDYAk2yWqm0N3bLAqgTZyvO0obImcIL/iVwISKM1sJIb8IN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This NULL value is most-likely a copy-paste error from an array
definition. So far the NULL didn't have any effect.
As there will be a union in struct attribute_group at this location,
it will trigger a compiler warning.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/perf/arm-ni.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index 90fcfe693439ef3e18e23c6351433ac3c5ea78b5..fd7a5e60e96302fada29cd44e7bf9c582e93e4ce 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -247,7 +247,6 @@ static struct attribute *arm_ni_other_attrs[] = {
 
 static const struct attribute_group arm_ni_other_attr_group = {
 	.attrs = arm_ni_other_attrs,
-	NULL
 };
 
 static const struct attribute_group *arm_ni_attr_groups[] = {

-- 
2.47.0

