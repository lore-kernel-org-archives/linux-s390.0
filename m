Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 2/7] mdev: bus uevent support
Date: Fri, 11 Oct 2019 16:15:52 +0800
Message-Id: <20191011081557.28302-3-jasowang@redhat.com>
In-Reply-To: <20191011081557.28302-1-jasowang@redhat.com>
References: <20191011081557.28302-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, Jason Wang <jasowang@redhat.com>

This patch adds bus uevent support for mdev bus in order to allow
cooperation with userspace.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vfio/mdev/mdev_driver.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vfio/mdev/mdev_driver.c b/drivers/vfio/mdev/mdev_driver.c
index b7c40ce86ee3..319d886ffaf7 100644
--- a/drivers/vfio/mdev/mdev_driver.c
+++ b/drivers/vfio/mdev/mdev_driver.c
@@ -82,9 +82,17 @@ static int mdev_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
+static int mdev_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	return add_uevent_var(env, "MODALIAS=mdev:c%02X", mdev->class_id);
+}
+
 struct bus_type mdev_bus_type = {
 	.name		= "mdev",
 	.match		= mdev_match,
+	.uevent		= mdev_uevent,
 	.probe		= mdev_probe,
 	.remove		= mdev_remove,
 };
-- 
2.19.1
