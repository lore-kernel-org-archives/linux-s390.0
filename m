Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41440825A;
	Tue, 24 Mar 2026 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374213; cv=none; b=b3SgKcB95tTSg7d23LGiMJ2UPzTQTdxPyx+dxz9KtLcuuVYJE2pCKT7gOtjq/Zpp8MqX1UZfdmLMA4VV0tQD76mvIuOR9XYnVhkngdpNzPLrJ1pIRdrtyrZrf03BX5ib6dgfVPJ6FPBj54ro5ow1+jvXnHQUTwXH6Wo1ccoXhTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374213; c=relaxed/simple;
	bh=2FFG5PWZUjng06lfMkc3vXvKO3PiSocEQu21vSTpMVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kR8Q6hVVR2jtv5doXuMdDhmOTqKBdaNDsIIpCLxFO+SiswzUtIPKzbNv9LyaDc2sNNSRT87qMq18GEl5+NJ6bvacp4Ps7gK80XFmytPt0Gg+r50Ytc7XE6UUIFIXn9A7u1oFSNeMuCBNOvUtI/5fTxkfe7uaS+q+BipmFT8oT8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cpAlMXFx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cpAlMXFx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OFnHwA4115693;
	Tue, 24 Mar 2026 17:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eQDWFxksAgzoKtvrt
	eYUE92VENhC3nHdFpzzuFnPjMA=; b=cpAlMXFxGyu/oH0OnqalvF3sw/olq6BYo
	ySm2zRu+5jMSFgmTj2PtJrFlmJwtv9lDmd2muyWSdbWsF4ikkkXSAjthUmdHB60x
	Y9/t1sXtRfLI45+7hkVL5CNTEQt9XDV4Qcm9nviEMTrAWp+Fu4+CWdHnKfKQXNa6
	OvdCYETuQQPH1hXoKKd2v1nvEJH/D3KLoBmhcTNbtl6uo9eIGO2wL0NmE7VBLS1l
	kIAPqSuvQ3HU+5d65DQVDR2+vrkjDRkRqNaX0hxRdXoAyXp5LD5jxtxz32bcHMAH
	RLEyMuVi2+7k5sqR/IzFtHF/GoHaxlAs4CevsLOFXkyiBEhy54Jgg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuv9sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OGHYYQ011824;
	Tue, 24 Mar 2026 17:43:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk2w89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OHh9qD46465404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:43:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F33C520043;
	Tue, 24 Mar 2026 17:43:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6F7E20040;
	Tue, 24 Mar 2026 17:43:07 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.26.26])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 17:43:07 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 4/9] KVM: s390: vsie: Fix nested guest memory shadowing
Date: Tue, 24 Mar 2026 18:42:56 +0100
Message-ID: <20260324174301.232921-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324174301.232921-1-imbrenda@linux.ibm.com>
References: <20260324174301.232921-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G83uT9_G-yK4hfY_x1x7tVvm7Bz6PgpQ
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c2cd31 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=KVoM4faz5-s9vnlyq5YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzNCBTYWx0ZWRfX8kfoYCdkTtQb
 HD4yyuYp/R4Xbds5FBhA4cOmqe1VR066lKTEkBdP4wzma8fDFwiw4T5kYMcVkkzvBu8aeIC+FDZ
 4o9sP1RjDLkAFyDh2lVDA54zLwDhsbhyQ2876enW6q0GeO+AUCcpQPMNxkYDWeYjuBVeJZSQ3Fe
 f/1+hIbg9ymr79J4K+lESK3+DGecL/WJqcBxo1WOMgoRrmc9DFXIBwMiqNj+kcbQ1n4EDebVIxo
 9T3wo0DCsmrcLJbv4USwWF4zcv5RKH4d5WNvML/X1EbFA4v2opFb57Wr93f/q1rbY2ns9SliMVb
 isZvgWxxJVzoZTsARzXm6CyKfUn54G6zjebrVkFffHOfdYEPut+b1b6MZ4q2CROWvpZCs9IYz+I
 MVwzj0wrO3rZpGJwWvsncAn61EsjDQGmQCB0H5k+ViapAjr3WRuHcyRtSKFwoljQKQkhbtW+zrC
 x5v30N3HVnU8P8zHu+w==
X-Proofpoint-GUID: G83uT9_G-yK4hfY_x1x7tVvm7Bz6PgpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240134

Fix _do_shadow_pte() and _do_shadow_crste() to properly mark the guest
page as dirty if the shadow mapping is writeable but the guest mapping
was write-protected and becomes writeable.

Fix _do_shadow_pte() to use the correct pointer (guest pte instead of
nested guest) to set up the new pte.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/gaccess.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 8fd690255e1b..70703bf866db 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1437,9 +1437,11 @@ static int _do_shadow_pte(struct gmap *sg, gpa_t raddr, union pte *ptep_h, union
 	if (!pgste_get_trylock(ptep_h, &pgste))
 		return -EAGAIN;
 	newpte = _pte(f->pfn, f->writable, !p, 0);
-	newpte.s.d |= ptep->s.d;
-	newpte.s.sd |= ptep->s.sd;
-	newpte.h.p &= ptep->h.p;
+	newpte.s.d |= ptep_h->s.d;
+	newpte.s.sd |= ptep_h->s.sd;
+	newpte.h.p &= ptep_h->h.p;
+	if (!ptep_h->s.d && newpte.s.d)
+		SetPageDirty(pfn_to_page(newpte.h.pfra));
 	pgste = _gmap_ptep_xchg(sg->parent, ptep_h, newpte, pgste, f->gfn, false);
 	pgste.vsie_notif = 1;
 	pgste_set_unlock(ptep_h, pgste);
@@ -1477,6 +1479,8 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 		newcrste.h.p &= oldcrste.h.p;
 		newcrste.s.fc1.vsie_notif = 1;
 		newcrste.s.fc1.prefix_notif = oldcrste.s.fc1.prefix_notif;
+		if (!oldcrste.s.fc1.d && newcrste.s.fc1.d)
+			SetPageDirty(phys_to_page(crste_origin_large(newcrste)));
 	} while (!_gmap_crstep_xchg_atomic(sg->parent, host, oldcrste, newcrste, f->gfn, false));
 
 	newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, 0, !p);
-- 
2.53.0

