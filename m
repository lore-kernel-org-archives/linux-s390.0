Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5D1FF1DF;
	Wed, 11 Dec 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939684; cv=none; b=gbrGbEDv5/Al6yYh/Es9z4IjI5OWWmIW2jNuu0SBLyY8WN4YzlKMkda8ynaG1UDj96eIfr5zDxrUKxSrnr/PcatMzqMGQMpv92MqejnQqM5dXU/T5YjeroeRbC2uXdkQshB1rNQ5BbkZvsIQO3OHz+VqcqnA8NrQhjJp17xKyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939684; c=relaxed/simple;
	bh=JVQjkpYq0m8NNLrkS5kkhx1NJZrlRJn/xCgBxc5Xuxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b2pyeBSdznH14i70f3RTanf8eyi2fvyEcWJaE1FMb75pKiXMdjsNPWo4Ca17O8VvIZZVtoR0hp6NUbaxjcLb1nZv/VHxcKPAhSKMwRhegyzeI8j+25cZVfUvzDjJ2OnkfWqR+3FkNG6kPWWYUH7hkcC6nW/6BqUW3fCmbkYTAyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HJjTPiDw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HJjTPiDw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939680;
	bh=JVQjkpYq0m8NNLrkS5kkhx1NJZrlRJn/xCgBxc5Xuxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HJjTPiDwphn1YGm/cqVJoW6rmE2EQ3VLZ+FEoyMkhUZVUl1FMJ4llfc5ZNb3ZnhNE
	 0XVRPX6gP6tfaFYWvSUBKDwoJi2/ufZxVEKnx0ARYxQGr0wwSLzgrDqrjlYJWVNvqw
	 xhPB7orAJMxLaFSajc+Q8KxY8elPLc8gG2ansxgY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:54:41 +0100
Subject: [PATCH 3/5] s390/pci: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-s390-v1-3-be01f66bfcf7@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939680; l=2547;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JVQjkpYq0m8NNLrkS5kkhx1NJZrlRJn/xCgBxc5Xuxw=;
 b=K0tDhaO073OA7SbwOive+JxY3MHkp1wAoAWMGk7xawBIqh9mSxKVhZmX3UoE+iSsNLO0uyWO/
 8FXWt7yr+M+BbNeXd1Yal19Bz+T7R2MHMgHLWe7+nmYSTq1JwMp4y3F
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/s390/pci/pci_sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index 5f46ad58dcd1c3fda7e95aeabcdd10cdf9efd64e..2de1ea6c3a8cbd7cccc9c1005696eb96fd4d75dd 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -135,7 +135,7 @@ static ssize_t recover_store(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_WO(recover);
 
 static ssize_t util_string_read(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *attr, char *buf,
+				const struct bin_attribute *attr, char *buf,
 				loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -145,10 +145,10 @@ static ssize_t util_string_read(struct file *filp, struct kobject *kobj,
 	return memory_read_from_buffer(buf, count, &off, zdev->util_str,
 				       sizeof(zdev->util_str));
 }
-static BIN_ATTR_RO(util_string, CLP_UTIL_STR_LEN);
+static const BIN_ATTR_RO(util_string, CLP_UTIL_STR_LEN);
 
 static ssize_t report_error_write(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *attr, char *buf,
+				  const struct bin_attribute *attr, char *buf,
 				  loff_t off, size_t count)
 {
 	struct zpci_report_error_header *report = (void *) buf;
@@ -164,7 +164,7 @@ static ssize_t report_error_write(struct file *filp, struct kobject *kobj,
 
 	return ret ? ret : count;
 }
-static BIN_ATTR(report_error, S_IWUSR, NULL, report_error_write, PAGE_SIZE);
+static const BIN_ATTR(report_error, S_IWUSR, NULL, report_error_write, PAGE_SIZE);
 
 static ssize_t uid_is_unique_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
@@ -203,7 +203,7 @@ const struct attribute_group zpci_ident_attr_group = {
 	.is_visible = zpci_index_is_visible,
 };
 
-static struct bin_attribute *zpci_bin_attrs[] = {
+static const struct bin_attribute *const zpci_bin_attrs[] = {
 	&bin_attr_util_string,
 	&bin_attr_report_error,
 	NULL,
@@ -227,7 +227,7 @@ static struct attribute *zpci_dev_attrs[] = {
 
 const struct attribute_group zpci_attr_group = {
 	.attrs = zpci_dev_attrs,
-	.bin_attrs = zpci_bin_attrs,
+	.bin_attrs_new = zpci_bin_attrs,
 };
 
 static struct attribute *pfip_attrs[] = {

-- 
2.47.1

