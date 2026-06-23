Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F72F39B5;
	Tue, 23 Jun 2026 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228822; cv=none; b=p4Gu3mCFPqlU8rKSo5AnOtGR5mb7PzV2H6zaJoUBSA0elQta4fvEcNNSxp/GtUh4+xQFjMJEBC5+q0JYtKLsQlUVgnovNOdam3E0yLrPQ2eqj8cIxUFtiGtasqpN/nHo9X3sMbm6IicGavoCICOek9PRwQb6OFEGGzRhSbajn8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228822; c=relaxed/simple;
	bh=tI9yzy9tmDL9pmUBKVytm+1++kVuYqmntG5DU8dx/pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYzLEbhqkgAXWJTcCoOKTIswamlx/Gm0wus8uOuTUqLd7+8+AyS3eMVxzr1E4dvlL0BrcaoX8HoCvR6lgBgOBcPR/4qEzUpikz6iWZq3nvuaLsByCoT+408fC5/Su1E368J+i/CAxQhIPA5m/pvwoetSDa+bD6osV75rp6wp590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HSpJXspk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HSpJXspk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmk3p2136766;
	Tue, 23 Jun 2026 15:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xSC9oyjuG3oebj7Ky
	e/o3GN7KG5JcgPvrQaPezLnOHY=; b=HSpJXspkvy9uxDAaE2kjlaoGEvLpkde1U
	QhaJwlGr7uBWoptGdwenLjUPwuVroWtnRdn6Ho0ZxCv3VO4oI+5mx+SHwhh++S0p
	yGwz9OUJ6LkkfRWw6X6DNP+odWIIoldnbOAQ801sTHHjK9hEFVl0wUAjaRGxRXoX
	sagX6eKRegxdXwbuluiloSCKvjMyTPCCVA4bT3m5PI9DfsTfHJ+kEz3JF2UgKcby
	MQXSFUMXmtqQc/BcNc8VW2ULkvRz3CcsKfyjlk0KHcz+mRmHrm1I6ChZc2Y2w0im
	o/XVvZccm4/61sVIjFxpGN0a7y+Fy9o9nlC/u96WLa2er5XV10KCg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqqbrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NFJhve007023;
	Tue, 23 Jun 2026 15:33:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phbxt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NFXXRi44368296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 15:33:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 677D620040;
	Tue, 23 Jun 2026 15:33:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C12A2004B;
	Tue, 23 Jun 2026 15:33:33 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 15:33:33 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v6 08/10] KVM: s390: selftests: Fix cmma selftest
Date: Tue, 23 Jun 2026 17:33:29 +0200
Message-ID: <20260623153331.233784-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623153331.233784-1-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3aa752 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=DNRWrYgN0gedYPQHzkwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX1ekeZAMN6Ip8
 3d81NUw5B5njfFxpXR3dq/D+SBj38SvOwSZuhlMyx0MjqgeuYiM7/5Lb9dPBj5u8eOomK+c6lRj
 EtviUiKgAdCB570t67vgJ+R3bmAq2CgLY868X9hsy8svC/LSfMBHV6Cu32nKgV5UayJFF2/q8Oh
 nEkLACdVtNO2d5u/DD8gosyYXaTq/Lw7KHzXnPqJ56xnkL3Cxir+8Y3XBljYQURIDetW92JVUVg
 e3nnxmiS7urQJAfmmu5QVGS20AcRl7k3axK9gheGppJVbkOSL2Ukgj+r1dq9ZcfajnILg07uX60
 hVXPDsJ8fMXfk0DIYCfOuSzEjUdx2/vDEoWbB609htgoOri1SRxxepQ4BmZZTPBdMvv0qcofxah
 kWBUUJVD7dtpjJvMmB8bB5ZSG1UVS32U/NwJlA3NvgzhhyMTtSptuPyh35eTewGx49RD9kwaUMz
 VZeab1ONecXcobMP17w==
X-Proofpoint-GUID: isVsS4xNhb3aq24rZ48izcqozY7W_J4Z
X-Proofpoint-ORIG-GUID: isVsS4xNhb3aq24rZ48izcqozY7W_J4Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfXyqcPQOjq0IEl
 6qjOnuONkqGNlxeyzzj9qdXZeEyj5vLm12BoU4y4G5UtY+QWpj4/rAEIArH82vayCWrXLHJM/kv
 qwWoIEXRo6l1BTorAFUvI8ZfQW4tnGg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230126

The existing cmma selftest depended on the host allocating page tables
for all present memslots. Since the gmap rewrite, memory that is not
accessed by the guest might not have page tables allocated yet.

This caused the test to fail due to a mismatch in the assertion.

Fix by having the guest access also the second half of the test
memslot, thus guaranteeing that its page tables are present.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 tools/testing/selftests/kvm/s390/cmma_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390/cmma_test.c b/tools/testing/selftests/kvm/s390/cmma_test.c
index e39a724fe860..15d81b2ed7ad 100644
--- a/tools/testing/selftests/kvm/s390/cmma_test.c
+++ b/tools/testing/selftests/kvm/s390/cmma_test.c
@@ -34,16 +34,22 @@ static char cmma_value_buf[MAIN_PAGE_COUNT + TEST_DATA_PAGE_COUNT];
 /**
  * Dirty CMMA attributes of exactly one page in the TEST_DATA memslot,
  * so use_cmma goes on and the CMMA related ioctls do something.
+ * Touch the page at offset 1M inside TEST_DATA to make sure its page
+ * tables are allocated in the host.
  */
 static void guest_do_one_essa(void)
 {
 	asm volatile(
 		/* load TEST_DATA_START_GFN into r1 */
+		"	xgr 1,1\n"
 		"	llilf 1,%[start_gfn]\n"
 		/* calculate the address from the gfn */
 		"	sllg 1,1,12(0)\n"
 		/* set the first page in TEST_DATA memslot to STABLE */
 		"	.insn rrf,0xb9ab0000,2,1,1,0\n"
+		"	agfi 1,0x100000\n"
+		/* also touch the first page of the second MB of TEST_DATA */
+		"	.insn rrf,0xb9ab0000,2,1,1,0\n"
 		/* hypercall */
 		"	diag 0,0,0x501\n"
 		"0:	j 0b"
-- 
2.54.0

