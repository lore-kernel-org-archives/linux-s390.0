Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806FA282F29
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030738; cv=none; b=eSR52uthikNqnmNIlGNZftsq+GeR9xJpaVFGxI3qsREVTznparWJFI0B5h5//33795rKJmvZ9TBNXueEo5n/WTXTJ3dxvpwNGn5ut/nyW/8pP3V57NiFyEQiKuSQpvouqHsyEgnpEaroKJak2Yk1HGyf061SOerRBgfkTW+Irj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030738; c=relaxed/simple;
	bh=nXs7SRT+0M5V+2d1gMZ1w/6pUv1lREuvHkx8kKWEi2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epcQ18aJ/eTfEA/zJ5qFNm5FBHHVrfJ+28DdcajORqcW3T9t8xaq0v7xDZrlBO0ErmuCv9kmMKo/nIrWEPrvj+OqQdXILi8QnnfwTaB3jBpb6aUgRTTn16IvFGnWsFAuZsKTAkfaQhd9sELhO/LG7yR+SiVzi581eFH8mWb2OvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UphVDrKF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UphVDrKF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Eo2WT3015225
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 15:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gXIfPacdSw+t/kQ2S
	DA7iIJlCVANLMOE0gEequT1zbw=; b=UphVDrKFBdz9gGVa0i8+09p7UGAIn+8dF
	Kz6GbYxX0hUuUe8d7LbtQoJjW1bYMucXZgRp9xs69K1l/qNTX9GmPLYncSrBlMi9
	vA0K3zCAdQbx35fCMU5cEfyTQENB9GrSFSO06yBhYKnrNixEGDlMQQPqyT8R/QDN
	JcohzxGxiBnU1W8Hyo5pAOlEtVOEb+OaQyIfH+CeaqjSaT+mTZkxkyHKfHGB8R1d
	p54BQ44w3KZBvD5vh1UG2iiKOdJIXoF4GZodxhxqdyVb4vn1byCtnL0Z0TnHzFG5
	nZ4PX4LvhoR2bSUwlVVyP4v/nhGYziYHCDTpLXollkdNwuwRANtHA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8ev0cqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 15:38:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FQGjd028631
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 15:38:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwbves-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 15:38:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676FcoKb44368248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 15:38:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7741320040;
	Thu,  6 Aug 2026 15:38:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43C4C2004B;
	Thu,  6 Aug 2026 15:38:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 15:38:50 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 3/3] s390/virtio: Enable CONTEXT_ANALYSIS
Date: Thu,  6 Aug 2026 17:38:49 +0200
Message-ID: <20260806153849.2622576-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806153849.2622576-1-hca@linux.ibm.com>
References: <20260806153849.2622576-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kbTpO9BZDfesfK2kHQtPa3A4MXYGAiGV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExOSBTYWx0ZWRfXxXYAm+elFehO
 KGnqp+Vwq6b2qGvpXf1eWKIukkzea5HLbk9s054vRuQa7u+DaibmrK5Y8IEnA2K+zrLqYboRB+g
 xEPQCkdcz9Pwjqjsr0MczyBgJgM4TLY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExOSBTYWx0ZWRfX7oy+QSyN7mDK
 kx6q3q0Fee6p67elsIg4xG9tWGWVuQPKPcgBZ8czh3/ypacH/IBKVcp42+sIn4ieO3V3uLjkoDu
 m4HyenAt4J1jRAzNqe34ZfDNGQ861j6aR0HQd7jIpvdSow+zsEGmh93tpolGBhwudthYLUpFNT8
 PKxSHwXZlEcAJgiC8kKfaUuvhTWxUu6Is+6u3Sb2yziq/pxVESTL061jpPCMxGeUrfhBsKhEaiy
 4qBWnZSpZ0mI7yPG24PD9BsXBsDpAK/pkwwlud2bEj98jqrMHnqXbBRvUrK5EHjlrqbktA5Ps9/
 rz7m9AKkTtJUzRi8Nf30f/vEpZI5TCIIxPlMHEp8at2PuyCQylOFA1b0Svb71R8in0dPRpiStbj
 BKW7ApnYH/bnvbKRg/Wi88XVRk5Tz7+XdL9GmOLQytnvFScjZA1Rkpr3zQbj9rw5KnrJjnOxkSY
 cyiJGvOCRhfmoMZZJEw==
X-Proofpoint-GUID: kbTpO9BZDfesfK2kHQtPa3A4MXYGAiGV
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a74aa8f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=kfv-jeONojG72FVcaNkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060119

All virtio code passes clang's compile time context analysis.
Therefore enable CONTEXT_ANALYSIS.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/virtio/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/virtio/Makefile b/drivers/s390/virtio/Makefile
index 2dc4d9aab634..cab140fe0b29 100644
--- a/drivers/s390/virtio/Makefile
+++ b/drivers/s390/virtio/Makefile
@@ -3,4 +3,6 @@
 #
 # Copyright IBM Corp. 2008
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_S390_GUEST) += virtio_ccw.o
-- 
2.53.0

