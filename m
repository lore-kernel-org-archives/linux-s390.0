Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A63890E8;
	Wed, 25 Mar 2026 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472545; cv=none; b=cdhKrhvZLkp74Wh6OAjtWpc1s6bTTuQ3SsAcPbhq2r1rnNgNlzDwtG6AyhxnSDjDpjVogIV3vi1VQaN8hEzYef/PGfPfvcJYRdqtkMpF52ARzpcF76lnXgr7vj+c7tS6g5HJfVOEmj+kZYWgxv+iwgEWrlKUbXHsx6YkuNrrh2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472545; c=relaxed/simple;
	bh=1+w+VmNGh7UWWoGPd/8zusryaGihqFcVScXp247ZUIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfMXhPTY9LXtDxhLbpYRlo9w5aoQ7FzKUze81H6c+wMkZirYuwppXKrzJlUkmK+c/slbkwqEQZF8d9TfxB+Ub9sVH76bt2FnQE6Dw5cHcPxE6nUbHHpxxZYv64uQJXM+R5/z2+7IGR0DGHtUBxgwv5tFmMV/+a1vgTwFi6VFZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZMNQTloD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZMNQTloD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PA5dAG415280;
	Wed, 25 Mar 2026 21:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8JJFpHxKBELvsQ6SM
	fSoQpelPUfFPaiRyKfo8dluKoQ=; b=ZMNQTloDC2tFYX9evHrpmoqIkUgINfMzR
	n5F9XaKKVsKaj7znFIRLKmq3bbPuKow37+9brXfpXQruWkKlYKjIU42qRwQRM+8J
	xfk2+FoEIDav+lblKfaA99dPlmefgE7aKGbAHFG5jJK/8NMetOJP3BHKQ7XIybz+
	Rluh2isxS26etHjtU5PF63N73hNznfQN41zcbcOVcqy2+ErggfA0DKIpcmKYIaLp
	1bHrGOS98n68hTNaJE1wV7tPxGtpHqqJR7rOLAsFzKZK+c96YmnNnYNygF99SLWl
	5EpH7SUDlm0lfJZaAsMtxxY6Z7SdWFXNWJJDY8TzB0Cb3ZXfOBWdQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumsjsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PK32jQ026864;
	Wed, 25 Mar 2026 21:02:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m054p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:18 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL2H4f15663798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:02:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 047505805D;
	Wed, 25 Mar 2026 21:02:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06DF158056;
	Wed, 25 Mar 2026 21:02:16 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:02:15 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 23/24] s390/vfio-ap: Disallow blocking migration in progress
Date: Wed, 25 Mar 2026 17:01:10 -0400
Message-ID: <20260325210149.888028-24-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260325210149.888028-1-akrowiak@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 22nzF0RYFEgEjOjkxTzWbffdY32ZTOAF
X-Proofpoint-ORIG-GUID: 22nzF0RYFEgEjOjkxTzWbffdY32ZTOAF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfXx1eDeb9yr3wJ
 lDCtQ4Sp/0yesvP8xr2EMaeXAYhGEYXUW07/D+oQlVATv49l5HtGY8qD+b7TGDmIM9ANeJEOEkF
 ExPDBD1VZagbWDt55d9n7VooI35ORCnCSPTYY0S8v2Sq4PP5bJyE1IJxBztPA55s9bmAyyhTL3B
 fVFKoV/JWddHnKqhcIDhShJT3xw8kMqWWdUVqPaRNCEZT8ktF2TffID22XadCIL2NMZMJrLCL6h
 s1yjpPT/h551jSFyp/AhEAVuE6jlejdcPtrUBs6dqfrmMVJbpvUXNa24HmIYHrmflt1qDRkNmMy
 zlXEHAmklVnEnQw3sSu5QdSva6vRl8LDV02GsD/DKDZUis3wPG04ZJr91UtDt0z7ERUCVKGD+aT
 6unhKe2AhqFG0bySTeQGjQfkBtG2srmrrPMqVD19dHCIKm6JFIEotOUm3C1hAIUcXSaLftPNHHQ
 m9ge/HY6h7QNlBD8VmA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c44d5b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=yxLGV8IA72irMGqYBd8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

The sysfs 'migratable' attribute allows a system administrator to enable or
block live guest migration. If an attempt to block migration is attempted
while a migration is in already in progress, the migration will complete
leaving the system administrator believing that it was blocked. To prevent
this scenario, the operation will fail with the
"Device or resource busy" (-EBUSY) error if a migration is in progress.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 1ff9994bd7ec..c8d454e52665 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1853,6 +1853,12 @@ static ssize_t migratable_store(struct device *dev, struct device_attribute *att
 		goto out_unlock;
 	}
 
+	if (!migratable && matrix_mdev->migratable &&
+	    vfio_ap_migration_in_progress(matrix_mdev)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	matrix_mdev->migratable = migratable;
 
 	if (matrix_mdev->migratable)
-- 
2.52.0

