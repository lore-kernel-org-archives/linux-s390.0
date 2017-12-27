From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 3/4] s390/diag: add diag26c support for VNIC info
Date: Wed, 27 Dec 2017 17:44:30 +0100
Message-ID: <20171227164431.17118-4-jwi@linux.vnet.ibm.com>
References: <20171227164431.17118-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171227164431.17118-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

With subcode 0x24, diag26c returns all sorts of VNIC-related information.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/diag.h | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index 6db78567294c..cdbaad50c7c7 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -229,13 +229,55 @@ struct diag204_x_phys_block {
 } __packed;
 
 enum diag26c_sc {
+	DIAG26C_PORT_VNIC    = 0x00000024,
 	DIAG26C_MAC_SERVICES = 0x00000030
 };
 
 enum diag26c_version {
-	DIAG26C_VERSION2 = 0x00000002	/* z/VM 5.4.0 */
+	DIAG26C_VERSION2	 = 0x00000002,	/* z/VM 5.4.0 */
+	DIAG26C_VERSION6_VM65918 = 0x00020006	/* z/VM 6.4.0 + VM65918 */
 };
 
+#define DIAG26C_VNIC_INFO	0x0002
+struct diag26c_vnic_req {
+	u32	resp_buf_len;
+	u32	resp_version;
+	u16	req_format;
+	u16	vlan_id;
+	u64	sys_name;
+	u8	res[2];
+	u16	devno;
+} __packed __aligned(8);
+
+#define VNIC_INFO_PROT_L3	1
+#define VNIC_INFO_PROT_L2	2
+/* Note: this is the bare minimum, use it for uninitialized VNICs only. */
+struct diag26c_vnic_resp {
+	u32	version;
+	u32	entry_cnt;
+	/* VNIC info: */
+	u32	next_entry;
+	u64	owner;
+	u16	devno;
+	u8	status;
+	u8	type;
+	u64	lan_owner;
+	u64	lan_name;
+	u64	port_name;
+	u8	port_type;
+	u8	ext_status:6;
+	u8	protocol:2;
+	u16	base_devno;
+	u32	port_num;
+	u32	ifindex;
+	u32	maxinfo;
+	u32	dev_count;
+	/* 3x device info: */
+	u8	dev_info1[28];
+	u8	dev_info2[28];
+	u8	dev_info3[28];
+} __packed __aligned(8);
+
 #define DIAG26C_GET_MAC	0x0000
 struct diag26c_mac_req {
 	u32	resp_buf_len;
-- 
2.13.5
