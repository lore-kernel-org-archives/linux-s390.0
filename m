Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FFB31F984;
	Wed,  3 Jun 2026 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501690; cv=none; b=l7veN5U/Z0Wrau6W0Fs35CyhS/rNAKwNqGzKGhyl/9bAhteNHczGR71ZnChcKeICnlrH0f9O5IGgjRZ+N7x0OefS7tigJjb1rk+U/h9U6Rmi2hMu8TVl2D4L89NIDKVw64UAPLrPWvYTi8K2YwcQyOprovBUv29ydNtLJmi+5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501690; c=relaxed/simple;
	bh=frB+SiLPLC2yAFk9xsb1e2zi0rXUJoOmpVmXtrUYtSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Os612pu2928x8lhfrzbsZ8vqmOhX0hP4n9jg5LoPLAVWHpOjy7218cRdHMxRtbEhyqu6EegNEnJhVM0KsXiLJW+6Swna/YwuOjYQyFCTWlpMAgkClyl/AiYpRyMcFu0d4f+UfvY5zZFzYsOEvKXjTvB+nc5YR5dfQUBv4hEmVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CaxI6Iep; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CaxI6Iep"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653BZXWh1276410;
	Wed, 3 Jun 2026 15:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gHrtBs6vMW/pTCjCj
	WmA20zYNGE81NgoCaBAwMk+9XQ=; b=CaxI6IepwW1nlfh+VJ+gaJskr5hAf5mFZ
	iwKFEj+KzQEGpMVgLOn+dZPiuEJh1rN3cuCjd/JR1xRnQhfsUr+/os3jvCBLgTL7
	ucW/FVcwP+ZeTqmFrC484HPHvZDhdC5oqLLmTrb7pdIwuz5gKxQdL+AhkYvcADv4
	Pgg40C2zxl0PQEpHA4kgviDEK3+iL7odgw0vhMNv6AL0DWxEdI7vdkQUHTV9mP/g
	LT3P2imFq06ChVWXV3wR2y84BX1E9gRoB5mg/UgXtrKBVl6Oh6ZL4cuXk/i7z+Ya
	+C+ExY2JDcGbfBtkgt19Xx8TGJyLPMrZhAsk0W0irv8AYaTQt9fuw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm53qhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 15:48:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653FdORT020826;
	Wed, 3 Jun 2026 15:48:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegrng2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 15:48:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653Flx5H51183904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 15:47:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D8F020043;
	Wed,  3 Jun 2026 15:47:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56CF32004B;
	Wed,  3 Jun 2026 15:47:59 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 15:47:59 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 3/3] KVM: s390: Allow for 2G hugepages
Date: Wed,  3 Jun 2026 17:47:58 +0200
Message-ID: <20260603154758.234768-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603154758.234768-1-imbrenda@linux.ibm.com>
References: <20260603154758.234768-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k_9dtEkIPGUfiEignEMcpIcfk7K3JO9F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE1MSBTYWx0ZWRfXxD9Ta4trSKYf
 NkpuxrV22q/YQLtc69auXJ2QB0Dw9jl9RpG0avutY+0CqX5f2B2zPb8txDoT8sJEYE8bZI5TGcm
 /MENmtish+pi9loyoAxXThn/khtjX7ixt8Ammd5ymgdI+Qe6uwfW4kA6ALnxpukqfXR+tJNYjkq
 KS2o+iZ/xg718ypmai9FbSLw26PNFOvj8CVL5UyGTIZoE6jyQQsFdLk673fSdlOvyQyI/gT+Khp
 t/j1RgDNC1JYXm97ZVohPOlLF0l1xNqXa78PL6pTrM0fNeXLfSKCpfaAcaB5Jg91zTJjEY8sN9x
 4SXsHU6QAE2WWggIOcxOUVf2KzIzT3w1fnShAJclHgbHTE40AYR3bt1N6R3BxdZT9w+TeEMRKwQ
 u8E0RNz+4BezBYfSVPP25+FnjduDf0BxBIhdZGfC5ZtrTnIBmOpJRgLNMqQEo4cjZjVNao+tb3A
 Wo8K8hCqCH2RXX8ttuA==
X-Proofpoint-ORIG-GUID: k_9dtEkIPGUfiEignEMcpIcfk7K3JO9F
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a204cb6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=jBZgYMDF7q3Z6fg6dRgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030151

Change gmap_2g_allowed() to perform the necessary checks to allow for
2G hugepages to be used, instead of returning false. The
GMAP_FLAG_ALLOW_HPAGE_2G gmap flag is now taken into account.

Also add appropriate kerneldoc comments.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index c9e348149ba1..c5a8132eaa22 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -635,10 +635,27 @@ int gmap_try_fixup_minor(struct gmap *gmap, struct guest_fault *fault)
 	return rc;
 }
 
+/**
+ * gmap_2g_allowed() - Check whether a 2G hugepage is allowed.
+ * @gmap: The gmap of the guest.
+ * @f: Describes the fault that is being resolved.
+ * @slot: The memslot the faulting address belongs to.
+ *
+ * The function checks whether the GMAP_FLAG_ALLOW_HPAGE_2G flag is set for
+ * @gmap, whether the offset of the address in the 2G virtual frame is the
+ * same as the offset in the physical 2G frame, and finally whether the whole
+ * 2G page would fit in the given memslot.
+ *
+ * Return: true if a 2G hugepage is allowed to back the faulting address, false
+ *         otherwise.
+ */
 static inline bool gmap_2g_allowed(struct gmap *gmap, struct guest_fault *f,
 				   struct kvm_memory_slot *slot)
 {
-	return false;
+	return test_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &gmap->flags) &&
+	       !((f->gfn ^ f->pfn) & ~_REGION3_FR_MASK) &&
+	       slot->base_gfn <= ALIGN_DOWN(f->gfn, _PAGES_PER_REGION3) &&
+	       slot->base_gfn + slot->npages >= ALIGN(f->gfn + 1, _PAGES_PER_REGION3);
 }
 
 /**
-- 
2.54.0

