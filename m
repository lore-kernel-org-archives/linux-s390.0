Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E6330F93D;
	Thu, 26 Mar 2026 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531060; cv=none; b=GYULnaXYn3PSdOoLYIrXIhXRfgP6RNNuKlKRUjbUlirahYWXY0TNgEp4K11XZGyas2mKQuhhrIsdkhi6UnPCaF//gtRRuHVLPcyKuF2rlGT8TLbTXwR9loXNKQ4qSDsxArN/p71lzvP8E2RRm1UUCk9dcm3OkKoxdMWJmMfZGXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531060; c=relaxed/simple;
	bh=AD1Wo2ci/5DqF4gGSVesfq5rSxmCnlBmXMXYiJZ+rMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qd8kAQWwNXl6Hvuy6SXZ6Sp9kEUQdA/Qguqft26dNy0uiqVq9Ufjc0dQV7iCsSbf6QeZaZxwHuGyol6Tpp395sgd1Z1BxwmDvlfZ702OOrLJnxjDGEEHuGoJLJYQZfsF4IuylfNJTzvv2C/L6vdncMQoFiIvoRNHJXWDb/x0jTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tlk0LILh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tlk0LILh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q14NDu632924;
	Thu, 26 Mar 2026 13:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lTiUuR+K7zie45gtF
	ik5T0EO3v+6hZxFUJ+mJC7sVzA=; b=tlk0LILhgD5Z8/XW3CR7jZJADGnc3LyNR
	pLHvbJDV/3/XpBuD/eDJ/l9/26vLJ0skjCEuMKcD+oq/1QNUnD9bYDdKa5YUAO6F
	+1OyOr7dYKWTguTifRQGXAfDQrt1aQfJCWOjHidipxp5dARwvtt2nmtKKb4y3cMx
	jXmb0dAF9NgOPPrpCvfp3W/xSLbQ9WVHgFl7YqQcObPXLpSvJGwlusTNh3iAqn5l
	Wup+yixyY8geFhnF66ZCG1xPlhIdDWL05olsDtjrugtzzRykqUuAiwGjuKky9SQy
	cs2txF1NbRKC3cI1RRhegP8ZYCEeHr/D0oReollSIPAe2xZHFEykA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumvd6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QAw11q031605;
	Thu, 26 Mar 2026 13:17:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nt36tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QDHPp748562466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 13:17:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 817F420040;
	Thu, 26 Mar 2026 13:17:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CA0220043;
	Thu, 26 Mar 2026 13:17:24 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.23.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 13:17:24 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v5 03/10] KVM: s390: vsie: Fix check for pre-existing shadow mapping
Date: Thu, 26 Mar 2026 14:17:12 +0100
Message-ID: <20260326131719.98229-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326131719.98229-1-imbrenda@linux.ibm.com>
References: <20260326131719.98229-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N_nXmcbcX2KIilpG91GejR176kDBrxHY
X-Proofpoint-ORIG-GUID: N_nXmcbcX2KIilpG91GejR176kDBrxHY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA5MyBTYWx0ZWRfX3i0FJLYh0j4K
 /1q26P0vtMEJ5HJ8WgUMJQgWYU9PUI44LpLfgfSFO3iD8dLuSM/57nQwyB1dh+cmje6iJRtze+X
 wB5b5dFIvoasGvbpAyQEG7Y52cj3bsbqh6roA8vkkOCjCbLn1N4I19wvsj5YMgG098fiK6Xotwx
 /OVmB/EFFKUECZPd8BeFmqXHn5v/qsTLOoDS5ViwPZdPwdC0gl5mttgFVeDdrS0friFFEjHdBxG
 0gXc/bF1HUp/l3wRwWe0OTsB+RYZgyNlmfxbPRZc795T6Hs867ix7RuhSkiKFcVg7wpdgd83XDw
 DTxwT6GLEBxapQrW3khLcgP/vAfoZHWE1eNbWw/XF4h3whQvytwRpiaTiJURT8uH1FyzR38IbKI
 vvb9+pBSkYqm1mmZKp74zTe8zZsop6wY4NHeKc2f/7AtEUUvYtu1iXKhq4J4AlZ/aG7ai3lxDmT
 R3OfyiqA5jpOC5v5liA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c531ea cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=IDpXgTtpuR7I2MJaEF4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260093

When shadowing a nested guest, a check is performed and no shadowing is
attempted if the nested guest is already shadowed.

The existing check was incomplete; fix it by also checking whether the
leaf DAT table entry in the existing shadow gmap has the same protection
as the one specified in the guest DAT entry.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
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

