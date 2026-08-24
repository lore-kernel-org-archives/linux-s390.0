Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30F343BDA3;
	Mon, 24 Aug 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582306; cv=none; b=mVSuAW4akqkPy9jkqqXMW4tclnDAqvJ3VAGlvCdndTkdCTKhNE6ODFhKKfWr+kEdRp6HXadrb7t8UVRNrOcNnm4wgr/3WnF/Rb92zK4HyjGGmkxqFRVtFVcUKCR4dE8q9fq1MfDO3Lp9Px5lq8cD9mEMFmifrxY2lgj6tRMu+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582306; c=relaxed/simple;
	bh=97iBd3zUVlmWeriAgo8jKdU6yQhV1vez8dVhN+KoLac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePobVl7ztCd7zpziVfmnpSquoBRJdTsVEBuXqtaPik+RkA3MsmEsiiYKaZJPENpiQsiU3QbkUZqxEfmo+mzv43zlUkA4Ju/LXeA7Xa+PhhxCIDZBy9ifDFK7xv4E65Vi4HTmeDRj10n7NSeNFu5iQMQlACFdBKTrl2GBsGDa1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KGou0o2X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KGou0o2X"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1WeK1935720;
	Mon, 24 Aug 2026 14:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EqaigvIYKs2WODbZa
	15AZkOJfroXKkfJJEpnzbZ0yjE=; b=KGou0o2Xt99eaRTIOIN0KucLtPgglEqCG
	AKCuILaJyZ0J9cN5A+m8qz4bE8PZURIuMMbkG300wKyRXMm6I1Vxej1wFvFAhd6W
	uGBB33uk0A3Y/GsiHp++EE5trd2S4myqvqCjse/DnTGhYVI8WIwgcvo49iI0V2W2
	NW8jBN04YJn1MGC41ri/6A4qiZz+KAp8oLoCEkFRgbcDuD/eA3wJh4MVlW02Mpkn
	EH/+Q+gnZ6jqe4jS4LDHQqpRcu2Xa0pVj1q/bf8QpBk2RFOYZU04WmAQpl/xC9S8
	pJ18jWZkk/z+xEGnqOkYp2c7vtmwvqj4y1Jj5m7B0EnOjhJ8eItJg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393t1pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQHVl009798;
	Mon, 24 Aug 2026 14:38:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxx9vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEcHRT33620304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:38:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A767A20040;
	Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 814C52004B;
	Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com
Subject: [kvm-unit-tests GIT PULL 13/13] s390x: skey: Fence TCG protection checks
Date: Mon, 24 Aug 2026 14:35:45 +0000
Message-ID: <20260824143740.291583-14-frankja@linux.ibm.com>
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
X-Proofpoint-GUID: HE5WShRl4xs--bIvnLsK5TZQddBwb0hV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfXwIa6Fks4XHyt
 9DU8AGCpWaUBWdtQrxEMeargv2YGHsRNdQ23Zjwdgc3O74cRUJKlGOo9PJS7aa7/8Nm5kRgn0Et
 z6QLL8MiuRlRFtAKbdkEytgHnCLAGOk2W1yRMfPhUeb8gEAg/TJcUondzSISKfHIabH2AKZKszA
 uR+G4JvA2B//kNCss9wb5kXgmxLFDG+6YBNtuWx/OHORLpJclw2Efz02D33/LaQq5YusnZ26b2j
 isHNrD6uzoYdFX22qRwbCpL1S06T8YelzJAmvEeV4/AONGEcUWbb/W3FCKjZwuW+IPrYetp9nni
 KcDftYUDI1Akv+n+sf8OAqnDNkuRmmb71dsR7QFMqJl841hSlTOVAwgDTlwQEFwSpHyQcKcoyNo
 +uOJdJX76jWKknUQX/adayG0tClL/UxduSGit12C+cm1RWcnKExtRXBvP7Ap/6uXZvbLD0aqba3
 mlpsrLflOMQPVt8tx2A==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c575e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=aj7vLwpqxZrPeLKjKC4A:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX9KaJNGl76bYG
 Se6fsqCPJlOOcK9k4TNC6Xgtts+I35GHDjrBxN/TnV1EIolVDosPi0AdDVU+JroUWlw14acZVCO
 aWss+Qgki7u+JnZGfIlrH0K3GslvLF0=
X-Proofpoint-ORIG-GUID: HE5WShRl4xs--bIvnLsK5TZQddBwb0hV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

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

