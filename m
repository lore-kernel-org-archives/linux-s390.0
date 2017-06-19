From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 3/4] s390/diag: add diag26c support
Date: Mon, 19 Jun 2017 13:22:24 +0200
Message-ID: <20170619112225.30471-4-jwi@linux.vnet.ibm.com>
References: <20170619112225.30471-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170619112225.30471-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Implement support for the hypervisor diagnose 0x26c
('Access Certain System Information').
It passes a request buffer and a subfunction code, and receives
a response buffer and a return code.

Also add the scaffolding for the 'MAC Services' subfunction.
It may be used by network devices to obtain a hypervisor-managed
MAC address.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/include/asm/diag.h | 26 ++++++++++++++++++++++++++
 arch/s390/kernel/diag.c      | 29 +++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index 8acf482162ed..96abd80528fc 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -8,6 +8,7 @@
 #ifndef _ASM_S390_DIAG_H
 #define _ASM_S390_DIAG_H
 
+#include <linux/if_ether.h>
 #include <linux/percpu.h>
 
 enum diag_stat_enum {
@@ -24,6 +25,7 @@ enum diag_stat_enum {
 	DIAG_STAT_X224,
 	DIAG_STAT_X250,
 	DIAG_STAT_X258,
+	DIAG_STAT_X26C,
 	DIAG_STAT_X288,
 	DIAG_STAT_X2C4,
 	DIAG_STAT_X2FC,
@@ -225,6 +227,30 @@ struct diag204_x_phys_block {
 	struct diag204_x_phys_cpu cpus[];
 } __packed;
 
+enum diag26c_sc {
+	DIAG26C_MAC_SERVICES = 0x00000030
+};
+
+enum diag26c_version {
+	DIAG26C_VERSION2 = 0x00000002	/* z/VM 5.4.0 */
+};
+
+#define DIAG26C_GET_MAC	0x0000
+struct diag26c_mac_req {
+	u32	resp_buf_len;
+	u32	resp_version;
+	u16	op_code;
+	u16	devno;
+	u8	res[4];
+} __packed;
+
+struct diag26c_mac_resp {
+	u32	version;
+	u8	mac[ETH_ALEN];
+	u16	res;
+} __packed __aligned(8);
+
 int diag204(unsigned long subcode, unsigned long size, void *addr);
 int diag224(void *ptr);
+int diag26c(void *req, void *resp, enum diag26c_sc subcode);
 #endif /* _ASM_S390_DIAG_H */
diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index ac6abcd3fe6a..349914571772 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -38,6 +38,7 @@ static const struct diag_desc diag_map[NR_DIAG_STAT] = {
 	[DIAG_STAT_X224] = { .code = 0x224, .name = "EBCDIC-Name Table" },
 	[DIAG_STAT_X250] = { .code = 0x250, .name = "Block I/O" },
 	[DIAG_STAT_X258] = { .code = 0x258, .name = "Page-Reference Services" },
+	[DIAG_STAT_X26C] = { .code = 0x26c, .name = "Certain System Information" },
 	[DIAG_STAT_X288] = { .code = 0x288, .name = "Time Bomb" },
 	[DIAG_STAT_X2C4] = { .code = 0x2c4, .name = "FTP Services" },
 	[DIAG_STAT_X2FC] = { .code = 0x2fc, .name = "Guest Performance Data" },
@@ -236,3 +237,31 @@ int diag224(void *ptr)
 	return rc;
 }
 EXPORT_SYMBOL(diag224);
+
+/*
+ * Diagnose 26C: Access Certain System Information
+ */
+static inline int __diag26c(void *req, void *resp, enum diag26c_sc subcode)
+{
+	register unsigned long _req asm("2") = (addr_t) req;
+	register unsigned long _resp asm("3") = (addr_t) resp;
+	register unsigned long _subcode asm("4") = subcode;
+	register unsigned long _rc asm("5") = -EOPNOTSUPP;
+
+	asm volatile(
+		"	sam31\n"
+		"	diag	%[rx],%[ry],0x26c\n"
+		"0:	sam64\n"
+		EX_TABLE(0b,0b)
+		: "+d" (_rc)
+		: [rx] "d" (_req), "d" (_resp), [ry] "d" (_subcode)
+		: "cc", "memory");
+	return _rc;
+}
+
+int diag26c(void *req, void *resp, enum diag26c_sc subcode)
+{
+	diag_stat_inc(DIAG_STAT_X26C);
+	return __diag26c(req, resp, subcode);
+}
+EXPORT_SYMBOL(diag26c);
-- 
2.11.2
