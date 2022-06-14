Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C57BCCA47E
	for <linux-s390@archiver.kernel.org>; Tue, 14 Jun 2022 04:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiFNEyv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Jun 2022 00:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240897AbiFNEyt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Jun 2022 00:54:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0E437BDA;
        Mon, 13 Jun 2022 21:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=I4XEyLqCvzQB/0jLxu8w6ax2i3tpB+17YQ0dEyNCgvI=; b=cMtWp2R6vygp0VxfDb55RnGBCp
        62ZaMpRAmBBC1+eafk6T/24rva95JOjcx9O5cy6yKOth+Tnfv1ekkBMzlY2B07WHUnrNnsi1YrvFY
        RkOKkobaWk9VIJgVd95XVE5r5AfYWAxQoreMYwDhyFaW6341ykp1KArIl8kfikCU+lOfL1hDzgoZH
        1KQID/IO70IQzt97Qrl/hXc2wDhgnDcPZ2NfTfXus7BOXbU4GyZ/SVL1sURn4+W1Lt0mSjg7iMN4d
        iLghi6IeY8fbPo8w39rkzOZpThQy5KiXvYptyWleSIipkYi36ZbJxahwScCSsiveKqMA9UsNqZ1q4
        j+mHuRtg==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0yZc-0072ez-Tn; Tue, 14 Jun 2022 04:54:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 04/13] vfio/mdev: remove mdev_{create,remove}_sysfs_files
Date:   Tue, 14 Jun 2022 06:54:19 +0200
Message-Id: <20220614045428.278494-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614045428.278494-1-hch@lst.de>
References: <20220614045428.278494-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Just fold these two trivial helpers into their only callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/vfio/mdev/mdev_core.c    | 12 ++++++++++--
 drivers/vfio/mdev/mdev_private.h |  3 ---
 drivers/vfio/mdev/mdev_sysfs.c   | 28 ----------------------------
 3 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 71c7f4e521a74..fe4230b21993d 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -44,7 +44,8 @@ static void mdev_device_remove_common(struct mdev_device *mdev)
 {
 	struct mdev_parent *parent = mdev->type->parent;
 
-	mdev_remove_sysfs_files(mdev);
+	sysfs_remove_link(&mdev->dev.kobj, "mdev_type");
+	sysfs_remove_link(mdev->type->devices_kobj, dev_name(&mdev->dev));
 	device_del(&mdev->dev);
 	lockdep_assert_held(&parent->unreg_sem);
 	/* Balances with device_initialize() */
@@ -212,16 +213,23 @@ int mdev_device_create(struct mdev_type *type, const guid_t *uuid)
 	if (ret)
 		goto out_del;
 
-	ret = mdev_create_sysfs_files(mdev);
+	ret = sysfs_create_link(type->devices_kobj, &mdev->dev.kobj,
+				dev_name(&mdev->dev));
 	if (ret)
 		goto out_del;
 
+	ret = sysfs_create_link(&mdev->dev.kobj, &type->kobj, "mdev_type");
+	if (ret)
+		goto out_remove_type_link;
+
 	mdev->active = true;
 	dev_dbg(&mdev->dev, "MDEV: created\n");
 	up_read(&parent->unreg_sem);
 
 	return 0;
 
+out_remove_type_link:
+	sysfs_remove_link(mdev->type->devices_kobj, dev_name(&mdev->dev));
 out_del:
 	device_del(&mdev->dev);
 out_unlock:
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index 6980f504018f3..346b9ec320466 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -20,9 +20,6 @@ extern const struct attribute_group *mdev_device_groups[];
 #define to_mdev_type(_kobj)		\
 	container_of(_kobj, struct mdev_type, kobj)
 
-int  mdev_create_sysfs_files(struct mdev_device *mdev);
-void mdev_remove_sysfs_files(struct mdev_device *mdev);
-
 int mdev_type_add(struct mdev_parent *parent, struct mdev_type *type);
 void mdev_type_remove(struct mdev_type *type);
 
diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
index 09745e8e120f9..dd81b91afcf7d 100644
--- a/drivers/vfio/mdev/mdev_sysfs.c
+++ b/drivers/vfio/mdev/mdev_sysfs.c
@@ -170,31 +170,3 @@ const struct attribute_group *mdev_device_groups[] = {
 	&mdev_device_group,
 	NULL
 };
-
-int mdev_create_sysfs_files(struct mdev_device *mdev)
-{
-	struct mdev_type *type = mdev->type;
-	struct kobject *kobj = &mdev->dev.kobj;
-	int ret;
-
-	ret = sysfs_create_link(type->devices_kobj, kobj, dev_name(&mdev->dev));
-	if (ret)
-		return ret;
-
-	ret = sysfs_create_link(kobj, &type->kobj, "mdev_type");
-	if (ret)
-		goto type_link_failed;
-	return ret;
-
-type_link_failed:
-	sysfs_remove_link(mdev->type->devices_kobj, dev_name(&mdev->dev));
-	return ret;
-}
-
-void mdev_remove_sysfs_files(struct mdev_device *mdev)
-{
-	struct kobject *kobj = &mdev->dev.kobj;
-
-	sysfs_remove_link(kobj, "mdev_type");
-	sysfs_remove_link(mdev->type->devices_kobj, dev_name(&mdev->dev));
-}
-- 
2.30.2

