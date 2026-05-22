Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48A338237D;
	Fri, 22 May 2026 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453002; cv=none; b=uwngn1Hbv5fMtU1U8iEsENiOIXIPnVzu+s6w6brMJq9+lwaz0+1Wklwz52jr88Oq5XsxqYuFcjOxBws777s51/k0ieM9/8kzjts11eeR//3PSD/YrWeAXhxpnFpyOj+El6d7RWXbXsvWOjBeNo/fbhX9hZf5P30OTdqvf1ZsUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453002; c=relaxed/simple;
	bh=qSHmElUD4hiaqyVjP00OnsdaSR/W0vfbTPjetyIDxxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BF2Yr7p5WdNJuCOSN7JPcdPFf3mWMl8YbFYi30dECiLviSnYdL9M9KMeyr4RxB3rOEC+GHwG5XrJu/blsE0zUXKquNmxUSxx78vCrSjm2hKS9rfwdOj3rIxYaQ7EYQWuhKpYp9RLmZ6obJXkCaROhFvZTZz6WkfTKv85Zi1wxDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FCgQTA3A; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FCgQTA3A"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M5vxsQ3991718;
	Fri, 22 May 2026 12:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3mscKG4sXxTfYaVBQ
	LmRHrsIdnluuVFiYNY4H2vDpc4=; b=FCgQTA3ADH6E7bmI3XQIxtBYckG9GpDFC
	EhXUWEV1kKiW2EIWuD0x1OS7F6ft2DRodP8ARK+W/RIxhuUeea3EWsvjOE8uLCJm
	IBzptzzZM7UpkdsUveROs1SBYjKxhKeFAqg7ldwLMLXmvZTaI/AmqhdERwdq3oMp
	4of1Ae9dcX4HfbBeQ/QlxV80c6S/UiUbPvN0y5VlNgBvSx44rinvaVzXihsz5jpe
	XEVbHiWJPRdSmzYWfHj+QeyuHYHfHzNKnqcr59uBiVu/yAQUDNIkdYerMMbOD8AC
	uzFYRVaLo8gcJamarU0JyKz44+xFMJCX2DWWqYmqsmiONH+j+Hjcg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8tcg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 12:29:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MCO7ZU001468;
	Fri, 22 May 2026 12:29:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkgtxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 12:29:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MCTqoi51315164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 12:29:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 054C620043;
	Fri, 22 May 2026 12:29:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCBDD20040;
	Fri, 22 May 2026 12:29:51 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 12:29:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 1/5] KVM: s390: vsie: Fix memory leak when unshadowing
Date: Fri, 22 May 2026 14:29:47 +0200
Message-ID: <20260522122951.117120-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522122951.117120-1-imbrenda@linux.ibm.com>
References: <20260522122951.117120-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEyMSBTYWx0ZWRfX01IC8/Lc/Vhj
 QG1bLYE+TlwxSm0+b7qx0YU18l432uNVLYRtdbTBAfSfSCkFt/w+yXYz4sLgh0V1cm45iKThji0
 EDbi70CQgl2CIzI3ZXP7rb8yZob0rLuMDqPueP0Rvc0ubk2fCr/dWWdgXa9z9IFzdIWnHQGdmOH
 ILbG2REAwRVINSima2Lo8IoobhHRPygITDD61g+X6jtz9No4Ea4U0evEeyrOsDCSs3RReTbcrag
 OlyC2hUoZmZAFHq1wiuWF7XizzwyNHkU3BSVW3HwjQu9iB8ZUWSFV9RVmiwmjtkBZ8HGxKYGk9X
 KSUi5mApGD1hD1clyVJTm7qan6yRUw5H+f25GqQPGImg2JGVGz6ijEAcwAioLgAv59dygrbyqC7
 6kJ5VtxbZExgpQfweJlEAPJAey0IVUA4IPR0aTJ6eUzXCzW8V11A1vKG6faTqar/es+c2WXGhKf
 Dcgx86hxc7mgz1s6obA==
X-Proofpoint-GUID: fcIzHsJm8rUFfraV5XMXBYr1npvhkVAo
X-Proofpoint-ORIG-GUID: fcIzHsJm8rUFfraV5XMXBYr1npvhkVAo
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a104c46 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Kg7RmGtffD6RKXAweUcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220121

When performing a partial unshadowing, the rmap was being leaked.

Add the missing kfree().

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
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

