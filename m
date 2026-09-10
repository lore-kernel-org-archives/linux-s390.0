Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C545DF4A
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037142; cv=none; b=mXAnaBpQmeQLViDKZqgL9GSiZRAXQNFBJD7VHvWiphyvcisDLhdvUqHQKBbp+txOZbN3j5J4louBdz8RWiXHGMJDXJ64zKDCEHJ5bIvlI79FPsoXNHuY0aZenoNvHeT+asvhlpK4l5vIlJ5Fo5Fa2CBbSRyHSAQ3ThfCUp06wIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037142; c=relaxed/simple;
	bh=/8mAkxpCpIcivQjh2cFoJGVe7gC/OGfKt2fjQd+KAlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtI5E2KUg+7f/fw3EBncX2f+zQfN9R/g8N5s/srR9AcYOxgNVgiqQavHlxRvqrg/37x3lVo/qI+fscodDiFlwUzfy5eZVBqZNw0m6WfNwf+Dkh8Ps9aVGj6+yrJqLJ55ovz3umhxzp/ljhmVAHPIH4qw1YvCAuTZgG7GCJMDcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jjLgAAkL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jjLgAAkL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A91Ykq2470230
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 10:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CJez6WjfQ/aqL7JFlf9BwQAb2b69al+tVoBuX4deX
	hg=; b=jjLgAAkLHBl+lsH74XFik3ePgomU9qeRUcdrWRebtmG7gV/jWUGt+O7Ri
	81UxKZJ52XZ86eF7IDeCeZUtxRCk9hmv6+/BIG0nt7CcKB7mD8Wi+rYI1RMqzD2i
	YL3NeHXq0c7IP7EEFxnpiHk4Eex+qZek0ibWRH+14oQiAwYinVFhy76SUtQUTL2R
	VsW0rY4qacL4krhu5Qj+4vk4cOm8fEDs8YNRPDBBBydZ6xuwfN/YUTqX58IRQT+u
	rvTWiY52P5WmVwei+cQBZLdlf+e9/xp4TYMZJTgDycEYXLTRmUG0CliJEbJ0u2kf
	3tEqqehdvSTvG9wYxLazRiXVY8Hbw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qkycc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 10:45:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68AAia9j014533
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 10:45:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkcr3kwpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 10:45:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68AAjQst47382794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 10:45:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 074A12004B;
	Thu, 10 Sep 2026 10:45:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4C0C2005A;
	Thu, 10 Sep 2026 10:45:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 10:45:25 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH] s390/debug: Reset pages_per_area and nr_areas when static registration fails
Date: Thu, 10 Sep 2026 12:45:25 +0200
Message-ID: <20260910104525.3788362-1-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa28a4b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=7iuyb7CgE9plqO7ptG8A:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: gok5dwHc4N0myPLqNvSp5Yk3GH6c0QZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDEyMiBTYWx0ZWRfX9v6B4vvwiLli
 LhPO2MtntHz3PkAhno8VK/uQ7ovIsl8TseKtYNWjsgGPQZb1ftZ9l8ezFAmp5qjcaWJInH7tde8
 haUQSfM7zGYmZ89cGfC28bWOMFuJGSDdCPoZ+cMhfyr4jRDlCSzmo1qcbNRW6u2rZ25vSZR0nAh
 u+K268ZzxeaqvPtxvaP/Y06nVcpF/8STDojqPDO9P83n7PLzXOfR0SswcFPf+9SDTlUgh6+3GMs
 p4gsI7WL6xXozJQ5rsmtR2OD9PsdQU0MGqjPFAHFPMNFAF9VjrXGNSgY4hK6w+KFrGlQjPgdFyc
 MdqRSIOsuHRUrQIWEeWCC/SR4xTu7bN6tcspMpVuGgfqRIJ/UojJ7JyCG0vTK2UNoJRLnFibhDw
 XlyXzniGcyCQRxi3S+cLRgSWU4HZh121gWSq1fDygRBm3Vn5xQ12WTbh/19dqDLU7DUBfbFWhL8
 9anrVfmnzdofAiNLQIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDEyMiBTYWx0ZWRfX6qiCUzqJ1Zw1
 fisnA29TfvFfPm0qQO+GdeBDH25qPvCEOwtUexvu/+2dMrU9H6gONc5ykMnD8mIsYW7HXPVsJ6S
 8MqctnN8gsy59goL8dPkFSGz4MpHMfM=
X-Proofpoint-GUID: gok5dwHc4N0myPLqNvSp5Yk3GH6c0QZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100122

Everywhere else in the debug feature, a NULL areas pointer implies zero
bounds: debug_info_alloc() sets areas to NULL exactly when
pages_per_area is 0, and debug_areas_swap() swaps areas, nr_areas and
pages_per_area together. The error path of debug_register_static() is the
sole exception.
Set pages_per_area and nr_areas to zero on the error path to restore
the invariant.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260903130733.709001-1-zaslonko@linux.ibm.com?part=3
Fixes: d72541f94512 ("s390/debug: add early tracing support")
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 arch/s390/kernel/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index b5bf8284dbfc..cb7799cf62d9 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -973,6 +973,8 @@ void debug_register_static(debug_info_t *id, int pages_per_area, int nr_areas)
 		id->areas = NULL;
 		id->active_pages = NULL;
 		id->active_entries = NULL;
+		id->nr_areas = 0;
+		id->pages_per_area = 0;
 		raw_spin_unlock_irqrestore(&id->lock, flags);
 
 		return;
-- 
2.55.0

