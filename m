Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530B3DB632;
	Mon,  1 Jun 2026 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327814; cv=none; b=LfQcLjjQ+fEhIZFKQtytaKF0KaAWGRBgg/a+bzPIbLAWiSNUVDYtl8hqZQ8bMH65OKmTpsKa+0eWeuNI/XAsaWuzy46CBOFc8g3H77TO1QwIg4kLBFdJmzxTFz/mStDyNNwjasvJ8/iihEWt9RKqsyn+ZlsJH1T5hGYNSOf7dKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327814; c=relaxed/simple;
	bh=XiJXh/3Iiy/mpxpcoqsz7KBxeWf7PqfU1rlpDGcPggM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciUEhdwASDzbV6eVb9BCLjIDusq/n8ZngOMh8CeZss7ThgrPh6SbM75ppaDjGM9qT0FDZ4c6fXOu8tnhXoC67bif59xi90krvU267EkZA79tLs1h8Bj+MwvIy072cS937i78Y8G1cXFXxkTmKcYzT7MnJkCcqOvtzD5924PRVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UTn+r7Io; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UTn+r7Io"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6513RppY2915495;
	Mon, 1 Jun 2026 15:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8YKzseVnpG5RIeHhW
	V3ErjTjlQyqbpe49wYU+4K4ONs=; b=UTn+r7IoUP7j7P3x6IkLNWGwpFA9H07dR
	Caq51zl1LadrLLobfeEbGSUtsUIybjSoNIn9nVGo3Es2qIsVBGMuWqUrM8CKczuc
	ERDGNGib3oEcJ+E8m1+HlDd8kGLUKxeOBADfkyhditcRzvpzVIb5hNELkW5h9yMt
	PccMPrR401ziXmKrdKf8D97ueeV3TFA6zjuQuLpxXfAaWydKgcSCOLTFVVnsPjUx
	5JNsPruAWvsEIXfc/zpz5BSWr75z4V3cK/OLg9Y5ZzCp0jPNzQQCGEUUyF4puHt8
	Sdx4FYv2h1ymIjwk/vhBsj8ZPzqF2M15BCmlBHf6gVN4/HcY+u4Vg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd41hfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:29:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651FOAVS031066;
	Mon, 1 Jun 2026 15:29:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvpvww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:29:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651FTqTm30015756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 15:29:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B88120043;
	Mon,  1 Jun 2026 15:29:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 117EE2004B;
	Mon,  1 Jun 2026 15:29:52 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 15:29:52 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 1/8] KVM: s390: Fix _gmap_unmap_crste()
Date: Mon,  1 Jun 2026 17:29:44 +0200
Message-ID: <20260601152951.196859-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601152951.196859-1-imbrenda@linux.ibm.com>
References: <20260601152951.196859-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE1MSBTYWx0ZWRfX3uA1x09ID2YI
 NTpYuGg8LWW022HSL/43Swcc+BEwfXy65AgBP1UGhAbT7RQoNJwo2IkmLL9E8hBtvT0dWlJcS6E
 crk5JM7IqrBj4+CwT2X3q+ulmlbNHNPzR99UchoJyKC/59ig+91IlSqfe4g/RONuvPtaxTlr0YJ
 CUbrHv08WsruOCxkAGCh99VohHOiSJWck++wAa2a++cvL/t7jV5cmpj7rKNo12A7t3Ki9FJywjJ
 frzlDM0lhRhEQCPyS7O5Glu4Oo8aGPtCO2bIK5G/VdJ6MGSKl9XxYIbkLb4Zbe+ZWcM5YktRiNe
 mziGkPBWXUZyWA+49BiwGyTLkBTSHSIYE+oTWLnAsY896wPhsqMCp+LmjQ5jxKZkzBXsyOkijjr
 FZu5drTjWkY9lJy7xhQD3ti9b9tCNTLng/h+w3KTEzU/hxJH3u91P04StYGHDOjfI/bGa6EjiuY
 kwBuPSSJMuMdN+Y88QQ==
X-Proofpoint-GUID: fw3nFwjjX2512l7ve9uLgm2AEB2YE5bG
X-Proofpoint-ORIG-GUID: fw3nFwjjX2512l7ve9uLgm2AEB2YE5bG
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1da577 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=KFDtdd5XBMBq3xqWTvkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010151

In _gmap_unmap_crste(), the crste to be unmapped is zapped calling
gmap_crstep_xchg_atomic() exactly once, and expecting it to succeed.
This is a reasonable sanity check, since kvm->mmu_lock is being held in
write mode, and thus no races should be possible.

An upcoming patch will change the behaviour of gmap_crstep_xchg_atomic()
to return false and clear the vsie_notif bit if the operation triggers
an unshadow operation. With the new behaviour, an unmap operation that
triggers an unshadow would cause the VM to be killed.

Prepare for the change by checking if the vsie_notif bit was set in
the old crste if gmap_crstep_xchg_atomic() fails the first time, and
try a second time. The second time no failures are allowed.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: b827ef02f409 ("KVM: s390: Remove non-atomic dat_crstep_xchg()")
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
---
 arch/s390/kvm/gmap.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 957126ab991c..52d55ddea8d4 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -395,15 +395,28 @@ static long _gmap_unmap_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct
 	struct gmap_unmap_priv *priv = walk->priv;
 	struct folio *folio = NULL;
 	union crste old = *crstep;
+	bool ok;
 
 	if (!old.h.fc)
 		return 0;
 
 	if (old.s.fc1.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags))
 		folio = phys_to_folio(crste_origin_large(old));
-	/* No races should happen because kvm->mmu_lock is held in write mode */
-	KVM_BUG_ON(!gmap_crstep_xchg_atomic(priv->gmap, crstep, old, _CRSTE_EMPTY(old.h.tt), gfn),
-		   priv->gmap->kvm);
+	/*
+	 * No races should happen because kvm->mmu_lock is held in write mode,
+	 * but the unmap operation could have triggered an unshadow, which
+	 * causes gmap_crstep_xchg_atomic() to return false and clear the
+	 * vsie_notif bit. Allow the operation to fail once, if the old crste
+	 * had the vsie_notif bit set. A second failure is not allowed, for
+	 * the reasons above.
+	 */
+	ok = gmap_crstep_xchg_atomic(priv->gmap, crstep, old, _CRSTE_EMPTY(old.h.tt), gfn);
+	if (!ok) {
+		KVM_BUG_ON(!old.s.fc1.vsie_notif, priv->gmap->kvm);
+		old.s.fc1.vsie_notif = 0;
+		ok = gmap_crstep_xchg_atomic(priv->gmap, crstep, old, _CRSTE_EMPTY(old.h.tt), gfn);
+		KVM_BUG_ON(!ok, priv->gmap->kvm);
+	}
 	if (folio)
 		uv_convert_from_secure_folio(folio);
 
-- 
2.54.0

