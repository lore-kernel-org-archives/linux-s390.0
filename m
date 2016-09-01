From: Joe Perches <joe@perches.com>
Subject: [PATCH] trivial treewide: Convert dev_set_uevent_suppress argument to bool
Date: Thu,  1 Sep 2016 13:11:36 -0700
Message-ID: <699402ce4c488995b4ddabff0f3b262851cf56ac.1472760613.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>, Jiri Kosina <trivial@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Assigning an int to a bitfield:1 can lose precision.
Change the caller argument uses from 1/0 to true/false.

No change to objects.

Signed-off-by: Joe Perches <joe@perches.com>
---
 block/genhd.c               | 4 ++--
 block/partition-generic.c   | 4 ++--
 drivers/acpi/dock.c         | 2 +-
 drivers/s390/cio/chsc_sch.c | 2 +-
 drivers/s390/cio/css.c      | 4 ++--
 drivers/s390/cio/device.c   | 4 ++--
 drivers/s390/cio/eadm_sch.c | 2 +-
 fs/fuse/cuse.c              | 4 ++--
 include/linux/device.h      | 2 +-
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index a178c8e..b242eb5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -519,7 +519,7 @@ static void register_disk(struct device *parent, struct gendisk *disk)
 	dev_set_name(ddev, "%s", disk->disk_name);
 
 	/* delay uevents, until we scanned partition table */
-	dev_set_uevent_suppress(ddev, 1);
+	dev_set_uevent_suppress(ddev, true);
 
 	if (device_add(ddev))
 		return;
@@ -562,7 +562,7 @@ static void register_disk(struct device *parent, struct gendisk *disk)
 
 exit:
 	/* announce disk after possible partitions are created */
-	dev_set_uevent_suppress(ddev, 0);
+	dev_set_uevent_suppress(ddev, false);
 	kobject_uevent(&ddev->kobj, KOBJ_ADD);
 
 	/* announce possible partitions */
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 71d9ed9..4465d81 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -344,7 +344,7 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	pdev->devt = devt;
 
 	/* delay uevent until 'holders' subdir is created */
-	dev_set_uevent_suppress(pdev, 1);
+	dev_set_uevent_suppress(pdev, true);
 	err = device_add(pdev);
 	if (err)
 		goto out_put;
@@ -354,7 +354,7 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	if (!p->holder_dir)
 		goto out_del;
 
-	dev_set_uevent_suppress(pdev, 0);
+	dev_set_uevent_suppress(pdev, false);
 	if (flags & ADDPART_FLAG_WHOLEDISK) {
 		err = device_create_file(pdev, &dev_attr_whole_disk);
 		if (err)
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 0c00208..6add25f 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -623,7 +623,7 @@ void acpi_dock_add(struct acpi_device *adev)
 	INIT_LIST_HEAD(&dock_station->dependent_devices);
 
 	/* we want the dock device to send uevents */
-	dev_set_uevent_suppress(&dd->dev, 0);
+	dev_set_uevent_suppress(&dd->dev, false);
 
 	if (acpi_dock_match(handle))
 		dock_station->flags |= DOCK_IS_DOCK;
diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 735052e..f767d0b 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -97,7 +97,7 @@ static int chsc_subchannel_probe(struct subchannel *sch)
 		kfree(private);
 	} else {
 		if (dev_get_uevent_suppress(&sch->dev)) {
-			dev_set_uevent_suppress(&sch->dev, 0);
+			dev_set_uevent_suppress(&sch->dev, false);
 			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
 		}
 	}
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 3d2b20e..2b26626 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -310,7 +310,7 @@ int css_register_subchannel(struct subchannel *sch)
 	 * the subchannel driver can decide itself when it wants to inform
 	 * userspace of its existence.
 	 */
-	dev_set_uevent_suppress(&sch->dev, 1);
+	dev_set_uevent_suppress(&sch->dev, true);
 	css_update_ssd_info(sch);
 	/* make it known to the system */
 	ret = css_sch_device_register(sch);
@@ -325,7 +325,7 @@ int css_register_subchannel(struct subchannel *sch)
 		 * a fitting driver module may be loaded based on the
 		 * modalias.
 		 */
-		dev_set_uevent_suppress(&sch->dev, 0);
+		dev_set_uevent_suppress(&sch->dev, false);
 		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
 	}
 	return ret;
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 6a58bc8..bfe8056 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -868,7 +868,7 @@ static void io_subchannel_register(struct ccw_device *cdev)
 	 * Now we know this subchannel will stay, we can throw
 	 * our delayed uevent.
 	 */
-	dev_set_uevent_suppress(&sch->dev, 0);
+	dev_set_uevent_suppress(&sch->dev, false);
 	kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
 	/* make it known to the system */
 	ret = ccw_device_add(cdev);
@@ -1077,7 +1077,7 @@ static int io_subchannel_probe(struct subchannel *sch)
 		 * Throw the delayed uevent for the subchannel, register
 		 * the ccw_device and exit.
 		 */
-		dev_set_uevent_suppress(&sch->dev, 0);
+		dev_set_uevent_suppress(&sch->dev, false);
 		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
 		cdev = sch_get_cdev(sch);
 		rc = ccw_device_add(cdev);
diff --git a/drivers/s390/cio/eadm_sch.c b/drivers/s390/cio/eadm_sch.c
index b3f44bc..fcccd74 100644
--- a/drivers/s390/cio/eadm_sch.c
+++ b/drivers/s390/cio/eadm_sch.c
@@ -251,7 +251,7 @@ static int eadm_subchannel_probe(struct subchannel *sch)
 	spin_unlock_irq(&list_lock);
 
 	if (dev_get_uevent_suppress(&sch->dev)) {
-		dev_set_uevent_suppress(&sch->dev, 0);
+		dev_set_uevent_suppress(&sch->dev, false);
 		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
 	}
 out:
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index c5b6b71..be3867f 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -350,7 +350,7 @@ static void cuse_process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
 		goto err_region;
 
 	device_initialize(dev);
-	dev_set_uevent_suppress(dev, 1);
+	dev_set_uevent_suppress(dev, true);
 	dev->class = cuse_class;
 	dev->devt = devt;
 	dev->release = cuse_gendev_release;
@@ -391,7 +391,7 @@ static void cuse_process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
 	mutex_unlock(&cuse_lock);
 
 	/* announce device availability */
-	dev_set_uevent_suppress(dev, 0);
+	dev_set_uevent_suppress(dev, false);
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
 out:
 	kfree(arg);
diff --git a/include/linux/device.h b/include/linux/device.h
index 38f0281..69e3c19 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -929,7 +929,7 @@ static inline unsigned int dev_get_uevent_suppress(const struct device *dev)
 	return dev->kobj.uevent_suppress;
 }
 
-static inline void dev_set_uevent_suppress(struct device *dev, int val)
+static inline void dev_set_uevent_suppress(struct device *dev, bool val)
 {
 	dev->kobj.uevent_suppress = val;
 }
-- 
2.10.0.rc2.1.g053435c
