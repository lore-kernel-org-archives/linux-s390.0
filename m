Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97EA3033D6;
	Mon, 27 Jul 2026 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146065; cv=none; b=FrYeRB8vjfr394hjvZFmrsynG3O4Hjt/JLZOBmNGsI3D+O39d/T72nCEhDduFDeqDZAJ9/A38b5KndVL6TSwUu8z4NIYDnnPEve5mU6XYzoN6qnPqVdgls8Bgx4GCm8lk6ZWlX+6VHB5zwnA0HntaBR4Y3WGkJ2OH50mc8q3Fok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146065; c=relaxed/simple;
	bh=8NRqUBqlwi38q4sGKQS40yiYdwUccU125s1nzL1FBlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CF6zIImxxNGoNOL3ldg8KflcLlXrcvqKMMFT1OAel+OzyQYdE2/eG9xTCkRUQTLE71qdGANuDIbfDOPKQkaAnpOPZrSMXK2Jezw8CKdswV46mObjd11u4fuGWZfxmUuFhO4cnzjy5NiA1o6ezRXLSxwkRrc0ac150RvKZ770hWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cCUg0WWq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cCUg0WWq"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9Uxn41743349;
	Mon, 27 Jul 2026 09:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=40ev2TFx5NMfd9QUL
	2Ykf21oZa0xKJK+TE7Dd+42cVs=; b=cCUg0WWqjaGLSERBOw1Zf/ZFSrPfe3ORf
	pk5mei3YPaPiWvZuKm9qcaAqNDNoIaX6lV4z/Df+XF1CT5BiC1E1cgfgWYPgZ7sq
	BkI2XT1Z3IMd4j9QbNSK1oYd2+0Mbc5cMsys19IsNlxzmqzzSHf/5LGg+W/ZiW/q
	DeDMJ0WFnftkjOaW/+e5DzNuKKrochvjcka9fBwLZnWPy5sgCnHc43nJCnjymoF1
	AGHYD0MmxAs3zqer8Zq1KdVc19JbpsvnH+z6l6BsT6mcarHxkmYMM0/25W8j/+k+
	xVwyBsQ203/fB88QWpv0SJUBiCVpyFke2f5cQIv0W8JE0nAnyOI1w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhxy48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:54:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R9s6W0008498;
	Mon, 27 Jul 2026 09:54:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh4s49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:54:08 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R9s62019006192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:54:07 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C19EB58051;
	Mon, 27 Jul 2026 09:54:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A68325805F;
	Mon, 27 Jul 2026 09:54:03 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ehn-de.ibm.com (unknown [9.224.77.173])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:54:03 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jaehoon Kim <jhkim@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [GIT PULL 1/5] KVM: s390: pci: Fix GISC refcount leak on AIF enable failure
Date: Mon, 27 Jul 2026 11:53:55 +0200
Message-ID: <20260727095359.107671-2-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727095359.107671-1-borntraeger@de.ibm.com>
References: <20260727095359.107671-1-borntraeger@de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfXxwK3F6kyTW98
 QLdlS6aHn5+n/V1X095G0PtvhLJG/ePmr2IYv9Jek7JoQ1vDqYAGXRoB9jX2CnLX3xat+8T5gVi
 xQgUaXbnZ/TSla3I+3pP8IvSVCoKgJM=
X-Proofpoint-GUID: tCtMy4AZq32RUJeuWPetj72pdeGNOP8W
X-Proofpoint-ORIG-GUID: tCtMy4AZq32RUJeuWPetj72pdeGNOP8W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfXxQe0ShSDS3k/
 eWkmcbT3h89RchYU4iwRgwIPGa0285URDaJLK6rEsIRBp5xVQ3W7ix9WAl8QB716t+dDjl+0OVw
 loR9FHSplcdxhMgo5FQafN6yjBmEpkAhJm70/BPhc27a62JLueSL0VYE0iyAQe1yNbjm27t+xx2
 CI37QXhqTtOw194gdm9YDLrGgdEWtG1U+z70bTchXgwdNVeZWZ2woxqo2nsi3l5bjtQlkzo0oAV
 yP9aXprdft+LVO9jJMENyjBJQCLX4VSIEEs+//9o/pzUoIZXbEu1itLD//GAXfP2pfI00CXEFQQ
 I55xvXKf4D1HFaZxweQvv2c2pZ5arIYKT64J3p3vGo4jXdG25GA3MH4KoeetueG9gxTI0NNeRwe
 sGmTxrBqbEc/UVBCtyEELN4fD2YlviaFgNiBYTNUjunF7xwKVFoYzvxO05nWQb6sJq7o8GWeA5K
 /4NUuorh2AlTTFOrqxw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a672ac0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Byx-y9mGAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=XiBTJgwI74MO822DETgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270096

From: Haoxiang Li <haoxiang_li2024@163.com>

kvm_s390_gisc_register() registers the guest ISC before pinning
the guest interrupt forwarding pages and allocating the AISB bit.
If any of the later setup steps fails, the function unwinds the
pinned pages and other local state, but does not unregister the
GISC reference. Add the missing kvm_s390_gisc_unregister() to the
error unwind path.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260624061910.2794734-1-haoxiang_li2024@163.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 5b075c38998e3..686113be05309 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -328,6 +328,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 unpin1:
 	unpin_user_page(aibv_page);
 out:
+	kvm_s390_gisc_unregister(kvm, fib->fmt0.isc);
 	return rc;
 }
 
-- 
2.55.0

