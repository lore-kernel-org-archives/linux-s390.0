Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462471FF1D0;
	Wed, 11 Dec 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939685; cv=none; b=PVk3TalRFqxVj4SB9dNJNYt5F4wF3mfLwsVtO4zS04wC59sKOU4lQecgm8AaTCzdc3aMhsXRCoSHdk5BGgo2VklaeZ/Ze0mvB3auoUp/DwyPJJUwzdjd6YojXM0gpRUOImQcelE5eD1rjm/HYgzl/UeUzHm9TfTRnp0XFu+aIN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939685; c=relaxed/simple;
	bh=xV6zJcNk00t9KvA7nCk23QmQDDzZHzdCO7WdqX+VHho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGM0rxr3niyxLNMNeSQGUXWcf1/nwtwv+Y0LwbIIyFgSBQSNjqWkDHZHdmO41lAWLz6MlVeQzmfMKBebwaI3eqz+tuCSNbpOW2paZIUL1efJBq9DuSSxM2Kh9s3fGYKZ5fb9mOA14APxllcqaxgSz0PxjW6bp0Wv4vf036xRLmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=REZlKwLL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="REZlKwLL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939680;
	bh=xV6zJcNk00t9KvA7nCk23QmQDDzZHzdCO7WdqX+VHho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=REZlKwLLl+o4neplV3J+cyp6ZxDal9gSj3poOhkb7sxin/PdAHJKjcjnQIagO3lZD
	 DbOUFlvSWdPNPvWZOo+EcM755L529HNPDR56ByvfMTMs0k44MzG+1Hv1bNpRkeflmh
	 O77lguE2/DE6j6e/RnmCQTC2DVnbvhbnl/paQaNs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:54:39 +0100
Subject: [PATCH 1/5] s390/crypto/cpacf: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-s390-v1-1-be01f66bfcf7@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
In-Reply-To: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939680; l=3086;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xV6zJcNk00t9KvA7nCk23QmQDDzZHzdCO7WdqX+VHho=;
 b=W38JfBzSN15hiDaBEBR5fuiLjhMuSpVPM1vylF1AfEbLH0PpsvYnBHBByMHGtmxNBS+S6s4ck
 TJBRFJoospmAM4H+nYsq+U73febAs0XTmb4ZmatfyKLGEclYwXpQQzt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/s390/kernel/cpacf.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kernel/cpacf.c b/arch/s390/kernel/cpacf.c
index c8575dbc890d64a5fcdcbd7a1a18215e2158c6e3..4b9b34f95d729806d416279b93ccb5a20e4406a7 100644
--- a/arch/s390/kernel/cpacf.c
+++ b/arch/s390/kernel/cpacf.c
@@ -14,7 +14,7 @@
 #define CPACF_QUERY(name, instruction)						\
 static ssize_t name##_query_raw_read(struct file *fp,				\
 				     struct kobject *kobj,			\
-				     struct bin_attribute *attr,		\
+				     const struct bin_attribute *attr,		\
 				     char *buf, loff_t offs,			\
 				     size_t count)				\
 {										\
@@ -24,7 +24,7 @@ static ssize_t name##_query_raw_read(struct file *fp,				\
 		return -EOPNOTSUPP;						\
 	return memory_read_from_buffer(buf, count, &offs, &mask, sizeof(mask));	\
 }										\
-static BIN_ATTR_RO(name##_query_raw, sizeof(cpacf_mask_t))
+static const BIN_ATTR_RO(name##_query_raw, sizeof(cpacf_mask_t))
 
 CPACF_QUERY(km, KM);
 CPACF_QUERY(kmc, KMC);
@@ -40,20 +40,20 @@ CPACF_QUERY(prno, PRNO);
 CPACF_QUERY(kma, KMA);
 CPACF_QUERY(kdsa, KDSA);
 
-#define CPACF_QAI(name, instruction)				\
-static ssize_t name##_query_auth_info_raw_read(			\
-	struct file *fp, struct kobject *kobj,			\
-	struct bin_attribute *attr, char *buf, loff_t offs,	\
-	size_t count)						\
-{								\
-	cpacf_qai_t qai;					\
-								\
-	if (!cpacf_qai(CPACF_##instruction, &qai))		\
-		return -EOPNOTSUPP;				\
-	return memory_read_from_buffer(buf, count, &offs, &qai, \
-					sizeof(qai));		\
-}								\
-static BIN_ATTR_RO(name##_query_auth_info_raw, sizeof(cpacf_qai_t))
+#define CPACF_QAI(name, instruction)					\
+static ssize_t name##_query_auth_info_raw_read(				\
+	struct file *fp, struct kobject *kobj,				\
+	const struct bin_attribute *attr, char *buf, loff_t offs,	\
+	size_t count)							\
+{									\
+	cpacf_qai_t qai;						\
+									\
+	if (!cpacf_qai(CPACF_##instruction, &qai))			\
+		return -EOPNOTSUPP;					\
+	return memory_read_from_buffer(buf, count, &offs, &qai,		\
+					sizeof(qai));			\
+}									\
+static const BIN_ATTR_RO(name##_query_auth_info_raw, sizeof(cpacf_qai_t))
 
 CPACF_QAI(km, KM);
 CPACF_QAI(kmc, KMC);
@@ -69,7 +69,7 @@ CPACF_QAI(prno, PRNO);
 CPACF_QAI(kma, KMA);
 CPACF_QAI(kdsa, KDSA);
 
-static struct bin_attribute *cpacf_attrs[] = {
+static const struct bin_attribute *const cpacf_attrs[] = {
 	&bin_attr_km_query_raw,
 	&bin_attr_kmc_query_raw,
 	&bin_attr_kimd_query_raw,
@@ -101,7 +101,7 @@ static struct bin_attribute *cpacf_attrs[] = {
 
 static const struct attribute_group cpacf_attr_grp = {
 	.name = "cpacf",
-	.bin_attrs = cpacf_attrs,
+	.bin_attrs_new = cpacf_attrs,
 };
 
 static int __init cpacf_init(void)

-- 
2.47.1

