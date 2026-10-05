Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2174147F3B5;
	Mon,  5 Oct 2026 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201813; cv=none; b=u67+GKAlh5FzjneQeCXOokQKggMm15uYtUMeEVi/n6nv4ODx7i7DcIycZZdpREwLiEhWYWDA0C2Q7pC/jNRBc5U4DMjeycB5gDO1nLRzrdA03aUK6Faa4ZnVchSKsxN6BkxhfffHzOz/Gn08bQ2Bf7VIEvpyhzpq9D+RqrqEoYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201813; c=relaxed/simple;
	bh=lPn6ULnJLRoJIRUhsZtPmVv0I8gq7PnQ7PYf/u3j7lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qImNTjI1jj546q3nax0o1+FuWqPBwClD5HSzEF4l4MxZiuLqy4FZbAf08ZfzZ5h3dqWdYFpf1aeekF7I78yznsQmip5wfy8tlgmQw3b0FQtOrR9Z7GSuLrHDwIbUpEoWnMRNOYjouwKu6HnuW303gbuJN7r1Sn3CztbuvKHDyCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D4zeH0ES; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D4zeH0ES"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695BZScU508855;
	Mon, 5 Oct 2026 12:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GnqKL5
	N1BJJGlOO3YGidxoapT5AxD8bMgBlh/s88Shg=; b=D4zeH0ESV50vtQwgDvDOIu
	vNZuQYQ3wUzxUDDBDvm7JNJ7proWpjuw0ob/uZVlm4WouqFG9Y0xIg5cqCVmUtcq
	7AL7gRa1ROzrjEEQy7V3x2TeE7dmuh7pGoAzcJn0rP6Dp8YO6McNGBMb15NU3DQG
	6O607O08FKMDkclm8VjIO/xWE33CTGceInUsnXiF/AzR7quZALNxYK4jRB+Y/d+o
	8gaZpiq6eboJwpaBKP6tLE4WslijU+CtqmJFRbILJ2mgkXelp0Mxl0VxJzEqT18W
	dWPkerlbL0Ru95sYc8GizoCeM5Gji/uz+auZbirLPhLip+xXZquS6Nvojgdr1HTw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5a15c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695BWUAd2850548;
	Mon, 5 Oct 2026 12:03:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pngf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695C3QKV51904914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 12:03:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12F8A2005A;
	Mon,  5 Oct 2026 12:03:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D796B2004B;
	Mon,  5 Oct 2026 12:03:25 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 12:03:25 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Mon, 05 Oct 2026 14:03:22 +0200
Subject: [PATCH v2 7/7] s390/pci: Drop the unused index argument of
 zpci_msi_clear_airq()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-s390_irq_domain_fixes-v2-7-d45b824874c0@linux.ibm.com>
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
In-Reply-To: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tobias Schumacher <ts@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX6ApIvKAfA0tJ
 kLaBvuH1s1xH5RGlhCJFr4cn8pqVQd1JHU/bdPg0CSjWQOfB1bzI9Tz7BoTo4+/ID4nTf2kMPcg
 hFQSsK5nuA7wluSnQbtvDGnXn9iS13o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX4olS+LFNeIPi
 oNelbKNuBoSCtpp61lHCaIdfZyuFSM/M+Y/p/u/fvSCb8IHeCQnrdBIVxLykRJTiB/Gdm2ExzmS
 66OjoC5u8uBBfycLXVlKjoMEuU/LvxtgO9hK9yF0nm6u7sjUQellxhF1rY99F0zppHt0vIMP8mG
 QxUHphLNtmph9t3HkZBgn7R9v7Qm5mVw5CUNygX4uFvrmGgHi8nfDAEiEpPwymj0p/EscHbLPj0
 Ax86errRFErBrzFptH1pfArkTRU65Kd5FwvAbsk7MIoi/NYk6RIuIHTqXWlGYNFCmR2JHaGbajp
 C+3llVCKzrUnGAVNkzLcqFZyX9G/dBebRnoAZmccEo+hTUMABTpMBlt8p/NhiLiIjNDi5BPHr1Z
 2kqjyocv5p4Wj5yZFvyXejBDfWrN3kNxYOfboFVZuRZfUCHTVNVlZUeogBIvzx4Ah8VLB/eEv+q
 Y80Pv0wtwepUHGXJZ9w==
X-Proofpoint-GUID: JM4Hl_ZwV8rKqQFav73sReUXtCJDwBgG
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac39213 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=suPEyLX7Zp9e240Fq7UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JM4Hl_ZwV8rKqQFav73sReUXtCJDwBgG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050045

zpci_msi_domain_free() passes its loop index to zpci_msi_clear_airq(),
which adds it to an offset that already accounts for it.
zpci_msi_domain_alloc() stores hwirq + i for each vector, so
zpci_decode_hwirq_msi_index() hands back msi_index + i and bit is
already zdev->msi_first_bit + msi_index + i.

The doubled index never selected a wrong entry. An irq domain's free()
callback is only ever invoked from irq_domain_free_irqs_hierarchy(),
which walks the range itself and passes a count of one. So, the loop in
zpci_msi_domain_free() runs once with an index of zero.

Drop the parameter and the addition.

No functional change.

Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 661867a1ffad..984bf9c96768 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -446,7 +446,7 @@ static int zpci_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	return 0;
 }
 
-static void zpci_msi_clear_airq(struct irq_data *d, int i)
+static void zpci_msi_clear_airq(struct irq_data *d)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(d);
 	struct zpci_dev *zdev = to_zpci_dev(desc->dev);
@@ -459,12 +459,12 @@ static void zpci_msi_clear_airq(struct irq_data *d, int i)
 
 	if (irq_delivery == DIRECTED) {
 		for_each_possible_cpu(cpu) {
-			airq_iv_set_ptr(zpci_dibv[cpu], bit + i, 0);
-			airq_iv_set_data(zpci_dibv[cpu], bit + i, 0);
+			airq_iv_set_ptr(zpci_dibv[cpu], bit, 0);
+			airq_iv_set_data(zpci_dibv[cpu], bit, 0);
 		}
 	} else {
-		airq_iv_set_ptr(zdev->aibv, bit + i, 0);
-		airq_iv_set_data(zdev->aibv, bit + i, 0);
+		airq_iv_set_ptr(zdev->aibv, bit, 0);
+		airq_iv_set_data(zdev->aibv, bit, 0);
 	}
 }
 
@@ -476,7 +476,7 @@ static void zpci_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 
 	for (i = 0; i < nr_irqs; i++) {
 		d = irq_domain_get_irq_data(domain, virq + i);
-		zpci_msi_clear_airq(d, i);
+		zpci_msi_clear_airq(d);
 		irq_domain_reset_irq_data(d);
 	}
 }

-- 
2.53.0

