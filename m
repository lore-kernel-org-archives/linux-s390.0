From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 1/3] virtio-ccw: diag 500 may return a negative cookie
Date: Mon, 21 Jan 2019 13:19:42 +0100
Message-ID: <20190121121944.12309-2-cohuck@redhat.com>
References: <20190121121944.12309-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190121121944.12309-1-cohuck@redhat.com>
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
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

If something goes wrong in the kvm io bus handling, the virtio-ccw
diagnose may return a negative error value in the cookie gpr.

Document this.

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 Documentation/virtual/kvm/s390-diag.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/s390-diag.txt b/Documentation/virtual/kvm/s390-diag.txt
index 48c4921794ed..7c52e5f8b210 100644
--- a/Documentation/virtual/kvm/s390-diag.txt
+++ b/Documentation/virtual/kvm/s390-diag.txt
@@ -68,7 +68,8 @@ Subcode 3 - virtio-ccw notification
     identifier, it is ignored.
 
     After completion of the DIAGNOSE call, general register 2 may contain
-    a 64bit identifier (in the kvm_io_bus cookie case).
+    a 64bit identifier (in the kvm_io_bus cookie case), or a negative
+    error value, if an internal error occurred.
 
     See also the virtio standard for a discussion of this hypercall.
 
-- 
2.17.2
