Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C636495F;
	Tue,  2 Jun 2026 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422510; cv=none; b=XIFPopGh46zVkj59Y4BkZS7GNG6FsuYy7A9/7r3oShbLs/5QJJiBlwyFvvjbAXnxoMpYbyg8ISjQCKoTBb9ckpk2PzJ2AszHlNo3ETOqP2QxhtuCHLzHC8IiLbiLfE0FNrU7+mf3fur6ixuVxtt46zpgWOB2VBIYYwT1KFz8OaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422510; c=relaxed/simple;
	bh=1010rjQSqWgjhCXqcQBMzd4aMyNe7OMtlFdN9TKBmwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goisJj3KVnTGpNV2Uk/8KtMQFkiFuS1U8FKErsmVSkNTi6LR8zARsYD6UCVVQxD3k9N3UvzO2aUEqvlbjGvFAaEik2BZm7wJHsvU2I6tdcwpZANK9PBSR3MbIEOQZ+7oPBeWYAbkdPWSx4H7qvDH/F4xQK0wgTON/hmhdl3PZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MH0ku/b9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MH0ku/b9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652DKODF219827;
	Tue, 2 Jun 2026 17:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=t56cNz+Yl3RXQVmD1
	RnmxJY+wN68i5knx/dyEg3KsY4=; b=MH0ku/b9pU1g2NWOGV7fDWRi18rYAcxqB
	LAcuR8ZfJ10fa0uZeTb3jwODlxBYXm4vV9itpD6uqGgu1bAsC0BjJ8zqsdVmzSeE
	u7mKwwrnkphXKBNzgw+I9r8p6PJHRnb6QWO6pzUSgygcxKZPLgcmfRh4cE+0EuvZ
	QdMcC8UFpMbdLhsxSQc2lh9Ef/fWxrqzxl/IjklaHBCOqbDIFJrjMXHlhx55veFU
	+E4G4fyZXKrAbqliJ8Z6449fxtKGJV2DYi4MUlZm813f5phCvekMezS0QU+YL3P9
	wFJersMusXQE0w1p8z8phba4dmkAIVvwuKqbOzIw6bGAEm92g1EHQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae6ukc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652HdQvW000536;
	Tue, 2 Jun 2026 17:48:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhcatv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HmJvK12452330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:48:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3A2B2004B;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 863C820049;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 02/10] KVM: s390: Fix _gmap_crstep_xchg_atomic()
Date: Tue,  2 Jun 2026 19:48:11 +0200
Message-ID: <20260602174819.255785-3-imbrenda@linux.ibm.com>
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
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=SMUcQ3FjFaoWpPRfvsEA:9
X-Proofpoint-GUID: wPT6hxpRbT8aRB6GUswpZBRi0dvOeW13
X-Proofpoint-ORIG-GUID: wPT6hxpRbT8aRB6GUswpZBRi0dvOeW13
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3MCBTYWx0ZWRfX92OUYc6VrLxk
 ZU4T6FMVTUNPtHP3LuHJiJ8I0re4Li7g8qpvY45Vgoiv0rUwkkfye3bU99LQkHVkzQAzTbRatk1
 tnehYgLCUN4Ak3hKG2Zj/dLz+yJ+GXAmt+x6sH4VTZs/80dq36F6nflgpGntzJyZbg61/QycVIg
 QpGXZeoFtwT4nndM1juIo7cdT/2n7ld+mDI2GGWU9UEUn7rp6AcGaEVX/X9XQFaBfPGLpJptOoA
 rl19qsso5aH8fIa1xGsUJxp35o+bbgOOS2OWH9TYkBBlk/Hs11Og4WE7zDL+Zh+iT3nTgQ4R+/E
 6iofhQn77/0CtA4McerV0KkUE5gfnVSE5DeFGjIRaV7gLs+MZIFJcWlqTY8Y5Reu7OiYDhjSFiO
 rfpL85LcDwNQMYn4VdzT+r4zGbNHzyqS1FKHs0B14wYerH3l7NYJZPWxC7kNHn3JvIrAzBjhlM9
 K5VfUUTBk0r61qYFEpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020170

The previous incorrect behaviour cleared the vsie_notif bit without
returning false, which allowed shadow crstes to be installed without
the vsie_notif bit.

Return false and do not perform the operation if an unshadow event has
been triggered, but still attempt to clear the vsie_notif bit from the
existing crste.

This will prevent the installation of shadow crstes without vsie_notif
bit and will also prevent the caller from looping forever if it was
not checking for the sg->invalidated flag.

Fixes: b827ef02f409 ("KVM: s390: Remove non-atomic dat_crstep_xchg()")
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260602142356.169458-3-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 742e42a31744..5374f21aaf8d 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -273,11 +273,14 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
 		gmap_unmap_prefix(gmap, gfn, gfn + align);
 	}
 	if (crste_leaf(oldcrste) && crste_needs_unshadow(oldcrste, newcrste)) {
+		newcrste = oldcrste;
 		newcrste.s.fc1.vsie_notif = 0;
 		if (needs_lock)
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
 		else
 			_gmap_handle_vsie_unshadow_event(gmap, gfn);
+		dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce);
+		return false;
 	}
 	if (!oldcrste.s.fc1.d && newcrste.s.fc1.d && !newcrste.s.fc1.s)
 		SetPageDirty(phys_to_page(crste_origin_large(newcrste)));
-- 
2.54.0

