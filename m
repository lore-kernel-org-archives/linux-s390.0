Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5D3CFF52;
	Fri, 20 Mar 2026 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023353; cv=none; b=qpUlNBm2XYrc1+9RrRqVhOZxFmYwx1mwjGHeYr16DPj8EzADeN3FFMBzlFw3QXZxxigGO2DxXRXMc9hdvWSu4eW8ah5z7TICjTuBh+qBp/TKeu5iKwEx7TsgQpqHuIMR2Vxwmb1cJSmBNjOC8S/3JSuEBQKQX1HkHsuUKc8aM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023353; c=relaxed/simple;
	bh=9LLxPughLm+7sXf/LYwlHmtJ/qYU8gc+9FkS/KNpYVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK4POu6nm1kQ9OeQKTWtSrI6gi+0iYq6npk9882LuFEq1eFngSVIzXRsgrSg8HaPlUnAh/4DmGSWQr1Cs+iUk3XQryUA0V1P1AnAuR3xonzMS/8xd0oQasLGAP6g2ZEv9jCUKG6SiBk9qJtp2GTTCuxhK7QHniwXTAf6XF9Gl40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pArr5/g+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pArr5/g+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KFdcUo3984736;
	Fri, 20 Mar 2026 16:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iy0O7AgL5jwXmTvNw
	kNv5LRHBzAbfu0EojsWXXAs1vk=; b=pArr5/g+V3d2TEKmrZ+0zDm9ZZjB1rwMn
	LTarDZGbqdvjCtD+SFaGgQvxCZmEs4gotssh8vsxkf+spfPU7J9yCee5p2U1wApL
	Hg7xwWgTAv07b6RnOHxih5p5XcOs1CndZ0X8HHX8GMQpI4xg6Wg2mffcEJxQDcHC
	2/7WnL2AE2bw1ySiI9LHXEIKIwaR2WLfUjWutP8W/TCRMHY3rYkDCdp9hFPyH8rf
	+E2b2H9yjr+vigrJX/JH+dotde6hVr12KGgMboZDLtQ3mtVtTWg9dC1XjyC81luS
	KwtUUNtVvS6y+1Fkza6YuWhbfD86qAi0zAJqs7Aylzp7D9PvVl+9A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3dbejf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KE31nc028501;
	Fri, 20 Mar 2026 16:15:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1qmvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KGFhvP21889292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 16:15:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B49CB20040;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F8B92004D;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 7/8] KVM: s390: vsie: Fix guest page tables protection
Date: Fri, 20 Mar 2026 17:15:41 +0100
Message-ID: <20260320161542.202913-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320161542.202913-1-imbrenda@linux.ibm.com>
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69bd72b4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=_xOeJ_NdDjmAqN1vBHoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEzMCBTYWx0ZWRfXyoUZIm7FJ2bj
 q95UnAlOeRW4L3Y7WDmR/E3nWxwzAQ40J7jO9zbhuoNTqcizmikgJC0+1Y5NtgaS87067i+hjyQ
 adUWlqULI09zvqZ9+VFv2zfQjze6r1qYfuoP/6pmLC0t8/u/U8ZrsE98X4f/+QGUON1gOMmccQK
 rDVKnqTe0fwk5Ty5LCjObHXDUgiIHP/Tz4t2ll3H1eBv6c0Ndp8bBzSCsJCPGrAUl4WjHV4fqfl
 3/KCH8gfXPnuTy/bXu+/Xg4l57byY8k0aOgwbiOGan1XOHo5m3dJG2MkJUyzlfO+bbGDkbdZ//b
 tTuarH64U/3msKEBXDGFtE9uyG7Nb0uOvmjr+BnUoaZ3clOFMuwBQ5XJISt8ThfpVztnrkHLIHi
 HugLhHjk9NqVonxdwMzbzdB6ot5KOeWTgX7CNUuHHpy9rcO+M42jXyISNN22PDuNLtyc7p5Ops4
 D5e0TBAhN0IlcHAa2hg==
X-Proofpoint-GUID: TijuISa9QL0hWkWS2GPUsHNHyV1w992P
X-Proofpoint-ORIG-GUID: TijuISa9QL0hWkWS2GPUsHNHyV1w992P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200130

When shadowing, the guest page tables are write-protected, in order to
trap changes and properly unshadow the shadow mapping for the nested
guest. Already shadowed levels are skipped, so that only the needed
levels are write protected.

Currently the levels that get write protected are exactly one level too
deep: the last level (nested guest memory) gets protected in the wrong
way, and will be protected again correctly a few lines afterwards; most
importantly, the highest non-shadowed level does *not* get write
protected.

Moreover, if the nested guest is running in a real address space, there
are no DAT tables to shadow.

Write protect the correct levels, so that all the levels that need to
be protected are protected, and avoid double protecting the last level;
skip attempting to shadow the DAT tables when the nested guest is
running in a real address space.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/gaccess.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 1054f9bd107f..17563f889c6b 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1517,13 +1517,15 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	 * Skip levels that are already protected. For each level, protect
 	 * only the page containing the entry, not the whole table.
 	 */
-	for (i = gl ; i >= w->level; i--) {
-		rc = gmap_protect_rmap(mc, sg, entries[i - 1].gfn, gpa_to_gfn(saddr),
-				       entries[i - 1].pfn, i, entries[i - 1].writable);
-		if (rc)
-			return rc;
-		if (!sg->parent)
-			return -EAGAIN;
+	if (w->level > LEVEL_MEM) {
+		for (i = gl ; i >= w->level; i--) {
+			rc = gmap_protect_rmap(mc, sg, entries[i].gfn, gpa_to_gfn(saddr),
+					       entries[i].pfn, i + 1, entries[i].writable);
+			if (rc)
+				return rc;
+			if (!sg->parent)
+				return -EAGAIN;
+		}
 	}
 
 	rc = dat_entry_walk(NULL, entries[LEVEL_MEM].gfn, sg->parent->asce, DAT_WALK_LEAF,
-- 
2.53.0

