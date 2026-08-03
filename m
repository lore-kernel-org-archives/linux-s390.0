Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3F40C5D4;
	Mon,  3 Aug 2026 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760858; cv=none; b=aLxDtb6qAUuBySlMAh7rqoWRmUxOdRYuHgUdsl7gAEyo83xh/2fToKIfv5OPH3Alrn6oatQEQn5/sWMChASpNm/ag4SKY+Q8tZoIkght29/sDCItKHYRO5QIhffR8M60Q3kIJ6QetzduKoBp3rdWwKSyFnq3clctZU4Jg7yFPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760858; c=relaxed/simple;
	bh=lrLXFoXGkCQqajiFzpvyyVTqja9Wibw9Q7qbE7OIzeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JARI9x/L+WUi1m2zaePrJDm6CROJ0BVWRB1er2fqnDCZN3k4l+G6O5jYRtRZ+aZ5mBPcytOVkrpDqnyIfgoWQ21IsDUF7CbogNMtq8cnzlpw881q6ty5bTsR7FAUOhBvrdZNjJi1Cg1EdOyjPbWX3kQyuPbll1XkcHuTjUJXugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FBRO3CTp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FBRO3CTp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHrQM1943500;
	Mon, 3 Aug 2026 12:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J5ryilsnnfEEjhv+w
	mZlP5DZ1N22K6iGMAkWi7r5uEo=; b=FBRO3CTpC3L9alivacjczHpWWIiZ4aDsE
	7lhyAuSKeuMQe9eWHo9mKxJSXG3KOoth/w85ltBrA4o4ePo24NZXbJRlfaWQF+z0
	Awlt7ODTHJ6rtV4KoOmYMBdPVpdN4fRgMkgQRSpX/otVjkDSMO4o89RFtPuezvh5
	zkc0Dj3nyj3VSmtRyEwZU9ta3W3fCe4ta/vvzyY/wCEh4Y2khm4UNQjUWkN3WZPV
	sXaEUG7kxxv5XZY4EZ2BIQtrgO1aemZvFQMXYfQX3xC824YKYc8uvtdoQNEGYpUq
	/LO4SC/KqW9P4tcmbdield9cZjgbcAMxfaY+JpCUP5lUZLEM8MZQg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g0k71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CQHEv027325;
	Mon, 3 Aug 2026 12:40:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qdgqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673Cekmk31457652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:40:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C912220040;
	Mon,  3 Aug 2026 12:40:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BF0A20043;
	Mon,  3 Aug 2026 12:40:46 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:40:46 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v8 11/13] KVM: s390: Return -EINTR if a signal is pending while faulting-in
Date: Mon,  3 Aug 2026 14:40:38 +0200
Message-ID: <20260803124040.126471-12-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803124040.126471-1-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX0fcjnLDbspwQ
 edKuIQi+/zzPFUrks/VxkUTM0S1p0bk6GxQSzkSO3nl968Zn3KP2rkZU08BMVchfWMd8Xxhb89D
 PxH1OJ+phwlCzQmYD4GojOeoxfDRZDGut0JIu945Ry83+pHoE1MRUSmy2BvMabnLYpMva1P4yKf
 BIJYkMzRN09l9NgZNHyrK4uKRTiOHjULJLGxWk+nvmN7OVEdb/YRZgo4ewGLQfHw6HB72Vo8Kn1
 FCVJyTRu7BuxbLPoIMmUpsYidh+fZwaUr6YNcn+BH5HN2sEYGN9fyVvKcbUriFiQHQuDZ2lxWG+
 EL+I5oa/nF2a8m5E4Zg+199vcP/SMj7D+AYWvjAqNBVA3vDTVcQiHL0fvQR1ve2zxsaG5p2TJs4
 iP788ZiXdzhx7qlfjoR3ND5ECf0hlGrZ5QBQqy3VmOyFlMaycSBG65szh7SiVskd+UXaDbF6lQJ
 K1LF6lUWk7nGmco6MgQ==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a708c55 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4yawSYOjwzvXb9KGJXwA:9
X-Proofpoint-GUID: QthsY7RTdJQ33zaa-zrLeFbpH9hI15Ff
X-Proofpoint-ORIG-GUID: QthsY7RTdJQ33zaa-zrLeFbpH9hI15Ff
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX+H6bkR0xKM6D
 2BhaJD7OoTOc91cpzGgabCYIsXZHzVPgz/6R1wxxdUsn3uPLLZmWFErznulM0ECweeiX9cGdrEF
 kAEQzTGPuAuwOrqF3D9a0wl27IDjiNU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030110

If a fatal signal is pending while trying to fault-in a page, return
-EINTR instead of -EAGAIN.

Also fix unpack_one() to handle -EINTR properly.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
---
 arch/s390/kvm/faultin.c | 6 +++---
 arch/s390/kvm/pv.c      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index fee80047bd94..3cc45f7f5b2d 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -91,9 +91,9 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 		/* Access outside memory, addressing exception. */
 		if (is_noslot_pfn(f->pfn))
 			return PGM_ADDRESSING;
-		/* Signal pending: try again. */
-		if (f->pfn == KVM_PFN_ERR_SIGPENDING)
-			return -EAGAIN;
+		/* Fatal signal pending: bail out. */
+		if (is_sigpending_pfn(f->pfn))
+			return -EINTR;
 		/* Check if it's read-only memory; don't try to actually handle that case. */
 		if (f->pfn == KVM_PFN_ERR_RO_FAULT)
 			return -EOPNOTSUPP;
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 1beacc841ca8..dc204b521052 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -809,7 +809,7 @@ static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak,
 			return -EAGAIN;
 	}
 
-	if (ret && ret != -EAGAIN)
+	if (ret && ret != -EAGAIN && ret != -EINTR)
 		KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx with rc %x rrc %x",
 			     uvcb.gaddr, *rc, *rrc);
 	return ret;
-- 
2.55.0

