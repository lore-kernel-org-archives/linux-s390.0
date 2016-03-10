From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/9] KVM: s390: Add diag "watchdog functions" to trace event decoding
Date: Thu, 10 Mar 2016 16:36:51 +0100
Message-ID: <1457624219-110920-2-git-send-email-borntraeger@de.ibm.com>
References: <1457624219-110920-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1457624219-110920-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

DIAG 0x288 may occur now. Let's add its code to the diag table in
sie.h.

Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/uapi/asm/sie.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/uapi/asm/sie.h b/arch/s390/include/uapi/asm/sie.h
index ee69c08..5dbaa72 100644
--- a/arch/s390/include/uapi/asm/sie.h
+++ b/arch/s390/include/uapi/asm/sie.h
@@ -7,6 +7,7 @@
 	{ 0x9c, "DIAG (0x9c) time slice end directed" },	\
 	{ 0x204, "DIAG (0x204) logical-cpu utilization" },	\
 	{ 0x258, "DIAG (0x258) page-reference services" },	\
+	{ 0x288, "DIAG (0x288) watchdog functions" },		\
 	{ 0x308, "DIAG (0x308) ipl functions" },		\
 	{ 0x500, "DIAG (0x500) KVM virtio functions" },		\
 	{ 0x501, "DIAG (0x501) KVM breakpoint" }
-- 
2.5.0
