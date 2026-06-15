Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5649A3EA97A;
	Mon, 15 Jun 2026 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527376; cv=none; b=YWcOYTmgU6J5Uc4n8iQSEvg+i4XxXDE+QOv7h6sZU14lilJlDZ5s9p++zUvrQOzdB29KZHpBSbhLoKNnksO3u/t/v3cenElcn2a15oCQZyC/Drch34hGl4qB2MT3VtcFz74pyj7WbixnA6qjp/K/jxSDWvsWRztNF2Y1bF/5OWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527376; c=relaxed/simple;
	bh=edYWt7gClOyIynKYIBBZ5BCSZ0FspC7q7omW2FnZCSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtvmnD+6f5hVSYcDncE7umBDaOcarwaHPxKUvlc0oQFP69YEFmfIt/fsUgk4bmS9956jaKe19oMW1FiLj7xJkzwIGJmeQe7sH4vOCyO17IseJbZBZ6Bum4JEElxmste8Jr4NYbKYLAU23rSTGGeNW+BuhQCzL3FxC1bzjF3jmUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jrjr5Rp/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jrjr5Rp/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAo3mZ2198634;
	Mon, 15 Jun 2026 12:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CN3N792buYpuQ9jR6
	b4vW60QyyTvtjHjDEH+78ghCgs=; b=jrjr5Rp//21DiwHMv/5aWmuZ0qLGDPKPW
	iKUgoNNhpgc2TClhWWbTXgmfSv1A1ktUDt8qnxgqbrtgNaWT5cQIECk5YcqXzGwj
	ZYHAqBouRU8pQSlT3bA16hPH2DomzxSsbxNECK05t6unzfRpXr+XeSM91izSXL1w
	MFuXhQgXs0GzU+MPCELRPGJ7W/ACjc84bpQNgEeujYK3tlzc2cLzPK4gLNbnWjnn
	AK9Nhe665lPTm+YXBxin8lv/0sffE9vLdJHQzBTPAcuKtzPqy61bF+xzvPmcoToh
	ghU+WXBKH7WYksfuQ94JYF9oWbhzXWJakgRqqs1Ax6er3eB+MKJtw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23ngfj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYiBZ028405;
	Mon, 15 Jun 2026 12:42:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhpxqtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgkrh43647248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 949C72004E;
	Mon, 15 Jun 2026 12:42:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 235342004B;
	Mon, 15 Jun 2026 12:42:46 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:46 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 05/17] KVM: selftests: Enable pre_fault_memory_test for s390
Date: Mon, 15 Jun 2026 14:42:31 +0200
Message-ID: <20260615124243.187614-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615124243.187614-1-imbrenda@linux.ibm.com>
References: <20260615124243.187614-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a2ff34d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=f1nrkDJSyVtqXGSnAM4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX+BL7GEeuFKk1
 0KZVLFZofVfVzg9l652O62G3yGaOK7B+pvBOkyihuB/VdsxGl273tIwHriKrpI5wuDiEHgg72OC
 7xot0C/8VOLZ/EyXPR9Bhka0AnHd6h01h3SKw3mtpLtVttG8d8oszIv9cE0kwf4EaN4TLjP8pb7
 lvM8YDXIBMKSl74inrbp44R3LnivOnvy6qX07FI2+HFFDIWgb099WMfCQ3QC1tpvgVKErm+D79+
 QXXiYaP87nV/S7m4U2D1E78rvoXvDCSJj/NNTcFc0IGlbD3NouEGz96LSVkv8tl4UO6kdtPFClw
 SWMdoy89VmlNsO9BT896k5qMvBb5NoGVMgCE4bKYzQNTOeGVP8HvwsSjRtyDTOrCkZ103VL3ocC
 1f27UHBxszy0IV0sjq2AUw4smdBMNexvOaINt7wMTEBjacuxX7eApJsrJw9WD3/Emqhh9usMA6n
 ocBOMtc6uKSjE5pgW1g==
X-Proofpoint-GUID: eEgiVGwx0ul3i9SM67UeeF9gy1tvyJ1U
X-Proofpoint-ORIG-GUID: eEgiVGwx0ul3i9SM67UeeF9gy1tvyJ1U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX0Uo7/U9XN6Lw
 5kH4+u9rs9MSn1kOLFU6TrXwUIoxjLnbApXaGeCL/E4uhl6hHW6qJCtkQwyx0vYZUBf/8zl8NKo
 nV3PQq98X1c9LN/qYE47m8FDr3/Ha5k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150130

Enable the pre_fault_memory_test to run on s390.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260527144358.186359-6-imbrenda@linux.ibm.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89..fff939db89cd 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -210,6 +210,7 @@ TEST_GEN_PROGS_s390 += s390/keyop
 TEST_GEN_PROGS_s390 += rseq_test
 TEST_GEN_PROGS_s390 += s390/irq_routing
 TEST_GEN_PROGS_s390 += mmu_stress_test
+TEST_GEN_PROGS_s390 += pre_fault_memory_test
 
 TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
-- 
2.54.0

