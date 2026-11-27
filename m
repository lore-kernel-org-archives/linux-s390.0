Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791895;
	b=uZH26EZGvyVVrkrCl4ydHKCsNzc6nwt0iL7zIhGU9ZFg9vQo+nk0pj8sHkzEZlseO7gY
	 I3oG5hMhdMyAfWPwvzZSVHTTUgQolQKe0efZEe/JPXzyPOJlItlE/JZ2IdTbv7jnGJihX
	 Ww2wZeRJKhJ4H2c7288enyxkR/gOW+oSd6R3Ex28EzSbLYNr7GwPa6EgZ+sjJtVeXLiHd
	 3kA6eGFdIemLqtXGAa6XlTiOv/5g9YF0Qp1eAhihaaIQJkJqgb5Kik2EEcNI3Tm5Yi+5/
	 o9XI/n/V5Qg1bML5p8iAb58v/yPIuC2EOlNBcKkecEkprUYCYB8EqHvM32JYMOTdKhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791895;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Pz++cFcxQTFRqn95+ctAkoFGohYT4P407RxerT0ZXks=;
	b=TIxrDIRBlEhQFaTdcTgzd1L2d2SbRrULh6Jqv34AlYJQ8u9p7x+NuqORQFSWpRh2RMYU
	 feKfKDbVT1kaMuoZkcU/L+0B7v0CxkxIL5YGO10G7f3gJKnegXQpVjj8S+Ih0ABRh8MfP
	 zVuUz7rvUz/A1I87EuuvD2SLWub0MpMzKq9LSvzamSH+ZOEpGByYpD1subfHpOv4P9new
	 0K4/PaDG+Wy2QS8ZC9TR4STUcO7qg+0ydwT3fcC0moln3EX+Ww9GhikWfDqvsGRxTK0ix
	 gDTvs0R7AQUNgdwgOmqvATTEbBn/jj83io+YauGD8bJHcZ5BxbttGOgmZ74AYWy518w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hSlHQwBc;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B3606A31C;
	Fri, 27 Nov 2026 15:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 843B3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hSlHQwBc
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4mOZ2011648;
	Fri, 27 Nov 2026 15:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Pz++cFcxQTFRqn95+
	ctAkoFGohYT4P407RxerT0ZXks=; b=hSlHQwBcKMyX8xdXehGG2aFlhiqoWlNJJ
	lnDn8EEv31UtaEs2Icq7dwy1SAQZp/TR2wTk++x6hhuktyuaqdiZ4ahY/0s9UBfL
	0ytnUlAFzJ3gLId2j32IXl8HZKG+NqPOoWYI1TmZfMzYv/UeuXMDz69C3bik5eF1
	OBMC/cnOouCaARCWVQqrw0iNJodIVIKOC6D96AiafUySsS3xXohwkF/qWqlkJdlQ
	OtiGQT3F2Or2eDtW77wJit4gJCvNocpfikG0bCCq4knaS+1RWOopPsh2hy5A65bZ
	i0ta/2a2pqW1sJNya6y3iO3EVSb0xT05fOIzqrCHj6fgTN4VXqpCQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4wcu7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4EiG3998994;
	Fri, 27 Nov 2026 15:04:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6x3h2jxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARF4ZnB18940194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:04:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11DC12004E;
	Fri, 27 Nov 2026 15:04:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16BC220071;
	Fri, 27 Nov 2026 15:04:26 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.43.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:04:25 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, seiden@linux.ibm.com
Subject: [PATCH v1 12/12] KVM: s390: vsie: Fix improper shadowing of non-present host ptes
Date: Fri, 27 Nov 2026 16:04:11 +0100
Message-ID: <20261127150411.221072-13-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127150411.221072-1-imbrenda@linux.ibm.com>
References: <20261127150411.221072-1-imbrenda@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX5no/k4eEJ7U9
 vPQRvHtKaIxDbXkOAoExmJ6GNeLiUnNMJ4SC1JR3S73hF7+V4EmDZSeS/2tcaDXrcHEDVctAEcf
 828oxrIskzMYT5m2F8kMYPqqIMyBZHI=
X-Proofpoint-GUID: eDTZL7Ib62chqWB9tFl_vqW5FvTmWAl9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX4eBnZ7Z5B3S8
 sNuSdE85Ph59muo5FhWvE9jpaJpOTFhiI8ZMmkG4SVMq5GtVyJJMEXxN2Hk6OhRhGizs9LrajDn
 2+LpSEq/ah1+6yXoAwzqfBVAqnxzBuDYgPXQyyQgY5nr6v5RCSs9pusqMid6FC2JU4u5r/kb9QC
 LVDoG/Atru0pLu19Dv+7Swmiioodaaq0Xi4VtPUiIja75mtQ9zF7WuGUaB51XmkHeAIaUlFtPYg
 p6xMryG+po90DQ98rWusntuJcpx0pw/EVxYZF3Wv/ed2vShZB4rpmER3iUiVlhW8yaeiJaci/I6
 /Y7Am2b0Y+QIqF9CfUGGw3v/9XqMtX6YYrdhnxjm1rVtLAyIfcBP/zvo9Jn4X7lQFM4HtR1mVqZ
 2hKLlWOsmHJlCh9G7yXLUEz99+Wft3DUvSPaOZv2cN3lB3hmMPN+uDmymJOuyO7UcModMmGeIdw
 w5zsOGrCeH/aU7VVIuw==
X-Proofpoint-ORIG-GUID: eDTZL7Ib62chqWB9tFl_vqW5FvTmWAl9
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b099c08 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=z8gcGgh87O6MxCmE1DIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270060

If a host pte that is being shadowed was empty in the old mapping, the
new mapping might end up not write-protected, even if it should have
been, since empty ptes do not have the p bit set.

Fix by only and-ing the old host p bit if the old entry was present.

Fixes: fd7bc612cf27 ("KVM: s390: vsie: Fix nested guest memory shadowing")
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Cc: stable@vger.kernel.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/gaccess.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/s390/gaccess.c b/arch/s390/kvm/s390/gaccess.c
index 2d27dcb68002..158af3415e2d 100644
--- a/arch/s390/kvm/s390/gaccess.c
+++ b/arch/s390/kvm/s390/gaccess.c
@@ -1434,7 +1434,8 @@ static int _do_shadow_pte(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gpa_t
 	newpte = _pte(f->pfn, f->writable, !p, ptep_h->s.s);
 	newpte.s.d |= ptep_h->s.d;
 	newpte.s.sd |= ptep_h->s.sd;
-	newpte.h.p &= ptep_h->h.p;
+	if (ptep_h->s.pr)
+		newpte.h.p &= ptep_h->h.p;
 	if (!newpte.h.p && !f->writable) {
 		rc = -EOPNOTSUPP;
 	} else {
-- 
2.56.1

