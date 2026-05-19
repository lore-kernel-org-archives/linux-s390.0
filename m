Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B6F3546F9;
	Tue, 19 May 2026 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202895; cv=none; b=iTwN8cyMjnXE6CZ9muL1xcrXcDR991LIIyj0PBE0BPFQzORsWq7ULE2ZtikIQHFuD/QZHBR1Ojic2p1UZdm9BXIFwv2Hk+WY6HedvDRxxf1UORLsp61dvN0qN7HTy2FEcPUs3GFf65u0Ge5mWeOTObKWNZk8BqxyTOblSJjfYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202895; c=relaxed/simple;
	bh=+sR34h7HYnVze/f/v4I8YfkkiyD86XlTb14J6467WY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHKgvwx2M9fpJYEm9i4oa7gnjMtj4CkJEiC4Ez7u8xud3JDucUQrse/4ZdW09yMYWK6LYpavfd2DfpsVgI4i9du/giliT2hkzbhksYSYNHurkSscE7fPS5VOMrTO3mAGBJKZ6PagZ1dU0OjR//CKDRzb+ExujVD7jmRXCj+MbLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KvCBljdJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KvCBljdJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J909J2165941;
	Tue, 19 May 2026 15:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TkcqHmyJMQP7K4bGj
	qb58wezYz9n4whuTuRbJcewiHc=; b=KvCBljdJebW+mrDzcrTrtjulXRAtsFwgs
	GyaIRzC+mpneW5D7lRneOPTJMraWxYp+lo5OHqFN6esOfpN0L1Wo+FCveGz+7Prr
	xwjebULhkFlOi4hp9EX17+/rq4QMfgSdlyZHLVQn7GDnOGdTf5FBrBjnEoXwlYEo
	t5+JtVuMAx/M9gz1WxQmgjXwwHBfpwND5wwbGfLALsoOOAjPOPzJTUIC6RG0WkHw
	e3ua6RA3g+Myy35oHar+yrHXrBVLbgZkQSurKJzYR4IDHDFtRgpDPxgy6CoveN6n
	hPRDBys7TyN0c2V3URSusxJeeeQNsSqdQrpQqODTTaD1/b/iYFlNg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88cw3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:01:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JEs7A5018026;
	Tue, 19 May 2026 15:01:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhk3b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:01:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JF1JCI36897190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 15:01:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA6122004E;
	Tue, 19 May 2026 15:01:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFA5C2004B;
	Tue, 19 May 2026 15:01:18 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 15:01:18 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 4/5] KVM: s390: vsie: Fix redundant rmap entries
Date: Tue, 19 May 2026 17:01:13 +0200
Message-ID: <20260519150114.264309-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519150114.264309-1-imbrenda@linux.ibm.com>
References: <20260519150114.264309-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zib5GkZ0d55qdV6sVNIRij0eIbhRFos3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0NSBTYWx0ZWRfX4ZiFxDoO/WUE
 wlYn5MWDQVbMQ00YwJnflxBi63YWAU4gAoOWvjUdshAOTF0clfQJQbPxw3MES8YLt8c+iYcB2K3
 ekifmxK7DIItUU9FjbNfvJJJ3pB4w7hWRIR6FonY9wEfInYRyQ7mt/lGN/g0fQRIwCstrL29bNK
 JBS5Xw7HkRTstZoCq95Z8SqkqsKHRQMw15pzig/7YP7dwA0Hsygtn4f3MaeMXYkCcD8sIg5PO3N
 j72j1+6FnaU9/e9WQPZc53Wb6FYiHHRe6GGKpb7Sf4i/x/1tx4w44n+eVh5xUL+iIk25UNbk9O+
 rq6DSKcni8qk1X7RTHPCh3uZZ2Jyn9zHKpm6EXQZaz44ty4ac8EP3Qk4so+kmmi5nO9MMS9Kbr2
 1hB1nof+rW4rADOO2mbsjxW+xW/oeg==
X-Proofpoint-GUID: Zib5GkZ0d55qdV6sVNIRij0eIbhRFos3
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0c7b46 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=7eV5o87doowNvqF6OWkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605130000 definitions=main-2605190145

The address passed to the gmap rmap was not being masked. As a
consequence several different (but functionally equivalent) rmap
entries were being created for each shadowed table.

Fix this by properly masking the address depending on the table level.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 8cff0cf5ce24..957126ab991c 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1025,6 +1025,7 @@ int gmap_insert_rmap(struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn, int level)
 int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn,
 		      kvm_pfn_t pfn, int level, bool wr)
 {
+	unsigned long bitmask;
 	union crste *crstep;
 	union pgste pgste;
 	union pte *ptep;
@@ -1041,8 +1042,9 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gf
 	if (rc)
 		return rc;
 	if (level <= TABLE_TYPE_REGION1) {
+		bitmask = -1UL << (8 + 11 * level);
 		scoped_guard(spinlock, &sg->host_to_rmap_lock)
-			rc = gmap_insert_rmap(sg, p_gfn, r_gfn, level);
+			rc = gmap_insert_rmap(sg, p_gfn, r_gfn & bitmask, level);
 	}
 	if (rc)
 		return rc;
-- 
2.54.0

