From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH 1/2] linux-headers: Update with ioeventfd changes.
Date: Thu, 21 Feb 2013 14:13:11 +0100
Message-ID: <1361452392-55867-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1361452392-55867-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1361452392-55867-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 linux-headers/linux/kvm.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 5af9357..a7f92a0 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -448,12 +448,14 @@ enum {
 	kvm_ioeventfd_flag_nr_datamatch,
 	kvm_ioeventfd_flag_nr_pio,
 	kvm_ioeventfd_flag_nr_deassign,
+	kvm_ioeventfd_flag_nr_arch,
 	kvm_ioeventfd_flag_nr_max,
 };
 
 #define KVM_IOEVENTFD_FLAG_DATAMATCH (1 << kvm_ioeventfd_flag_nr_datamatch)
 #define KVM_IOEVENTFD_FLAG_PIO       (1 << kvm_ioeventfd_flag_nr_pio)
 #define KVM_IOEVENTFD_FLAG_DEASSIGN  (1 << kvm_ioeventfd_flag_nr_deassign)
+#define KVM_IOEVENTFD_FLAG_ARCH      (1 << kvm_ioeventfd_flag_nr_arch)
 
 #define KVM_IOEVENTFD_VALID_FLAG_MASK  ((1 << kvm_ioeventfd_flag_nr_max) - 1)
 
@@ -463,7 +465,7 @@ struct kvm_ioeventfd {
 	__u32 len;         /* 1, 2, 4, or 8 bytes    */
 	__s32 fd;
 	__u32 flags;
-	__u8  pad[36];
+	__u8  data[36];    /* for architecture-specific data */
 };
 
 /* for KVM_ENABLE_CAP */
-- 
1.7.12.4
