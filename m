From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/2] virtio/s390: use dev_to_virtio
Date: Tue,  1 Mar 2016 13:44:52 +0100
Message-ID: <1456836293-49239-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1456836293-49239-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1456836293-49239-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: mst@redhat.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Geliang Tang <geliangtang@163.com>, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Geliang Tang <geliangtang@163.com>

Use dev_to_virtio() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
Message-Id: <912bf59bd3a48f2d4d4994681e898dc084fe29d3.1451484163.git.geliangtang@163.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index bf2d130..46b110a1 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -945,8 +945,7 @@ static struct virtio_config_ops virtio_ccw_config_ops = {
 
 static void virtio_ccw_release_dev(struct device *_d)
 {
-	struct virtio_device *dev = container_of(_d, struct virtio_device,
-						 dev);
+	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_ccw_device *vcdev = to_vc_device(dev);
 
 	kfree(vcdev->status);
-- 
2.3.9
