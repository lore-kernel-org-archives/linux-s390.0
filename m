Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB823D1CDF;
	Fri, 12 Jun 2026 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267001; cv=none; b=VLpmrTIuYps7p2mhgPTFaUWfd9D7w/1P434E0wDM2p6I6aieUFRTUtlRwO8TFinh3l1nxF+vX1kzxyGvk2HTc9hTXNxiyRBAWb7zasMROx1JSHzcCyPlvCHscFT7w3oMtinJueRcQEhAdTcohF+QOHC5Mgvb08efqZM+4NU2344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267001; c=relaxed/simple;
	bh=Mq6nFhJPyjrc67PHpXk9Dl6vX3gsEgmGVNtPL2nA9FY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i+KxXH1H6Iqvx+DOjiOlm/auVGICK7NBsXhfrgN3M9x/1nYHVX9LPfR1W8MNPugMCzOtqV7fF9wqGS/ROQspcOZ+8cjwJ5/IOVvR8n5kqX8bhD9CVMeHl7i2wPpN1S37JfY1P/oqmUur2IRKN/UTXamX1U7KPjVf/EFzYh46kEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HpAtsqD0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HpAtsqD0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BMxjGB4146614;
	Fri, 12 Jun 2026 12:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hQ1Fqm
	2/fzJJ/sfAjwl2uIJKBr88BRDQ33gwivK8ojE=; b=HpAtsqD0LwQYXM+8TUPTaC
	s0aGCadD1jAtkqJyhV2Gi3tO8GC3I6J/825hTsxTlypDgSfxLxZ4swJC8p/kNNsd
	YVWn5ihGbTIqOAY4FnRiEfCvmxsqE9u6iFx9jZpovCi86sOOe/ITcU/n6cHYK3ij
	b1biYHE1SWR3n0LN/jmuk+PvVXmWZV0cluVDHgpBtprXETLO0XPIR6lNlPUpok/J
	kR0SRgh3PvvsIoVCR38E0Z33JnGgD+nswmNgfLfuX+DHOFnq025A8kMXJSqS6qOB
	myGvoJUGr92KER4rXzXz/0npCddW8hk6W6Flf8K8ILFck7ljASKUpMFlE1YCTvkw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c8w0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 12:23:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CCJfxW014816;
	Fri, 12 Jun 2026 12:23:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08yshh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 12:23:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CCNESb16581072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 12:23:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B288820049;
	Fri, 12 Jun 2026 12:23:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CDE720040;
	Fri, 12 Jun 2026 12:23:14 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.8.71])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 12:23:13 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 12 Jun 2026 14:23:03 +0200
Subject: [PATCH v4 3/4] KVM: s390: vsie: Refactor handle_stfle
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-vsie-alter-stfle-fac-v4-3-74f0e1559929@linux.ibm.com>
References: <20260612-vsie-alter-stfle-fac-v4-0-74f0e1559929@linux.ibm.com>
In-Reply-To: <20260612-vsie-alter-stfle-fac-v4-0-74f0e1559929@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, kvm@vger.kernel.org,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4047;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=kv8LvXigEiKNEzIUmdnfEmexbf8Ni4wSjNqzaYeJyqQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnav/SDcy5VZfTvWbzlmd8E8R+rM0ReHzizrd8rxYK5e
 v3utXozO0pZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZjIgWJGhjXvJVv7zm/4qCGw
 u8CIpYCTUUF4g47oNWe9WT+mJu198pLhf33IX9GSTt3a5XvsP9wX6fPWPquln1EQa6Z9sk0/bMZ
 ddgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDExMSBTYWx0ZWRfX2hUSok+ITeN6
 ailkyX4XeBE5tfu69By9cpjE8hU7bdPjVOiLr4flewOugD/cuadcQHdf7xrqmgcUqf8Ku3DyB3c
 kQMKdZt+89jyhpiDh7DbTMv3Gq8vPmU=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2bfa37 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=QF4Ne7cRFios67fmdukA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TwYsz0DB7MUwSRZQm-wu-_QPCW9PZbeU
X-Proofpoint-ORIG-GUID: TwYsz0DB7MUwSRZQm-wu-_QPCW9PZbeU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDExMSBTYWx0ZWRfX3NLTZ2CqN88q
 QLm9eADdzHwRYEWKxe0dN8EK76BMKqUjWWgsejXLPqcFckO3w5xZhzgzFGrsY3qzhzpDC+lj2cb
 I/uCvCool4re9CifLp3JBvNMZDDyZ9+BhXBd2aTPlRjGHoE7GI6enTmE+/NuAiIRfsbwRq8kgSQ
 AtHDZxbbBXzvv+2/33QNRBKmQwBrlZApBJARmzJ53h8DdyDbjTygltfoc95QxXTqVyW0N6aMg7M
 rxV0hDCwFlDrx7nVrjaiD6SYbA0/M5Hk6uaN1XQQfhXl57Iu+Wq8TfV6ReVlL3C86trsfwIm+yR
 bl+UyNb2dQg91IZ+B8TqVRl+8O0wh84M1WZo0bScO4TLzf9IfpuL2ZzgqxeQOvpZs7s61jbED+z
 c2ywd7f9wCdKBpR4MKwcWwgsG3qeGXyyTe5siffjy9QGdyUOmHXvXBleqH7I1GcKxNIZeyFpeIl
 9pXaUnXyFzoZ1aMMVOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120111

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Use switch case in anticipation of handling format-1 and format-2
facility list designations in the future.
As the alternate STFLE facilities are not enabled, only case 0 is
possible.
No functional change intended.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h |  1 +
 arch/s390/kvm/vsie.c             | 53 ++++++++++++++++++++++++++++------------
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 60345dd2cba2..4192769b5ce0 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -444,6 +444,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_ASTFLEIE2	14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index e5a23f1c9749..c7dcdd460dd1 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -6,12 +6,15 @@
  *
  *    Author(s): David Hildenbrand <dahi@linux.vnet.ibm.com>
  */
+#include <linux/align.h>
 #include <linux/vmalloc.h>
 #include <linux/kvm_host.h>
 #include <linux/bug.h>
+#include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/bitmap.h>
 #include <linux/sched/signal.h>
+#include <linux/stddef.h>
 #include <linux/io.h>
 #include <linux/mman.h>
 
@@ -1000,6 +1003,23 @@ static void retry_vsie_icpt(struct vsie_page *vsie_page)
 	clear_vsie_icpt(vsie_page);
 }
 
+static int handle_stfle_0(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+			  u32 fac_list_origin)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+
+	/*
+	 * format-0 -> size of nested guest's facility list == guest's size
+	 * guest's size == host's size, since STFLE is interpretatively executed
+	 * using a format-0 for the guest, too.
+	 */
+	if (read_guest_real(vcpu, fac_list_origin, &vsie_page->fac,
+			    stfle_size() * sizeof(u64)))
+		return set_validity_icpt(scb_s, 0x1090U);
+	scb_s->fac = (u32)virt_to_phys(&vsie_page->fac);
+	return 0;
+}
+
 /*
  * Try to shadow + enable the guest 2 provided facility list.
  * Retry instruction execution if enabled for and provided by guest 2.
@@ -1009,29 +1029,30 @@ static void retry_vsie_icpt(struct vsie_page *vsie_page)
  */
 static int handle_stfle(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
-	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
-	__u32 fac = READ_ONCE(vsie_page->scb_o->fac);
+	bool has_astfleie2 = test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_ASTFLEIE2);
+	u32 fac = READ_ONCE(vsie_page->scb_o->fac);
+	int format_mask, format;
+	u32 origin;
+
+	BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct vsie_page, fac), 8));
 
-	/*
-	 * Alternate-STFLE-Interpretive-Execution facilities are not supported
-	 * -> format-0 flcb
-	 */
 	if (fac && test_kvm_facility(vcpu->kvm, 7)) {
 		retry_vsie_icpt(vsie_page);
 		/*
 		 * The facility list origin (FLO) is in bits 1 - 28 of the FLD
 		 * so we need to mask here before reading.
 		 */
-		fac = fac & 0x7ffffff8U;
-		/*
-		 * format-0 -> size of nested guest's facility list == guest's size
-		 * guest's size == host's size, since STFLE is interpretatively executed
-		 * using a format-0 for the guest, too.
-		 */
-		if (read_guest_real(vcpu, fac, &vsie_page->fac,
-				    stfle_size() * sizeof(u64)))
-			return set_validity_icpt(scb_s, 0x1090U);
-		scb_s->fac = (u32)virt_to_phys(&vsie_page->fac);
+		origin = fac & 0x7ffffff8U;
+		format_mask = has_astfleie2 ? 3 : 0;
+		format = fac & format_mask;
+		switch (format) {
+		case 0:
+			return handle_stfle_0(vcpu, vsie_page, origin);
+		case 1:
+		case 2:
+		case 3:
+			unreachable();
+		}
 	}
 	return 0;
 }

-- 
2.54.0

