From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 1/4] KVM: s390/perf: provide additional sigp events
Date: Wed, 20 Apr 2016 14:54:53 +0200
Message-ID: <1461156896-27006-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1461156896-27006-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461156896-27006-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pbonzini@redhat.com, rkrcmar@redhat.com
Cc: borntraeger@de.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, jfrei@linux.vnet.ibm.com, agraf@suse.de, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

perf kvm stat can decode sigp events, let's make
the list complete by adding the missing ones.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/uapi/asm/sie.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/uapi/asm/sie.h b/arch/s390/include/uapi/asm/sie.h
index 5dbaa72..8fb5d4a 100644
--- a/arch/s390/include/uapi/asm/sie.h
+++ b/arch/s390/include/uapi/asm/sie.h
@@ -16,14 +16,19 @@
 	{ 0x01, "SIGP sense" },					\
 	{ 0x02, "SIGP external call" },				\
 	{ 0x03, "SIGP emergency signal" },			\
+	{ 0x04, "SIGP start" },					\
 	{ 0x05, "SIGP stop" },					\
 	{ 0x06, "SIGP restart" },				\
 	{ 0x09, "SIGP stop and store status" },			\
 	{ 0x0b, "SIGP initial cpu reset" },			\
+	{ 0x0c, "SIGP cpu reset" },				\
 	{ 0x0d, "SIGP set prefix" },				\
 	{ 0x0e, "SIGP store status at address" },		\
 	{ 0x12, "SIGP set architecture" },			\
-	{ 0x15, "SIGP sense running" }
+	{ 0x13, "SIGP conditional emergency signal" },		\
+	{ 0x15, "SIGP sense running" },				\
+	{ 0x16, "SIGP set multithreading"},			\
+	{ 0x17, "SIGP store additional status ait address"}
 
 #define icpt_prog_codes						\
 	{ 0x0001, "Prog Operation" },				\
-- 
2.8.1
