Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CDD246BCD;
	Wed, 18 Mar 2026 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821189; cv=none; b=hqJ4spABnuMKuTGppvh6fDe+sfCqizCd5S0DEdTwgi390HxTKV/xW1pkQ2N0L2X1V6bEgXumepT2kGEASIRLnJP9+/TPof3U5XY3MFrmMQUj4aH6ZNL/xBDTs+kzm94oTtDborUxnI4K56t9Ftbd3rP16myGjOm3TUS80J3JJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821189; c=relaxed/simple;
	bh=R73OdvbQdAE9CXoalJYo32MIcVpbCG6XjskhFqNdCY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfTTwpL31XWlF+cROJ2SB0TYzGmqvKmY0eK2V1bDuBmEy9BLWmig0JRcA6a71gP0X1KZYbBaWeSh3hxPxfzpJag/j3riCinSy7s82ppGb2VMOYj2ED2uzkqL3KRxbStYwNO4fbauOCsuXtFt5U6ft4apPzhe42XVY/ixd2z9kw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sSIUSXw8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sSIUSXw8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I804FW544589;
	Wed, 18 Mar 2026 08:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tCGSgebCNTOMMsLXk
	MvE/9vqspYQuJlwsaobortlhlY=; b=sSIUSXw8vniNTp6D4nEWfTUML4YphUzIk
	sHQfZmHhhy5tfHVcEFSwenvWhmpPoZ+zuSP9J2pkYUvaE+fKq8jNq63lda643MiD
	3zX9CQPjvjlRn0sRFU0Yabp4OPIEkTVR7JwNX4IU42pVSTJobi4cxkzvxx4Q3tAQ
	s6/g5SlmegKd/gLbOkwjKFOu9LJXWxlQ9i4JCNY1Fk7LfQ7gH8XgaanLC+B+upgm
	xMkKtgM6MO3Bz+Nfc5vAue0JkGXfxWqRoS3VYkZgbwZRQAmcmfHO4UvmoZDkinEs
	AZsvGoJpVRyy/N3X2W4d8fICuMGf7e+0E/JMlFcO1/x5eOOKhxKdg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3d08y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:06:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I644Pf028496;
	Wed, 18 Mar 2026 08:06:14 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1ctw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:06:14 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I86CU859507066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 08:06:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2353858058;
	Wed, 18 Mar 2026 08:06:12 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C882F5805D;
	Wed, 18 Mar 2026 08:06:09 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ibm.com.com (unknown [9.111.93.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 08:06:09 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [GIT PULL 1/6] KVM: s390: Fix a deadlock
Date: Wed, 18 Mar 2026 09:06:01 +0100
Message-ID: <20260318080606.2450514-2-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318080606.2450514-1-borntraeger@de.ibm.com>
References: <20260318080606.2450514-1-borntraeger@de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69ba5cf7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=MFxHPMzSBJxkdh7CuRcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2NCBTYWx0ZWRfXw/ZH0rrWfM2N
 5QkPsA2hw2V+AB52SyBlnZpsMfPoS375dhiDfoLbmJxWmjKVDYLQwgupOxpysDQ8Zk6bGAwQIeB
 XjNLWk7huVmaio5q7CY+c4c5QgXKScfiPDWsHBR6PdyPqYyWFdYZScxih+1r+mzUEEDcKwfm5um
 5kf2du8T/E9w1dXQo46XyvowqBtdvrkjJpmczF3/5n65ZWxWUibFfwfoIgG+PKInG84JjoLlEKA
 OobuNPH5SoN6YRz3BYKSjy7B/7i2cmXOU/TEraavbbZA3kGdRQ54c7L7LfQnIda1dXlJmzBzcwV
 xyOn1GGuG2TtTUD46615m+VwriqJCRaiADSv6wgBYJ5XPoJ0isxBbm8LLP828QsenNNCCVvfGBL
 I4TYv4pNvMZShMbW+b3EOUyJBSUR3sKEAo6w8ggFl0V6U2xqc94SlyVYynIo+H8a5FsLgLnedQV
 cQpiKwI37R0B1eaHV6Q==
X-Proofpoint-GUID: gr_fHM5mlYq50tpJsSpPAq52xrV2F9Cr
X-Proofpoint-ORIG-GUID: gr_fHM5mlYq50tpJsSpPAq52xrV2F9Cr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180064

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

In some scenarios, a deadlock can happen, involving _do_shadow_pte().

Convert all usages of pgste_get_lock() to pgste_get_trylock() in
_do_shadow_pte() and return -EAGAIN. All callers can already deal with
-EAGAIN being returned.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 4630b2a067ea6..a9da9390867d3 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1434,7 +1434,8 @@ static int _do_shadow_pte(struct gmap *sg, gpa_t raddr, union pte *ptep_h, union
 	if (rc)
 		return rc;
 
-	pgste = pgste_get_lock(ptep_h);
+	if (!pgste_get_trylock(ptep_h, &pgste))
+		return -EAGAIN;
 	newpte = _pte(f->pfn, f->writable, !p, 0);
 	newpte.s.d |= ptep->s.d;
 	newpte.s.sd |= ptep->s.sd;
@@ -1444,7 +1445,8 @@ static int _do_shadow_pte(struct gmap *sg, gpa_t raddr, union pte *ptep_h, union
 	pgste_set_unlock(ptep_h, pgste);
 
 	newpte = _pte(f->pfn, 0, !p, 0);
-	pgste = pgste_get_lock(ptep);
+	if (!pgste_get_trylock(ptep, &pgste))
+		return -EAGAIN;
 	pgste = __dat_ptep_xchg(ptep, pgste, newpte, gpa_to_gfn(raddr), sg->asce, uses_skeys(sg));
 	pgste_set_unlock(ptep, pgste);
 
-- 
2.53.0

