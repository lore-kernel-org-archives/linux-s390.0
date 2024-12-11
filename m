Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7031FF1D1;
	Wed, 11 Dec 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939684; cv=none; b=JLaacBWDUi9AKfeD0natVdv4cYN58sMXptxcTWqiOqzd/27mOfvY6UxmuS9g+UNIQiopkqprdMHXLoNFhJUabyHz1E7RCW/oaY2T48vAA9bF62Xb55S1eEK3vz01TE3VFsXijl1wVEaQVwzMF5hhLN+2kOM2jAwyn4e8AQ4gjSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939684; c=relaxed/simple;
	bh=WJ1JLrL8V13d4lDWJbvW3CzFfSfBUFy9QVkkKqUwJCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qv4iBz+8LTHwNJHg0PxFUEKOdqZrcZgC6FoURYHpwqVF67MAcvvk4YDwuFiDp1cqXAlF+Yory7ZwB2bTdy4Y4h24ifsKCTIyO2b6ZNVfDLeZu6WogXpX6YJrq+EiWaUSyvKKaz8JH/2E+5dnPzJLvvPhghAka8KlHOu9igEIPrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=O+6t9X7U; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="O+6t9X7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939680;
	bh=WJ1JLrL8V13d4lDWJbvW3CzFfSfBUFy9QVkkKqUwJCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O+6t9X7U7J2nqTcvRCtnKuiMx4rmlecVubIX/cWHQDEPR54I87dK1mD2vGEmfl+fD
	 Z2Daju995EEtCC5ck/pbaCQPN9iurpFs6HvGFjLQVb0/d6UE7dn4Vh87kmDkhcbGBk
	 MkHeoedAtlWwk0spDYBmZqLsKRvCUkxHow/5LMXc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:54:42 +0100
Subject: [PATCH 4/5] s390/sclp: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-s390-v1-4-be01f66bfcf7@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939680; l=2161;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WJ1JLrL8V13d4lDWJbvW3CzFfSfBUFy9QVkkKqUwJCo=;
 b=X9fGukjy/L3Ky3Y10NF3t1Nm9TXaG9O/i7fYKaIj1hDOptRIGsYRueBHyRLFOcWjc4wAQDOQP
 RkFJ9pWvsojDXeKHVPRZoGRCbNqbVSA1V0tspD0tIYKaAqlcyQsf+u3
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/s390/char/sclp_config.c | 4 ++--
 drivers/s390/char/sclp_sd.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp_config.c b/drivers/s390/char/sclp_config.c
index f56ea9b60e08e817652a9b7d19d420e9977c6552..ae5d289871779cc5cc1f3070c64746ea702eb41d 100644
--- a/drivers/s390/char/sclp_config.c
+++ b/drivers/s390/char/sclp_config.c
@@ -128,7 +128,7 @@ static int sclp_ofb_send_req(char *ev_data, size_t len)
 }
 
 static ssize_t sysfs_ofb_data_write(struct file *filp, struct kobject *kobj,
-				    struct bin_attribute *bin_attr,
+				    const struct bin_attribute *bin_attr,
 				    char *buf, loff_t off, size_t count)
 {
 	int rc;
@@ -142,7 +142,7 @@ static const struct bin_attribute ofb_bin_attr = {
 		.name = "event_data",
 		.mode = S_IWUSR,
 	},
-	.write = sysfs_ofb_data_write,
+	.write_new = sysfs_ofb_data_write,
 };
 #endif
 
diff --git a/drivers/s390/char/sclp_sd.c b/drivers/s390/char/sclp_sd.c
index c2dc9aadb7d2c213c93c4fb5e4cdf66d18fc1f78..8524c14affed68587cace9c2e8ac1f02f87052de 100644
--- a/drivers/s390/char/sclp_sd.c
+++ b/drivers/s390/char/sclp_sd.c
@@ -476,7 +476,7 @@ static struct kobj_type sclp_sd_file_ktype = {
  * on EOF.
  */
 static ssize_t data_read(struct file *file, struct kobject *kobj,
-			 struct bin_attribute *attr, char *buffer,
+			 const struct bin_attribute *attr, char *buffer,
 			 loff_t off, size_t size)
 {
 	struct sclp_sd_file *sd_file = to_sd_file(kobj);
@@ -539,7 +539,7 @@ static __init struct sclp_sd_file *sclp_sd_file_create(const char *name, u8 di)
 	sysfs_bin_attr_init(&sd_file->data_attr);
 	sd_file->data_attr.attr.name = "data";
 	sd_file->data_attr.attr.mode = 0444;
-	sd_file->data_attr.read = data_read;
+	sd_file->data_attr.read_new = data_read;
 
 	rc = sysfs_create_bin_file(&sd_file->kobj, &sd_file->data_attr);
 	if (rc) {

-- 
2.47.1

