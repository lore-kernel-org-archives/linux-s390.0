Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDCC3F8247;
	Tue,  4 Aug 2026 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853323; cv=none; b=nshrWOZN9kPWxlHcUOWjk4rPox0j9yOsKcINUBMTsAQuBPwt/lmaTFtDqy3HlKs1Lzjpbmf3qybyTTKyw6MuxHJOZ0WxRk7A4hA6xg5UmCYMV5KognZzdT/sSonbzpkzcsKnxkbQG9wsOGP6one2tt3AUg4xZUncPkZrgz9aBiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853323; c=relaxed/simple;
	bh=97iBd3zUVlmWeriAgo8jKdU6yQhV1vez8dVhN+KoLac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUbR0oPcbIdy2FFwW6rEqW/nQhD3REqHeRQN/ZajfW4qFsgQClPmptz9KQiWWCQfQCHSDp4GN8ozOWMFE8VL0mSaq7YFEsLMIT04LRyBCTCFwQXqvbPAWWtyWixIPIYEFMnKlzlY9tIfNVj5t4EwRpZijTMKpbvAOFY+arP6LyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UUXXxSRm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UUXXxSRm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674ClXRW3207482;
	Tue, 4 Aug 2026 14:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EqaigvIYKs2WODbZa
	15AZkOJfroXKkfJJEpnzbZ0yjE=; b=UUXXxSRmKCx6jRBN41+YLaQ7R4pTXRM7x
	OhIiFA2RnyXegMLEaCW/9pHtSSBE4FLQppNbzjIWlwbhEur794DaO5LbTKVnHl21
	+z3yJjJZpiTY0N3Hmj3bsAIz0I2/YueUJJ3TGSqzogAhtLEdF6e28Bfo0ybWFXtE
	P77RCXMMoLJxQaP0bgXWTr6+1OY8tMYDOodSPxEsc5MWAJAB3JAGiayh3jRroKLx
	7BZxyjPH6/jrSiKjLEsSmwWzumepy/4nQgCGDC7AOfXR1XwKY3I04YF3S6eXfuv+
	oKoIhUO3Tke+Sc27eCpfC9pwkCxho6tzruGISI7kRXIlf6RPdum8Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqp6nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 14:21:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674EBKpJ024216;
	Tue, 4 Aug 2026 14:21:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyj245-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 14:21:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674ELho951577202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 14:21:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44F5F2004B;
	Tue,  4 Aug 2026 14:21:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2452B20043;
	Tue,  4 Aug 2026 14:21:43 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 14:21:43 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests 2/2] s390x: skey: Fence TCG protection checks
Date: Tue,  4 Aug 2026 14:16:29 +0000
Message-ID: <20260804142133.1745878-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804142133.1745878-1-frankja@linux.ibm.com>
References: <20260804142133.1745878-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K14RDMgUUDNq5WdEYA7l0u_dRMZmMi-i
X-Proofpoint-ORIG-GUID: K14RDMgUUDNq5WdEYA7l0u_dRMZmMi-i
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExNSBTYWx0ZWRfX+zLnbjuTtRar
 NyJzH5OyRw9DbmjYo6068kp9Z4xcSHUbkMpB1wA+pkG3BcY9Np7g4ikDnJOcNi2ratRbNJkk/ym
 Vaqeuutt8oOTrBcdetv6n0EqIoKIdxM=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a71f57b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=aj7vLwpqxZrPeLKjKC4A:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExNSBTYWx0ZWRfX5hHfXEAGw4UW
 uUBiaAitdgmfRv9rcXTTbLpUnFTyyDcJ9+m2Ox85AZvxRjR18j+3f+WzilKcKKFx8hl0EwolMQv
 qkgNeUM8fB++AHaoAr6oB+yJ2Uekk0NvDfQqzKqP04HS7eRsmgLc9UJyTr9IOViNJq+ot0jQAGQ
 d2Vnk2CpBpFDs4TNbcl2oRTWaHQt81qvLwNecK6JlB6tgGfm3hmRHDysoU61Sx79elB6AMU5JZy
 vVr7iTL/+L7U49FQv8+Ch6lmEy8oBgR66a8oNmOctJZ3VR/hjexHJjQ8uh6rKi3RCZOEW8uy3nP
 sh8OW6edzFgSYn6dkKkbSzJAXtWo4yWFKqAtzTA8dJ1WDCN+qEgMa4giWr0pWx5IfME/6Ezc63c
 Wt9Rorv+ZRo6TUD69sgDmHUdiJv6+ZZztjsDjw+sKcY4bUmHS+KB4BjSpULbZUtkzw69gU73AXl
 fCWGhY2kWr7tj1vSL5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040115

TCG does not implement the skey memory protection, skip those tests
under TCG instead of filtering them in the CI logs.

This way the test will PASS when run by humans and there's no
confusion why it fails anymore.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/skey.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/s390x/skey.c b/s390x/skey.c
index bb769730..1fc95857 100644
--- a/s390x/skey.c
+++ b/s390x/skey.c
@@ -14,6 +14,7 @@
 #include <vmalloc.h>
 #include <css.h>
 #include <mmu.h>
+#include <hardware.h>
 #include <asm/page.h>
 #include <asm/facility.h>
 #include <asm/mem.h>
@@ -736,6 +737,13 @@ int main(void)
 	test_set();
 	test_set_mb();
 	test_chg();
+
+	if  (detect_host() == HOST_IS_TCG) {
+		report_skip("No actual access protection in TCG for skeys.");
+		report_prefix_pop();
+		return report_summary();
+	}
+
 	test_test_protection();
 	test_store_cpu_address();
 	test_diag_308();
-- 
2.53.0

