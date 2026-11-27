Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791878;
	b=Lkz64HD+GLrYZa3ELqOvxYXp8gljB84kTB3vkTI0Fm5R7a3L3nGQTgpfJse3iEPHlygo
	 v87anYgJOWvR9wFWfp8QKNSqzEHcK5LnpnAEJCfKcumJbAv0Y/U3fkgYAeurrlVLXNsq8
	 9SyRI2NxHPQMtS3EGNAEu/ANeYPT11XgAxy6D9bLCwMIrIbUbqf4md87ncwS83DWGWnv7
	 9m4R8Jv3W4kkk+ygMpbu4/vWg3Fhywr8kUJYOLZrkUgIFOUDAZi76M8nTL8ruxh4TBuaP
	 9hc130A7bDBlpJHoMX20l2KGm8iVsSU/QZAWV9RAVieGnjx0A9o/QW9e18Y8a9nmkTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791878;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=42zbbuR3m+Ap5sH8Miw2baB8CchuNriaMT2JiV6Myx4=;
	b=TvYheKYoz/Pf2R1Q45B+72o+kMRGfW0XHh7R5NmxvvAbzCEzRf0mIOTQxhf/PPzpq8Ri
	 0hMIKqHfs+6s6aYKW7UdtBt/sqxhDGWLLFvPbBiyxSRjJYnlFJ2cCl6rxP5t4/rfKQCoz
	 dOLMQOvfvOOo1Qfpk85DdKkzHSh59DN7OHcDk9aFkHzRl2s3qqb9BuRIRjDUmqcPh35I1
	 Ssx1loH/j19yQlFSzKi0DXefG09pGBsBZ5Go0k00ojNuF2ZoQegl+UPWGr67UfN5Qc1/5
	 +aQ/StMTjMwbeTMv1nZPVoD8LHyEkQSER7uIMVe16cmpqkNGqtxuFc2Z7Iv1sWLYLzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ADAwPqLg;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21DF606A31F;
	Fri, 27 Nov 2026 15:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F21DF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ADAwPqLg
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4cG33419332;
	Fri, 27 Nov 2026 15:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=42zbbuR3m+Ap5sH8M
	iw2baB8CchuNriaMT2JiV6Myx4=; b=ADAwPqLgiymy2HWHAVSomrMmGhVngh8PJ
	ZVYoDc1wOUh/ofqImONs3l7GEKcg3xBXERusd5haVISqKx0VGkDt4w0bZPjHgfpc
	NwMIaSKFj9+rRY62S8iRRfAT19m2O/pRog5iV1IBPaMWhGvtgB7GnoYdJj4lnSw3
	oEscdYJB0IytiAZNBFL96YG9BMkDluiSYBfKnJlNi0XjTBmw2oF6tQjkWdS5oolR
	IEntVCS4UHcT0/aTXXXMi3ZcwnuH9XhBXoHFsxlhASUCpI312O/QOEM03RuFIrQv
	lP8R4vt3HJZrB1rMMPhq0buTy5YpPlPGhoSVQb+Wu3tkTxC1VR9Xg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fapd6e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4EZe3999005;
	Fri, 27 Nov 2026 15:04:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6x3h2jvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARF4LCq44826992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:04:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF94A20049;
	Fri, 27 Nov 2026 15:04:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D16BF2005A;
	Fri, 27 Nov 2026 15:04:19 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.43.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:04:19 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, seiden@linux.ibm.com
Subject: [PATCH v1 07/12] KVM: s390: Fix race in gmap_clear_young_pte()
Date: Fri, 27 Nov 2026 16:04:06 +0100
Message-ID: <20261127150411.221072-8-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX6UbH4HWlz+3w
 7Ecw2ioGm2SsHMG7AKPDpJD1k24/brIc00eMNni0ZR7B8NC8ln+R7EY4UJXjO0HvEAtF3LEnIk3
 6NI/HGo+OLN1pgCw2I5UVz12DV18YTJMAj8OOUN9Nurw11w+xkw8yOmCE2NLBtG0ZKrKPOeVipL
 UkjyfIjJKGsiOnY3Z+t6XRi3nAmBAsvEb7T5Ffg0tvuerlSwgcFrZs+fNrdcnI9VGl+FjYhHw4C
 sjdoro3dmcKG5C2MRQ+9AENcHv9sWjg1070FGKejHLDUOfVWuufi2mdCoWtcfTuEN3/+kgoiNs9
 e/dWzGpt25RaggCnzK7IOZiSYYR5Q8p1zTcRVvAklCtXVEHpkCBkuH5U5dW4R5atuZwxoSsRgNg
 Dk3s958IOFyQR4YBXXytBVxUt13MtajFfAVeA6RFr+PiINC0I7jHQoFZf9y51g+xDKNVEGGwxR5
 wdiFuP9uogt/R50M8HQ==
X-Proofpoint-ORIG-GUID: ZNJYmiwejiqWUnhOzHohU3T_-OipZF2Y
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b099bfa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=nOR91-uie9e_eXNfdBwA:9
X-Proofpoint-GUID: ZNJYmiwejiqWUnhOzHohU3T_-OipZF2Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfXw2zBR2yRJGjJ
 zreMovgaGkjfP2VjY0fFG6uAJ30P1Nx8FiYYk9sZNddjYp816SUR5nHzKin8ko4Ru41VW09fGwS
 32tvFaynkvx30ewzaWkm4UA6dVv7nyI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270058

In gmap_clear_young_pte(), pte is being READ_ONCE() outside of the lock
for an opportunistic check, and then the same value is reused inside
the lock without checking again.

If the actual value of the pte has changed between the opportunistic
check and the lock, a stale value for pte is used and written to the
pte.

Fix by reading the value of the pte again inside the lock, and
performing the check again.

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Cc: stable@vger.kernel.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/gmap.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 31669a5c51cc..837815a7dffa 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -302,19 +302,23 @@ static long gmap_clear_young_pte(union pte *ptep, gfn_t gfn, gfn_t end, struct d
 		return 0;
 
 	pgste = pgste_get_lock(ptep);
-	if (!pgste.prefix_notif || gmap_mkold_prefix(p->gmap, gfn, end)) {
-		new = pte;
-		new.h.i = 1;
-		new.s.y = 0;
-		if ((new.s.d || !new.h.p) && !new.s.s)
-			folio_set_dirty(pfn_folio(pte.h.pfra));
-		new.s.d = 0;
-		new.h.p = 1;
-
-		pgste.prefix_notif = 0;
-		pgste = __dat_ptep_xchg(ptep, pgste, new, gfn, walk->asce, uses_skeys(p->gmap));
+	pte = READ_ONCE(*ptep);
+	if (pte.s.pr && (pte.s.y || !pte.h.i)) {
+		if (!pgste.prefix_notif || gmap_mkold_prefix(p->gmap, gfn, end)) {
+			new = pte;
+			new.h.i = 1;
+			new.s.y = 0;
+			if ((new.s.d || !new.h.p) && !new.s.s)
+				folio_set_dirty(pfn_folio(pte.h.pfra));
+			new.s.d = 0;
+			new.h.p = 1;
+
+			pgste.prefix_notif = 0;
+			pgste = __dat_ptep_xchg(ptep, pgste, new, gfn, walk->asce,
+						uses_skeys(p->gmap));
+		}
+		p->young = 1;
 	}
-	p->young = 1;
 	pgste_set_unlock(ptep, pgste);
 	return 0;
 }
-- 
2.56.1

