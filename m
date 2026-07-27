Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFBE3E63BB;
	Mon, 27 Jul 2026 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146067; cv=none; b=QxafnkCDJUxKe+OAf6+lhAHrLWIBIYVObbj6Nge7PJjrg4HCiA6bNZk40gqlXAZQw4YQ6IB6PH9nVLDmdzOn5XcN/I9YSCwkRcfPRvHclZkt3LS6Nyx1VsD10g1CQr5wpSmNkP1gYcYnoaLR7t6XN+mO/BKoKUMNfuGUAe7mjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146067; c=relaxed/simple;
	bh=9ZnjUzssi9uaPKdPu+5nhru7+0Bpe8WRiGV4lkIVnKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8t9K/Cvg2p4oX4ejNd+1l/0MQzCKiTPKrbVL92in0weu3g2uHK4UUsN98VrlRhH5iT7dpvlcnO7VabsMdgNcHxCt00gti+hml+/Bvqz0FU/GWANIfcb8k3q8zHOMFi4D6g4t0ZO/bHResUd7bm+RrStAMkZ9q/kStjzAJnA+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YB7/4/8H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YB7/4/8H"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9UcB91821145;
	Mon, 27 Jul 2026 09:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FyCiTNNL/ZwVbqfmE
	IYbK7YyNU48Fcb41XAcLfwndUw=; b=YB7/4/8Hdmi7IgeAU98DUdJoiLjQ8OhKS
	tZFtDgrNFvv3FpM1ZGDUwqPHWufle5H282OvtbmJPZj6OEWyFF0EAsjZgijIkpVG
	Genv/+yGu2mh3Li4w6ivjd8GOfZQW54WsB5xFZY1UgBDy7Ckn2WiE1oOGRa7apG8
	ENWwxmJ0iaSmKlETD7u9pX9CF0IvKxFTsS09g/XMNDeIo2NpF+RGMbD4W+45pSz3
	OU1GsZF2hraNqV1a7Em+3hYPJ4x13Cybin+fBQUZYO1SI+3yEtEEHFQA1Y6bRPce
	lRzhAGgEb0MoiBy01I/vnxkh7k151BpyYPnIg6AifUIOfdU0p7NgQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw77br9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:54:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R9fJXp016747;
	Mon, 27 Jul 2026 09:54:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjvua5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:54:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R9sAEG29754052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:54:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 756A35805A;
	Mon, 27 Jul 2026 09:54:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 388F058051;
	Mon, 27 Jul 2026 09:54:07 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ehn-de.ibm.com (unknown [9.224.77.173])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:54:06 +0000 (GMT)
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
Subject: [GIT PULL 2/5] KVM: s390: vsie: Avoid potential deadlock with real spaces
Date: Mon, 27 Jul 2026 11:53:56 +0200
Message-ID: <20260727095359.107671-3-borntraeger@de.ibm.com>
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
X-Proofpoint-GUID: QL0T8RtsGArH0Pg-DvZzC60LnyfQmCjv
X-Proofpoint-ORIG-GUID: QL0T8RtsGArH0Pg-DvZzC60LnyfQmCjv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX7mkcCX9qmc1L
 6JW7wNoXSLiVtmEbzbGL3oGPSYTsnkSNAxn9Wagc18MgH7DBn1nrYfUtcwKTKcWrs3UEybrWXz9
 FDbZ75ueMaV7ox8VhddiRrlu14NFq+UT0ciHKUV/zyY+GuIAE1WCtluI5l2U66DBCw1QiqHigF4
 2vk0WaVZnTzXTrD8fGZkz9mZQGrnIkCdCYp682KQzTcN3CuoArhw+cZci6NefHBYeZOgedtN1TP
 YMYle3nCi+/LZjbgkm387tMJyG6JHa5U1RbumVobR72MdazEWyGqU4/aY49WnWh5W6qM3XT3YZL
 ubYqDHArahUoBxbkhd6SLppBo4FKLSn2RWlxf3k4vy3lhl/4dcN37Q5knsgdvz7j/ULa/TKMN2/
 8bcZt47HB/g0Mx1cwy9/Eqwi6E1pEYMc0rSxxkv1Yesw6S8/JEHyP/q+VGfyyn3hhOvhhRrXKoz
 V9cNUlRGZVVI3K5bWXw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a672ac5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=h1X_5t0Fh-6HCxHrEOoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX4ZRbhU+Jsmmd
 hNBmWxOwywkmpANPfm84JPesxPE5PLQG9vJpNtTsO3w1ojE8IGeVKQ6N5/Ipx0qFMtoRlkfn4ws
 jbCo1e/e8I4NkYy1ewO0D7G+LCqIX7M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270096

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

The natural lock ordering is mmu_lock -> children_lock, but in
gmap_create_shadow() the reverse order is used when handling shadowing
of real address spaces.

Convert the inner locking of kvm->mmu_lock to a trylock; return -EAGAIN
if the lock is busy, and let the caller try again.

This path is not expected to happen in real-life scenarios, so its
performance is not important.

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 298fbaecec28d..8abb4f55b306b 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1374,8 +1374,13 @@ struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *pare
 			/* Only allow one real-space gmap shadow. */
 			list_for_each_entry(sg, &parent->children, list) {
 				if (sg->guest_asce.r) {
-					scoped_guard(write_lock, &parent->kvm->mmu_lock)
+					if (write_trylock(&parent->kvm->mmu_lock)) {
 						gmap_unshadow(sg);
+						write_unlock(&parent->kvm->mmu_lock);
+					} else {
+						gmap_put(new);
+						return ERR_PTR(-EAGAIN);
+					}
 					break;
 				}
 			}
-- 
2.55.0

