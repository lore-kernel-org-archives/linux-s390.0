Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20A47ECE2;
	Wed,  6 May 2026 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076731; cv=none; b=uhqFrHuiuvybJAhaaDEQBo8RgF7I0Qh+Dxz+0pxL11MLufWFJPk/dKp1AVrjtOePWoysZz45Tkk+cBZATVL/ijf/KMkbaCu49l4svNZbECjMkOKcV4DGCcXWrfP8BqKD/1JP2iL3nsHup7lpi7aK3RKRKFJblEJHuP1Y/2qmhcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076731; c=relaxed/simple;
	bh=kQ61SAgcpNKVNqQyHejQt/G1nqRZgV8Fz2vwq2rwfAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHCz8zwuvDq1AieTzOyzcbznSFp2S/avaPla7OXzLiZ38RsM5QcfmmqT7C5HM8vB87FP1wMHyVvqVSY99+JTU3J4PMbmJOAWoczyA/jNwDAFV/JUfFF3umiGHMD/xIcha9oZ0NYwtkOAo7hnXjHuIDJI/bm2POAQjJhb40RWLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ffn1GEyn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ffn1GEyn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646703Ej1105811;
	Wed, 6 May 2026 14:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DhfPWcO5EF3y/xxNO
	7K0qO9cxW4EkyZsDNGaVY1+IN4=; b=Ffn1GEynO5JXplSVKLzAL/DdS5Y7vKP6u
	5t8lsz6/Y+p1Zm3dBWVsDxTksCz8yXQmwH5t8ihyPRJBIHSb0QZjDxLDLpqnNUC/
	8R/bF67G2vSTOMyPMMNZEYMbCktFf1CCnMRyWSj6HlXcy7rYT0ejQ6APr2WuX4VG
	6KeBjKnlj9I73bgaOQ/oJoLR0PqTvLXdDSvy9CjUdQWpqlY1HxXi7mdSPXikOcgf
	hPtwj60ddrZdyvZzqWmsePB2wkjx1z33jMXq5BYCqlV0TCM8xXy1DsRTfNeR9KNf
	YvqZzcMqIxxqFSXd24XzYh0Q69c369haoEe4VELWAtv8il0g/swyg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4rdgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:12:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646E9g4i007382;
	Wed, 6 May 2026 14:12:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgec80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:12:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646EC0NS60162496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 14:12:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 720B020065;
	Wed,  6 May 2026 14:12:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 457B620063;
	Wed,  6 May 2026 14:12:00 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 14:12:00 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 1/3] KVM: s390: vsie: Fix memory leak when unshadowing
Date: Wed,  6 May 2026 16:11:57 +0200
Message-ID: <20260506141159.154240-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506141159.154240-1-imbrenda@linux.ibm.com>
References: <20260506141159.154240-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzOSBTYWx0ZWRfXzVe1Qp2mGNRd
 EP7GmOVNUkoN33P361bs4m1yKSG6n2WWhWD8B1oDSmnh5NSpkzw8SVdNoOgonnhE995vmu9EXgc
 A7wsQehoAPq4+N8/Fidcr2SMmgtI2KFDCDjizZcFkZKCIHwaoHcki2hZiBn/eel+GJH3uKE3vnp
 Dmptn9pZqC9wMnDSjuwApVp35+JJugbSNZn8yTx+Axz+7ZqOfWhpYj2ZRiNbo7Drs0Y5G8op+Vx
 O3O+7IaHRDTAIe+NwRe1eyPKpu4VRJOUIzgGt71m8fiy2e9JyA6xzKEMsblEjQtee8V0Or3/wUE
 EEnP1vI9DP/A2JiIS5OxwJazTtAxXhud7DFEdFB9UGqWyQNq347ucCOmmLAlks3QP4k5RkS+hFa
 w3OgNIcOcvIC7VFrJldbn5H+t9Cc+0Iky5C/9jkdu+8ekJ+NV+4LzD7PKDagLdsxy67sPFwpgev
 KArycMLzSra9p2V52Ig==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fb4c36 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=FIwfFwBzLqp-Dx9J93EA:9
X-Proofpoint-GUID: pg7UiIAw5nVFWB4yJmw3TbLFR8OC1mlJ
X-Proofpoint-ORIG-GUID: pg7UiIAw5nVFWB4yJmw3TbLFR8OC1mlJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060139

When performing a partial unshadowing, the rmap was being leaked.

Add the missing kfree().

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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

