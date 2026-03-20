Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D93CF055;
	Fri, 20 Mar 2026 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023351; cv=none; b=ufBVxk9//aHicdeOk25+6jCRdByAPo0lYcXx77pEFciJ7gXh2rJnl+SRrfIJbWjlZPjGgJIl9wXIWpthyXzHmkOv23otrvYbN1ss+AfoSvIjNprftQ9rJb+LKfr4BGbCUxMGY+VXoeeN2xfgGqe8REko7Qree7GLLbnqndiBNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023351; c=relaxed/simple;
	bh=CMIxBDgO+n1A/9SEkf98kUAGvJZlIK3tSKK0E9G6p/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSah6kejfBSILszmizFVXm5NpZ32JR78Nd7WyC5SzdhNS3WPlgMv0QEhS2vwVZwDzd+/CHHKNI+jpfSSghIVw8L5qfkzA2oRQ6dMV67BwjGiV8rAdMhhMFDc2MK1ITC/goYHPOSfGiNboKXTAHE3qZ/8dekUsw6/LWq7NaiHKTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SeDthXlc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SeDthXlc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8bNNx734854;
	Fri, 20 Mar 2026 16:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mWuEbw18p0LQsiEzb
	IY7JrprUCsHf+YGsUm9HrCTmCg=; b=SeDthXlcjTXC+rFpQThtKKAachbH2IJ61
	dJDtA7XDwl3bgAGwR/bxRBNYjAnziKA9nootvgnt+Q9Eh1FV/dKVkcbirGkADIaI
	sRUwKMfd04oBSD8fvI1n7d6H0zyyAglAASwoD2kfxWgL7BnmcdfpXUN2yghAAZqI
	YH7FBUcO9llGFsN6p0qBMRXp0TkOhCDilKPSw4ihSUor5IK3g8mp/ftXphUKjv9h
	/d4REIZloPASyj8j8Oxcs/EF6G8DyUM2bPxvIEDCGyB7vBbhZ/VA+Rk5HRVGpUPi
	dMhBm8EKGtXDPRb6sJVqrX+1nx01XCToRUypJOQ0sdX4FN+TszBZw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybsmdab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KG5seo005412;
	Fri, 20 Mar 2026 16:15:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sr0db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KGFhkf22020564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 16:15:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0167E20040;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7BA62004B;
	Fri, 20 Mar 2026 16:15:42 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 16:15:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 3/8] KVM: s390: vsie: Fix check for pre-existing shadow mapping
Date: Fri, 20 Mar 2026 17:15:37 +0100
Message-ID: <20260320161542.202913-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320161542.202913-1-imbrenda@linux.ibm.com>
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69bd72b3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=PlgCcmkuhnOIsHVkaVAA:9
X-Proofpoint-ORIG-GUID: 8_m56WBBBjHT9L5bKGwFDaINS9Y1nPRd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEzMCBTYWx0ZWRfX7QQXryXtUFpt
 IwSW/pD0IE5thTAfROClABmvTG9HSCyI1Tr1hbnbhZoEGX0ORcor0PZikZQG+ssw0PwfOcS4Khw
 RJuK7E1+NgnBgpTBNAX4F5boL+642eVvFKjAXqhYyJCd2T5OKpiKYkzae/mJjB9INQ5H8MKTFE7
 Ncg8/tXCEt5EILeUWl/jLniJGhW243InIrkAV+w6Yy5VAPkOVV/+pVoWUOd+WjgAODKEr3YF7SG
 Pd7rdJme5OQhmelm19ARKmy5P7e/5YCRDhZDB0m8kK8RIn4Gtl1mJqN43tChQPe14wGtvH2d8tD
 zfIzvSxGoTEnQLsCqupugIaGchZ/GE7i8qtJ+z3HyEQY5jhZUQmHOYZJwB+BVB1Omdfku1HyLYD
 nJu8hd/G+gHfW1m26llryni6UblHJyn3umXTrZIepz3Teos5nlfryRxL1lHhPiSktnrkq1+TxXl
 siESXuR7Gz28txKipcw==
X-Proofpoint-GUID: 8_m56WBBBjHT9L5bKGwFDaINS9Y1nPRd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200130

When shadowing a nested guest, a check is performed and no shadowing is
attempted if the nested guest is already shadowed.

The existing check was incomplete; fix it by also checking whether the
leaf DAT table entry in the existing shadow gmap has the same protection
as the one specified in the guest DAT entry.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/gaccess.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 4ee862424ca0..dad02f7f90f1 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1507,7 +1507,8 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 		return rc;
 
 	/* A race occourred. The shadow mapping is already valid, nothing to do */
-	if ((ptep && !ptep->h.i) || (!ptep && crste_leaf(*table)))
+	if ((ptep && !ptep->h.i && ptep->h.p == w->p) ||
+	    (!ptep && crste_leaf(*table) && !table->h.i && table->h.p == w->p))
 		return 0;
 
 	gl = get_level(table, ptep);
-- 
2.53.0

