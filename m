From: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] KVM: s390: Disable CONFIG_S390_GUEST_OLD_TRANSPORT by default
Date: Mon, 25 Sep 2017 16:45:29 +0200
Message-ID: <1506350729-11311-1-git-send-email-thuth@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

There is no recent user space application available anymore which still
supports this old virtio transport, so let's disable this by default.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 48af970..923bf04 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -930,7 +930,7 @@ config S390_GUEST
 	  the KVM hypervisor.
 
 config S390_GUEST_OLD_TRANSPORT
-	def_bool y
+	def_bool n
 	prompt "Guest support for old s390 virtio transport (DEPRECATED)"
 	depends on S390_GUEST
 	help
-- 
1.8.3.1
