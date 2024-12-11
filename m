Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AD0202F9E;
	Wed, 11 Dec 2024 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939687; cv=none; b=rvtWOSPm6ylx27R0zg2dkAPhl+2RS1eaMIZbDjf6gVmoFtC4taMV3DxH8vDE8hW2rmqOIOb7Vg5VlB76DNWqAm9/0wuN3xJoX5NopvInoKoliU+75jRnbs8sXXDUqhVsFleOeq+RGOKkRwXeIDU+BP/mlz/5EDoUx24IYpszUkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939687; c=relaxed/simple;
	bh=khp6Kp6PQ4N5d8E6nOwINYUtZHWHtP2p0DSv3OfHocI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9IRMWMZ/76jBXUF5cz7ucRIMZPhQ+9XCeeEcnKJl/gAVE6ZI2q/6Ht8BxAX5GStw7MklkC82wUy1IS8MEaD2w2sDpC8cLR2BzGuN5iFZhvTeajUg0ME5IHHCIMU391NwHeJQImgCDJUVoB3iIyoW3Fu/B1CXGp4bXX6YcP/2/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tTWqH3Uf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tTWqH3Uf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939680;
	bh=khp6Kp6PQ4N5d8E6nOwINYUtZHWHtP2p0DSv3OfHocI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tTWqH3UfjkXEV8dbGPLkR9aYXWMHF/H3t5hK0V4GiCaHpAYNtkMNt1rlZG6HXOK+0
	 OZ2dde3392CtRtxAbXb5gH/u4fch+HcowSb7EeIS1vpAp0fRGI4IpS/J8VA3ovmei/
	 IoK1qxxKr/rPH8NDXbNL5OUikDbDmvYmL7JaixJI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:54:43 +0100
Subject: [PATCH 5/5] s390/pkey: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-s390-v1-5-be01f66bfcf7@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939680; l=14342;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=khp6Kp6PQ4N5d8E6nOwINYUtZHWHtP2p0DSv3OfHocI=;
 b=RlgLX++1AVH08W/1E8c2XzAnU0VZ837lB69QhXVzfiXnq+wd4v6nMXA5xe/kyJNT8rth7P/UT
 iwrjv2/0oU5Dw0eGxytahrGhjggyNfQXffCKW/wXIC/ImaBIaqJboVr
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/s390/crypto/pkey_sysfs.c | 128 +++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/s390/crypto/pkey_sysfs.c b/drivers/s390/crypto/pkey_sysfs.c
index a4eb45803f5e6d6b17dec709e6068448973399f6..57edc97bafd29483eedc405d47eabe3d7f6c28fc 100644
--- a/drivers/s390/crypto/pkey_sysfs.c
+++ b/drivers/s390/crypto/pkey_sysfs.c
@@ -184,7 +184,7 @@ static ssize_t pkey_protkey_hmac_attr_read(u32 keytype, char *buf,
 
 static ssize_t protkey_aes_128_read(struct file *filp,
 				    struct kobject *kobj,
-				    struct bin_attribute *attr,
+				    const struct bin_attribute *attr,
 				    char *buf, loff_t off,
 				    size_t count)
 {
@@ -194,7 +194,7 @@ static ssize_t protkey_aes_128_read(struct file *filp,
 
 static ssize_t protkey_aes_192_read(struct file *filp,
 				    struct kobject *kobj,
-				    struct bin_attribute *attr,
+				    const struct bin_attribute *attr,
 				    char *buf, loff_t off,
 				    size_t count)
 {
@@ -204,7 +204,7 @@ static ssize_t protkey_aes_192_read(struct file *filp,
 
 static ssize_t protkey_aes_256_read(struct file *filp,
 				    struct kobject *kobj,
-				    struct bin_attribute *attr,
+				    const struct bin_attribute *attr,
 				    char *buf, loff_t off,
 				    size_t count)
 {
@@ -214,7 +214,7 @@ static ssize_t protkey_aes_256_read(struct file *filp,
 
 static ssize_t protkey_aes_128_xts_read(struct file *filp,
 					struct kobject *kobj,
-					struct bin_attribute *attr,
+					const struct bin_attribute *attr,
 					char *buf, loff_t off,
 					size_t count)
 {
@@ -224,7 +224,7 @@ static ssize_t protkey_aes_128_xts_read(struct file *filp,
 
 static ssize_t protkey_aes_256_xts_read(struct file *filp,
 					struct kobject *kobj,
-					struct bin_attribute *attr,
+					const struct bin_attribute *attr,
 					char *buf, loff_t off,
 					size_t count)
 {
@@ -234,7 +234,7 @@ static ssize_t protkey_aes_256_xts_read(struct file *filp,
 
 static ssize_t protkey_aes_xts_128_read(struct file *filp,
 					struct kobject *kobj,
-					struct bin_attribute *attr,
+					const struct bin_attribute *attr,
 					char *buf, loff_t off,
 					size_t count)
 {
@@ -244,7 +244,7 @@ static ssize_t protkey_aes_xts_128_read(struct file *filp,
 
 static ssize_t protkey_aes_xts_256_read(struct file *filp,
 					struct kobject *kobj,
-					struct bin_attribute *attr,
+					const struct bin_attribute *attr,
 					char *buf, loff_t off,
 					size_t count)
 {
@@ -254,7 +254,7 @@ static ssize_t protkey_aes_xts_256_read(struct file *filp,
 
 static ssize_t protkey_hmac_512_read(struct file *filp,
 				     struct kobject *kobj,
-				     struct bin_attribute *attr,
+				     const struct bin_attribute *attr,
 				     char *buf, loff_t off,
 				     size_t count)
 {
@@ -264,7 +264,7 @@ static ssize_t protkey_hmac_512_read(struct file *filp,
 
 static ssize_t protkey_hmac_1024_read(struct file *filp,
 				      struct kobject *kobj,
-				      struct bin_attribute *attr,
+				      const struct bin_attribute *attr,
 				      char *buf, loff_t off,
 				      size_t count)
 {
@@ -272,17 +272,17 @@ static ssize_t protkey_hmac_1024_read(struct file *filp,
 					   buf, off, count);
 }
 
-static BIN_ATTR_RO(protkey_aes_128, sizeof(struct protaeskeytoken));
-static BIN_ATTR_RO(protkey_aes_192, sizeof(struct protaeskeytoken));
-static BIN_ATTR_RO(protkey_aes_256, sizeof(struct protaeskeytoken));
-static BIN_ATTR_RO(protkey_aes_128_xts, 2 * sizeof(struct protaeskeytoken));
-static BIN_ATTR_RO(protkey_aes_256_xts, 2 * sizeof(struct protaeskeytoken));
-static BIN_ATTR_RO(protkey_aes_xts_128, sizeof(struct protkeytoken) + 64);
-static BIN_ATTR_RO(protkey_aes_xts_256, sizeof(struct protkeytoken) + 96);
-static BIN_ATTR_RO(protkey_hmac_512, sizeof(struct protkeytoken) + 96);
-static BIN_ATTR_RO(protkey_hmac_1024, sizeof(struct protkeytoken) + 160);
-
-static struct bin_attribute *protkey_attrs[] = {
+static const BIN_ATTR_RO(protkey_aes_128, sizeof(struct protaeskeytoken));
+static const BIN_ATTR_RO(protkey_aes_192, sizeof(struct protaeskeytoken));
+static const BIN_ATTR_RO(protkey_aes_256, sizeof(struct protaeskeytoken));
+static const BIN_ATTR_RO(protkey_aes_128_xts, 2 * sizeof(struct protaeskeytoken));
+static const BIN_ATTR_RO(protkey_aes_256_xts, 2 * sizeof(struct protaeskeytoken));
+static const BIN_ATTR_RO(protkey_aes_xts_128, sizeof(struct protkeytoken) + 64);
+static const BIN_ATTR_RO(protkey_aes_xts_256, sizeof(struct protkeytoken) + 96);
+static const BIN_ATTR_RO(protkey_hmac_512, sizeof(struct protkeytoken) + 96);
+static const BIN_ATTR_RO(protkey_hmac_1024, sizeof(struct protkeytoken) + 160);
+
+static const struct bin_attribute *const protkey_attrs[] = {
 	&bin_attr_protkey_aes_128,
 	&bin_attr_protkey_aes_192,
 	&bin_attr_protkey_aes_256,
@@ -295,9 +295,9 @@ static struct bin_attribute *protkey_attrs[] = {
 	NULL
 };
 
-static struct attribute_group protkey_attr_group = {
-	.name	   = "protkey",
-	.bin_attrs = protkey_attrs,
+static const struct attribute_group protkey_attr_group = {
+	.name	       = "protkey",
+	.bin_attrs_new = protkey_attrs,
 };
 
 /*
@@ -341,7 +341,7 @@ static ssize_t pkey_ccadata_aes_attr_read(u32 keytype, bool is_xts, char *buf,
 
 static ssize_t ccadata_aes_128_read(struct file *filp,
 				    struct kobject *kobj,
-				    struct bin_attribute *attr,
+				    const struct bin_attribute *attr,
 				    char *buf, loff_t off,
 				    size_t count)
 {
@@ -351,7 +351,7 @@ static ssize_t ccadata_aes_128_read(struct file *filp,
 
 static ssize_t ccadata_aes_192_read(struct file *filp,
 				    struct kobject *kobj,
-				    struct bin_attribute *attr,
+				    const struct bin_attribute *attr,
 				    char *buf, loff_t off,
 				    size_t count)
 {
@@ -361,7 +361,7 @@ static ssize_t ccadata_aes_192_read(struct file *filp,
 
 static ssize_t ccadata_aes_256_read(struct file *filp,
 				    struct kobject *kobj,
-				    struct bin_attribute *attr,
+				    const struct bin_attribute *attr,
 				    char *buf, loff_t off,
 				    size_t count)
 {
@@ -371,7 +371,7 @@ static ssize_t ccadata_aes_256_read(struct file *filp,
 
 static ssize_t ccadata_aes_128_xts_read(struct file *filp,
 					struct kobject *kobj,
-					struct bin_attribute *attr,
+					const struct bin_attribute *attr,
 					char *buf, loff_t off,
 					size_t count)
 {
@@ -381,7 +381,7 @@ static ssize_t ccadata_aes_128_xts_read(struct file *filp,
 
 static ssize_t ccadata_aes_256_xts_read(struct file *filp,
 					struct kobject *kobj,
-					struct bin_attribute *attr,
+					const struct bin_attribute *attr,
 					char *buf, loff_t off,
 					size_t count)
 {
@@ -389,13 +389,13 @@ static ssize_t ccadata_aes_256_xts_read(struct file *filp,
 					  off, count);
 }
 
-static BIN_ATTR_RO(ccadata_aes_128, sizeof(struct secaeskeytoken));
-static BIN_ATTR_RO(ccadata_aes_192, sizeof(struct secaeskeytoken));
-static BIN_ATTR_RO(ccadata_aes_256, sizeof(struct secaeskeytoken));
-static BIN_ATTR_RO(ccadata_aes_128_xts, 2 * sizeof(struct secaeskeytoken));
-static BIN_ATTR_RO(ccadata_aes_256_xts, 2 * sizeof(struct secaeskeytoken));
+static const BIN_ATTR_RO(ccadata_aes_128, sizeof(struct secaeskeytoken));
+static const BIN_ATTR_RO(ccadata_aes_192, sizeof(struct secaeskeytoken));
+static const BIN_ATTR_RO(ccadata_aes_256, sizeof(struct secaeskeytoken));
+static const BIN_ATTR_RO(ccadata_aes_128_xts, 2 * sizeof(struct secaeskeytoken));
+static const BIN_ATTR_RO(ccadata_aes_256_xts, 2 * sizeof(struct secaeskeytoken));
 
-static struct bin_attribute *ccadata_attrs[] = {
+static const struct bin_attribute *const ccadata_attrs[] = {
 	&bin_attr_ccadata_aes_128,
 	&bin_attr_ccadata_aes_192,
 	&bin_attr_ccadata_aes_256,
@@ -404,9 +404,9 @@ static struct bin_attribute *ccadata_attrs[] = {
 	NULL
 };
 
-static struct attribute_group ccadata_attr_group = {
-	.name	   = "ccadata",
-	.bin_attrs = ccadata_attrs,
+static const struct attribute_group ccadata_attr_group = {
+	.name	       = "ccadata",
+	.bin_attrs_new = ccadata_attrs,
 };
 
 #define CCACIPHERTOKENSIZE	(sizeof(struct cipherkeytoken) + 80)
@@ -455,7 +455,7 @@ static ssize_t pkey_ccacipher_aes_attr_read(enum pkey_key_size keybits,
 
 static ssize_t ccacipher_aes_128_read(struct file *filp,
 				      struct kobject *kobj,
-				      struct bin_attribute *attr,
+				      const struct bin_attribute *attr,
 				      char *buf, loff_t off,
 				      size_t count)
 {
@@ -465,7 +465,7 @@ static ssize_t ccacipher_aes_128_read(struct file *filp,
 
 static ssize_t ccacipher_aes_192_read(struct file *filp,
 				      struct kobject *kobj,
-				      struct bin_attribute *attr,
+				      const struct bin_attribute *attr,
 				      char *buf, loff_t off,
 				      size_t count)
 {
@@ -475,7 +475,7 @@ static ssize_t ccacipher_aes_192_read(struct file *filp,
 
 static ssize_t ccacipher_aes_256_read(struct file *filp,
 				      struct kobject *kobj,
-				      struct bin_attribute *attr,
+				      const struct bin_attribute *attr,
 				      char *buf, loff_t off,
 				      size_t count)
 {
@@ -485,7 +485,7 @@ static ssize_t ccacipher_aes_256_read(struct file *filp,
 
 static ssize_t ccacipher_aes_128_xts_read(struct file *filp,
 					  struct kobject *kobj,
-					  struct bin_attribute *attr,
+					  const struct bin_attribute *attr,
 					  char *buf, loff_t off,
 					  size_t count)
 {
@@ -495,7 +495,7 @@ static ssize_t ccacipher_aes_128_xts_read(struct file *filp,
 
 static ssize_t ccacipher_aes_256_xts_read(struct file *filp,
 					  struct kobject *kobj,
-					  struct bin_attribute *attr,
+					  const struct bin_attribute *attr,
 					  char *buf, loff_t off,
 					  size_t count)
 {
@@ -503,13 +503,13 @@ static ssize_t ccacipher_aes_256_xts_read(struct file *filp,
 					    off, count);
 }
 
-static BIN_ATTR_RO(ccacipher_aes_128, CCACIPHERTOKENSIZE);
-static BIN_ATTR_RO(ccacipher_aes_192, CCACIPHERTOKENSIZE);
-static BIN_ATTR_RO(ccacipher_aes_256, CCACIPHERTOKENSIZE);
-static BIN_ATTR_RO(ccacipher_aes_128_xts, 2 * CCACIPHERTOKENSIZE);
-static BIN_ATTR_RO(ccacipher_aes_256_xts, 2 * CCACIPHERTOKENSIZE);
+static const BIN_ATTR_RO(ccacipher_aes_128, CCACIPHERTOKENSIZE);
+static const BIN_ATTR_RO(ccacipher_aes_192, CCACIPHERTOKENSIZE);
+static const BIN_ATTR_RO(ccacipher_aes_256, CCACIPHERTOKENSIZE);
+static const BIN_ATTR_RO(ccacipher_aes_128_xts, 2 * CCACIPHERTOKENSIZE);
+static const BIN_ATTR_RO(ccacipher_aes_256_xts, 2 * CCACIPHERTOKENSIZE);
 
-static struct bin_attribute *ccacipher_attrs[] = {
+static const struct bin_attribute *const ccacipher_attrs[] = {
 	&bin_attr_ccacipher_aes_128,
 	&bin_attr_ccacipher_aes_192,
 	&bin_attr_ccacipher_aes_256,
@@ -518,9 +518,9 @@ static struct bin_attribute *ccacipher_attrs[] = {
 	NULL
 };
 
-static struct attribute_group ccacipher_attr_group = {
-	.name	   = "ccacipher",
-	.bin_attrs = ccacipher_attrs,
+static const struct attribute_group ccacipher_attr_group = {
+	.name	       = "ccacipher",
+	.bin_attrs_new = ccacipher_attrs,
 };
 
 /*
@@ -570,7 +570,7 @@ static ssize_t pkey_ep11_aes_attr_read(enum pkey_key_size keybits,
 
 static ssize_t ep11_aes_128_read(struct file *filp,
 				 struct kobject *kobj,
-				 struct bin_attribute *attr,
+				 const struct bin_attribute *attr,
 				 char *buf, loff_t off,
 				 size_t count)
 {
@@ -580,7 +580,7 @@ static ssize_t ep11_aes_128_read(struct file *filp,
 
 static ssize_t ep11_aes_192_read(struct file *filp,
 				 struct kobject *kobj,
-				 struct bin_attribute *attr,
+				 const struct bin_attribute *attr,
 				 char *buf, loff_t off,
 				 size_t count)
 {
@@ -590,7 +590,7 @@ static ssize_t ep11_aes_192_read(struct file *filp,
 
 static ssize_t ep11_aes_256_read(struct file *filp,
 				 struct kobject *kobj,
-				 struct bin_attribute *attr,
+				 const struct bin_attribute *attr,
 				 char *buf, loff_t off,
 				 size_t count)
 {
@@ -600,7 +600,7 @@ static ssize_t ep11_aes_256_read(struct file *filp,
 
 static ssize_t ep11_aes_128_xts_read(struct file *filp,
 				     struct kobject *kobj,
-				     struct bin_attribute *attr,
+				     const struct bin_attribute *attr,
 				     char *buf, loff_t off,
 				     size_t count)
 {
@@ -610,7 +610,7 @@ static ssize_t ep11_aes_128_xts_read(struct file *filp,
 
 static ssize_t ep11_aes_256_xts_read(struct file *filp,
 				     struct kobject *kobj,
-				     struct bin_attribute *attr,
+				     const struct bin_attribute *attr,
 				     char *buf, loff_t off,
 				     size_t count)
 {
@@ -618,13 +618,13 @@ static ssize_t ep11_aes_256_xts_read(struct file *filp,
 				       off, count);
 }
 
-static BIN_ATTR_RO(ep11_aes_128, MAXEP11AESKEYBLOBSIZE);
-static BIN_ATTR_RO(ep11_aes_192, MAXEP11AESKEYBLOBSIZE);
-static BIN_ATTR_RO(ep11_aes_256, MAXEP11AESKEYBLOBSIZE);
-static BIN_ATTR_RO(ep11_aes_128_xts, 2 * MAXEP11AESKEYBLOBSIZE);
-static BIN_ATTR_RO(ep11_aes_256_xts, 2 * MAXEP11AESKEYBLOBSIZE);
+static const BIN_ATTR_RO(ep11_aes_128, MAXEP11AESKEYBLOBSIZE);
+static const BIN_ATTR_RO(ep11_aes_192, MAXEP11AESKEYBLOBSIZE);
+static const BIN_ATTR_RO(ep11_aes_256, MAXEP11AESKEYBLOBSIZE);
+static const BIN_ATTR_RO(ep11_aes_128_xts, 2 * MAXEP11AESKEYBLOBSIZE);
+static const BIN_ATTR_RO(ep11_aes_256_xts, 2 * MAXEP11AESKEYBLOBSIZE);
 
-static struct bin_attribute *ep11_attrs[] = {
+static const struct bin_attribute *const ep11_attrs[] = {
 	&bin_attr_ep11_aes_128,
 	&bin_attr_ep11_aes_192,
 	&bin_attr_ep11_aes_256,
@@ -633,9 +633,9 @@ static struct bin_attribute *ep11_attrs[] = {
 	NULL
 };
 
-static struct attribute_group ep11_attr_group = {
+static const struct attribute_group ep11_attr_group = {
 	.name	   = "ep11",
-	.bin_attrs = ep11_attrs,
+	.bin_attrs_new = ep11_attrs,
 };
 
 const struct attribute_group *pkey_attr_groups[] = {

-- 
2.47.1

