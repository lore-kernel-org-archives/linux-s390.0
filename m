From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH] virtio/s390: rename drivers/s390/kvm -> drivers/s390/virtio
Date: Tue,  7 Jul 2015 11:41:01 +0200
Message-ID: <1436262061-684-1-git-send-email-cornelia.huck@de.ibm.com>
References: <55940495.9050007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <55940495.9050007@redhat.com>
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
To: virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

This more accurately reflects what these drivers actually do.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 MAINTAINERS                               | 2 +-
 drivers/s390/Makefile                     | 2 +-
 drivers/s390/{kvm => virtio}/Makefile     | 0
 drivers/s390/{kvm => virtio}/kvm_virtio.c | 0
 drivers/s390/{kvm => virtio}/virtio_ccw.c | 0
 5 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/s390/{kvm => virtio}/Makefile (100%)
 rename drivers/s390/{kvm => virtio}/kvm_virtio.c (100%)
 rename drivers/s390/{kvm => virtio}/virtio_ccw.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 280a568..fbef7d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10577,7 +10577,7 @@ L:	linux-s390@vger.kernel.org
 L:	virtualization@lists.linux-foundation.org
 L:	kvm@vger.kernel.org
 S:	Supported
-F:	drivers/s390/kvm/
+F:	drivers/s390/virtio/
 
 VIRTIO HOST (VHOST)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
diff --git a/drivers/s390/Makefile b/drivers/s390/Makefile
index 95bccfd..e5225ad 100644
--- a/drivers/s390/Makefile
+++ b/drivers/s390/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the S/390 specific device drivers
 #
 
-obj-y += cio/ block/ char/ crypto/ net/ scsi/ kvm/
+obj-y += cio/ block/ char/ crypto/ net/ scsi/ virtio/
 
 drivers-y += drivers/s390/built-in.o
 
diff --git a/drivers/s390/kvm/Makefile b/drivers/s390/virtio/Makefile
similarity index 100%
rename from drivers/s390/kvm/Makefile
rename to drivers/s390/virtio/Makefile
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/virtio/kvm_virtio.c
similarity index 100%
rename from drivers/s390/kvm/kvm_virtio.c
rename to drivers/s390/virtio/kvm_virtio.c
diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
similarity index 100%
rename from drivers/s390/kvm/virtio_ccw.c
rename to drivers/s390/virtio/virtio_ccw.c
-- 
2.3.8
