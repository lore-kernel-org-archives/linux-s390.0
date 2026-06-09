Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D5F48122A;
	Tue,  9 Jun 2026 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017791; cv=none; b=tL89Nun4X7Ni6ByUFucvlc+XmJlepXuXgVSk9O4xO0HLHyx7Q8upt8cUzeLYleNKL2toaGGimjddJjvY5cotB3TjPlOB28OfV/oSGs59wfYY+8JAYFYf3fa4dRQeTRIKLomDwCHwNRpFfd+c0Q03narl6BN3m+TdtwPEDE7NS9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017791; c=relaxed/simple;
	bh=vcYtDgZTc4vGtlTuaY/ESPp9jBjlWimJGEtLWhsxfsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0Xpmf9qTJnSEgk5kVe9guELSEHSqTWkKFhc6UEgkh2seTOe9vrLLkFMYg44hsYKEPRrbJzwXXRh/P9WiryXuDH+CY6QGHHzj/CIJ1FfKOaxJtQ2a/wzJIPP/ztvAvNx4AbffAWJeon3CnV/SQLcB4R6fVjT6+RRxXB/gPiqETI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Se0o+qaX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Se0o+qaX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659CJuSk2217938;
	Tue, 9 Jun 2026 15:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2lONbZzle9OgFE8l5
	NDLS20Y0bIhuXxJl9SjkVmsMkk=; b=Se0o+qaXOCNFDrhf/zXjusBdtSqu5txex
	C8wu13J7cwVZ2aTlQ6z/aTXUleZoX2jpEBroEhTJN9RhsDMeAHyfZvumg2KFLeaF
	pL9XzAgFU1HDMaONjnhdaW18e8vTfMgkRcKb0kPIN/gXzXQ0s3SjyH5kCiUgk5Ke
	gn0f8LywrfO6UlHXaDBZ+r5TgRPbxxhfy1lwYjhLTMnlRzyf9WXQkIxunRykO1G8
	2N79VhwFhxPtmRuiHN8xJF8gAfFZiZQ9nAvPsKLESsp4JDeWJL0DIz2QjufqCnZL
	pZKiKft2qHGjbwi0PYedaap7nvVSI6MGURphR/IwhVUL32plAALWQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6svgn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 15:09:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659F4at5017673;
	Tue, 9 Jun 2026 15:09:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g2bt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 15:09:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659F9YWZ15532394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 15:09:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14F8A20040;
	Tue,  9 Jun 2026 15:09:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1BD820043;
	Tue,  9 Jun 2026 15:09:32 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.28.58])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 15:09:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 1/4] KVM: s390: Add module parameter to fence 2G hugepages
Date: Tue,  9 Jun 2026 17:09:27 +0200
Message-ID: <20260609150930.665370-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609150930.665370-1-imbrenda@linux.ibm.com>
References: <20260609150930.665370-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eFEROybzjBXP0Gb6_ZePJRHAj7MzfPzg
X-Proofpoint-GUID: eFEROybzjBXP0Gb6_ZePJRHAj7MzfPzg
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a282cb4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=-5nL1enD9Bub2BjMfYYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0NCBTYWx0ZWRfX2omlXGUzxIo6
 GF3XKZs0ULS8V7ry8siWXKLkRpAcq42zI/jqnSGyspdb1PUemDawuvrHyZtUkbw+hPwpZyF7ueZ
 88jArYnicV7q0lZevua7Ms8di3oesARlKoZiVzOeDCokX6nUDq4YQGsCvLLEXwJ2+rWHGOCoc0i
 v+ekejrusZibnOmZnFtcaYeK7A5Ibh68pnJnVW38MbA1td/APhTDWLCzqGeXkgHYJ7JKCQPjmvU
 VoD0fBO/EOB29+o+LcxRa1C0JGK0jd7nMs3Gx8RB9BMyZpxqFP8ZLL3shaMQKK269nhLmCG+83y
 pX53DXu5VogVD906Em+wn0+r1y9pGsmHlSEuMcK4RLxJeCK03iHFsEiBf9Z9m8mRGVn/3+QqqM4
 a6pM78LigX5Yq7wHX3ll4TSSbUxBCu8ADFdthjPd1Sa3k76zU3PoUO6JhvOFy4xFGgjGfmtBF1D
 bk1O7g3o4PMWZKSk/rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090144

Add the hpage_2g module parameter to KVM to allow enabling or disabling
2G hugepages in KVM.

If hpage_2g is enabled but hpage is not enabled, print a message and
disable hpage_2g.

Opportunistically fix the comment for the hpage module parameter.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ffb20a64d328..801a622691b6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -204,11 +204,16 @@ static int nested;
 module_param(nested, int, S_IRUGO);
 MODULE_PARM_DESC(nested, "Nested virtualization support");
 
-/* allow 1m huge page guest backing, if !nested */
+/* allow 1m huge page guest backing */
 static int hpage;
 module_param(hpage, int, 0444);
 MODULE_PARM_DESC(hpage, "1m huge page backing support");
 
+/* allow 2g huge page guest backing */
+static int hpage_2g;
+module_param(hpage_2g, int, 0444);
+MODULE_PARM_DESC(hpage_2g, "2g huge page backing support");
+
 /* maximum percentage of steal time for polling.  >100 is treated like 100 */
 static u8 halt_poll_max_steal = 10;
 module_param(halt_poll_max_steal, byte, 0644);
@@ -5820,6 +5825,11 @@ static int __init kvm_s390_init(void)
 		return -ENODEV;
 	}
 
+	if (hpage_2g && !hpage) {
+		hpage_2g = 0;
+		pr_info("Disabling 2G hugepage support, since 1M hugepage support is not enabled.\n");
+	}
+
 	for (i = 0; i < 16; i++)
 		kvm_s390_fac_base[i] |=
 			stfle_fac_list[i] & nonhyp_mask(i);
-- 
2.54.0

