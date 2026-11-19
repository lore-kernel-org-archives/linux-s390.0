Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084396;
	b=b4rs0FticWzS9brxggu2+rhPYyv8rEsvAJGebis+dFjZ1MJRD42FMfCOh1hp+9mHp/OH
	 l4iYH2JDJoHxNOpiiEAQO5TaozOoCTL7ldPTuUdsYvgkKtgpG4yF+A0/Z0b3Gn/kv3KqZ
	 Sen1frwKat51jEoKI6gevamnM+YHQLxsJ7L+SYbywMx1FEkAV8lEaE4lAFvLDsN1Vhq9x
	 ox5luEWDcQxjIRZscQ3pheK2a7u0WBuypffOjmhyfVnuWolVhZwQMXAYzBJtwhFrDRupF
	 2+85icbIhpemq5n0tEyZRFjOtP4DJZ50AiRGMKuQAtBZOE0V1pBXN2vPN7G0jEeVEaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084396;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vyH3okKf+EpZ+er3TT1hLigzzd95RfDuQgEOLD7RHes=;
	b=pnMd7p6sKW8sv0IPnQ7XdcDhdsZjBU/WShY5PoqAUqvvr2SdzjfKL6hffg6VlashaTIo
	 h23jpcSlvxrdqz5J2FtLz7YrA3yKTTrfixouU0G5pXGB2ebE2BmDyE2vVOB7ZG0gmuct4
	 p23Q1EbqgKUGlV29pcNwL31ZuGQJOP3JUtSGlD/mxyddWlO2A9DT50n8IuK86iVLF6LBQ
	 nzXGb9FAxn+Fib9vlZ1uwoRHTXb7yvOrM21+lLRoaH3uKksjPUgzHxKP2N/49LwfyqCmG
	 bDawENSzmc22az5vqKpurOQvqbJHouPr/2e9COdDNk10SpHbwrz1pZz6Gd03ayE1SOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sFS22Use;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B249606A326;
	Thu, 19 Nov 2026 10:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B249606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sFS22Use
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6v4S63423875;
	Thu, 19 Nov 2026 10:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vyH3okKf+EpZ+er3T
	T1hLigzzd95RfDuQgEOLD7RHes=; b=sFS22UseFxtTQY/tzQkbJle2WRPzT6Jcs
	BIS43ktOeQcBgpB2beTrx/3dBUPU2D2yNd2jHwlasVG23QfZ8nmWK6LsYvC/PGPx
	t7+h67/jioCIZ4mdAedzGq8xa3ekuB4DFecUoO00oioI7r9WnECeOSLqrRaqUANp
	0W0qIQr6i88wzuCkxMSxhqojCF7iJBbWubN6EI8U65mfbl9tHtOpKVq/D3mgiSdM
	SLh7UnF+2/tE/KE0IalciNXZRu0HH5Ak+biTZlS5PDrpqDQ+gkFt6TVq1oyw6DeS
	ZiPjHSkfvAzxd2FrrxoK3PsEt8pEjLDU69qEnAvkFKbr8AiT7S7Fw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105x02sb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 10:33:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJAA7WV3327265;
	Thu, 19 Nov 2026 10:33:10 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1bb5d3kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 10:33:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJAX93816122402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 10:33:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F52E58064;
	Thu, 19 Nov 2026 10:33:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 776A758062;
	Thu, 19 Nov 2026 10:33:07 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 10:33:07 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>
Subject: [GIT PULL 3/6] KVM: s390: Move some skey functions to headers
Date: Thu, 19 Nov 2026 11:32:56 +0100
Message-ID: <20261119103259.7523-4-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119103259.7523-1-borntraeger@linux.ibm.com>
References: <20261119103259.7523-1-borntraeger@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: yFDhBHFq3s4BP7RzsrXjP9lKuNEW8mDM
X-Proofpoint-GUID: yFDhBHFq3s4BP7RzsrXjP9lKuNEW8mDM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfXxl2LJCKfQooS
 TrGi9TpoiLrr5dH/RFhEBGQ1JQf8WkwajXghvRFVaHgeMT8q1LtfFn+2p8fQ6Ea/mqbTw0dtlfx
 cvttcTyD5SQxYF/sH75e4HYYewfp94gv8sMATx3OgJZoJA599g44rDQuqdQ3P/jjuXY4EViqf7Z
 0SCg1Cnbe9c8fjM9lTjSrsWXhHFbDpD144uO7xqlQKUBkpp5/mf0XDrWu6CCCNhAh8D7HiOWu/j
 G2JcqAcg6BONGhU/ZYmD4j+d3TYE705/2/D0L0Qi3SpFe1V6RaSmvPltdxDRx7Yio2XS41UHxRL
 fDunKyWiBVdUr8ci6CVDUK8U+TU2JXNJFPQpvdAHL8cCBdLU5mF/uOLw0XpWjYViTqz1JvPaEZy
 t7Ht2Rr01GJC2bsPCPjHcnQDgvFMfq+KArRGzdo5hdVcx/LkHjfQ+hB67Ec1uEgGFsySBLcZOtY
 dSL6kczTL1e+b7hWgGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfX3PJea3Hfx/K0
 X5Rh4K+SQcr6jHmHTWrUhxTWSQbhDuUdmQgmCOH2TAmofkLBaF7O9tXLrs4assiduUb5iJQ5dOC
 Y5olAYSxRbvEXU1Yyr/s0hoDPbxEI6Q=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afed067 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=HEUQaSvOCpYZseJEH4QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190041

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

Move some storage key handling functions to headers, since they will be
needed from outside, and they are small, so inlining is acceptable.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+: prerequisite for the next patch
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.c | 26 --------------------------
 arch/s390/kvm/gmap/dat.h | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index a2031aece4ed1..7a25e41a14239 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -159,32 +159,6 @@ bool __must_check dat_crstep_xchg_atomic(union crste *crstep, union crste old, u
 	return cspg_crste(crstep, old, new);
 }
 
-static void dat_set_storage_key_from_pgste(union pte pte, union pgste pgste)
-{
-	union skey nkey = { .acc = pgste.acc, .fp = pgste.fp };
-
-	page_set_storage_key(pte_origin(pte), nkey.skey, 0);
-}
-
-static void dat_move_storage_key(union pte old, union pte new)
-{
-	page_set_storage_key(pte_origin(new), page_get_storage_key(pte_origin(old)), 1);
-}
-
-static union pgste dat_save_storage_key_into_pgste(union pte pte, union pgste pgste)
-{
-	union skey skey;
-
-	skey.skey = page_get_storage_key(pte_origin(pte));
-
-	pgste.acc = skey.acc;
-	pgste.fp = skey.fp;
-	pgste.gr |= skey.r;
-	pgste.gc |= skey.c;
-
-	return pgste;
-}
-
 union pgste __dat_ptep_xchg(union pte *ptep, union pgste pgste, union pte new, gfn_t gfn,
 			    union asce asce, bool uses_skeys)
 {
diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index e6215c0b571f9..9cdd1f122d7ae 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -1008,4 +1008,30 @@ static inline bool crste_is_ucas(union crste crste)
 	       crste.h.fc0.tl == _UCAS_ENTRY_LENGTH && crste.h.fc0.tf == _UCAS_ENTRY_OFFSET;
 }
 
+static inline void dat_set_storage_key_from_pgste(union pte pte, union pgste pgste)
+{
+	union skey nkey = { .acc = pgste.acc, .fp = pgste.fp };
+
+	page_set_storage_key(pte_origin(pte), nkey.skey, 0);
+}
+
+static inline void dat_move_storage_key(union pte old, union pte new)
+{
+	page_set_storage_key(pte_origin(new), page_get_storage_key(pte_origin(old)), 1);
+}
+
+static inline union pgste dat_save_storage_key_into_pgste(union pte pte, union pgste pgste)
+{
+	union skey skey;
+
+	skey.skey = page_get_storage_key(pte_origin(pte));
+
+	pgste.acc = skey.acc;
+	pgste.fp = skey.fp;
+	pgste.gr |= skey.r;
+	pgste.gc |= skey.c;
+
+	return pgste;
+}
+
 #endif /* ARCH_KVM_GMAP_DAT_H */
-- 
2.53.0

