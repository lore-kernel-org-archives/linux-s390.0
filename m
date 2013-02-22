From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v2 1/2] linux-headers: Update with ioeventfd changes.
Date: Fri, 22 Feb 2013 13:09:59 +0100
Message-ID: <1361535000-39210-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1361535000-39210-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1361535000-39210-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 linux-headers/linux/kvm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 5af9357..00f2e53 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -448,12 +448,14 @@ enum {
 	kvm_ioeventfd_flag_nr_datamatch,
 	kvm_ioeventfd_flag_nr_pio,
 	kvm_ioeventfd_flag_nr_deassign,
+	kvm_ioeventfd_flag_nr_css,
 	kvm_ioeventfd_flag_nr_max,
 };
 
 #define KVM_IOEVENTFD_FLAG_DATAMATCH (1 << kvm_ioeventfd_flag_nr_datamatch)
 #define KVM_IOEVENTFD_FLAG_PIO       (1 << kvm_ioeventfd_flag_nr_pio)
 #define KVM_IOEVENTFD_FLAG_DEASSIGN  (1 << kvm_ioeventfd_flag_nr_deassign)
+#define KVM_IOEVENTFD_FLAG_CSS      (1 << kvm_ioeventfd_flag_nr_css)
 
 #define KVM_IOEVENTFD_VALID_FLAG_MASK  ((1 << kvm_ioeventfd_flag_nr_max) - 1)
 
-- 
1.7.12.4
