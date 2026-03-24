Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1B040757D;
	Tue, 24 Mar 2026 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374193; cv=none; b=kCKMBb2xjpL2fNOgv3ZSS8bXrzNribRECuOjnr9JmME60gyyrTCK9s1ZuH0rpsh57F4OmoN3mBZPDaPPeXLnEIxBjB/ytwOWk+bwqa6l1LgPvd8YpiReI/7JOH6i2xAY7qEi4GoEZ8SgRe75PD0r6EmKU/e9SQK41w714qsp0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374193; c=relaxed/simple;
	bh=OJ0YppEpXxWljpnDo2C4R25lit9Ina1zpzH2IgqgCAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cghi4PqdiIuQRy9gt3DyO1EV2wuY8pTSo0C8ptad/eVHej+Pq9L0XJ/9wk1cbV+I4BdALBOqZ2JXpBonGUbRmwRGKx3j/Rdh2Y15mO89FTTGg0SE9NhK/XFKyY/POMV8CKV72IJ+vEkrXXwrB2hUU1TAYmGKG8e2BpG56iM5tdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BnTh1ujn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BnTh1ujn"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O69eRr018998;
	Tue, 24 Mar 2026 17:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oDSu/bQDxMYWLBwio
	nStkeQoi6NLCfGdNBrHSiGUtoI=; b=BnTh1ujnDHuc5HiFug11tMO7Cb8JFBbzk
	K89I23eamCDJ6hEe0Iny4ime0NsXiw6lAx4u2krsSACZWQ8mfu2jieE9sWEIteGn
	54S0s7ALVHA2C7CI7c3Crh3/VOAgEg6+X0778UGBGYZ4v6lFLEm1vOhQtjENXdMs
	RP8ahhyzaHHGkSWbiRwU7CyvuTM6/Rv7NRj9K4B6BtaYkfoOQeENSGbGP3sZm0DF
	3F2P0+g8y14TbhvXResyZn/S6bXAhboC4H7oW/G/xnsflltMVGebvJekKReS00az
	UTzNgxcLqzRhHqQC14+j9FEYKyX7xwAZ2MDYc1Dm4jMsl7VrGuzKg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxvwcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OGPlvR026698;
	Tue, 24 Mar 2026 17:43:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275ku11c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OHh4gn47251880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:43:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 728C320040;
	Tue, 24 Mar 2026 17:43:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CFF72004B;
	Tue, 24 Mar 2026 17:43:03 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.26.26])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 17:43:03 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 1/9] KVM: s390: vsie: Fix dat_split_ste()
Date: Tue, 24 Mar 2026 18:42:53 +0100
Message-ID: <20260324174301.232921-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324174301.232921-1-imbrenda@linux.ibm.com>
References: <20260324174301.232921-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c2cd2d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=LsQdvuOhCgcXfIND9tsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzNCBTYWx0ZWRfX0rLEKvHtKFrS
 GMuhW8WLhSo+uZtLw9TMMgkvBXtlK4Z4Ad9YijoR8fnHTsX9+N1F8H3UgZZVqh0hs2Kk72/qdGg
 Fr4UGR1VM37dEnPVwxD2H8HphbhsF4QC+kvpRrzGG/9Jhd2tVIl5hjBrsbCZ3qFiMrnhi8q8IHu
 mT6VXVkqMByKlxBBvdSqBDPHSmnvPJ+5+N0fy6QpM6ZIPfXNxNpfT6ku5mTejwedBhsSWkTNc2Q
 5K2aTod/fvSo+nS0uX3LRQ3Ejh4ZgrmeILY/RDTqPKmrJi7MU9o/5+KLGBUoHKmPjWBuHtZD1h1
 qlZgM2EJ/JV9fU08Ynugf5xUsK8YJgPpqRO260qbwLJH9ZTAyKwDnG9y5iEMJzFj5dpcKUPYQrx
 EWWIaFqU2Y91Cez0G7jsTdCgs9zP9cw4fqXVaxJc2BjyShZlKeJhO6b5TYFFVRcTHGR5Ip3Htd2
 uvDjFfxQh7Nk/lZW5AA==
X-Proofpoint-GUID: jLXuIi1cypaD4PU5w38QWKOU-gQVcrmK
X-Proofpoint-ORIG-GUID: jLXuIi1cypaD4PU5w38QWKOU-gQVcrmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240134

If the guest misbehaves and puts the page tables for its nested guest
inside the memory of the nested guest itself, and the guest and nested
guest are being mapped with large pages, the shadow mapping will
lose synchronization with the actual mapping, since this will cause the
large page with the vsie notification bit to be split, but the
vsie notification bit will not be propagated to the resulting small
pages.

Fix this by propagating the vsie_notif bit from large pages to normal
pages when splitting a large page.

Fixes: 2db149a0a6c5 ("KVM: s390: KVM page table management functions: walks")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 670404d4fa44..48b5f2bcf172 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -292,6 +292,7 @@ static int dat_split_ste(struct kvm_s390_mmu_cache *mc, union pmd *pmdp, gfn_t g
 				pt->ptes[i].val = init.val | i * PAGE_SIZE;
 			/* No need to take locks as the page table is not installed yet. */
 			pgste_init.prefix_notif = old.s.fc1.prefix_notif;
+			pgste_init.vsie_notif = old.s.fc1.vsie_notif;
 			pgste_init.pcl = uses_skeys && init.h.i;
 			dat_init_pgstes(pt, pgste_init.val);
 		} else {
-- 
2.53.0

