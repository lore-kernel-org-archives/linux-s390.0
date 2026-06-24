Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE9384243;
	Wed, 24 Jun 2026 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299983; cv=none; b=J/njOTvgYoIqAwt7rls4dmEPstAJkr4YM3an2yyZbFc2ilONUk16cnhHwRyoAUBdFcGqWYPyJpzLCb5/eX2KkJW2ZHfDMglRAHwYGxu5aE/PtDiD+ZRqTq64o3471zOL6inEOoyR7wui/v0mWSpMFLineTSG6SyMr/1Xxss6nhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299983; c=relaxed/simple;
	bh=r4BAkcru/jFlGc3TCVGalfQ7Yu+JL5L+mVNtVKfVA7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jj9qs44i3ATNIqykFNvLMlkHR1BdxzmKdwgQnz9Wi0CS+g5vNPXrvbM7P3rA7V3HY+qLXxgb2ZfjFVZv9Dl5q06z9/BmByjmTOY2Vx4BNnahwjGWCSzZqY+2mw3plClCnw8Nd+didOQedFA+5+XCd64BlRbAzBg9QQxgN1S4Xdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SqtImmWQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SqtImmWQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmPAR644168;
	Wed, 24 Jun 2026 11:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/MyQoXZLoLkjHieX5
	a37w9ncdsE8VSp9Z3MEmXdQQNM=; b=SqtImmWQ6NVSPdiiXGESIOtAVzbJvgwVk
	qrpVZK3Te0Yk6Px5R8lRaVkVm0rzB+joxdfA8VN2ZXj1xjbdFFHSHY8ymIIsdw3V
	tEcrqNmgRws4DYWcJfjEViyNHqx+ma8zFA1D1UQF965RBHjBkHqijhCMzZllxfxj
	j8sFuE9qTTswuKCGmz8xTmuTtmc2iYWUmbwhLfyz8Rfv46aja05+EU0/OafipvLE
	0eFqvD+ItopJYGZYBS/sBFrw8yplrGApxI5dLHj51TTe2Sztq7qY/hfi3qgPpkBZ
	2NhhdJDtlG5dlMcYEn9M3HJWZOYFV5fz9nglciwNmxomREsKXX6+Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4kscq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OB4sTh006040;
	Wed, 24 Jun 2026 11:19:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwgc3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OBJU7F38011322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 11:19:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F0F320040;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E8D620043;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 06/12] KVM: s390: Do not set special large pages dirty
Date: Wed, 24 Jun 2026 13:19:22 +0200
Message-ID: <20260624111928.144283-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624111928.144283-1-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3bbd49 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=0LurFWx9qGocQMs31jYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX1HbmfPZJgatM
 dcyORDh/etLx20PDO0sS/n5DinmQRDDvBfRpTrllBN45GzRJsoT4KMhf1aTU8+04ELC9JXrsXKb
 D/LKWdL1ndEZ3O1MbES6LJhmrqJxOT+AZqKnrU7mu9c/rMMEwGQfGDR/SZZgsSxbB4XXCJUseZm
 Uxiva9snVSgc1i+Bql3rQaSPYAkC5S4YQ6EkslWcVwSbeHIDn3w2X/jPSBf+cyvmpZnMgehGOiV
 h24NsHqj02iwInvhKHUz5hIiS2wpPRsHbqb5ZV5L+mwMN9CyoXcPY4XyusT+548gTC4za4V9Wmk
 kqIN6CxgPEuyscW/4wGtg7Zlkozlp4zCJsVMFTuLb24M01hxNp24rh8Q+CpFjCL1JSJEr30NJcm
 ayP6woziypnGHRNcz4dMJ9qDYkYTXA==
X-Proofpoint-GUID: UcahHe_x0RaEp5iuH6or97Cud5TZgt5x
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX0cA3e0WK0glJ
 39lIVzzgPtNyTVjBvJn3VIE19DTtH2RsqdtETLNg0lp6GOxr3cNd/OLbhG1rGmD7fro5nRCtm6N
 5gRu/HSmSRkHqVsX8/N68oQqfCz7H/Q=
X-Proofpoint-ORIG-GUID: UcahHe_x0RaEp5iuH6or97Cud5TZgt5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240094

Special pages / folios should not be set dirty. This also applies to
large pages.

Add a missing check in gmap_clear_young_crste() to prevent setting the
large page dirty if it is a special page.

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260623153331.233784-4-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 52d55ddea8d4..3192f610f696 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -327,7 +327,7 @@ static long gmap_clear_young_crste(union crste *crstep, gfn_t gfn, gfn_t end, st
 		new.h.i = 1;
 		new.s.fc1.y = 0;
 		new.s.fc1.prefix_notif = 0;
-		if (new.s.fc1.d || !new.h.p)
+		if ((new.s.fc1.d || !new.h.p) && !new.s.fc1.s)
 			folio_set_dirty(phys_to_folio(crste_origin_large(crste)));
 		new.s.fc1.d = 0;
 		new.h.p = 1;
-- 
2.54.0

