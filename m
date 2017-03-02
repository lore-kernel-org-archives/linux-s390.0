From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] s390/virtio: change maintainership
Date: Thu,  2 Mar 2017 17:08:23 +0100
Message-ID: <1488470903-16358-2-git-send-email-borntraeger@de.ibm.com>
References: <1488470903-16358-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1488470903-16358-1-git-send-email-borntraeger@de.ibm.com>
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
To: borntraeger@de.ibm.com, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Halil is doing a lot more work in the virtio area on s390 than I
do. Let's reflect the reality in the maintainers file.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca6f5f7..52780b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13203,8 +13203,8 @@ F:	include/uapi/linux/virtio_*.h
 F:	drivers/crypto/virtio/
 
 VIRTIO DRIVERS FOR S390
-M:	Christian Borntraeger <borntraeger@de.ibm.com>
 M:	Cornelia Huck <cornelia.huck@de.ibm.com>
+M:	Halil Pasic <pasic@linux.vnet.ibm.com>
 L:	linux-s390@vger.kernel.org
 L:	virtualization@lists.linux-foundation.org
 L:	kvm@vger.kernel.org
-- 
2.7.4
