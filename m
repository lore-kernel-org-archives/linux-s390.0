Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC783EDE70;
	Tue, 12 May 2026 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608384; cv=none; b=ORTHT42edD3ZfHqASQfyUGqIo1TChsr3AopOVaAOxyzZTvfkGEA81zq3U2fUm0h/99Il2DtD0WUlBEZodVR6Nyy+As3F7Uk8EQR5WDokPY9TTjeqfl603aZRCd8U+s7YM97Tku5dybOcoCIQ2/25eNFKBrC+QwLfB0/0/02ZjF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608384; c=relaxed/simple;
	bh=6GV5Vvv1QtySVNas7FsOsLR4Qvug2IpjEXbXmzFwcKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=po9caR1rCjX26jIp1W97TZhTVrenjkCpmG+EOdR+bEWV/Kmzc8pfazsD3CbQe8XKwgbRaD/GGrThAqx1skGeeeEBW5KdOKbOsa7mv3ozME+aZlJysmCLYDzmflvoLRvKumKJv7C59r2W1zdkseOHwcjdLJBrYhhXRABy7HMJk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rvV/1db4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rvV/1db4"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCegsT2760071;
	Tue, 12 May 2026 17:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aq9FpqHF5AwyvCGwu
	NCgltPX+uPxkNey9LSf6Xgt4o4=; b=rvV/1db4bm/nBMhTI0v7dTZ/g34GsmqPA
	5gtNlc4qi/Rre8TI5CjR3vejO2SMO4+pJjJdTKDYXCTjOHinJtDHv2k2RBVivHJZ
	MRnehcXzgB9Y6b3/tP+2w5Xkg4rELK0YaXbVIvLMJs0ye59lgbx1hZujid55fIkk
	jCb4SMDS9vEwINjoSaQ4aFxW1BkAb96Klap5kl4hrWdlpkZCXKtNkpLhXYOy8bki
	zHafgsiW3X0TFAkIXH3TR8ipyBwkpp6Hp+Bi7PYMj5y6bkLkP7Oa6W3RcM8DD1qR
	8PMbzhXLYj7zxAbkjEvHO8XNstrbuRvV64qz6Vm6Ontce3/DYWlnA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6m5dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:52:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CHdQcX029757;
	Tue, 12 May 2026 17:52:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgc8pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:52:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CHqqGL28836322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 17:52:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6958720040;
	Tue, 12 May 2026 17:52:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 346BE2004B;
	Tue, 12 May 2026 17:52:52 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 17:52:52 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 1/5] KVM: s390: vsie: Fix memory leak when unshadowing
Date: Tue, 12 May 2026 19:52:47 +0200
Message-ID: <20260512175251.300882-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512175251.300882-1-imbrenda@linux.ibm.com>
References: <20260512175251.300882-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oqUvaPZFQPlIbYS8LYtWGt46NiVicsSo
X-Proofpoint-GUID: oqUvaPZFQPlIbYS8LYtWGt46NiVicsSo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4MyBTYWx0ZWRfX4SkiTKJ94FZD
 kU7cSr9zycdz//G0gj/1ifX998BZBRGniXPWGI8IWdeQ17FID4oPaQT0GPOBtKUV1dQSXRB2fQ9
 5SAghR6ovXFYLB+VQevJYfZQeJ8NP+Id/sxBG51TEwpDU4W4mctGmg8GZ3dxrdwyGxFyiKtEhcg
 3j5NhLK/+n6IunyoKlCFCzhnqEuZG/NgxLxm3MYrKLbtQGwqHBgn82AAeggib1s9JSggupJXDto
 fYaFHrkxaU56wZ3owoIZZasAtwDYyGdBQOk5ICWD43YRmeK4j0yzCC76S6EO5fqBrZ3Hr40jnoB
 Q79bZ7gpEfGIMH3WMsP2gNIO/GJbqpJ9HRZHu5ABStoRjgH+gDHd7X5kNaHksVcUuTJ4/lFnJya
 shFr+lYoR3lx0G8kO4YuEI5i6I81pqDvxxy9xSiA6vwhtrgB46m775MP/lGSx4tM0TlWYxBvlAC
 3dl1gD6IWumLc0aePcw==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a0368fa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=HcuRRwaqOfwKfrSmNnAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120183

When performing a partial unshadowing, the rmap was being leaked.

Add the missing kfree().

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 3c26e35af0ef..fd1927761980 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1143,8 +1143,10 @@ void _gmap_handle_vsie_unshadow_event(struct gmap *parent, gfn_t gfn)
 		}
 		scoped_guard(spinlock, &sg->host_to_rmap_lock)
 			head = radix_tree_delete(&sg->host_to_rmap, gfn);
-		gmap_for_each_rmap_safe(rmap, rnext, head)
+		gmap_for_each_rmap_safe(rmap, rnext, head) {
 			gmap_unshadow_level(sg, rmap->r_gfn, rmap->level);
+			kfree(rmap);
+		}
 	}
 }
 
-- 
2.54.0

