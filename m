Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D437A850;
	Thu,  2 Jul 2026 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005866; cv=none; b=qr1vQeYKxFqAyslqo8X/n6XqtQhaGF3dAbve8x+v2wm+VsA4yhHTfxrQ5nk5hmEGjpk2LohXXm+nJ2FJSVxZZH4cijm6sIju6cUmrjtWVj/PJIHjihb0dilpqZYZTpI4tbhDy71kn72ZoPCRiQeu/VJ42i9lvD9vEWaYcSC/o+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005866; c=relaxed/simple;
	bh=zpAGeMVIRdUYyEoqERKacBwmcCkUoSv/iuNgnLeGQeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1MHZ2qskxOHuYezRQhizypmeB94SCyYTEUFje+cdZ8qgcMQEiD8rcYNaqiShdIXmklijpJCibc1T16FxMB5xDFoPyHbCZUFPvqfotVuhR2RHdpmz6LHiztNqtoFPMlobQQWI4+zslapoEqFavFkIuR55WphgtP6PjIMnlrQzYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dPAymGj8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dPAymGj8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662EIGTn4074329;
	Thu, 2 Jul 2026 15:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CoaUq/2Ip/QoEp7+U
	kUg/LdM6diRQm5S4TTNQeDQm/M=; b=dPAymGj8ZjaobahMBYyjdUVohMgPKJjD0
	UR+nUKGSV+8/vuIxW/hv+heSuUhn5vwtXSdHq15Zi6jKKv4+jOYlDzZDHJY2JAdj
	1D8bsiR73AJiHBhnlx0jv6v6cyagneHKMLIDW9YVo4JBegjVTd2fESKpCjo7Edlv
	Qi5QoJJiBknsa92Ojjj0Aa5ABgEYEApOieFxZMzX7MJdMRJcE5wkk/UV62oJPOGf
	hF8ek7N3hk/nVyByHNyrc51rvSlyCKPH9mDtMBNQB2OUoUFLdANiomnm9ACXucNV
	m8Aomjkoft3rt+fxRG40jEVuF9JQoEhZbK2oWV+QKHV1Etu59O3lQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n62pqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662FJjcr004295;
	Thu, 2 Jul 2026 15:24:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukcjtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662FOFNk46006782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 15:24:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92EA820043;
	Thu,  2 Jul 2026 15:24:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9811220040;
	Thu,  2 Jul 2026 15:24:14 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.87.55])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 15:24:14 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 7/8] KVM: s390: Fix dat_crste_walk_range() early return
Date: Thu,  2 Jul 2026 17:24:05 +0200
Message-ID: <20260702152406.204782-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702152406.204782-1-imbrenda@linux.ibm.com>
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX7mbg925+vP8R
 d1CKzazDGujGx6H0FuxsWAuODcXQz2o0V4UTBAnnhyvDAruOU6LL1Vx2JGtqMOH8AHlrOWuBUJD
 bHsj98DTms3SM7pH+DSCtpjmQ/2nHgVOC+UMQCow2o1AVquzoc3RjlR0UX0UHWzhusqJF9KIO/6
 OBox3fnErHoLOz4kti+W7xeGlTlh0sQj9qSovPHkYjaauwhiMNGhUw6B6HQriCUCi/bwLbFFMbL
 dGSM3r3voA8b82NZSRWT5N2pCeP+G9mjZaAw+ZWU3rjgWWzvXqD5OI2kIWDGsRKILj7l4mxP1Oq
 396uo3XUzJfTxuiZaFeSNV9AT1Ipnx7adbVu90n2LY4o/YpjnOldWIeDIeIu4YOmql5BVIR67BG
 HxL4cfrB+/MWPACi5Lbi20JbAAnrLLFjXlr4KPE8Wo2LbQ8Ur/QB4vRHNBnQAVQk/iyd9vxWzes
 grHFXIIVpTUqVFUgUgA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a4682a6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=rMBDsGxj1jqsR9YKdtkA:9
X-Proofpoint-ORIG-GUID: -ExmyckZlvYFDak7_HNlaY6HM2JI4lmH
X-Proofpoint-GUID: -ExmyckZlvYFDak7_HNlaY6HM2JI4lmH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX8Ndjve+kxjJl
 innkBQFAO9s8CXi8n8yAR0Hp0gia6MIiv0NW1nMWW+8Yqe0z737H1LPKPLV+LczNeD4X3Gi65vy
 lT4wFk2sy6tzUQzQ8VfsSja21sTksXw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020160

If a walk entry handler for a lower level returns a value,
dat_crste_walk_range() will not return immediately, but instead loop
again and move to the next entry.

This means that some entries are potentially skipped, and early return
is ignored. Skipped entries might lead to all kinds of issues, given
that the caller expects them to not be skipped. Early return is often
used to interrupt a walk when a rescheduling is needed; if it is
ignored it can lead to stalls.

Fix by breaking from the loop immediately if the walk to a lower level
returned non-zero.

Fixes: 2db149a0a6c5 ("KVM: s390: KVM page table management functions: walks")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 5f1960ec982d..ed4259d17629 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -570,6 +570,8 @@ static long dat_crste_walk_range(gfn_t start, gfn_t end, struct crst_table *tabl
 			else if (walk->ops->pte_entry)
 				rc = dat_pte_walk_range(max(start, cur), min(end, next),
 							dereference_pmd(crste.pmd), walk);
+			if (rc)
+				break;
 		}
 	}
 	return rc;
-- 
2.55.0

