Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97683CB2FE;
	Mon, 22 Jun 2026 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144470; cv=none; b=VZAcFuNybhlrzhlQKO7oOCBSwBKpf9dmlroLeqKNihIq58YK171gh8vFfK+31v90/9CZHLaawJTIWtMmadNFa9u0TjWqHj96N/4Xy8b1lkPEGgrtG7SloxTGZ9Cyq+i03LxV1BFRQhdnZA9sF6VCH/2yeJThBczTl3m75VFaNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144470; c=relaxed/simple;
	bh=tI9yzy9tmDL9pmUBKVytm+1++kVuYqmntG5DU8dx/pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1ZiVJzq0+h6Ji3IOElVaZqQnacATdgHnlYRMKC5NA1AJYCgou/mlOM/H/xSB7reeV+aIVe4QQYuXU8EClKio3sTckBQpFRbtg7oANK0x2Y4J5+pD9pgCiCj7yHzWK40TybzFlW5LxxSK+30qXhd+EMJnsZPHbIeoAHMSLqOy0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rhci/BIe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rhci/BIe"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmSkZ3447396;
	Mon, 22 Jun 2026 16:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xSC9oyjuG3oebj7Ky
	e/o3GN7KG5JcgPvrQaPezLnOHY=; b=rhci/BIepcc8MrrQ4DXtMKngXQcWLDQ6V
	diA0oKAZeWtIu1Hpw1CX5UC4iF9vFblgkTx+NsvRCbVp+tllrvoi5m4Z7LdA5ZJj
	HorVjG2loRGK2vK9Bju2SWVOrUpRGqKiAXUzZTCy3tQ+ELvMJDPV9zjxiz0fRrUc
	qCwndS+ZbonpxeX6H4GIntVLrvYTRL9vi6D36Wt2hWrdSoDj1iIjRsT/1Bv4kjzw
	ksZpg2bMTzGJhtPNezYIcG5li+D/EgEoiSRSQoTXC0f4PZosJWIsfF9LpkUmrgXi
	sH3XmiWR4CgzDVuD+uoYjYGYIzBtm1bdyO7C8iGVgbGJWZytL7Y6A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3a6f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MG4bSa008743;
	Mon, 22 Jun 2026 16:07:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyep3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MG7gw334865552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 16:07:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 072A420040;
	Mon, 22 Jun 2026 16:07:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD34E2004B;
	Mon, 22 Jun 2026 16:07:41 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 16:07:41 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v5 8/9] KVM: s390: selftests: Fix cmma selftest
Date: Mon, 22 Jun 2026 18:07:38 +0200
Message-ID: <20260622160739.202044-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622160739.202044-1-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a395dd3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=DNRWrYgN0gedYPQHzkwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfXzESkxHTH+An7
 BmnnPBvw4DZrvQjRIRxymd86fkKc0CfsU24P7E+yU79v43hWdR3ZGHnJhL1ba8BEdL8hz2VpQWR
 cA+Zr1SR3BPEplerMdr9mmp2bIDIOSo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX6Qh9s7FRCxzZ
 vF09s4ZQCMqVZbF95HSmp3LxzjztoThcyup0d79t29Nf/l1uPWkmWEXOWE5uI9FisSAExPR5XZy
 tPL7E7CvOI7hPvYB8gyiVsvHpKZRqF8wXl4assf3rly7TzUdp7Y4YaSvF3amcUsc/5PLLFqScMC
 UhzHJDFFIzBhhzciRv5KGPhrZ1KIzmjKHo17Huq5J/TkjhylkX4IsaoGH0R9XqI8s6tf46UeAKz
 EK6TF69rPWtdS8M+O1zkRtWSFRhTvxtcFyNYCIZs22/qLoYoCp429iwYl9SV9G7FTOaUgQpxr0U
 KMR6Dn5LGqKJvwfDtKmvtj/QHk9n1vO8Ewm0Rn2yiN6Z8s4j8L8CHshfsieZunh6fAb7e+b7xFJ
 1s5vJ+NxbNZr/2DuBXv69U8geOn+dIEGBjSs+uHhX0E3iMGPLPlHWf15Aug/TqzQsnovakxyU/D
 a2YssL/O9T7/l8qs9Rg==
X-Proofpoint-ORIG-GUID: HeDC_Moz733qgFjQ6uGoVXUGpeAqsuT5
X-Proofpoint-GUID: HeDC_Moz733qgFjQ6uGoVXUGpeAqsuT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220157

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

