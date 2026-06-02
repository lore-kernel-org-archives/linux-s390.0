Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818293B6348;
	Tue,  2 Jun 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410247; cv=none; b=Vm5z3DsXpG7xGymgnuyGwpcq0f1QR4xjnvTzFcafmH5twOA+4VImqH7FD4t7AUu3e/lloPM0vP7LoUWLRtbw0prH7hzxTLDKhrOPxFCmuVuB0QSavnINbkPx5M8eJALk/bBOVbOWWfy+P9+QXfMhoGLeWap0qTISKfVI+Ai8us8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410247; c=relaxed/simple;
	bh=XiJXh/3Iiy/mpxpcoqsz7KBxeWf7PqfU1rlpDGcPggM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/BXdu9LpKW+weo0jol4BDyKZWwODZ+2uc3Kh6GbzE13qaCs2/ASYt7Sd0NKJu0VXwRGOxgcPRgAyGmlpk8TO9JjwbU6gEM6304XuVwRtaOYBvVblZZ+HN2PRsvc/ccrpvDlGCgnWa4oPXm1djjPYHuAEwkQaew8/tTWsGn0Xk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IJekw7Cp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IJekw7Cp"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6524vO5k1020056;
	Tue, 2 Jun 2026 14:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8YKzseVnpG5RIeHhW
	V3ErjTjlQyqbpe49wYU+4K4ONs=; b=IJekw7CpkXMXYQ6H8kB54SyfehziKY42Y
	G1eyP5bCZWsm3BlfKlTNf0Sp8VmigdvcEiCCKPaLwnoC/FO+8T7Lltc1KMsw0o7p
	ay7c7iPhKVRbe/ITJOYSqjX5ruxRJEOmgu46DSZto3iW2BdOd+RTkFg8BRWmZrFv
	yTIi62d4cNbe1yY2WBkFv7n8JJfsEQVFwSKEp64lyeR1T6J+YRq7VKy0zSfBuHom
	NkEo2YwbXnt+YYNnnrCoRZ7JhqoMkGMn3sNvoY4MTPkZB7QBcx+PF/nB4iKHAMuW
	/XACrEpyJXsE07yYBW+lW20ht4C18+eQfmmffamepxX0EH7IG7dBQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq6aux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652DOIWv007350;
	Tue, 2 Jun 2026 14:24:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k3mpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652ENvPj47776012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 14:23:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16A2420040;
	Tue,  2 Jun 2026 14:23:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E11C32004B;
	Tue,  2 Jun 2026 14:23:56 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 14:23:56 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 01/10] KVM: s390: Fix _gmap_unmap_crste()
Date: Tue,  2 Jun 2026 16:23:47 +0200
Message-ID: <20260602142356.169458-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602142356.169458-1-imbrenda@linux.ibm.com>
References: <20260602142356.169458-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: srwHOVlL-bUjj5u-crP5XIhCGHpRatbp
X-Proofpoint-GUID: srwHOVlL-bUjj5u-crP5XIhCGHpRatbp
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1ee784 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=KFDtdd5XBMBq3xqWTvkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzNiBTYWx0ZWRfX77jcICa4YfG7
 q/ediefjkOlyIK3v5E5ifAx4LdGKC3N0QmMjQ5PvkQv3fVL9fx5tEezvAvehg8cZqD3N29QKuxC
 4/0DJSGzAo5oWOW5jaE9Ot8AQqoRtTsM+6ed7Gcy/K7S4p9SoqhdpMEYVOJkWQGvVnPTLx1ffZl
 BGkO7d+JYUec7F5pcya7zrYB6bpgGMd7we5rDsbHa369iC8bvR20acn+mzvIZKOQwuWurNhFyOf
 qPPiR9slLx4us6iGtwOiX8zZleiGeZBPf2cYgnwYD637uwYBEtV7TqOyy1wmLQYc2FB1vvwZsGU
 1CRgT1Fjw9xd4MlirEKg9CpHQiDQcfI3va2PFO4C4Fbg3gMYs5o6Vhz34gUyKlH6bt7Lax67Ezn
 F8sAysx9g3UDZ6PfUHhjwMA55ByPENaIowGyHI+HoGTdadBfi2k+R3Nj6wGSuKQph2SNcOG96S0
 aEJzlGaC696wudjx2+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020136

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

