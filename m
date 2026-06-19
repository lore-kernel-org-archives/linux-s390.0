Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D53BBFDA;
	Fri, 19 Jun 2026 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884338; cv=none; b=I/ZBqYM9rlh70LYlSrI4q//NulGfdBFm38ngAEOHG3w2YyojIMT0Z1VOvthRk73EUIbIOYlzjxTk9DLNDkrPgQDd9i0Bi+FZ6Q2yD/MZjo/C4oLPW6sM/y8jzeHEg7dAnIZW0tCqNWX1Suxa8zZqVmf/11w1UOUaceKuiYn0bJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884338; c=relaxed/simple;
	bh=hbQAG+GhjsSMPCx0hwnF1zC3Rj3l3q4skyx7NoTg2Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoGIVWE8MPWPEgnDXz6KpJPVaTv9IV0SU0NA0XstQp5MaQGCzv+dae8z513amC7fZOtfTgJzUUKRozxmCI30WA3//AKNbAswYOqGYdAp1XjHLlLWZcJSdHqDtuYINeskwnrrBV1DrVWue1ihwy6ZXQOc+iRP/4n9xEF0Fn4ICjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wq5TSGwD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wq5TSGwD"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JDISni2320856;
	Fri, 19 Jun 2026 15:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iDUfPWs1Ez3QEJ/kU
	Or/Sw5kQfEbaNbCSgDp2PRytao=; b=Wq5TSGwDVu/nA7ZGTrbT8fEURlgKYzwt5
	vQuLS6hQeZXSWgTDjsRmxI9rwEtdT7u7AufwhL7EdQ1AB37X3EI3sQ6Laa2zFfLW
	dQkaRBJvXdmAjwPldFrTSOl8M1oR3joIx2ktTKMEK5Yfwlcb8WfVV50ZiaHR/B2i
	U12QDq7Vnk2edkEhZ5DyAQnCNNc+aRYhYQIual19HOzgf7ex1FXTWxh9RLPywBcB
	U6s2AQZCEQkrtAtt0wXX61OOe8NSAyiIaVQUxGRQEQQTqKG7lkE23wxVNWq/9ZBn
	I/IM1Sshbfy2HCKg52o26778GYGVSyrGoyv+pb2b+FUPuOidVczAg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxp6cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 15:52:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JFnbuU026483;
	Fri, 19 Jun 2026 15:52:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172hh6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 15:52:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JFq4X516646492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 15:52:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8498920043;
	Fri, 19 Jun 2026 15:52:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77E9820040;
	Fri, 19 Jun 2026 15:52:03 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.54.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 15:52:03 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v4 7/7] KVM: s390: selftests: Fix cmma selftest
Date: Fri, 19 Jun 2026 17:51:54 +0200
Message-ID: <20260619155154.307572-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619155154.307572-1-imbrenda@linux.ibm.com>
References: <20260619155154.307572-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a3565a9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=DNRWrYgN0gedYPQHzkwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE1MCBTYWx0ZWRfXxl91l9S9YczP
 s7OulZVIDKSQpBIJG2KzhY+Z1G4CshMABsvK/evkuk8UMVhZKaqPx4DOwYju4o+HJZSEZs96xbB
 mBiheuGUUTrjgHXUZ4E9nKissjHiY5P0uSc2bL4qI2dSoeFads41Q2Lqf1/yP6wZ7XffWhKO63O
 gWjY1/s15LZbcF57+4ZO+VNOkRwz7LrJ1PYfm05zetZv8LHBYod4m+5j8aEoZOpuvfrB72T5a7a
 /iLHRBmRDacpukzRyOCEzoDF0e8pABAJz6pRL1LlQ7YFxdpJedi6jqiLDByv7Z3J2nVsuRQizkD
 B+jeRqVsQpqoKuLhDL9c04rtWyAyMd68guDPzPTYFLERRr3iLg0CmPLT3HaJ/7PtAipxadpcNCi
 jRA8mt4Tcy6EcheVdvj2vH5muVzlQFMv2rC/LJr4sD96scsHF4rT8cLPTlFiS/F2i9tDM/mrY/z
 H6Y36BxzX3B1xNsmOJA==
X-Proofpoint-GUID: xtFfXYUq_faZfX_1LIL3onqqQHPQxWfU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE1MCBTYWx0ZWRfX1FdNjIhzORcm
 61OdWcn8BXcoB4krlAD/mD9rdY/7OaAIuBEVtTQ/rYezvsjfpRbx7X1bgm3PcLARnGnJ+KcNXlx
 CwYEpvyVx8OJRx6ZhediWjCk1EuybZE=
X-Proofpoint-ORIG-GUID: xtFfXYUq_faZfX_1LIL3onqqQHPQxWfU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190150

The existing cmma selftest depended on the host allocating page tables
for all present memslots. Since the gmap rewrite, memory that is not
accessed by the guest might not have page tables allocated yet.

This caused the test to fail due to a mismatch in the assertion.

Fix by having the guest access also the second half of the test
memslot, thus guaranteeing that its page tables are present.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 tools/testing/selftests/kvm/s390/cmma_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390/cmma_test.c b/tools/testing/selftests/kvm/s390/cmma_test.c
index e39a724fe860..04f34b7ec127 100644
--- a/tools/testing/selftests/kvm/s390/cmma_test.c
+++ b/tools/testing/selftests/kvm/s390/cmma_test.c
@@ -39,11 +39,14 @@ static void guest_do_one_essa(void)
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
+		"	.insn rrf,0xb9ab0000,2,1,1,0\n"
 		/* hypercall */
 		"	diag 0,0,0x501\n"
 		"0:	j 0b"
-- 
2.54.0

