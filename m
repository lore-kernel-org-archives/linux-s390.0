Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515443E9C3;
	Mon, 24 Aug 2026 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582307; cv=none; b=RW2tBnv3w5Frz/QtEYPRQ4DRYKG/PQIvEaain/6FvgaO5t5hyXe94fhVHTqNdAlCGnfskGHPug2yX5eo2zzineD/MVwsJWMwuFrcZNFqc/JfE0oC5DR5vYgO3y0LrbjoDz+6K0IFQNcLiaQKB42fkIDu0lyA7wy4RO9lvb0SWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582307; c=relaxed/simple;
	bh=2i2GqgBKWbdOCGhl8VWX1wNN+BgcLql1ggshhnNX9LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bR8xmpiozCQ4xA1fOR4A90eS17VdczxY79gvTFcDhCBsochXJytu7cTwfqE1nXRy73TcyTXSydrPeEtEfvPfSb7vwe9MNEokHf8TF6VCpMhVeNMpxqS3eeRRqlU7zBb9YrUqRM+CchY013u42WVrgGao1wIJzmdlpoPn6xljYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eaQ0Ob/e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eaQ0Ob/e"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1ZoV085374;
	Mon, 24 Aug 2026 14:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wutDP6M+YjyD2Vmut
	7DQLgwnsiIjh6oF1fCLjYayfrw=; b=eaQ0Ob/e39qB2L4JJ8AsGeATrydXLR6gV
	xDoj69wZMAaey9+Q5T8UzpnTf6gNYBt159M/fboJX4cphk6OFfeEYwuj36O45t49
	FpgP5QqNvlSve9vuzSX0BZGlYp5kQl1dxlJjex13faS5fXEURkONfSgbKAAsRiik
	ooKye1yxIn5R3M2GyirDexgoX3orlbDVa2L2EckPuRnbLT8i1MpHiP9o2D5e8LBn
	/sfaSA5ih/hKm9Tm5vE3EsK6AHrAvP5WhdcbixFCMwwDdtDEyl2oXllr7ULyoOpa
	yJezAZjU7ANLSoa7IqgWq7sm7gfR1Tw3SJqBmnihs3o7n7c7h4bdA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqhyts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQJAT011210;
	Mon, 24 Aug 2026 14:38:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag6cf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEcHMN44171690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:38:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 527AD20043;
	Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 333DA2004F;
	Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com,
        Cornelia Huck <cohuck@redhat.com>
Subject: [kvm-unit-tests GIT PULL 11/13] s390x: stsi: regression test for the STSI 3.2.2 count clamp
Date: Mon, 24 Aug 2026 14:35:43 +0000
Message-ID: <20260824143740.291583-12-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824143740.291583-1-frankja@linux.ibm.com>
References: <20260824143740.291583-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2X5tLpg6BOA6m-kOkUYq0txTAB3WxZPh
X-Proofpoint-ORIG-GUID: 2X5tLpg6BOA6m-kOkUYq0txTAB3WxZPh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfXxgm/5/6nMIUF
 Ekh9Z/j0fAtF2oNqhMk2S/IV5Yux/5/gf5cjGZBRDSwyJXxNgxu4m61dwPiWl79KPdbsrsLtJzu
 ZTVqIF8SGWGEL5qvHHaKuzHOUTjlX4Lmbd9+1L+YbSg/Gn+TF7ONecxXWmIRk5ZtYl9DYtoT/cT
 97tVO8sk7pM1hzVOLh+y0VxlurDr8GPfH/0iYjqame05ptUSTz1oLvP2kUW1OoAVabyar+DKLmu
 Fl0aa6DiXKeoSdul/fZBF84hXQZzZoOl/r2Fq6GzTPsNvjz9Py1nG9k6GPnkIDcjukssvI9t3k0
 LsE7/UEewel5YEHBaBdZ8RjXFUwiJ2ZWoR+UC6WFb8is3jL237oQg1FNsiM7Fpm0ZwuNisl7+I8
 iPK1gpwdumlIi3okamOvO9DTPUdIeuWUEMrOdDC7NOonH4f8FCs3BDRzZKbGHAXdcF1JekOX5p2
 zbXfLpFEgs/7DBzsvIA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c575e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=Crfzy22EUI-5sfthhwgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX46ZStb55sn0O
 AukXRPOjplOfHN6/W+2nNFooetqrg/RTh3DOfnFX2oX7xNu5+t6PhtJHDEh4IorJIVW2R7ixMvd
 6vNXBH7QkcLyWmpAwPoAKhWMB1VN468=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

From: Christian Borntraeger <borntraeger@linux.ibm.com>

See https://lore.kernel.org/qemu-devel/20260622092035.400959-1-borntraeger@linux.ibm.com/
for the QEMU fix.
Add a regression test that races STSI 3.2.2 on one CPU against a second CPU
that continuously forces an out-of-range count value.
The out of bound access usually crashes/asserts QEMU with any sane
distribution build of QEMU, so its more or less guest root can kill itself.
We should test and fix nevertheless.
Testcase piggybacks on the existing stsi test, so some cases will be
tested twice. (with smp 1 and smp 2)

Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[frankja@linux.ibm.com: Merged the new unittests.cgf entry into old one]
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/stsi.c        | 76 ++++++++++++++++++++++++++++++++++++++++++++-
 s390x/unittests.cfg |  2 +-
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/s390x/stsi.c b/s390x/stsi.c
index 94a579dc..96361143 100644
--- a/s390x/stsi.c
+++ b/s390x/stsi.c
@@ -2,7 +2,7 @@
 /*
  * Store System Information tests
  *
- * Copyright (c) 2019 IBM Corp
+ * Copyright IBM Corp. 2019,2026
  *
  * Authors:
  *  Janosch Frank <frankja@linux.ibm.com>
@@ -133,6 +133,79 @@ out:
 	report_prefix_pop();
 }
 
+/*
+ * Number of STSI 3.2.2 calls raced against the count corruptor below.
+ * A memory write should be faster than an kvm->qemu exit, so 100 is
+ * good enough.
+ */
+#define RACE_ITERATIONS 100
+static u8 corrupt_count_value;
+
+static void count_corruptor(void)
+{
+	struct sysinfo_3_2_2 *data = (void *)pagebuf;
+
+	for (;;)
+		*(volatile u8 *)&data->count = corrupt_count_value;
+}
+
+/*
+ * Race STSI 3.2.2 on the boot CPU against a secondary CPU that continuously
+ * forces the given out-of-range value into the "count" field. Returns true
+ * if every STSI returned cc == 0, false on an unexpected condition code.
+ */
+static bool race_count_value(uint8_t value)
+{
+	int i, cc;
+
+	corrupt_count_value = value;
+	smp_cpu_setup(1, PSW_WITH_CUR_MASK(count_corruptor));
+
+	for (i = 0; i < RACE_ITERATIONS; i++) {
+		cc = stsi(pagebuf, 3, 2, 2);
+		if (cc) {
+			report_fail("count 0x%02x: unexpected cc %d on iteration %d",
+				    value, cc, i);
+			break;
+		}
+	}
+
+	smp_cpu_stop(1);
+	smp_cpu_destroy(1);
+
+	return i == RACE_ITERATIONS;
+}
+
+/*
+ * The count value is 8 bit and valid values are 1-8 if stsi 3.2.2 is present.
+ * We test 0,9 as off-by-one, and 0xff as maximum value.
+ */
+static void test_3_2_2_race(void)
+{
+	report_prefix_push("3.2.2 count race");
+
+	if (stsi_get_fc() < 3) {
+		report_skip("Running under lpar, no level 3 to test.");
+		goto out;
+	}
+
+	if (smp_query_num_cpus() < 2) {
+		report_skip("Need at least 2 CPUs to race the count field.");
+		goto out;
+	}
+
+	if (race_count_value(0x0))
+		report_pass("host survived racing STSI 3.2.2 count 0x00");
+
+	if (race_count_value(0x9))
+		report_pass("host survived racing STSI 3.2.2 count 0x09");
+
+	if (race_count_value(0xff))
+		report_pass("host survived racing STSI 3.2.2 count 0xff");
+out:
+	report_prefix_pop();
+}
+
 int main(void)
 {
 	report_prefix_push("stsi");
@@ -140,5 +213,6 @@ int main(void)
 	test_specs();
 	test_fc();
 	test_3_2_2();
+	test_3_2_2_race();
 	return report_summary();
 }
diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index ed4d069e..8c39d4f1 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -79,7 +79,7 @@ qemu_params=-device diag288,id=watchdog0 --watchdog-action inject-nmi
 
 [stsi]
 file = stsi.elf
-qemu_params=-name kvm-unit-test --uuid 0fb84a86-727c-11ea-bc55-0242ac130003 -smp 1,maxcpus=8
+qemu_params=-name kvm-unit-test --uuid 0fb84a86-727c-11ea-bc55-0242ac130003 -smp 2,maxcpus=8
 
 [smp]
 file = smp.elf
-- 
2.53.0

