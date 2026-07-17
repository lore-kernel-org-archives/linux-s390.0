Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD886352023;
	Fri, 17 Jul 2026 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295158; cv=none; b=r69tgXWoRnOzmIH1870S2PdAFuJlLx6vyoLBwMlekvHEuUBRptTplWrO1hdBvy5Y/WSadug6wkhZmIwYfl0bNZr+oPh1zd3J2YDo12WeRbBRJS7o1gn8Jwg2M8V8RVFn4/v5LQI2mV335IfhW+NTfrs91kLZU/RJYUElF4a0/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295158; c=relaxed/simple;
	bh=xdcHg81gHsuYnLujRUBA0ajvBDm6zaWm/hEbY789ZUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUOa6jhDQbUShbEHBu9ZIHe3mSX+IheFEc6p7qO502xg9MqpUFRyDLdbwYs/pRz8AvFlJL3nx4+GMYyJWRkI0AZC8SXQ6IdQ+LVFDybqGlIcKzlychCBJdFebTlbexPSzg5AqDjW9TBT87tC9t/esMNhlVGgBeEhwNJ8bCl0ies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BWGUdR/K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BWGUdR/K"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCg95O2057668;
	Fri, 17 Jul 2026 13:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hv3MCqUl10qHtcMMy
	BPEBq70OO1Ou5CXW72neiXa7f0=; b=BWGUdR/KoyBCcKVqRpwUIrKMHJEXCpzo7
	Fv9gye7RnnX9iAT1JZSvAkb9TmbiCawPjJ/iG2q2bP0F+qE2ZEdd46hxSqrsPmVj
	JRuFQ7P0caExpO1zOtEpkBRsdx1BrtgBRsrWdCJ9kwZUu268FnHuhBKgmYOToA+p
	f2bBCewoAxOEtn4lRYTOH87joGJ8EeNtwbOPGzLtZs9AXJrpv8ds4BmR2k6iShfW
	ZoAP2GIAzxaNyKfKvuodBQQGXpbIG/LUOICX/Vxp49TTgHQIzyFWBoAhLzMFw75f
	gzrAgAWfb92fEWe/3TRTjL+ZeqnMOMPYs7ekJ2UJ2u3akfp9k6smA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtpqkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:32:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HDJh9p002357;
	Fri, 17 Jul 2026 13:32:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgsnus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:32:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66HDWNh050266490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 13:32:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E733720063;
	Fri, 17 Jul 2026 13:32:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7A932004F;
	Fri, 17 Jul 2026 13:32:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 17 Jul 2026 13:32:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 9D76C162754; Fri, 17 Jul 2026 15:32:22 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>, Chris Li <sparse@chrisli.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
Subject: [RFC PATCH 3/4] mm: introduce __ptent sparse attribute
Date: Fri, 17 Jul 2026 15:32:21 +0200
Message-ID: <80bfffc76cb5a270aeabda26f50f65d10742a1df.1784292223.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784292223.git.agordeev@linux.ibm.com>
References: <cover.1784292223.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4icc14cu2ighxfl6FYrzqzdyrQx3mEWV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzNCBTYWx0ZWRfX4Bm51xaL6rTi
 EoPU+wFi1ueRET11r1OsI8V/rbxrp0TbXSv/SuFljLrsDNIhjEoHQORIkWofKYC5a/ohNs6Idsr
 UaYO/00+2/vfJlZIkJtyJJ8uxlMJXkk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzNCBTYWx0ZWRfXxPMds4jv0n+H
 AeGHMJuxoDM7Lw50LDrxQbVuja2t7abTeOhr0aQJHg48fvY5yj15BCL8D7ncW2NAAWoLzIqn4+w
 mjcYTW/2GtwkXFJmlohKG7zuaf/73a5H8iJTtMFI1GtZu+Y6FF8UGiwIPdZ2cj1XXFhA0mrxOEg
 mQdetyOdo1xyH50Hd6z87t3NwtKS6lHhl0sF4a03XozRCIET7bmVvo5lXP/8x2InLw7v7SaviUm
 LxlOiI/OaWwCn6absDQtSMa9FLzFoCNRWtGyMqlBnxUABvJl/vkgi5/RRzkIjzYsyZyfa2filok
 hfveiTHpnBA6exlhuSoCBxxViVN/orDTdAS4hVn1BzCyTiqkXiDX61l69bZnQgQJIhAjF+0ZhEb
 jZNSDGogIm+ErAWXOhDJWXc8ck9FAHnD5/9N9Lope7r8amZ4lSlh6Xbc3Lqw9zjlPkg5/vOFqjY
 gid1QLCMR2ww2NU1IqA==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a5a2eeb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=htX2hAWjaI0RTq2uS3kA:9
X-Proofpoint-GUID: 4icc14cu2ighxfl6FYrzqzdyrQx3mEWV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170134

Introduce a new __ptent sparse attribute to enable type checking for
page table entries. This attribute would mark architecture-specific
pte_t type, whose pointers should only be accessed through proper
accessors, such like ptep_get(), set_pte() etc.

The corresponding sparse tool rework for this attribute is required
to cause the "dereference of PTE pointer" warning.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 include/linux/compiler_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_type=
s.h
index c5921f139007..472af4fb2546 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -58,6 +58,7 @@ static inline void __chk_io_ptr(const volatile void __i=
omem *ptr) { }
 # define __nocast	__attribute__((nocast))
 # define __safe		__attribute__((safe))
 # define __private	__attribute__((noderef))
+# define __ptent	__attribute__((ptent))
 # define ACCESS_PRIVATE(p, member) (*((typeof((p)->member) __force *) &(=
p)->member))
 #else /* __CHECKER__ */
 /* address spaces */
@@ -78,6 +79,7 @@ static inline void __chk_io_ptr(const volatile void __i=
omem *ptr) { }
 # define __nocast
 # define __safe
 # define __private
+# define __ptent
 # define ACCESS_PRIVATE(p, member) ((p)->member)
 # define __builtin_warning(x, y...) (1)
 #endif /* __CHECKER__ */
--=20
2.53.0

