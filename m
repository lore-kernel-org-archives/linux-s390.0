Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F937A829;
	Sat,  8 Aug 2026 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208849; cv=none; b=R5+bj20E302tqvOfoBAQjDRwKW5+qxpgOGedKHZxXC6HERHYBcQuhlks7wKAFUVV4+1OGXiEry7meF/7iqic5yJDCJ2tykRsF338ujKc1Eo2szAQZpjNLDINYoSwvsUMYlD6ybSPJUX467aPOHkdFde/EOGbHjZjzxDrTL46Lv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208849; c=relaxed/simple;
	bh=4tidI23Pm+dYwkNbLIXMMsazONFi/qGjVCp+vtRgBAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqNeIweLglsSIjPqWcOflun0fZ3gyGyLPgWt3p7LcpBtqSH/4/WBcmoFeZ/cMjGPkXrLv4mHAovXeXgCYFgLSGmjhW1WAqCF+VEdKyRc2Tg4V4eL4D/XQw4EGhnG4+MciCjiBfuCCGSVLyLcuaNtsAcdAMreSP0Up5q2cjvgTyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e6W5cLMO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e6W5cLMO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678H1tqh605924;
	Sat, 8 Aug 2026 17:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qbE/FfN+6bKSEEHXg
	zeGEhHoSj357bjJBkyHRtmLeYs=; b=e6W5cLMOxSIYV2R8CS00JKhqb4U0YmTSk
	O9/U66SDr5TaJjwZJdLm9Fhg1ma7U8vMKPlLFoGIsM5XMNqkxVZdEm7J6JPYJHPL
	ZoLPY34noF85BrzzfH1tFLRIwvxFJrdcPX6uQcg++t80j3binXGghu9I+SNU+9Ac
	XPFsz+TT6nQP8beDhPsy0jRFgXcRe44z2GrxveE+6MLQ3Lmi+T5meVQfPRaGZJ7h
	cLqHtZD1EXV9Qkw/isn94Dnp0GOzW5bQ/mf9+vxmctnv02LSd21P1T5gR+8EaWid
	H5fhgG1AHyQMGPpp/pb/5+IqMLoPSA0giNoNnOQWGK7zFKjNjNrWQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvkchn9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 17:07:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678GudD4013079;
	Sat, 8 Aug 2026 17:07:22 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswu03vkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 17:07:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 678H7KqK27984572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 17:07:21 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C775558050;
	Sat,  8 Aug 2026 17:07:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00A8D58045;
	Sat,  8 Aug 2026 17:07:19 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.94.189])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Aug 2026 17:07:18 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 3/5] s390/vfio-ap: Fix use of wrong lock in mdev probe function
Date: Sat,  8 Aug 2026 13:07:10 -0400
Message-ID: <20260808170712.839066-4-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808170712.839066-1-akrowiak@linux.ibm.com>
References: <20260808170712.839066-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mizJpq5wg1SRAPkJIGn-j68Ptjvt9EnM
X-Authority-Analysis: v=2.4 cv=J86aKgnS c=1 sm=1 tr=0 ts=6a77624a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=IOhVIQ1U7ISs0PSOFQMA:9
X-Proofpoint-ORIG-GUID: mizJpq5wg1SRAPkJIGn-j68Ptjvt9EnM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE0NiBTYWx0ZWRfX6r5CDk+8WwP1
 lKxGJO4wCC+cNW1v4UHUUFKQ973J/wUf4MrgMbZAJ4Eh2F2F8IcC3FKvmYnvYzB8pO6qil8zRU6
 3NTsrinqOBevI1aUyhUQoba2Us+wISxv7szBhwwyrFu0tuGwoTBEaiLqKz4SQnb6p3cQuhYC1Bo
 /RJCF243zxFSLoDylz4zhngebfK1HnUcg4o9+iKFhyotdig4kVBSLCvpen8g8ym5fwQussaSbyA
 VtV5KrVS2uZK34xvGNg+59W04PZ1fZ84RXjp3UgrcJUH4b+xd5vkjVlSHkimO8N9lFjrAGnV/Mp
 OeWtgAmIcksKSVpJmFb5KMqjpx5yXVrQUPs+8ZWwozJ3uYofi124iNdALoFl0KPfseClSGdxEUN
 4lC3nloQygqVn4QaCqdbzsQhmagjccGysWKKrowJ1Oh5Aj34MXMhl3ovjcE0+jPu7UkY1JmgV3x
 d6hzucMh9eT3S1vaVng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE0NiBTYWx0ZWRfXwAxH70ALHyjA
 CZd6UTXWJqVv8AJ6+KMi4IvKK7doVbSbb/sdQWuvj4iEx+0rITI3Gsp0b/HwnR172i54a8dM1WK
 dj2/Cfe8VznXHpzYQTxrQU3ncp8XFX0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080146

The vfio_ap_mdev_probe function uses the matrix_dev->mdevs_lock
mutex to guard the add of a newly created ap_matrix_mdev object to the
matrix_dev->mdev_list. This mutex does not protect against traversal
of the list; its purpose is to guard against concurrent access to fields
contained in an ap_matrix_mdev object. This could lead to kernel memory
corruption or use-after-free if another mdev is created concurrently.

The adding of an ap_matrix_mdev object to matrix_dev->mdev_list
is now guarded by the matrix_dev->guests_lock which is the correct
way to protect against concurrent mdev_list access.

See the vfio-ap-locking.rst in the linux kernel tree.

Fixes: 2c1ee8983aa3 ("s390/vfio-ap: prepare for dynamic update of guest's APCB on queue probe/remove")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e382e5a1cb99..a472de00bc14 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -803,9 +803,9 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 	matrix_mdev->req_trigger = NULL;
 	matrix_mdev->cfg_chg_trigger = NULL;
 	dev_set_drvdata(&mdev->dev, matrix_mdev);
-	mutex_lock(&matrix_dev->mdevs_lock);
+	mutex_lock(&matrix_dev->guests_lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
-	mutex_unlock(&matrix_dev->mdevs_lock);
+	mutex_unlock(&matrix_dev->guests_lock);
 	return 0;
 
 err_put_vdev:
-- 
2.53.0

