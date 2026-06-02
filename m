Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3582A3FD973;
	Tue,  2 Jun 2026 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422512; cv=none; b=ayx/F5DNi00qgRNsrkaa+xNj5AuJRF3If8Gh7/FTCvkPQ/N4SkzgA/Hc4WonQZkmCKhecC21Wud8jSURY/Z//3/jBbeZXZFBG6ZmIZZakYL2lJDVW8H2Jgep3GorQJsExAse0AW47AULaG4rrojOypz1EBy/wG/6v0VxKTgeXpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422512; c=relaxed/simple;
	bh=JUqEOO2x0yyQzTW/2ZECCbFUpA3rNeowOzU6KuvpDAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4XsQ1IWk5wlDcFHVaH+i1X+LYga67rjM4zrSAN1OC5uW8ltCqAn+eFSzGW0n7mVBWOqib7B7ZF2X+IttPjFAm1piYl9Brm6QQgRTafuMO/CJnbv9w1+yOFzA8+eD4ULIX6nntG+H+fy/A3c/e9mV7QoVNWCPiY79Hlw538araA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m6vqOLMD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m6vqOLMD"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65280F4r2905913;
	Tue, 2 Jun 2026 17:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=79Ycjh6J0niRwtyJn
	rMD6NRoinmp/eSFTbvZzCV4Vug=; b=m6vqOLMD/+pYrAa0seOEYjXyzB2+pBR/D
	nZpWfpSrvQ6AC4hKEf1Y8qTXhq9DjYG5ToCrQF+Kt4MeT9RmWQt332iURSZXxLkR
	sTbx0nK1Sh2dVwkGa3RzMmFxw1JWEEwQ6ZD5WYFtXZsPtQ2FDiRhwxrNA17ZBFiz
	7hTNcx2Y0xL83zRGpVkBq8Mxj8OjohqAD5cgHzLV4NZJ4yV8JYpdrmSiV/yXGKyu
	Fgbu2RMCSbeOrvmG9JvVRzjMmmPPRiSNMvSbahh5Xivc8sS2tsZ1k0nR2bKuD+Xp
	AGfj2PZAEeltle7hn8gQdbeKFRI9Kn99LTl4Fi7Os3DZRqR06rGQg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae6ukb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652HdOmQ031100;
	Tue, 2 Jun 2026 17:48:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qcm9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HmJm831130122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:48:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 807C520040;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 634A32004B;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 01/10] KVM: s390: Fix _gmap_unmap_crste()
Date: Tue,  2 Jun 2026 19:48:10 +0200
Message-ID: <20260602174819.255785-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602174819.255785-1-imbrenda@linux.ibm.com>
References: <20260602174819.255785-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1f176a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=KFDtdd5XBMBq3xqWTvkA:9
X-Proofpoint-GUID: V5cYnMKOn9Y3Jf5yxq7QEfy59FriVm6A
X-Proofpoint-ORIG-GUID: V5cYnMKOn9Y3Jf5yxq7QEfy59FriVm6A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3MCBTYWx0ZWRfXwdfqnttgDLD3
 uJ4Fp13wmOFJkPilOTTZ69G8Sqjlg/sv5JniRsMUX9Bovp52HBGQPkU+PonMj6H09pyDx7kvTJZ
 kL2i/LW6//reCNrZfr0+Z6RJImXMIoUb7ziJXpRayoASKOTz5P1jG/pnHSYrpPGy+RB2XAv0GTh
 fvkl7sT+kHkuQuKiktZkz7Wa3WKRkl0KAWQoDuhThFsaLFoRIWPmBknkBOSBgtWgOosgaDKyTO6
 DxYL/BEjuqePR8XSGGUdRfgwUbHxP3cyzUK9SUTSbIet84FlRKlGqPHWgVLqG573fObsO9Ce1X+
 TUKa+jNTofMf2ctGBRYKNiTgBQ9n3lQZKV7m/qX+jJDW1nkWC/mhX4O3fFj/3rYMqgmx8gqfACV
 GQQ1F4K0+jWjE2opHXSW/hRJD7brYrFgn56FwwwBNevIKTGLougZyJdgv8tH08iCw1tXthkyY2/
 XQxlEm3z5ADl7eq2f3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020170

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

Fixes: b827ef02f409 ("KVM: s390: Remove non-atomic dat_crstep_xchg()")
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260602142356.169458-2-imbrenda@linux.ibm.com>
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

