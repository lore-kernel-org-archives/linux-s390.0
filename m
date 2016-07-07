From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/2] virtio/s390: deprecate old transport
Date: Thu,  7 Jul 2016 17:07:57 +0200
Message-ID: <1467904077-1887-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1467904077-1887-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1467904077-1887-1-git-send-email-cornelia.huck@de.ibm.com>
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
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

There only ever have been two host implementations of the old
s390-virtio (pre-ccw) transport: the experimental kuli userspace,
and qemu. As qemu switched its default to ccw with 2.4 (with most
users having used ccw well before that) and removed the old transport
entirely in 2.6, s390-virtio probably hasn't been in active use for
quite some time and is therefore likely to bitrot.

Let's start the slow march towards removing the code by deprecating
it.

Note that this also deprecates the early virtio console code, which
has been causing trouble in the guest without being wired up in any
relevant hypervisor code.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Sascha Silbe <silbe@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/Kconfig                | 13 +++++++++++++
 drivers/s390/virtio/Makefile     |  6 +++++-
 drivers/s390/virtio/kvm_virtio.c |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index a8c2590..80fffc2 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -875,4 +875,17 @@ config S390_GUEST
 	  Select this option if you want to run the kernel as a guest under
 	  the KVM hypervisor.
 
+config S390_GUEST_OLD_TRANSPORT
+	def_bool y
+	prompt "Guest support for old s390 virtio transport (DEPRECATED)"
+	depends on S390_GUEST
+	help
+	  Enable this option to add support for the old s390-virtio
+	  transport (i.e. virtio devices NOT based on virtio-ccw). This
+	  type of virtio devices is only available on the experimental
+	  kuli userspace or with old (< 2.6) qemu. If you are running
+	  with a modern version of qemu (which supports virtio-ccw since
+	  1.4 and uses it by default since version 2.4), you probably won't
+	  need this.
+
 endmenu
diff --git a/drivers/s390/virtio/Makefile b/drivers/s390/virtio/Makefile
index 241891a..df40692 100644
--- a/drivers/s390/virtio/Makefile
+++ b/drivers/s390/virtio/Makefile
@@ -6,4 +6,8 @@
 # it under the terms of the GNU General Public License (version 2 only)
 # as published by the Free Software Foundation.
 
-obj-$(CONFIG_S390_GUEST) += kvm_virtio.o virtio_ccw.o
+s390-virtio-objs := virtio_ccw.o
+ifdef CONFIG_S390_GUEST_OLD_TRANSPORT
+s390-virtio-objs += kvm_virtio.o
+endif
+obj-$(CONFIG_S390_GUEST) += $(s390-virtio-objs)
diff --git a/drivers/s390/virtio/kvm_virtio.c b/drivers/s390/virtio/kvm_virtio.c
index b0a849f..5e5c11f 100644
--- a/drivers/s390/virtio/kvm_virtio.c
+++ b/drivers/s390/virtio/kvm_virtio.c
@@ -458,6 +458,8 @@ static int __init kvm_devices_init(void)
 	if (test_devices_support(total_memory_size) < 0)
 		return -ENODEV;
 
+	pr_warn("The s390-virtio transport is deprecated. Please switch to a modern host providing virtio-ccw.\n");
+
 	rc = vmem_add_mapping(total_memory_size, PAGE_SIZE);
 	if (rc)
 		return rc;
-- 
2.6.6
