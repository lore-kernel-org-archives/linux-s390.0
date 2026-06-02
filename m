Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C983FBB55;
	Tue,  2 Jun 2026 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422510; cv=none; b=g8inbEwQZLSyfULiP7kH/ocmNT2cdW0m8LuC2OY7X50ztO5tlyVC1YAAKBwsPx6I2meNQm6Hqe+USW/LPfrgrAa2TcMG1XE0Z8Mld/Pnk9Z9pln1KOUz02v7cuSf27vO+Chy62XafFpcDfCGd/7ClevRvF/ExvEHV7NymnA1T8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422510; c=relaxed/simple;
	bh=Ocw2gzuRN1sPHvqLz6f6ApKvT0yuMYTpbkUrNmFpM5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VECP2Karcx770Ra+537llDKpNrR/MXAE2wTJoxiIbUFr0lLMlO7xYwXI23dB5WLfoj8YY6zT+OOkgr+HZUtXb1dmsfas6tyYwitkAfjLzU6YGuGQM/d0N2lTyUVUeE4qwy4oCskkbENrtrmP4+JoIu+jOTiHNT7C/z1H7nNT/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qmZCVzgJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qmZCVzgJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652G6MpH3724979;
	Tue, 2 Jun 2026 17:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YCFd9L5vv8wLIwMSC
	g85D2ABGcohd2CAIO8W06EwQgk=; b=qmZCVzgJgmyP4X3OCGqbb3W4II5pj+B3v
	3SPUaLGF9EXaTg74PkdgyE+BG2kywzoaMJp9lllaa+fGnUQVER0LPyWqlO0VCtCH
	kk+YxFZ5rSuzCdosTKMao9LfMBndVXq9/gkqCa+wmSXPoa9dMssdSjosIgKdgAT7
	sTBrjT1AitFS8Aw1oHG2aMXjgwsyLbAzOhTd1RlVTfhWjpRwnHW2kx71U051PqD5
	34CURMG9/gJu6Ukl5DUSzKTeRo13RgRAGgWIIvDDQIlPVxcskPq4Ohfyxp6ZQWIP
	95T5AItKX8J5EzeMUMjWOmfpsnNa9mXa21fVIFGjN322yOSim9V1w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae6ukd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652HdRUA019821;
	Tue, 2 Jun 2026 17:48:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyc4bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HmKD848955650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:48:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E77712004B;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB4672004E;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 04/10] KVM: s390: Fix guest / virtual address confusion in _essa_clear_cbrl()
Date: Tue,  2 Jun 2026 19:48:13 +0200
Message-ID: <20260602174819.255785-5-imbrenda@linux.ibm.com>
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
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=DrbGolfmOjewO6_yJogA:9
X-Proofpoint-GUID: IDQjuD5oAOUTCSfodPAKp73teNmT0rnH
X-Proofpoint-ORIG-GUID: IDQjuD5oAOUTCSfodPAKp73teNmT0rnH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3MCBTYWx0ZWRfX/Eikcz41JPYO
 PC/PklftXCMjsv4cAafAFKIlutPP2G/4d7h2AjJ9N1jbLuo8cuNLBT8tPFVk+MZupDqD1j+TXS+
 3r6kNJnBNXc6qP7TP4tMspVayycJcvjkDixhsgkP0kW0rpySx+0uFaIqi3TogUMQFuOYb2SGcXj
 LLKYiIx8UZf68eXC+u65ooDUKFslnZKWH7wu1XaSTwWyNJl079GvMEyxe8P3Cw/UqvfPUZFWNLR
 KOWhbRSR5sWW7syH6pTG6/5gGtZd7DhqvyIvUxInPSKgXmYiPMNPEyZYEDmZVyDo1kTwKOPLJpP
 jf/0dk8Gc+Z7pgZ+oK0BleOLa0dg/dVB6aXpwQAn6R+TiS/fvIk/yeQs2h+G96LNYmeN5y5hDmh
 auG7bgRvsXjq2f6igBvai5PJj3DSFqBNKdvD2P/jlKJEeN5Q8bLAwdSTkFPTz7/3vw7JDL0p6GA
 2mlmIGXgjJbFBwHxwnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020170

Until now, gmap_helper_zap_one_page() was being called with the guest
absolute address, but it expects a userspace virtual address.

This meant that in the best case the requested pages were not being
discarded, and in the worst case that the wrong pages were being
discarded.

Fix this by converting the guest absolute address to host virtual
before passing it to gmap_helper_zap_one_page().

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260602142356.169458-5-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index cc0553da14cb..447ec7ed423d 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1188,6 +1188,7 @@ static void _essa_clear_cbrl(struct kvm_vcpu *vcpu, unsigned long *cbrl, int len
 	union crste *crstep;
 	union pgste pgste;
 	union pte *ptep;
+	hva_t hva;
 	int i;
 
 	lockdep_assert_held(&vcpu->kvm->mmu_lock);
@@ -1199,8 +1200,11 @@ static void _essa_clear_cbrl(struct kvm_vcpu *vcpu, unsigned long *cbrl, int len
 		if (!ptep || ptep->s.pr)
 			continue;
 		pgste = pgste_get_lock(ptep);
-		if (pgste.usage == PGSTE_GPS_USAGE_UNUSED || pgste.zero)
-			gmap_helper_zap_one_page(vcpu->kvm->mm, cbrl[i]);
+		if (pgste.usage == PGSTE_GPS_USAGE_UNUSED || pgste.zero) {
+			hva = gpa_to_hva(vcpu->kvm, cbrl[i]);
+			if (!kvm_is_error_hva(hva))
+				gmap_helper_zap_one_page(vcpu->kvm->mm, hva);
+		}
 		pgste_set_unlock(ptep, pgste);
 	}
 }
-- 
2.54.0

