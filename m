From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 4/5] virtio/s390: add missing \n to end of dev_err message
Date: Mon, 16 Jan 2017 15:04:32 +0100
Message-ID: <20170116140433.21301-5-cornelia.huck@de.ibm.com>
References: <20170116140433.21301-1-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170116140433.21301-1-cornelia.huck@de.ibm.com>
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
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Colin Ian King <colin.king@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trival fix, dev_err message is missing a \n, so add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Message-Id: <20160927200844.16008-1-colin.king@canonical.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 01e3dcfd7c64..0672c6234ae8 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -454,7 +454,7 @@ static void virtio_ccw_del_vq(struct virtqueue *vq, struct ccw1 *ccw)
 	 * This may happen on device detach.
 	 */
 	if (ret && (ret != -ENODEV))
-		dev_warn(&vq->vdev->dev, "Error %d while deleting queue %d",
+		dev_warn(&vq->vdev->dev, "Error %d while deleting queue %d\n",
 			 ret, index);
 
 	vring_del_virtqueue(vq);
-- 
2.11.0
