Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D84142AFBF;
	Wed, 12 Aug 2026 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531490; cv=none; b=NURCny9MJSCuEAX3PcT42gyrQC6du04pJO1H4zXvvLpNPeuU+qrV3uYNYVgnL6xPMMUcLh7rzWjGZHEzY2Zij0C4ckcOsm9Qwk6AS+KatJdIFH45AYkKuvA9InFZWoEX15gtKNN6d4GJb+O7NBbZClE5JDY/zRQpHzlPlfalPbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531490; c=relaxed/simple;
	bh=9eaD6MGX1VFPUc2zZ2uy2DIzpTw7oUYy0gf+M7Q02E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfVqjgeqZYAlTWbCTvyU5mC3fid7xfYH3budjS1LAc2994UVBHHgU+RVlgAk2yq49HwUUIsxkjqxbKNLyRIfjhAEyMQBw7c5v+hgolprot59P3xOtkeL9MJ9Vno6XQUcgw/m0lpOE0zE8ONjXIJt01Hw0KGrg93jW5qR8/8jcxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A612bLnA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A612bLnA"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CA2F7r3087896;
	Wed, 12 Aug 2026 10:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Gw+LyPPcYYYYJNmUw
	CW/4/+TN+vfwYswQKIea3NZl1g=; b=A612bLnA8I5xp00BSqwh1IzlftmsUblVc
	zedx9kdipS/OPsSmcYBe59GsS9MZnEN3XRTF9xxF4mVqmIzDSpGvjx54hal/P+h3
	Y4nYm6saeLKgpf8gZDu3hSsNHhwXkbw/9BcSOQUFISuCkzVZN+vT/ibuw2Qvsp+F
	pWYw0A8GmZ5gB8plnCMbNk9ZAqw4t2N89cCA2HLAIDlrG7qNaLbGTuSuQNGnVxVb
	gyqZI6sGy8lJhQI2OfZZOxFLWGHE6KyOPVzVUttFhdwVvTCVIa+yVgiOdCZSoDF+
	fvVDo3Ye1FRrqrW8cpYH582x060j4WLPpcbORTVjSrNeNM8ZttU3A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp317jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CAfIhl004331;
	Wed, 12 Aug 2026 10:44:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gdfvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CAicFZ47448558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 10:44:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0AB620040;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDFF52004B;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 5/9] KVM: s390: Fix pgste_get_trylock_multiple()
Date: Wed, 12 Aug 2026 12:44:32 +0200
Message-ID: <20260812104436.109741-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812104436.109741-1-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c4e9b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=sS5RpU0ZaWfbfMIWq_AA:9
X-Proofpoint-GUID: dnTbpcyDW5JsX3he0sNzspusPAtte_t_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX2Y6tc2vEHOcP
 ClgWWYA2uhmWJTY+bt81K2xshmCtyv/ahpQed2tVUUrixIBfRq5O0ZjYN0mP6xF6uQBYyRrC3x9
 LfpP8YpMkVw1M/+kKOpYovm80m8gG2roRr9DfUkN36jyVJTednu5TmxKLg/32A0FtlhtfsuBLR+
 OGnXMhXVILwaeN/MsoSWW3RpqiTu8u6GDGIfdGeyG/vdP9j6YCG3ywmurJ7KNKqK4GF7vmt814C
 E2Of7Or4kf+o+vClYXxtQQZUMEDalC34QCFnLOajFgfwdtfMSQVlKnFYAGoeXCsUJa2gxq9LD3Q
 Sm2hDrDHWLEokY/kMBDul1qwmWLiAoiJpLUfOfVi2FgKcac9D+4iunGxsgFh+3V0bbNNAd0CXHC
 J2qwgii+O/p3koRsdE+L6Y+c0OaWAAFmPipnwxdpjovhVAFeW5pRRQzk8nx1Se5HsX2lbZwxisi
 lBqBjH0cP5d5Cev4dww==
X-Proofpoint-ORIG-GUID: dnTbpcyDW5JsX3he0sNzspusPAtte_t_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX4Wzc+mfj5etq
 b6+5YzdnC82RRXL8PbqGKw3VvtXjH6KmyJZWU6nhr1tJPOKFD8q/ssRdJyb7DjOZyTxL9yqDw8q
 ln5mqA6kFe1SgjqlwB5NLO3QX2Gug/U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120084

In case of failure, pgste_get_trylock_multiple() will attempt to unlock
the locked PGSTEs based on whether the PCL is set. In some
circumstances this can lead to unlocking PGSTEs that were locked by
other threads.

Fix by unlocking the amount of PGSTEs that were actually locked,
ignoring the PCL bit in the array.

Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lifecycle management")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 165c704fcf29..f4dd6f783417 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -923,11 +923,8 @@ static void pgste_set_unlock_multiple(union pte *first, int n, union pgste *pgst
 {
 	int i;
 
-	for (i = 0; i < n; i++) {
-		if (!pgstes[i].pcl)
-			break;
+	for (i = 0; i < n; i++)
 		pgste_set_unlock(first + i, pgstes[i]);
-	}
 }
 
 static bool pgste_get_trylock_multiple(union pte *first, int n, union pgste *pgstes)
@@ -940,7 +937,7 @@ static bool pgste_get_trylock_multiple(union pte *first, int n, union pgste *pgs
 	}
 	if (i == n)
 		return true;
-	pgste_set_unlock_multiple(first, n, pgstes);
+	pgste_set_unlock_multiple(first, i, pgstes);
 	return false;
 }
 
-- 
2.55.0

