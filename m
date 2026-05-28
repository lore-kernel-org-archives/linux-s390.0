Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359453C3448;
	Thu, 28 May 2026 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968859; cv=none; b=Nnrpx7s6izWZW4cn0t0XtnNDbihC6RQ/BJ7+kjkB+YSMFI3RreE9MDytSTx0EEGwg0A7u/LQEzgclS7hMZRsYF0qWG0GSo3P9zFnO7axfvYRo4gcRzQhfa8YNGaihRaXYfGQTBP6i9Ld7XNY4TFFlHFLeU+TbnU534QGTIbto7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968859; c=relaxed/simple;
	bh=4QbUygGBfPN/90jpuHlkX2BooX7/mhiF/z6oFBHL0iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxNIXlE33Gzbl/ZnI8s/8eaetDBt4aYouV90SGhFG647vB4s8VVc83dpzYl1RLzqmQpCM6B2ADcsmInOEs5Ycpng0Kc2iJaPyCqtuT4sMwo5l9rCbstqHrx3ydDCNBl1ZYmUt+SKjkxYz+lOkMAKhxuJnYWVyyj9+kPl8IQkxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tcnufYVQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tcnufYVQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RL7G4i035843;
	Thu, 28 May 2026 11:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5M3i/CJFeusXdKzJ2
	7DQX+/89Mnp+A7QQ2sAWnwLmKw=; b=tcnufYVQ6KRR+NSnHagll+Z6LRH6Gtxzh
	zsTHF4MI75hR9CiMrJR+ee+Eg4/A5Ms1PQVb//QMzqUUM8MGOfJCCtR8AhiYM+WU
	VKd5vNRRwW++btIJsXHDcokRrnUz/YZKNHPEzMbv8fZpIbrhVfZ+SlUdYAokeM2S
	fb7quozV3Pv+vK8C6q7cLln8TjscTbqW3ibuPW+j4N7x0cNB/wJr8wNjmgxVODQ5
	FymdNrv1GZGET6r7Po1KxqdFDJ6gTYt4+NHNpORyW8OJjfAZ0xL6OEqhh/WV6sWf
	UAot4j7f292eHrNnf9rOBLNPzqoR49E5C08dP6fouiNK3raYxNWaQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bammk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SBdLwD007521;
	Thu, 28 May 2026 11:47:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb7w3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SBlSow43581886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 11:47:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93B6820040;
	Thu, 28 May 2026 11:47:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 596E72004B;
	Thu, 28 May 2026 11:47:28 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 11:47:28 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 1/7] KVM: s390: Fix _gmap_crstep_xchg_atomic()
Date: Thu, 28 May 2026 13:47:21 +0200
Message-ID: <20260528114727.142178-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528114727.142178-1-imbrenda@linux.ibm.com>
References: <20260528114727.142178-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDExNyBTYWx0ZWRfX6xzL7IeammGd
 IKSOg8zKqUDaPJpuUzn5aEzBa/SBf8LDyP/XVDnmOdb9iiWDw5UDJPzrZTd10UdFcFOOFbMY/RY
 pP/vLBab769Z2YHPBo5wRWbOvj5NIPvW+U6K7UgJKY5ZWVy252SWpTQLSkV8qy4zvMVZen7Fkpk
 1Bk8KtjiwdvptL0wyaYlg7/4vxS8VT5YYtjm5e9AaPwuqiaAvj7wEMRCCPIq3NVklY+rILtkNbs
 bIHoo+syFP0m7ZCNYldeD7nQy2lLL3xj98dpxRIcwgN4t/yPiCxko7LGZO2thUzD9oscortt/0D
 qD0ngSH6gDCd2bixVH8InXJfcmrkCHMWeM9XaoEca+bh55F2luEqhp0EXF/K0XBiEmWOxbM/g3Z
 Ql3ELscqpbnPaCE+vZSccdw3psXkw1GBVQlRhFiaBWCMhUQqinc53jG1djfl1FKpdTm926hnHi/
 FSgneRW0rumr5VzaiYg==
X-Proofpoint-ORIG-GUID: LhLdN16e65mR9dvtr3cI98PfwQR3C8m3
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a182b57 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=8n31qW9GTWRDXsIo7y8A:9
X-Proofpoint-GUID: LhLdN16e65mR9dvtr3cI98PfwQR3C8m3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280117

Return false and do not perform the operation if an unshadow event has
been triggered.

The previous incorrect behaviour cleared the vsie_notif bit without
returning false, which allowed shadow crstes to be installed without
the vsie_notif bit.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: b827ef02f409 ("KVM: s390: Remove non-atomic dat_crstep_xchg()")
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
---
 arch/s390/kvm/gmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 742e42a31744..122ed8566314 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -273,11 +273,11 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
 		gmap_unmap_prefix(gmap, gfn, gfn + align);
 	}
 	if (crste_leaf(oldcrste) && crste_needs_unshadow(oldcrste, newcrste)) {
-		newcrste.s.fc1.vsie_notif = 0;
 		if (needs_lock)
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
 		else
 			_gmap_handle_vsie_unshadow_event(gmap, gfn);
+		return false;
 	}
 	if (!oldcrste.s.fc1.d && newcrste.s.fc1.d && !newcrste.s.fc1.s)
 		SetPageDirty(phys_to_page(crste_origin_large(newcrste)));
-- 
2.54.0

