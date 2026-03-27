Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C5330B32;
	Fri, 27 Mar 2026 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625050; cv=none; b=Qi7vvh/+L+iIAhZz1H2oQnlQJafdFH3wG22+pKYTp6p+Gu/vYnP97UbgzxRFqgEPtDikBKtPmqCCaPtNaS8oSxJ1PYqJErzBcOKHCui0TN3L2YCjlwiPgR/F8oMDYKlm68eNzQHAYXTK+xw3XWCbgewxT2IJ3z0X1sX2QN2QYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625050; c=relaxed/simple;
	bh=HxHQcTdxh1DSqWo1LrNgmMUxHbi/u5hzKykKDOpktOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EM8sanrFu7rjIPOx6Kl6hQz0DoraYKhocvfZqMnHt2GlgDiQsofWGBrW+HsH9Yn8LwvF2z6dHrDb50PYlWPLiG2B1MzElwitD9HSagoEeEyI8fCpLesqOmZ2n8ZZPW7w2F2mU4Z0CU2BMxjA7eq8ys8tj9aFptrf4ve0S4DHGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mlja8SK7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mlja8SK7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RAKCSQ3275715;
	Fri, 27 Mar 2026 15:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=C5ioDTL6Wi0ry1qy7
	pdSLuJfLmOL0v2wMiCS93WG89w=; b=mlja8SK7MqHYpwkCvJ4hBVY1jgP0wEueA
	CIrpfXwZTQi9RjbYFpljwQ7d4pE2twnPD7d8tDlKTJSc0aRa1qfPSwb+/RLPtXtl
	sr8mbXrQYgqcsx2L4lyAqewyQsPAG+uHH+TEDBzejHujTkhAjWTcMfdV/5Sg2E0m
	cEN0AAgpZk0zayAQOI2ZAPjV5DWUQkuTbmOxEDEQw+R62TM21+6vdiV5pYMUmRiv
	cVEpScQf0c4J5E0bD7JGk/hGXLhBQywRNTw/pg5xj9ilo6BL7maNBuNlBdNW54lx
	2RC4fDujyAyE4+H1YB1UGHy23D4jxdHwXHSAkw4LjJBJsHkoslyLg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqtw0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RC6x9i004392;
	Fri, 27 Mar 2026 15:24:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2fryp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RFO09h50201016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 15:24:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01B9A20043;
	Fri, 27 Mar 2026 15:24:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 694E620040;
	Fri, 27 Mar 2026 15:23:59 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.84.176])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 15:23:59 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 03/10] KVM: s390: vsie: Fix check for pre-existing shadow mapping
Date: Fri, 27 Mar 2026 16:23:49 +0100
Message-ID: <20260327152356.250625-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327152356.250625-1-imbrenda@linux.ibm.com>
References: <20260327152356.250625-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tvZDGSVv-RZ2Hs42DgvSlmSFcX7-rBC3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX0DkMx/vI3Gth
 1SAbZafsaD7fbXt4gRUlo5exH7VnIXVl+uyJz0nuVlKqpjb3d7JtIC/x8ycLskmcAz8s5RdWJdC
 Q1GzMHVZaI2befYgXlITQjQzzi5t/OEhbZYc6JI/6Y5U+RtxreNYxrB9Vl4+v8lFphKrvvXR96E
 +gllc4f6dz8zr5U+IChJKPM10/0hMUZieg52WSBUiKZwOpNcCYB8/SRHB9fBh2BAQBipdpl8DRK
 CYQAqCsK/U0gOrXfDz6HsBM2UIUX0Wf1oClzPpIwfgSDkVJ2YtfisClhaCVV0iJOYxeEKsMGVyv
 S5VHU/4EnSKdhOzLsMteg/pgp0JbfeCdMY9jdZdS+v8vceg/F8FuE8I5t2mRiQr/3+18BN1pDEg
 0t5/b24+FyIE4yAqUPMsUZcTOhynpTmRwRiB+3B0Lfm5iPECo7qsHGtYttQHhIGPh/GhZ1hNJW1
 mYGzsL4HeDLBORGkLgA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c6a116 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=IDpXgTtpuR7I2MJaEF4A:9
X-Proofpoint-GUID: tvZDGSVv-RZ2Hs42DgvSlmSFcX7-rBC3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270105

When shadowing a nested guest, a check is performed and no shadowing is
attempted if the nested guest is already shadowed.

The existing check was incomplete; fix it by also checking whether the
leaf DAT table entry in the existing shadow gmap has the same protection
as the one specified in the guest DAT entry.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 4ee862424ca0..8fd690255e1b 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1506,8 +1506,9 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	if (rc)
 		return rc;
 
-	/* A race occourred. The shadow mapping is already valid, nothing to do */
-	if ((ptep && !ptep->h.i) || (!ptep && crste_leaf(*table)))
+	/* A race occurred. The shadow mapping is already valid, nothing to do */
+	if ((ptep && !ptep->h.i && ptep->h.p == w->p) ||
+	    (!ptep && crste_leaf(*table) && !table->h.i && table->h.p == w->p))
 		return 0;
 
 	gl = get_level(table, ptep);
-- 
2.53.0

