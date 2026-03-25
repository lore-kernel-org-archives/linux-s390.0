Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5D3FCB1C;
	Wed, 25 Mar 2026 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458810; cv=none; b=e/VOcwNSjaoI77XZE77bkG8Mg5mtYS6V3idBxmsV3YibeRBemUILMK7vEQBrsGUw5yOzgw9a7y++rGkKUvzZl9mpPZL0QbqHbMsLgGcfyxofG6iK3uJtLAZw8cozCctyxjxUo9N1PbATXesIlTlweKDVgJbQqXcODgrk2zp385s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458810; c=relaxed/simple;
	bh=TUIP8O/Lmpp9kp3YWRLfpndaoRJAsPL8xMtXjD9HidQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bmdq4NAet7l422K5XSjcQ9EzR7wH03PtKurydg/VQ7WFHmwbaIR0DPjPKQudOnt1wdsPkeDJ70FRZzjzq3FaaV7ncVyGwic7NkSvcTUNwiZx3fMvF1k6BgQouoOKhGVf+W7TTCP1jgpiQNnw3pSLzIm/N7diwUHBoILVrBZ/V70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zo2sRYaM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zo2sRYaM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PBXv0i618716;
	Wed, 25 Mar 2026 17:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TPCEcBpmx9auzUSLj
	7LRAxCfvlT/PVkVjehko+uH5/0=; b=Zo2sRYaMLREAmFKd/fVZ62T4UCJrspweE
	SCAqgjq20SpgAyYMhbwHnPW6CuYRu1za7S/VsqC8bFs1YVYl4EFtYZrYA+1yEV/d
	YjQRR3x2nngrG1bGZ5wM/rLYroWIYUHWHNIN6zFGSOTDcMKEm9hYjE0Dso4eFQl3
	i6b/LdbHxccly7NByhbr8kitFhuPReeIqjVoPjBnWcCqvrX1VfAPqVz3xDujkexg
	iV7SuBU9XX+rEmV2429/7StaK5JKs6Tqsc8QZwWbUQ4e+3KNXReTA4Qyq8y3PDMP
	YDOB1Zbz/xv/mqplMYtpGciNATcEgxc9QgHFTuePYQLlJklQG6GJA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty1hkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PG1BRd011824;
	Wed, 25 Mar 2026 17:13:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk79c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PHDDvF44040588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:13:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 930F620040;
	Wed, 25 Mar 2026 17:13:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6674520043;
	Wed, 25 Mar 2026 17:13:13 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 17:13:13 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v4 06/10] KVM: s390: vsie: Fix nested guest memory shadowing
Date: Wed, 25 Mar 2026 18:13:07 +0100
Message-ID: <20260325171311.182210-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325171311.182210-1-imbrenda@linux.ibm.com>
References: <20260325171311.182210-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c417ae cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=qWq0Kag4T7NBTqZ9-FgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyMSBTYWx0ZWRfX4vcXyDNEObCC
 WzdaPZFdFP8L3oy0kOTJhtqPMRbKPYoC+Aw2X1EtyBs9LRsEENuVGnNZ33Lh891Im3O0mUCee2m
 dljhVAkMbsGnRhgMRz4bQ8/++A08pWVxHOH4hFJsiQ9cn9byUGWTDpju7FnaIMpY4tR0i8HK+w5
 /zRKvpWrb5wi4WX6EGPJZPEEB6gKN9Y2Mkx03GbRAw0/8EIxxvBVCrE6s2aIDlejR30Q95RxNdR
 H6uuXbh3rBl649Ow1KrRlquOAL3U2hKVPYHjiyd5W5ddp2IXUFfFNfsWO5m/GulRXEiUwy2yIX8
 cTsS8aJzGYBigsJJpImR7NVrPjtg/PMPA5dzMzsRWmidcGwhe2gditS6xk+7Oc8X+EEQ+pUVm8F
 cAXuTtk2OQqVMZZlLQFBGwNH2SlxY33Ie6VOLN39WTBeb8QJdIZ138XUq2bjswWQf09dg3qRM75
 8ighdEX5U/GiZ2oulaw==
X-Proofpoint-GUID: ysqmxU_ZB-yLVL-UzdrHjJTqTDwp_LGb
X-Proofpoint-ORIG-GUID: ysqmxU_ZB-yLVL-UzdrHjJTqTDwp_LGb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250121

Fix _do_shadow_pte() to use the correct pointer (guest pte instead of
nested guest) to set up the new pte.

Add a check to return -EOPNOTSUPP if the mapping for the nested guest
is writeable but the same page in the guest is only read-only.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/gaccess.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 8fd690255e1b..6655c214f2d7 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1436,10 +1436,12 @@ static int _do_shadow_pte(struct gmap *sg, gpa_t raddr, union pte *ptep_h, union
 
 	if (!pgste_get_trylock(ptep_h, &pgste))
 		return -EAGAIN;
-	newpte = _pte(f->pfn, f->writable, !p, 0);
-	newpte.s.d |= ptep->s.d;
-	newpte.s.sd |= ptep->s.sd;
-	newpte.h.p &= ptep->h.p;
+	newpte = _pte(f->pfn, f->writable, !p, ptep_h->s.s);
+	newpte.s.d |= ptep_h->s.d;
+	newpte.s.sd |= ptep_h->s.sd;
+	newpte.h.p &= ptep_h->h.p;
+	if (!newpte.h.p && !f->writable)
+		return -EOPNOTSUPP;
 	pgste = _gmap_ptep_xchg(sg->parent, ptep_h, newpte, pgste, f->gfn, false);
 	pgste.vsie_notif = 1;
 	pgste_set_unlock(ptep_h, pgste);
@@ -1477,6 +1479,9 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 		newcrste.h.p &= oldcrste.h.p;
 		newcrste.s.fc1.vsie_notif = 1;
 		newcrste.s.fc1.prefix_notif = oldcrste.s.fc1.prefix_notif;
+		newcrste.s.fc1.s = oldcrste.s.fc1.s;
+		if (!newcrste.h.p && !f->writable)
+			return -EOPNOTSUPP;
 	} while (!_gmap_crstep_xchg_atomic(sg->parent, host, oldcrste, newcrste, f->gfn, false));
 
 	newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, 0, !p);
-- 
2.53.0

