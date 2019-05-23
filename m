Return-Path: <SRS0=0NiW=TX=vger.kernel.org=kvm-owner@kernel.org>
From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v2 8/8] virtio/s390: make airq summary indicators DMA
Date: Thu, 23 May 2019 18:22:09 +0200
In-Reply-To: <20190523162209.9543-1-mimu@linux.ibm.com>
References: <20190523162209.9543-1-mimu@linux.ibm.com>
Message-Id: <20190523162209.9543-9-mimu@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Halil Pasic <pasic@linux.ibm.com>

Hypervisor needs to interact with the summary indicators, so these
need to be DMA memory as well (at least for protected virtualization
guests).

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 03c9f7001fb1..f666ed397dc0 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -140,11 +140,17 @@ static int virtio_ccw_use_airq = 1;
 
 struct airq_info {
 	rwlock_t lock;
-	u8 summary_indicator;
+	u8 summary_indicator_idx;
 	struct airq_struct airq;
 	struct airq_iv *aiv;
 };
 static struct airq_info *airq_areas[MAX_AIRQ_AREAS];
+static u8 *summary_indicators;
+
+static inline u8 *get_summary_indicator(struct airq_info *info)
+{
+	return summary_indicators + info->summary_indicator_idx;
+}
 
 #define CCW_CMD_SET_VQ 0x13
 #define CCW_CMD_VDEV_RESET 0x33
@@ -225,7 +231,7 @@ static void virtio_airq_handler(struct airq_struct *airq, bool floating)
 			break;
 		vring_interrupt(0, (void *)airq_iv_get_ptr(info->aiv, ai));
 	}
-	info->summary_indicator = 0;
+	*(get_summary_indicator(info)) = 0;
 	smp_wmb();
 	/* Walk through indicators field, summary indicator not active. */
 	for (ai = 0;;) {
@@ -237,7 +243,7 @@ static void virtio_airq_handler(struct airq_struct *airq, bool floating)
 	read_unlock(&info->lock);
 }
 
-static struct airq_info *new_airq_info(void)
+static struct airq_info *new_airq_info(int index)
 {
 	struct airq_info *info;
 	int rc;
@@ -253,7 +259,8 @@ static struct airq_info *new_airq_info(void)
 		return NULL;
 	}
 	info->airq.handler = virtio_airq_handler;
-	info->airq.lsi_ptr = &info->summary_indicator;
+	info->summary_indicator_idx = index;
+	info->airq.lsi_ptr = get_summary_indicator(info);
 	info->airq.lsi_mask = 0xff;
 	info->airq.isc = VIRTIO_AIRQ_ISC;
 	rc = register_adapter_interrupt(&info->airq);
@@ -275,7 +282,7 @@ static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 
 	for (i = 0; i < MAX_AIRQ_AREAS && !indicator_addr; i++) {
 		if (!airq_areas[i])
-			airq_areas[i] = new_airq_info();
+			airq_areas[i] = new_airq_info(i);
 		info = airq_areas[i];
 		if (!info)
 			return 0;
@@ -360,7 +367,7 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
 		if (!thinint_area)
 			return;
 		thinint_area->summary_indicator =
-			(unsigned long) &airq_info->summary_indicator;
+			(unsigned long) get_summary_indicator(airq_info);
 		thinint_area->isc = VIRTIO_AIRQ_ISC;
 		ccw->cmd_code = CCW_CMD_SET_IND_ADAPTER;
 		ccw->count = sizeof(*thinint_area);
@@ -625,7 +632,7 @@ static int virtio_ccw_register_adapter_ind(struct virtio_ccw_device *vcdev,
 	}
 	info = vcdev->airq_info;
 	thinint_area->summary_indicator =
-		(unsigned long) &info->summary_indicator;
+		(unsigned long) get_summary_indicator(info);
 	thinint_area->isc = VIRTIO_AIRQ_ISC;
 	ccw->cmd_code = CCW_CMD_SET_IND_ADAPTER;
 	ccw->flags = CCW_FLAG_SLI;
@@ -1501,6 +1508,7 @@ static int __init virtio_ccw_init(void)
 {
 	/* parse no_auto string before we do anything further */
 	no_auto_parse();
+	summary_indicators = cio_dma_zalloc(MAX_AIRQ_AREAS);
 	return ccw_driver_register(&virtio_ccw_driver);
 }
 device_initcall(virtio_ccw_init);
-- 
2.13.4
