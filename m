Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9792E218AD3;
	Thu,  5 Dec 2024 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418459; cv=none; b=Nz84DRxOJW4YD7jnMtRxOQtOD+904nsnJ44P/oHIMi2vkFzY8rYC5aCPeJk4lLqEA6UhJRviIZuriv1icM9SPDosifyNQUGL6jDfrolZ213e1Zb+kWRQLuBkPGjiwrAQ//ONIAuo89GfDfur2lrXQpwNp1saOXWeDffdAs4oevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418459; c=relaxed/simple;
	bh=E3N88pgbfcFNczdyyZIDRWIEzyj/imMXLOtvtzzfj5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V4D83OiebWhcZlPQ6sSVxKRc1nFuzPv4ZezwCHPvMEFqXIFYUcsk7UrK0RIjPtKRhYvrxO0KlNiYHMq1a792QUUi5sBBDZPwtrOEN29rbUF5jqInDUVDpGu9gdxvWl/Tb0zzAOIQHYsj2DJYS0KPY+fRFABMr9T+7z0cq4X7yJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gMg9obWh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gMg9obWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733418454;
	bh=E3N88pgbfcFNczdyyZIDRWIEzyj/imMXLOtvtzzfj5I=;
	h=From:Date:Subject:To:Cc:From;
	b=gMg9obWhZy2Hze5qDX2TxRvmJ3ZO2py+NRt8sMvfLrUksupPw/mWexk22inDUtNcW
	 Dd/3O2Riue6i/GbcqdilnilBEYvUnP6OMj/R4aBjY/sK+7o+Y9hdbODZF0Eo5sQZGe
	 MYHmXb0gkzIiQLrItT8E8KpiQ7W2LB2mgaJEq4vo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 05 Dec 2024 18:07:31 +0100
Subject: [PATCH] sysfs: constify macro BIN_ATTRIBUTE_GROUPS()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-sysfs-const-bin_attr-groups_macro-v1-1-ac5e855031e8@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIANLdUWcC/x3NQQ6CMBBA0auQWTtJqVLEqxhDapniLGjJTDUaw
 t1tWL7N/xsoCZPCrdlA6MPKOVW0pwbCy6eZkKdqsMZeWms61J9GxZCTFnxyGn0pgrPk96rj4oN
 kdNF5d566fjBXqJ1VKPL3eNwf+/4HPRR1D3MAAAA=
X-Change-ID: 20241205-sysfs-const-bin_attr-groups_macro-6f6a63d57908
To: Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733418454; l=4906;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=E3N88pgbfcFNczdyyZIDRWIEzyj/imMXLOtvtzzfj5I=;
 b=v+ul19CBklTVDUy3JIyuDMl11glqTGxgWy0d6lIV29RyMzkcHe1OYz5oi1wy8knh7oEYiFW1x
 8ER6gtOEbQJALaVzaJ+kHsD+0MZGyd0So2PBAYZc0/smZD2gWU2IDId
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

As there is only one in-tree user, avoid a transition phase and switch
that user in the same commit. As there are some interdependencies
between the constness of the different symbols in the s390 driver,
covert the whole driver at once.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
This is intended to be merged through the driver core tree.
---
 drivers/s390/cio/chp.c | 28 ++++++++++++++--------------
 include/linux/sysfs.h  |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index cba2d048a96b3cb0cc79080ef4c771b0f7d5bc34..4a0b3f19bd8ef9780da6b4657fbda73171e8c22b 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -128,7 +128,7 @@ static int s390_vary_chpid(struct chp_id chpid, int on)
  * Channel measurement related functions
  */
 static ssize_t measurement_chars_read(struct file *filp, struct kobject *kobj,
-				      struct bin_attribute *bin_attr,
+				      const struct bin_attribute *bin_attr,
 				      char *buf, loff_t off, size_t count)
 {
 	struct channel_path *chp;
@@ -142,11 +142,11 @@ static ssize_t measurement_chars_read(struct file *filp, struct kobject *kobj,
 	return memory_read_from_buffer(buf, count, &off, &chp->cmg_chars,
 				       sizeof(chp->cmg_chars));
 }
-static BIN_ATTR_ADMIN_RO(measurement_chars, sizeof(struct cmg_chars));
+static const BIN_ATTR_ADMIN_RO(measurement_chars, sizeof(struct cmg_chars));
 
 static ssize_t measurement_chars_full_read(struct file *filp,
 					   struct kobject *kobj,
-					   struct bin_attribute *bin_attr,
+					   const struct bin_attribute *bin_attr,
 					   char *buf, loff_t off, size_t count)
 {
 	struct channel_path *chp = to_channelpath(kobj_to_dev(kobj));
@@ -196,22 +196,22 @@ static ssize_t chp_measurement_copy_block(void *buf, loff_t off, size_t count,
 }
 
 static ssize_t measurement_read(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *bin_attr,
+				const struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
 	return chp_measurement_copy_block(buf, off, count, kobj, false);
 }
-static BIN_ATTR_ADMIN_RO(measurement, sizeof(struct cmg_entry));
+static const BIN_ATTR_ADMIN_RO(measurement, sizeof(struct cmg_entry));
 
 static ssize_t ext_measurement_read(struct file *filp, struct kobject *kobj,
-				    struct bin_attribute *bin_attr,
+				    const struct bin_attribute *bin_attr,
 				    char *buf, loff_t off, size_t count)
 {
 	return chp_measurement_copy_block(buf, off, count, kobj, true);
 }
-static BIN_ATTR_ADMIN_RO(ext_measurement, sizeof(struct cmg_ext_entry));
+static const BIN_ATTR_ADMIN_RO(ext_measurement, sizeof(struct cmg_ext_entry));
 
-static struct bin_attribute *measurement_attrs[] = {
+static const struct bin_attribute *measurement_attrs[] = {
 	&bin_attr_measurement_chars,
 	&bin_attr_measurement_chars_full,
 	&bin_attr_measurement,
@@ -435,7 +435,7 @@ static ssize_t speed_bps_show(struct device *dev,
 static DEVICE_ATTR_RO(speed_bps);
 
 static ssize_t util_string_read(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *attr, char *buf,
+				const struct bin_attribute *attr, char *buf,
 				loff_t off, size_t count)
 {
 	struct channel_path *chp = to_channelpath(kobj_to_dev(kobj));
@@ -448,10 +448,10 @@ static ssize_t util_string_read(struct file *filp, struct kobject *kobj,
 
 	return rc;
 }
-static BIN_ATTR_RO(util_string,
-		   sizeof(((struct channel_path_desc_fmt3 *)0)->util_str));
+static const BIN_ATTR_RO(util_string,
+			 sizeof(((struct channel_path_desc_fmt3 *)0)->util_str));
 
-static struct bin_attribute *chp_bin_attrs[] = {
+static const struct bin_attribute *const chp_bin_attrs[] = {
 	&bin_attr_util_string,
 	NULL,
 };
@@ -468,9 +468,9 @@ static struct attribute *chp_attrs[] = {
 	&dev_attr_speed_bps.attr,
 	NULL,
 };
-static struct attribute_group chp_attr_group = {
+static const struct attribute_group chp_attr_group = {
 	.attrs = chp_attrs,
-	.bin_attrs = chp_bin_attrs,
+	.bin_attrs_new = chp_bin_attrs,
 };
 static const struct attribute_group *chp_attr_groups[] = {
 	&chp_attr_group,
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 0f2fcd244523f050c5286f19d4fe1846506f9214..b4368377fac96734a5ee98209f9532b838953f07 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -293,7 +293,7 @@ __ATTRIBUTE_GROUPS(_name)
 
 #define BIN_ATTRIBUTE_GROUPS(_name)				\
 static const struct attribute_group _name##_group = {		\
-	.bin_attrs = _name##_attrs,				\
+	.bin_attrs_new = _name##_attrs,				\
 };								\
 __ATTRIBUTE_GROUPS(_name)
 

---
base-commit: dabe889a826e866d71af72a890f2be07a660350c
change-id: 20241205-sysfs-const-bin_attr-groups_macro-6f6a63d57908

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

