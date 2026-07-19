Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690DD1DF25C;
	Sun, 19 Jul 2026 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466018; cv=none; b=Xg7FBTf9frhG0oYdqZWs+IerdAU+mDXnUTPl/EYmIFvjRG3xKng0O9zKJQB8AIhmr06+q3Y3qhkgC0hNiPTV8kT/IU3LqZlhMy+X2avLduvZstH6hZr3QLh6MbhpBwijeb4MHapNdBZs4kYjKJbrgiTXdU09+ydW2Ud/f8T9C6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466018; c=relaxed/simple;
	bh=vCmvLDArPZy/NUup35qgdegCw9i5pFNHjjD61YwH2BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMNfAcyTZ2sZfFQMRupG7Hf5LpNmfaW+Y3TXmhCPerTln3WfZ5SVnpmpp1QvQWIuC/vkRf2dlYc0EqYz/YnSPYH87cFosIaMRtuHz1hc2/BvW0dTrtVMt5qShZWoZiQKJJ6JdM2dViJ/I0BeCiyPunNUMVSt14QuBpbrtcLTuvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f6yjYuje; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f6yjYuje"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JBBpfs3271375;
	Sun, 19 Jul 2026 13:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WQkyUxtVb/VVZMZPX
	rGLYPGKt1Bd9s/iaj5r4la55mE=; b=f6yjYujesno1pC/g741Cw712ObaOGPQYw
	7n4sOfumozlJXhCWk+TG/dT9X+PyzG8b08ONjHq3QmjjbebEuOqAAaegyIUQaKQh
	/31CcD5AG5rrny7sTrU6445uppZUWQrnVITTlLCNT6ox9oAkQnmwIYSfnatpWN9p
	jRNOalOp4MiNq7zyFUnJNl/v/iRmyatOzQ5gL2uXQqgccjR0J+l1UqoVoB7M0sRl
	c8FuAcUiPtG7UG9aKe8EXyFNvVRqfpyy0MMNgJpmCpP8liIip1zQuthauLqpD0IU
	84RhstGuzcOmO2hibKFyE4QvpAZHIPwkm8zCCzRPe/yaub52+aZgA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77jucq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:00:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66JCnad7018664;
	Sun, 19 Jul 2026 13:00:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy1c91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:00:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66JD07Xe30409180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 13:00:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5288F20043;
	Sun, 19 Jul 2026 13:00:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C2A32004E;
	Sun, 19 Jul 2026 13:00:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Jul 2026 13:00:07 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] s390/mm: Use lock_mm_and_find_vma() in do_secure_storage_access()
Date: Sun, 19 Jul 2026 15:00:03 +0200
Message-ID: <20260719130006.3882764-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719130006.3882764-1-hca@linux.ibm.com>
References: <20260719130006.3882764-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5cca5b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=q1cbuJAsPhdWy6OxXkMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX47NzsLR88s+T
 8gxghUM6sRauXUVW5BR0whwCeT6o3s4+sOM09O4CxwojvBXhYyOnzFpGHMcTVYtHfBxM2RVYhRZ
 31cRd6ILPnj9RBWlCjnzwUZFAg7k/MY4nTtCZ2Z5Z5gSK4NU5kgMrMZDvRd8w1O65WKBOjmcpCy
 oDWQoEP5UP4RaclIZVpyy9tLVK9gZHcsHS3lW1ZaIWjxq99GNLJF2+vU2Mtox0aSLj4/2ypiXmG
 qGa8CC6+YJvPHpsAaABVnU14pyQB5QyyeoHa7V8nl1lPjENXd64mAzbpQ8ySfmTM+2cpjVJxf0q
 UvHrqJVG/KcmXhdPyq5RaNpjmHbSnDYqU9d5jROG42nO2I4lJV+mhgcLlPvvTAciWKBQoM8uii1
 2hH4ja9/wMkVtw3hnGEjjrQP4k9TYuMGTgE9wRLtvOiJg6OIy+0LfVHL+xlMHLhvqtWfEtN+jjv
 Ss6DcuuR2IDc3VF3kkQ==
X-Proofpoint-ORIG-GUID: kMnjA2552nWMiRn4DESu5hbmBj0BZI-e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX+HaucYrukZxR
 reslfhd9zvEawid968wfEq00KMMaz0936VJTtiWygDNedMavKFe7P9l71VMbGmYq54NVNh+GuSD
 7Cr41xgANwmcVKdRr4nuhBqpSk9+q8Q=
X-Proofpoint-GUID: kMnjA2552nWMiRn4DESu5hbmBj0BZI-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190139

do_secure_storage_access() uses find_vma() without verifying that the
faulting address is within the returned vma. Add this missing check by
converting to lock_mm_and_find_vma().

This is not a critical fix, since the worst that could happen is a
WARN_ON_ONCE() in folio_walk_start().

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260717093904.E4A421F00A3E@smtp.kernel.org/
Link: https://lore.kernel.org/all/20260717093904.E4A421F00A3E@smtp.kernel.org/
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 2839d7a64401..f150d97cac2e 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -455,10 +455,9 @@ void do_secure_storage_access(struct pt_regs *regs)
 	} else {
 		if (faulthandler_disabled() || !mm)
 			return handle_fault_error_nolock(regs, 0);
-		mmap_read_lock(mm);
-		vma = find_vma(mm, addr);
+		vma = lock_mm_and_find_vma(mm, addr, regs);
 		if (!vma)
-			return handle_fault_error(regs, SEGV_MAPERR);
+			return handle_fault_error_nolock(regs, SEGV_MAPERR);
 		folio = folio_walk_start(&fw, vma, addr, 0);
 		if (!folio) {
 			mmap_read_unlock(mm);
-- 
2.53.0

