From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] KVM: s390: virtio-ccw: don't overwrite config space values
Date: Mon, 29 Jun 2015 16:44:01 +0200
Message-ID: <1435589041-36194-2-git-send-email-borntraeger@de.ibm.com>
References: <1435589041-36194-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1435589041-36194-1-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, mst@redhat.com, Eric Farman <farman@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Eric noticed problems with vhost-scsi and virtio-ccw: vhost-scsi
complained about overwriting values in the config space, which
was triggered by a broken implementation of virtio-ccw's config
get/set routines. It was probably sheer luck that we did not hit
this before.

When writing a value to the config space, the WRITE_CONF ccw will
always write from the beginning of the config space up to and
including the value to be set. If the config space up to the value
has not yet been retrieved from the device, however, we'll end up
overwriting values. Keep track of the known config space and update
if needed to avoid this.

Moreover, READ_CONF will only read the number of bytes it has been
instructed to retrieve, so we must not copy more than that to the
buffer, or we might overwrite trailing values.

Reported-by: Eric Farman <farman@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Tested-by: Eric Farman <farman@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/kvm/virtio_ccw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 6f1fa17..f8d8fdb 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -65,6 +65,7 @@ struct virtio_ccw_device {
 	bool is_thinint;
 	bool going_away;
 	bool device_lost;
+	unsigned int config_ready;
 	void *airq_info;
 };
 
@@ -833,8 +834,11 @@ static void virtio_ccw_get_config(struct virtio_device *vdev,
 	if (ret)
 		goto out_free;
 
-	memcpy(vcdev->config, config_area, sizeof(vcdev->config));
-	memcpy(buf, &vcdev->config[offset], len);
+	memcpy(vcdev->config, config_area, offset + len);
+	if (buf)
+		memcpy(buf, &vcdev->config[offset], len);
+	if (vcdev->config_ready < offset + len)
+		vcdev->config_ready = offset + len;
 
 out_free:
 	kfree(config_area);
@@ -857,6 +861,9 @@ static void virtio_ccw_set_config(struct virtio_device *vdev,
 	if (!config_area)
 		goto out_free;
 
+	/* Make sure we don't overwrite fields. */
+	if (vcdev->config_ready < offset)
+		virtio_ccw_get_config(vdev, 0, NULL, offset);
 	memcpy(&vcdev->config[offset], buf, len);
 	/* Write the config area to the host. */
 	memcpy(config_area, vcdev->config, sizeof(vcdev->config));
-- 
2.3.0
