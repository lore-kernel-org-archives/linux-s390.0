Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D9483BD6;
	Thu,  3 Sep 2026 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455465; cv=none; b=IM8+5+bo7NIe6jrLxymo0FCg9aNx5csyC163S1L7U9o1oHxwRKzWD+JPVhHLfoJmjSdUi9Gkxe2OGPfsTdrDj+e/e7Oc5ATzJ/xUcF0ON6CQ2oGioi2f64tGTAKjWEKV03P8XA32lQBuu7XGxE8l1p3uWBtbz46c9Bnzf61/dgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455465; c=relaxed/simple;
	bh=8uZA9DwDzum8nSGOOZf3OWHO0rV7Ip1l08Q4q+sUC2E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aEwQWLpawQQvlpGU6Q6ClE8qp1kok0StcDiMGBZd4jhzQJYSqZM176IAIDib53fgholvbl4d1hXHjMJbZ2COZ4/sjxr2wObtJY5nt6VRp0utl7PHeZ+Zj/+5FzN7SBuXJ2E0DA65Uwgxfhr814tofBowLDihOYAR9sib+JMeiy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PGTrLSNO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PGTrLSNO"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G2WhH3425680;
	Thu, 3 Sep 2026 17:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=DLNbvQO0+tstQxEqQ9L6/yhfIzTY
	zXU44xXbdp27xUE=; b=PGTrLSNOdLQ74hN4M8v/XvrZhNA8BqztDwrakBwmYa/f
	jY03jjSBwKsuXSevpNVGigWQgg2gOQ2k3o90ZxrxKy37Yg3/IbByUc/34Y8Yhamj
	3wEl53eTgeCOIbCcvDf76YWkwnEXtaRdttmBhKQExbY7L+0JEaeAcUv29qV++OP9
	FJt3sC2RIy67PpogoYg7G4KACB/MW9NrxffSkjznqS5kJfXxknLIiJtTcZalXGXo
	8F4i9p7YB0tDr7aaVS/rU9+LTLs9qTuR/6HIc7AJcY2u2PS5+9NeG+JS1dJTNYRy
	hjobMk3oi/2q6WySKRnRqowiBIFQ51lDo4puhRRgdQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq55654d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 17:11:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GuFnt024531;
	Thu, 3 Sep 2026 17:11:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceygenn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 17:11:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683HAubk47382994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 17:10:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 786C620049;
	Thu,  3 Sep 2026 17:10:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29E4420040;
	Thu,  3 Sep 2026 17:10:56 +0000 (GMT)
Received: from osiris (unknown [9.87.144.233])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  3 Sep 2026 17:10:56 +0000 (GMT)
Date: Thu, 3 Sep 2026 19:10:54 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 7.3-rc2
Message-ID: <20260903171054.12158A58-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0OCBTYWx0ZWRfXy0/4AtdWZoS9
 7oVZWOCAGHN9y614cYQO79kLskQZa4ZhzxxsnrlZ4gIaZpR/qd+5Dk7jhgiRSMvIBmzrrPEeusx
 BQPh4aZTuHp+cpX0mPSq5rakn/pYjWV4OC2RI6QTorvgQfaIOb2wsoIUW4CpevValLAhTCtgbH+
 36H5BkmJsJmc5pQeq1GoKHBw2eMj5piNj3dJwc/OmwxMIaYETl/HF0EIVgm/BnlQ6yLUn+K3zhw
 T0qpsC1X7Z5KvcUlOkaElOXPdaS9Wq3ly8quHx2f//e/ugg4tdmcd9TXZZh8fcXTjdKlOkY1Oqi
 uDbcERepinB741JThV/bqQzMAup+HWukZY2D8pLaXIYukLIhwPS/929pGOCjfhQIv7oVW4rF+FJ
 TMFjsoDhn6Zttge7UywruG9qRR1PhloSqrFHl/gGqVbi+8wyY+Fidxg87HKpu6INX8SplyA9srk
 w45p6NRWYzarPe4HTIw==
X-Proofpoint-ORIG-GUID: lh8JOpTYGT3WysZhEMBW_YP9Bf5fxuVS
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a99aa25 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=N01Kg58rJpZZUFJ0mp4A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: lh8JOpTYGT3WysZhEMBW_YP9Bf5fxuVS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0OCBTYWx0ZWRfXyozmKPT5tdap
 enx38B0lOfZiCSx5hAEm5OzzovOusy02P+JdauNvMIYboNb/MB4nfqi6NisMEPdSJiJtE9MPTLB
 wP2D+Tjhal1UQbbuIoxMSpuhrel9rOo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030148

Hi Linus,

please pull s390 fixes and one small cleanup for 7.3-rc2.

Thanks,
Heiko

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.3-2

for you to fetch changes up to 98d23edcd41432286cf03672252507a841323c8c:

  s390/zcrypt: Fix uninitialized padding in CRT key structure (2026-09-01 12:44:48 +0200)

----------------------------------------------------------------
s390 fixes for 7.3-rc2

- Use jiffies instead of jiffies_64 to address a data-race reported by
  KCSAN

- Unpoison cpacf instruction results to address KMSAN reports

- Drop unused member from ap_device_id

- Fix potential NULL pointer dereferences in IPL code

- Add missing length check to SCLP error report handling

- Add missing length check to zcrypt CCA code

- Fix return code handling in diag324 code

- Handle multiple PMU stop callback invocations in perf pai code
  correctly

- Reduce excessive debug feature size in perf pai code from 32 MiB to
  4KiB

- Switch to common CPU capacity code in topology code to get rid of few
  lines of code

- Address various bugs in corner cases in boot code

- Simplify/Rework crst_table_upgrade() to address a potential NULL
  pointer dereference in case of an allocation failure

- Initialize padding bytes in CRT key structure in zcrypt code

----------------------------------------------------------------
Harald Freudenberger (1):
      s390/zcrypt: Fix uninitialized padding in CRT key structure

Heiko Carstens (3):
      s390/time: Use jiffies instead of jiffies_64
      s390/pai: Reduce excessive debug feature size
      s390/mm: Simplify crst_table_upgrade()

Holger Dengler (1):
      s390/zcrypt: Validate length in reply before using it

Ilya Leoshkevich (1):
      s390/cpacf: Unpoison instruction results

Mete Durlu (1):
      s390/topology: Switch to common cpu capacity code

Niklas Schnelle (1):
      s390/pci: Fix leak of uninitialized kernel data in SCLP report

Sumanth Korikkar (1):
      s390/diag324: Preserve -EBUSY return code

Thomas Richter (1):
      s390/pai: Handle multiple PMU stop callback invocations

Uwe Kleine-König (The Capable Hub) (1):
      s390/ap: Drop unused member from ap_device_id

Vasily Gorbik (5):
      s390/ipl: Fix NULL deref in kdump without re-IPL parm block
      s390/ipl: Fix NULL deref in dump_reipl without re-IPL parm block
      s390/boot: Fix physical memory search range
      s390/boot: Avoid IPL parameter append past command line
      s390/boot: Bound command line facility ranges

 arch/s390/boot/alternative.c         |  5 +-
 arch/s390/boot/ipl_parm.c            | 28 ++++++------
 arch/s390/boot/physmem_info.c        |  2 +-
 arch/s390/include/asm/cpacf.h        |  6 +++
 arch/s390/include/asm/processor.h    |  1 -
 arch/s390/include/asm/smp.h          |  4 +-
 arch/s390/kernel/diag/diag324.c      |  3 +-
 arch/s390/kernel/ipl.c               | 12 +++--
 arch/s390/kernel/perf_pai.c          | 27 +++++++++--
 arch/s390/kernel/smp.c               | 16 ++-----
 arch/s390/kernel/topology.c          |  2 +-
 arch/s390/kernel/vtime.c             |  6 +--
 arch/s390/mm/pgalloc.c               | 89 +++++++++++++++---------------------
 arch/s390/pci/pci_sysfs.c            |  3 ++
 drivers/s390/crypto/zcrypt_cca_key.h |  1 +
 drivers/s390/crypto/zcrypt_ccamisc.c | 15 +++++-
 include/linux/device-id/ap.h         |  2 -
 17 files changed, 119 insertions(+), 103 deletions(-)

diff --git a/arch/s390/boot/alternative.c b/arch/s390/boot/alternative.c
index 19ea7934b918..77e8bad560c5 100644
--- a/arch/s390/boot/alternative.c
+++ b/arch/s390/boot/alternative.c
@@ -45,11 +45,12 @@ static void alt_debug_modify(int type, unsigned int nr, bool clear)
 
 static char *alt_debug_parse(int type, char *str)
 {
-	unsigned long val, endval;
+	unsigned long val, endval, limit;
 	char *endp;
 	bool clear;
 	int i;
 
+	limit = type == ALT_TYPE_FACILITY ? MAX_FACILITY_BIT : MAX_MFEATURE_BIT;
 	if (*str == ':') {
 		str++;
 	} else {
@@ -73,7 +74,7 @@ static char *alt_debug_parse(int type, char *str)
 			if (str == endp)
 				break;
 			str = endp;
-			while (val <= endval) {
+			while (val <= endval && val < limit) {
 				alt_debug_modify(type, val, clear);
 				val++;
 			}
diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 6bc950b92be7..c1b43e5e688a 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -23,6 +23,7 @@ struct parmarea parmarea __section(".parmarea") = {
 };
 
 char __bootdata(early_command_line)[COMMAND_LINE_SIZE];
+static char command_line_buf[COMMAND_LINE_SIZE];
 
 unsigned int __bootdata_preserved(zlib_dfltcc_support) = ZLIB_DFLTCC_FULL;
 struct ipl_parameter_block __bootdata_preserved(ipl_block);
@@ -135,31 +136,29 @@ static size_t ipl_block_get_ascii_scpdata(char *dest, size_t size,
 
 static void append_ipl_block_parm(void)
 {
-	char *parm, *delim;
-	size_t len, rc = 0;
+	size_t len, extra = 0;
+	char *delim;
 
 	len = strlen(early_command_line);
-
-	delim = early_command_line + len;    /* '\0' character position */
-	parm = early_command_line + len + 1; /* append right after '\0' */
+	delim = early_command_line + len; /* '\0' character position */
 
 	switch (ipl_block.pb0_hdr.pbt) {
 	case IPL_PBT_CCW:
-		rc = ipl_block_get_ascii_vmparm(
-			parm, COMMAND_LINE_SIZE - len - 1, &ipl_block);
+		extra = ipl_block_get_ascii_vmparm(command_line_buf, sizeof(command_line_buf), &ipl_block);
 		break;
 	case IPL_PBT_FCP:
 	case IPL_PBT_NVME:
 	case IPL_PBT_ECKD:
-		rc = ipl_block_get_ascii_scpdata(
-			parm, COMMAND_LINE_SIZE - len - 1, &ipl_block);
+		extra = ipl_block_get_ascii_scpdata(command_line_buf, sizeof(command_line_buf), &ipl_block);
 		break;
 	}
-	if (rc) {
-		if (*parm == '=')
-			memmove(early_command_line, parm + 1, rc);
-		else
+	if (extra) {
+		if (command_line_buf[0] == '=') {
+			memmove(early_command_line, command_line_buf + 1, extra);
+		} else if (len < COMMAND_LINE_SIZE - 2) {
 			*delim = ' '; /* replace '\0' with space */
+			sized_strscpy(delim + 1, command_line_buf, COMMAND_LINE_SIZE - len - 1);
+		}
 	}
 }
 
@@ -231,7 +230,7 @@ static void modify_fac_list(char *str)
 			if (str == endp)
 				break;
 			str = endp;
-			while (val <= endval) {
+			while (val <= endval && val < MAX_FACILITY_BIT) {
 				modify_facility(val, clear);
 				val++;
 			}
@@ -245,7 +244,6 @@ static void modify_fac_list(char *str)
 	check_cleared_facilities();
 }
 
-static char command_line_buf[COMMAND_LINE_SIZE];
 void parse_boot_command_line(void)
 {
 	char *param, *val;
diff --git a/arch/s390/boot/physmem_info.c b/arch/s390/boot/physmem_info.c
index 1f2ca5435838..0ebb2174713f 100644
--- a/arch/s390/boot/physmem_info.c
+++ b/arch/s390/boot/physmem_info.c
@@ -141,7 +141,7 @@ static int tprot(unsigned long addr)
 
 static unsigned long search_mem_end(void)
 {
-	unsigned long range = 1 << (MAX_PHYSMEM_BITS - 20); /* in 1MB blocks */
+	unsigned long range = 1UL << (MAX_PHYSMEM_BITS - 20); /* in 1MB blocks */
 	unsigned long offset = 0;
 	unsigned long pivot;
 
diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index a83683169d98..6174552d856d 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -301,6 +301,7 @@ static __always_inline void __cpacf_query(unsigned int opcode,
 					  cpacf_mask_t *mask)
 {
 	__cpacf_query_insn(opcode, mask, CPACF_FC_QUERY);
+	kmsan_unpoison_memory(mask, sizeof(*mask));
 }
 
 static __always_inline int __cpacf_check_opcode(unsigned int opcode)
@@ -370,6 +371,7 @@ static __always_inline int cpacf_query_func(unsigned int opcode,
 static __always_inline void __cpacf_qai(unsigned int opcode, cpacf_qai_t *qai)
 {
 	__cpacf_query_insn(opcode, qai, CPACF_FC_QUERY_AUTH_INFO);
+	kmsan_unpoison_memory(qai, sizeof(*qai));
 }
 
 /**
@@ -422,6 +424,7 @@ static inline int cpacf_km(unsigned long func, void *param,
 		  [opc] "i" (CPACF_KM)
 		: "cc", "memory", "0", "1");
 
+	kmsan_unpoison_memory(dest, src_len - s.odd);
 	return src_len - s.odd;
 }
 
@@ -454,6 +457,7 @@ static inline int cpacf_kmc(unsigned long func, void *param,
 		  [opc] "i" (CPACF_KMC)
 		: "cc", "memory", "0", "1");
 
+	kmsan_unpoison_memory(dest, src_len - s.odd);
 	return src_len - s.odd;
 }
 
@@ -587,6 +591,7 @@ static inline int cpacf_kmctr(unsigned long func, void *param, u8 *dest,
 		  [opc] "i" (CPACF_KMCTR)
 		: "cc", "memory", "0", "1");
 
+	kmsan_unpoison_memory(dest, src_len - s.odd);
 	return src_len - s.odd;
 }
 
@@ -619,6 +624,7 @@ static inline void cpacf_prno(unsigned long func, void *param,
 		: [fc] "d" (func), [pba] "d" ((unsigned long)param),
 		  [seed] "d" (s.pair), [opc] "i" (CPACF_PRNO)
 		: "cc", "memory", "0", "1");
+	kmsan_unpoison_memory(dest, dest_len);
 }
 
 /**
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index be8369115f6d..9434c76c25b8 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -46,7 +46,6 @@ struct pcpu {
 	unsigned long ec_mask;		/* bit mask for ec_xxx functions */
 	unsigned long ec_clk;		/* sigp timestamp for ec_xxx */
 	unsigned long flags;		/* per CPU flags */
-	unsigned long capacity;		/* cpu capacity for scheduler */
 	signed char state;		/* physical cpu state */
 	signed char polarization;	/* physical polarization */
 	u16 address;			/* physical cpu address */
diff --git a/arch/s390/include/asm/smp.h b/arch/s390/include/asm/smp.h
index fb2bdbf35da5..a6c621e0491c 100644
--- a/arch/s390/include/asm/smp.h
+++ b/arch/s390/include/asm/smp.h
@@ -30,7 +30,7 @@ static __always_inline unsigned int raw_smp_processor_id(void)
 	return cpu;
 }
 
-#define arch_scale_cpu_capacity smp_cpu_get_capacity
+#define arch_scale_cpu_capacity topology_get_cpu_scale
 
 extern struct mutex smp_cpu_state_mutex;
 extern unsigned int smp_cpu_mt_shift;
@@ -53,9 +53,7 @@ extern void smp_save_dump_secondary_cpus(void);
 extern void smp_yield_cpu(int cpu);
 extern void smp_cpu_set_polarization(int cpu, int val);
 extern int smp_cpu_get_polarization(int cpu);
-extern void smp_cpu_set_capacity(int cpu, unsigned long val);
 extern void smp_set_core_capacity(int cpu, unsigned long val);
-extern unsigned long smp_cpu_get_capacity(int cpu);
 extern int smp_cpu_get_cpu_address(int cpu);
 extern void smp_fill_possible_mask(void);
 extern void smp_detect_cpus(void);
diff --git a/arch/s390/kernel/diag/diag324.c b/arch/s390/kernel/diag/diag324.c
index fe325c2a2d0d..3eec0cc8fb9e 100644
--- a/arch/s390/kernel/diag/diag324.c
+++ b/arch/s390/kernel/diag/diag324.c
@@ -182,8 +182,7 @@ long diag324_pibbuf(unsigned long arg)
 		goto out;
 	rc = copy_to_user((void __user *)address, data->pib, data->pib->len);
 	rc |= put_user(data->sequence, &udata->sequence);
-	if (rc)
-		rc = -EFAULT;
+	rc = rc ? -EFAULT : data->rc;
 out:
 	mutex_unlock(&pibmutex);
 	return rc;
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index d74ef30155aa..b1e798f8e1dd 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -1157,6 +1157,8 @@ static struct attribute_group reipl_nss_attr_group = {
 
 void set_os_info_reipl_block(void)
 {
+	if (!reipl_block_actual)
+		return;
 	os_info_entry_add_data(OS_INFO_REIPL_BLOCK, reipl_block_actual,
 			       reipl_block_actual->hdr.len);
 }
@@ -1927,7 +1929,8 @@ static struct shutdown_action __refdata dump_action = {
 static void dump_reipl_run(struct shutdown_trigger *trigger)
 {
 	struct lowcore *abs_lc;
-	unsigned int csum;
+	unsigned long ipib = 0;
+	unsigned int csum = 0;
 
 	/*
 	 * Set REIPL_CLEAR flag in os_info flags entry indicating
@@ -1943,9 +1946,12 @@ static void dump_reipl_run(struct shutdown_trigger *trigger)
 	    reipl_type == IPL_TYPE_UNKNOWN)
 		os_info_flags |= OS_INFO_FLAG_REIPL_CLEAR;
 	os_info_entry_add_data(OS_INFO_FLAGS_ENTRY, &os_info_flags, sizeof(os_info_flags));
-	csum = (__force unsigned int)cksm(reipl_block_actual, reipl_block_actual->hdr.len, 0);
+	if (reipl_block_actual) {
+		ipib = __pa(reipl_block_actual);
+		csum = (__force unsigned int)cksm(reipl_block_actual, reipl_block_actual->hdr.len, 0);
+	}
 	abs_lc = get_abs_lowcore();
-	abs_lc->ipib = __pa(reipl_block_actual);
+	abs_lc->ipib = ipib;
 	abs_lc->ipib_checksum = csum;
 	put_abs_lowcore(abs_lc);
 	dump_run(trigger);
diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index cdb8006220ca..5c18c8b82ab7 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -464,6 +464,7 @@ static void pai_start(struct perf_event *event, int flags,
 			cpump->event = event;
 		}
 	}
+	event->hw.state &= ~PERF_HES_STOPPED;
 }
 
 static void paicrypt_start(struct perf_event *event, int flags)
@@ -510,6 +511,13 @@ static void pai_stop(struct perf_event *event, int flags)
 	struct pai_mapptr *mp = this_cpu_ptr(pai_root[idx].mapptr);
 	struct pai_map *cpump = mp->mapptr;
 
+	/* Cope with multiple invocations:
+	 *   1. perf_event_throttle() --> PMU->stop()
+	 *   2. task schedules out --> PMU->stop()
+	 * Check for event already stopped.
+	 */
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
 	if (!event->attr.sample_period) {	/* Counting */
 		pai_pmu[idx].pmu->read(event);
 	} else {				/* Sampling */
@@ -672,9 +680,9 @@ static void pai_have_samples(int idx)
 {
 	struct pai_mapptr *mp = this_cpu_ptr(pai_root[idx].mapptr);
 	struct pai_map *cpump = mp->mapptr;
-	struct perf_event *event;
+	struct perf_event *event, *e2;
 
-	list_for_each_entry(event, &cpump->syswide_list, hw.tp_list)
+	list_for_each_entry_safe(event, e2, &cpump->syswide_list, hw.tp_list)
 		pai_have_sample(event, cpump);
 }
 
@@ -691,6 +699,17 @@ static void paicrypt_sched_task(struct perf_event_pmu_context *pmu_ctx,
 		pai_have_samples(PAI_PMU_CRYPTO);
 }
 
+/* Prevent ioctl(fd, PERF_EVENT_IOC_PERIOD, ...) call.
+ * It sets perf_event::event_limit to a positive value and causes
+ * perf_event_overflow() to invoke pai_stop() call back function when
+ * perf_event::event_limit hits zero. This is not supported because the
+ * sample events CRYPTO_ALL and NNPA_ALL are always taken at schedule out
+ * of a task.
+ */
+static int pai_check_period(struct perf_event *event, u64 value)
+{
+	return -EINVAL;
+}
 /* ============================= paiext ====================================*/
 
 static void paiext_event_destroy(struct perf_event *event)
@@ -804,6 +823,7 @@ static struct pmu paicrypt = {
 	.stop	      = paicrypt_stop,
 	.read	      = paicrypt_read,
 	.sched_task   = paicrypt_sched_task,
+	.check_period = pai_check_period,
 	.attr_groups  = paicrypt_attr_groups
 };
 
@@ -1015,6 +1035,7 @@ static struct pmu paiext = {
 	.stop	      = paiext_stop,
 	.read	      = paiext_read,
 	.sched_task   = paiext_sched_task,
+	.check_period = pai_check_period,
 	.attr_groups  = paiext_attr_groups,
 };
 
@@ -1221,7 +1242,7 @@ static int __init paipmu_setup(void)
 static int __init pai_init(void)
 {
 	/* Setup s390dbf facility */
-	paidbg = debug_register("pai", 32, 256, 128);
+	paidbg = debug_register("pai", 1, 1, 128);
 	if (!paidbg) {
 		pr_err("Registration of s390dbf pai failed\n");
 		return -ENOMEM;
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 167c72803ccf..32499cad86f0 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -659,23 +659,13 @@ int smp_cpu_get_polarization(int cpu)
 	return per_cpu(pcpu_devices, cpu).polarization;
 }
 
-void smp_cpu_set_capacity(int cpu, unsigned long val)
-{
-	per_cpu(pcpu_devices, cpu).capacity = val;
-}
-
-unsigned long smp_cpu_get_capacity(int cpu)
-{
-	return per_cpu(pcpu_devices, cpu).capacity;
-}
-
 void smp_set_core_capacity(int cpu, unsigned long val)
 {
 	int i;
 
 	cpu = smp_get_base_cpu(cpu);
 	for (i = cpu; (i <= cpu + smp_cpu_mtid) && (i < nr_cpu_ids); i++)
-		smp_cpu_set_capacity(i, val);
+		topology_set_cpu_scale(i, val);
 }
 
 int smp_cpu_get_cpu_address(int cpu)
@@ -727,7 +717,7 @@ static int smp_add_core(struct sclp_core_entry *core, cpumask_t *avail,
 		else
 			pcpu->state = CPU_STATE_STANDBY;
 		smp_cpu_set_polarization(cpu, POLARIZATION_UNKNOWN);
-		smp_cpu_set_capacity(cpu, CPU_CAPACITY_HIGH);
+		topology_set_cpu_scale(cpu, CPU_CAPACITY_HIGH);
 		set_cpu_present(cpu, true);
 		if (!early && arch_register_cpu(cpu))
 			set_cpu_present(cpu, false);
@@ -967,7 +957,7 @@ void __init smp_prepare_boot_cpu(void)
 	ipl_pcpu->state = CPU_STATE_CONFIGURED;
 	lc->pcpu = (unsigned long)ipl_pcpu;
 	smp_cpu_set_polarization(0, POLARIZATION_UNKNOWN);
-	smp_cpu_set_capacity(0, CPU_CAPACITY_HIGH);
+	topology_set_cpu_scale(0, CPU_CAPACITY_HIGH);
 }
 
 void __init smp_setup_processor_id(void)
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 1377c6f3f670..42fc0294f543 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -147,7 +147,7 @@ static void add_cpus_to_mask(struct topology_core *tl_core,
 			cpumask_set_cpu(cpu, &book->mask);
 			cpumask_set_cpu(cpu, &socket->mask);
 			smp_cpu_set_polarization(cpu, tl_core->pp);
-			smp_cpu_set_capacity(cpu, CPU_CAPACITY_HIGH);
+			topology_set_cpu_scale(cpu, CPU_CAPACITY_HIGH);
 		}
 	}
 }
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index d804e1140c2e..efcbf406f03e 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -32,7 +32,7 @@ static atomic64_t virt_timer_elapsed;
 DEFINE_PER_CPU(u64, mt_cycles[8]);
 static DEFINE_PER_CPU(u64, mt_scaling_mult) = { 1 };
 static DEFINE_PER_CPU(u64, mt_scaling_div) = { 1 };
-static DEFINE_PER_CPU(u64, mt_scaling_jiffies);
+static DEFINE_PER_CPU(unsigned long, mt_scaling_jiffies);
 
 static inline void set_vtimer(u64 expires)
 {
@@ -81,7 +81,7 @@ static void update_mt_scaling(void)
 		memcpy(cycles_old, cycles_new,
 		       sizeof(u64) * (smp_cpu_mtid + 1));
 	}
-	__this_cpu_write(mt_scaling_jiffies, jiffies_64);
+	__this_cpu_write(mt_scaling_jiffies, jiffies);
 }
 
 static inline u64 update_tsk_timer(unsigned long *tsk_vtime, u64 new)
@@ -144,7 +144,7 @@ static int do_account_vtime(struct task_struct *tsk)
 		lc->system_timer += timer;
 
 	/* Update MT utilization calculation */
-	if (smp_cpu_mtid && time_after64(jiffies_64, __this_cpu_read(mt_scaling_jiffies)))
+	if (smp_cpu_mtid && time_after(jiffies, __this_cpu_read(mt_scaling_jiffies)))
 		update_mt_scaling();
 
 	/* Calculate cputime delta */
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 9610770fcf6d..4b160eedc5a0 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -55,63 +55,46 @@ static void __crst_table_upgrade(void *arg)
 
 int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 {
-	unsigned long *pgd = NULL, *p4d = NULL, *__pgd;
-	unsigned long asce_limit = mm->context.asce_limit;
+	unsigned long *table, *pgd;
+	int rc, notify;
 
 	mmap_assert_write_locked(mm);
-
 	/* upgrade should only happen from 3 to 4, 3 to 5, or 4 to 5 levels */
-	VM_BUG_ON(asce_limit < _REGION2_SIZE);
-
-	if (end <= asce_limit)
-		return 0;
-
-	if (asce_limit == _REGION2_SIZE) {
-		p4d = crst_table_alloc(mm);
-		if (unlikely(!p4d))
-			goto err_p4d;
-		crst_table_init(p4d, _REGION2_ENTRY_EMPTY);
-		pagetable_p4d_ctor(virt_to_ptdesc(p4d));
+	VM_BUG_ON(mm->context.asce_limit < _REGION2_SIZE);
+	rc = 0;
+	notify = 0;
+	while (mm->context.asce_limit < end) {
+		table = crst_table_alloc(mm);
+		if (!table) {
+			rc = -ENOMEM;
+			break;
+		}
+		spin_lock_bh(&mm->page_table_lock);
+		pgd = (unsigned long *)mm->pgd;
+		if (mm->context.asce_limit == _REGION2_SIZE) {
+			crst_table_init(table, _REGION2_ENTRY_EMPTY);
+			p4d_populate(mm, (p4d_t *)table, (pud_t *)pgd);
+			pagetable_p4d_ctor(virt_to_ptdesc(table));
+			mm->pgd = (pgd_t *)table;
+			mm->context.asce_limit = _REGION1_SIZE;
+			mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
+				_ASCE_USER_BITS | _ASCE_TYPE_REGION2;
+			mm_inc_nr_puds(mm);
+		} else {
+			crst_table_init(table, _REGION1_ENTRY_EMPTY);
+			pgd_populate(mm, (pgd_t *)table, (p4d_t *)pgd);
+			pagetable_pgd_ctor(virt_to_ptdesc(table));
+			mm->pgd = (pgd_t *)table;
+			mm->context.asce_limit = TASK_SIZE_MAX;
+			mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
+				_ASCE_USER_BITS | _ASCE_TYPE_REGION1;
+		}
+		notify = 1;
+		spin_unlock_bh(&mm->page_table_lock);
 	}
-	if (end > _REGION1_SIZE) {
-		pgd = crst_table_alloc(mm);
-		if (unlikely(!pgd))
-			goto err_pgd;
-		crst_table_init(pgd, _REGION1_ENTRY_EMPTY);
-		pagetable_pgd_ctor(virt_to_ptdesc(pgd));
-	}
-
-	spin_lock_bh(&mm->page_table_lock);
-
-	if (p4d) {
-		__pgd = (unsigned long *) mm->pgd;
-		p4d_populate(mm, (p4d_t *) p4d, (pud_t *) __pgd);
-		mm->pgd = (pgd_t *) p4d;
-		mm->context.asce_limit = _REGION1_SIZE;
-		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
-			_ASCE_USER_BITS | _ASCE_TYPE_REGION2;
-		mm_inc_nr_puds(mm);
-	}
-	if (pgd) {
-		__pgd = (unsigned long *) mm->pgd;
-		pgd_populate(mm, (pgd_t *) pgd, (p4d_t *) __pgd);
-		mm->pgd = (pgd_t *) pgd;
-		mm->context.asce_limit = TASK_SIZE_MAX;
-		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
-			_ASCE_USER_BITS | _ASCE_TYPE_REGION1;
-	}
-
-	spin_unlock_bh(&mm->page_table_lock);
-
-	on_each_cpu(__crst_table_upgrade, mm, 0);
-
-	return 0;
-
-err_pgd:
-	pagetable_dtor(virt_to_ptdesc(p4d));
-	crst_table_free(mm, p4d);
-err_p4d:
-	return -ENOMEM;
+	if (notify)
+		on_each_cpu(__crst_table_upgrade, mm, 0);
+	return rc;
 }
 
 unsigned long *page_table_alloc_noprof(struct mm_struct *mm)
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index d98d97df792a..bbb76113a4d0 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -153,6 +153,9 @@ static ssize_t report_error_write(struct file *filp, struct kobject *kobj,
 	if (off || (count < sizeof(*report)))
 		return -EINVAL;
 
+	if (count < (report->length + sizeof(*report)))
+		return -EINVAL;
+
 	ret = sclp_pci_report(report, zdev->fh, zdev->fid);
 
 	return ret ? ret : count;
diff --git a/drivers/s390/crypto/zcrypt_cca_key.h b/drivers/s390/crypto/zcrypt_cca_key.h
index f5907b67db29..8a69eed75040 100644
--- a/drivers/s390/crypto/zcrypt_cca_key.h
+++ b/drivers/s390/crypto/zcrypt_cca_key.h
@@ -219,6 +219,7 @@ static inline int zcrypt_type6_crt_key(struct ica_rsa_modexpo_crt *crt, void *p)
 	    copy_from_user(key->key_parts + 2 * long_len + 2 * short_len,
 			   crt->u_mult_inv, long_len))
 		return -EFAULT;
+	memset(key->key_parts + 3 * long_len + 2 * short_len, 0, pad_len);
 	memset(key->key_parts + 3 * long_len + 2 * short_len + pad_len,
 	       0xff, crt->inputdatalength);
 	pub = (struct cca_public_sec *)(key->key_parts + key_len);
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index d4ce6352b5b2..19909bf43dc9 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1158,8 +1158,21 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 
 	/* do not check the key here, it may be incomplete */
 
-	/* copy the vlsc key token back */
+	/*
+	 * Copy the vlsc key token back.
+	 * The available space in the destination (key_token) and the source
+	 * (t) buffer is always larger as the valid range of prepparm->kb.len.
+	 * Validate t->len by comparing it with the length information in the
+	 * param block of the request (prepparm->kb.len)
+	 * The value range of prepparm->kb.len has been checked above.
+	 */
 	t = (struct cipherkeytoken *)prepparm->kb.tlv1.key_token;
+	if (t->len != prepparm->kb.len - 3 * sizeof(uint16_t)) {
+		ZCRYPT_DBF_ERR("%s reply with invalid key_token length %u\n",
+			       __func__, t->len);
+		rc = -EIO;
+		goto out;
+	}
 	memcpy(key_token, t, t->len);
 	*key_token_size = t->len;
 
diff --git a/include/linux/device-id/ap.h b/include/linux/device-id/ap.h
index 0992333a34db..e050abebbf3d 100644
--- a/include/linux/device-id/ap.h
+++ b/include/linux/device-id/ap.h
@@ -4,7 +4,6 @@
 
 #ifdef __KERNEL__
 #include <linux/types.h>
-typedef unsigned long kernel_ulong_t;
 #endif
 
 #define AP_DEVICE_ID_MATCH_CARD_TYPE		0x01
@@ -14,7 +13,6 @@ typedef unsigned long kernel_ulong_t;
 struct ap_device_id {
 	__u16 match_flags;	/* which fields to match against */
 	__u8 dev_type;		/* device type */
-	kernel_ulong_t driver_info;
 };
 
 #endif /* ifndef LINUX_DEVICE_ID_AP_H */
