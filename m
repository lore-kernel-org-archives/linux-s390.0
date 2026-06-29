Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992F3A1E7E;
	Mon, 29 Jun 2026 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724772; cv=none; b=JSJS775Q4+J8vEf6EMKzea4INwO0BftrjBZFOM2gI7n1nIuDUdhPe9AM4POWkaj1z333r9ur99duNKOEry1iVhVAVXauscBdaSr55mhgiyFB+EbBLKqgrOYrZFzC+75MAJrAIg/C8/4FtcTp7jaEIbPltyPdGufkz1cw6adoxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724772; c=relaxed/simple;
	bh=isTs2bvSehS7eQvVpSzmhjEA8qLZJWOKB6ryjOqHMik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhIlhVYmCBGQ6g2DT9X0hGxYaxRUJV3MOPQHbzrSUDcUlBtKS9Jw5YuVrv12xuka2ySWnUE5JTI6RmzGWRXriC+cKX95N+aIKLKqoXvd6WziguWhwM+iIUSdrEDkMksBUG0hJxnF4r0aWuCARuE/IODqKMPyXHZJx92446T1qTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pQ/1F+D2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pQ/1F+D2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6mlYK2674768;
	Mon, 29 Jun 2026 09:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6GV/zJp4bky5621let/9XIeEm4iM0IqtMVjjh7sGe
	OU=; b=pQ/1F+D20Hjj8OL/nu0yBLr4OproxkO7W7ILiA3h8ng8suxY0JWbQ5+kt
	4vnc9Ht9mg3bqwPzJAXsxIWMzbo4czOQ55LIh7WKf7LjRnQaYku3we0zpfgMEO4g
	CTbFGrHtFrDF9TtLvoZF2eq9gizGIkEWlbrtukWk4hWWlpRkLTKyMYRSl5PIgD4Q
	pRHQzvp1BxW8QXFopgchvPMByPNsRIpwWHauESkhG6IY96bKXN6TCbQQrqeywJ+S
	UdKX+HHGBb8Ic398kWEAooDkhYpyZgm/thNt/72te1KZXTb8R9a6migBY0t3zl0o
	qRqsjYIQ4CPlhDsT7g9Malx3Wz1sg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfrge7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 09:19:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65T94fiK026824;
	Mon, 29 Jun 2026 09:19:27 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sujvq9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 09:19:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65T9JP5G12190280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 09:19:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AECBA5805C;
	Mon, 29 Jun 2026 09:19:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D38758054;
	Mon, 29 Jun 2026 09:19:24 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 09:19:24 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?UTF-8?q?Nico=20B=C3=B6hr?= <nrb@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] s390x: stsi: regression test for the STSI 3.2.2 count clamp
Date: Mon, 29 Jun 2026 11:19:21 +0200
Message-ID: <20260629091921.710920-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a4238a0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=LAdyEf86j-jhdMKrYogA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX37fCybDyOMVK
 GfOGl/YaTZcqDIQXewGe7LptaY9HvfrGxCnkKu5XnwGnJrS++cVF8tfyTTpH3xv6VejafVYpfd9
 J6emEfWuibzjsoSjXQE6VyZ1AVWaaK8=
X-Proofpoint-GUID: WOpmGi3gF8rw-6cfiyEUQUwTTT7x02GP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX7tnE56kfZNsZ
 cGZPXC296tEoyBGGegTaG6KMI5c+ArvnFZEHoWwoKZQPsGVBOVRh+CqmIasIM6QUIFuCb4HFcUR
 BzcFP47S4C25YCYjmmHK3XiI3qtX7xaVpt8H+WjETi4G6PsAv7BMLrqPEoeLJ0mMsxkU9qU+8um
 hQ8dp/cNInNrGSMSCvFjy+OAsCYee6+A6l/MDFskT+XSPD9wjY4/kY0Dp0QSORZBEXEOdgnSm4q
 iCFL0lOzjwkn7HZzxBh+CF6gDL2dLijXhFgkI9ZTMjWtbV0/QVKR3/7XyzjpK1ko7WSwJPCHcm1
 UUYr95b/Rg2psNrkT/wdN4gYJegYrYUzqscVVkGtssdrKYWChOA5UKozRwaE+b17qHsy5UdfKhc
 rZOHN3LOQJrwxblnAGDoJZkJAjnhjcgBGi/kMUPg1HQd/bE6aAMj25seW0tUXMrC8QqaGZtDrd6
 buUePzc48raEeDVJyZQ==
X-Proofpoint-ORIG-GUID: WOpmGi3gF8rw-6cfiyEUQUwTTT7x02GP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

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
---
If wanted we could split this into a separate file or always run the
test with smp=2 to avoid the duplication

 s390x/stsi.c        | 76 ++++++++++++++++++++++++++++++++++++++++++++-
 s390x/unittests.cfg |  9 ++++++
 2 files changed, 84 insertions(+), 1 deletion(-)

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
index ed4d069e..c1462506 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -81,6 +81,15 @@ qemu_params=-device diag288,id=watchdog0 --watchdog-action inject-nmi
 file = stsi.elf
 qemu_params=-name kvm-unit-test --uuid 0fb84a86-727c-11ea-bc55-0242ac130003 -smp 1,maxcpus=8
 
+# Regression test for the QEMU STSI 3.2.2 count clamp. Needs a second CPU to
+# race the guest-visible count field, and only applies to QEMU's KVM path.
+[stsi-3-2-2-race]
+file = stsi.elf
+qemu_params=-name kvm-unit-test --uuid 0fb84a86-727c-11ea-bc55-0242ac130003
+smp = 2
+accel = kvm
+timeout = 30
+
 [smp]
 file = smp.elf
 smp = 2
-- 
2.53.0

