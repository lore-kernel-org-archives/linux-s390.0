Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5B2989B5;
	Tue, 23 Jun 2026 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228820; cv=none; b=sUBOmLcd7YI8qA7P1UhAxEguVY8oy4FS+PHn/rTAItbKkmsdwLPBAn5Cwwa7vdgh7Obp5T/irHd/vpE00MonZM/Bsm6bnrHFJTUojtmi7Iv3MMHtO7qrl9yUvv+2lI/MkApLh/v14mT+L0R6wdSX6vLBMR1aBfJCnzQMurs4C28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228820; c=relaxed/simple;
	bh=oPjOyf3Hgbx6tuk6sQAUVHzo31rRBbp8eiOdKXU7eDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnHVGddnNrjX65rEO7sLums9ygxU4EFTJ9dau4aiQLi1cDZ9WZ52g/2Oyc0uLzNEuc35yzs+3OBvnlK95LTzQ0KfKl0qSqJrBsfZ86MigsXYNvQVIJWrgNkTuw+BUTtkLJWQHlzG6oqm7DhVVXys5GD1xGJTMFhv7h1Zc0Cgduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sZYqAZk1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sZYqAZk1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBn3in2137009;
	Tue, 23 Jun 2026 15:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eXfq10rdjq2dwJz74
	2ligmWaaqJDzL3+tscnHm/Avgo=; b=sZYqAZk1X7Rj32QyHBlS8wVigw84VRCwL
	yPkowKX6fNN8Yq2Pfhr7pA8/F/f8vpsgTM0rrgOF5DpllqmWnFYZgFVuzQO8qt8g
	qwUhGxR3QghJab0g4OkQK0tEt3uqJgD3XMeJZuXBTV0P2eZfW5Xgt3EWoJD1yHrV
	HqXjYYhx54GVDqL9mPK43AQT/LlNzPiqGz/DbiNea7JAijyc+zBCKAG7VZuQdz43
	4O2hfr6RLryeKS0FPqDd4qGQKHj4rlOaSPKt89nPZjqim3mvSnTsAD8tCO1XCbhE
	E7WCqcauBTyAK5fYEG6fDFUi4fKK4DycYIN0B5XiXixu7gfpOpB0w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqqbrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NFJc4S027624;
	Tue, 23 Jun 2026 15:33:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qc7m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NFXWmp32178434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 15:33:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F54320040;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49F982004E;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v6 04/10] KVM: s390: Fix code typo in gmap_protect_asce_top_level()
Date: Tue, 23 Jun 2026 17:33:25 +0200
Message-ID: <20260623153331.233784-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623153331.233784-1-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3aa751 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=9Lu97PCYw38bWmK0XoMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX7l7TM61owP26
 cZ9uLr21ZL0QWX0EJEek7jd5lGkxQk0fmyjq/fsh9muI7Dp9LCA54dqgid96HHG175uQH8aYzPT
 9tjGXntEAEzTAalwXS9fCgf9wu6kPC2PvHrMaDqZzsWjq7Qmg9mZeL35BWIwJHPX3GX02fucH4v
 LW7DGB3+aqhY+Xcr9XEO9H0c/RuoxZdkYhphzgxeFMTUc8O/Z6NViTYWA8XdONXW9FQfxTFLXUK
 ckEOKkztUZ6nRaF1/L3CSZ1FN5cs+5PZkUSWI4+WQy64T/rMefh2mHd9mJACaWH/MKbLphb5giM
 ms9AN76IIUcPtcL2b81K77bz7qRUJ1D64/AIhEYOYa/gaxIvd99w+awR0mqLlphKwvgbKvJLtPX
 DgIHF1wlez7w0hIg//rCY8rgTBwMGlR6xd55wyzoTjCmm0uJjh5i5bdRx/+blEU4qJn+c0V77T4
 zt56aVY6WxD1tfy+lwA==
X-Proofpoint-GUID: nbE84GzJCfJjwmtwL8E-V8cGcVtV8jv5
X-Proofpoint-ORIG-GUID: nbE84GzJCfJjwmtwL8E-V8cGcVtV8jv5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX+Qg1MSpyrDUn
 JFt964LaqpT7scBU6ve3peFjnvw5UE3F/br6HVMVw+dYAeswz1kZdNLOcaDY0nzOLVrZEzWKmUp
 LBobYs++R1cEXuokVvMEgB/HY6p9HtE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230126

The correct length to pass to kvm_s390_get_guest_pages() is asce.tl + 1,
not asce.dt + 1. It was a typo, which, due to fortuitous circumstances,
did not cause bugs. It should nonetheless be fixed.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e5f98a6899bd ("KVM: s390: Add some helper functions needed for vSIE")
---
 arch/s390/kvm/gmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 3192f610f696..e6e786811db8 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1262,7 +1262,7 @@ static int gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, struct gma
 	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
 	smp_rmb();
 
-	rc = kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.dt + 1, false);
+	rc = kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.tl + 1, false);
 	if (rc > 0)
 		rc = -EFAULT;
 	if (!rc)
-- 
2.54.0

