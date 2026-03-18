Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6B3DA7CF;
	Wed, 18 Mar 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842946; cv=none; b=SRpwVyJnmqInW1NIhP5DX21jsAFDi68TNi2J8DAXp/d/fvfIKtPTZA+xgkKzshYrFu2vzRz11ndFHC+uVm/JnfP64yYnzzXXaaeGGCoW339C8BIXf16JNZqDAGBCBFy65WK48AGonHK4b3v87uUEGrFEGkls8yVwQB7je7+AAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842946; c=relaxed/simple;
	bh=fVS8jI2X+aGCXc+PBAz9mYKnFNfSMcBx70egiIJpiG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwGOi+gXJHHCs5h7TaJG6IxOTklIGuYcY29p7kHmDQxWoqUjdPHThntKf9m7fdHEz/APfYDTySPD+1LnSQCyYr2YPq7o99U8UYIXrZGxGe2cOdU28OcwJh9OdGYb0pHk51l8+jAFCrFzq6CvCkmtsh+KitsjJXOQTXkE4TRSLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MgvfPF4n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MgvfPF4n"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IDekJK1512429;
	Wed, 18 Mar 2026 14:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cfQRZlaHbNRmIUlsM
	Wde7iY/BNFftsNFHVz8LTnBt9Y=; b=MgvfPF4naA0YqrFbpJV0iW6p2eWya0dC9
	SJfxkc3V3A7dmQE8cIcKGgr6ofXjnbLlwCHNtHZR4BzNF8ouU3KlJ1o2jl+VH9ZI
	WAqQqiQ8471YBwWOd8Zm7me61LFvFK/5HpiTWVsOponQTxz+7j1yZVMtTgZaZ+GD
	fvbpi+1ffsDDsDtDIBz/4eOcdS7tQTqlJQH8WMWmofznU7LUTS0V4jDKEzvvILh/
	OiVIdRqo4yJBp7h0CynMCUwPL/ivB6Dq0rXhv6fawoQFpNXiTizqJvfgeDkaDD30
	rulJCQ+55WQFjECiTgWkkZAWbiyx4BV2C5Zep6zT03hM5G9nPQ36g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3j1ujr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:09:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IDxVEq028765;
	Wed, 18 Mar 2026 14:08:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgke9d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:08:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IE8teF24773046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 14:08:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC10320040;
	Wed, 18 Mar 2026 14:08:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96BB02004B;
	Wed, 18 Mar 2026 14:08:55 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 14:08:55 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nsg@linux.ibm.com,
        nrb@linux.ibm.com, seiden@linux.ibm.com, gra@linux.ibm.com,
        schlameuss@linux.ibm.com, hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v1 6/7] KVM: s390: vsie: Fix off-by-one when protecting guest page tables
Date: Wed, 18 Mar 2026 15:08:52 +0100
Message-ID: <20260318140853.119460-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140853.119460-1-imbrenda@linux.ibm.com>
References: <20260318140853.119460-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e9qMVFATTwcJSeDBRUFNU4i7TyFbSgC-
X-Proofpoint-ORIG-GUID: e9qMVFATTwcJSeDBRUFNU4i7TyFbSgC-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNiBTYWx0ZWRfX0sl2p+pCWnN1
 GZ2oI413QEYJRvKvF085D362YL1vienRufEZJEYz3mQraptOjLz3F6JUy33/05c1uJ5sctJXye+
 Hi3WaiFwO1s44GhFxrd1iypimZ9zLX9fbuUQ3UKLxDaOeuuy3PoFlZss96U7Ax7oCf0T89HK9P+
 +0zE4rnQ1lHn6rfzTavhcFgB/yFWF3ll2vGnF5HpmJ3AmryUTzMU24CEHA2UwIPHSn4l5OYWKEJ
 RJ7Cs5XfnwgDcmUsjclksUgwnD7sNHKxwMelHB0DakMU5klZEQIdZBJBisRv2AhP9L6eKwmg0CT
 gJjkUku86+N6s9kr/nU7zSwzW+/iUonSgxxdF8DYf3eDilMrETTQzFRZpifpUQWHzp4X9OKmmQW
 hfnlBVdc6PqeCZShOcpbgKDcMgwIIm3y5rudYvSsIey22MZ8E9fx6EhhgxHqIKisuZB3lsWObMU
 iQP6mV/+eruC3Lr2iqQ==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69bab1fc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=bkfxphG0_3iQy6Gj3vsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180116

When shadowing, the guest page tables are write-protected, in order to
trap changes and properly unshadow the shadow mapping for the nested
guest. Already shadowed levels are skipped, so that only the needed
levels are write protected.

Currently the levels that get write protected are exactly one level too
deep: the last level (nested guest memory) gets protected in the wrong
way, and will be protected again correctly a few lines afterwards; most
importantly, the highest non-shadowed level does *not* get write
protected.

This leads to all sorts of races and other issues.

Write protect the correct levels, so that all the levels that need to
be protected are protected, and avoid double protecting the last level.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/gaccess.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 3bcf988d6faa..8b287fcf611d 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1516,8 +1516,8 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	 * only the page containing the entry, not the whole table.
 	 */
 	for (i = gl ; i >= w->level; i--) {
-		rc = gmap_protect_rmap(mc, sg, entries[i - 1].gfn, gpa_to_gfn(saddr),
-				       entries[i - 1].pfn, i, entries[i - 1].writable);
+		rc = gmap_protect_rmap(mc, sg, entries[i].gfn, gpa_to_gfn(saddr),
+				       entries[i].pfn, i + 1, entries[i].writable);
 		if (rc)
 			return rc;
 		if (!sg->parent)
-- 
2.53.0

