Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E743CE51;
	Wed, 12 Aug 2026 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535528; cv=none; b=lkOiiJo7IwO+Drr6H/YdHUm7wfSvmA+UcAsqu451b+AZS/9RxG9HCiTiZ7Z2Z6VoKjOqe+Z55Qn9uw89xK/7RV9HZsQ8Le0SDjzBzYiUY9QwYZ6vn3RK1bpytSWC/PHESDcdbAHT0lav8LuUrgQveZOdSIrlclqrU/L2GaWYO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535528; c=relaxed/simple;
	bh=2Wf/N3kpJHEuHd+RiacnJK0+ci8T3IWekGQoJJU4yiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOvlCAg3T4ITosP63lUtjWGd+zt6Pxo6imFXeO//JMwdf7hc6jBPEdPxbcGVU8PThQcXoBn7EMv4VNDmXPF2KaExSgI06/56yUwF0aUs7Jdn6LIw33Ajy19WKTraoYWF16CaWyUho3TkTrNtUS2PBiFTK2eNMlJkh2D90WfnyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WBDupF6f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WBDupF6f"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3WIL3304218;
	Wed, 12 Aug 2026 11:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8dYG0nkgaSZFR6vpj
	HeCMiXGkd9Xt8YhJC2ESgxg6vY=; b=WBDupF6fuhX5jgV1Ffil1J59VTxNeURoM
	USTG66tXZHUHlSVQisJJWXqH43KKvhC+xQb14xCjc0n50vl+p4a94cdPK6jlK2Au
	jLHhfRg8+j7kKebqRH6jHTFtAwviSqM+MZpuoDCgz+vON4GHAtmzYi2d0NbRmZ7/
	g0f4WLfSFFdAo4kXeyrxzJ0r6U20t2G9xdmuzv0eFmrhIABWwfob6fQQgsyNqvAn
	mNZ3D4Gcr27CQqy4Q5PWg6h9Z20EjVPXr4QAzLJbtdcOz5b1VfOdo/W73AxyKB3V
	n5e+Sj5WyevZENofT7CS+Cqj+1whSQpNHjweQDMHX4Q5xaoq8yxag==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9t8gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:52:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBnshm018703;
	Wed, 12 Aug 2026 11:52:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gdp73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:52:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBpwrM63701474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:51:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B06BF58059;
	Wed, 12 Aug 2026 11:51:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EC295805D;
	Wed, 12 Aug 2026 11:51:56 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 11:51:56 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v3 6/9] s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
Date: Wed, 12 Aug 2026 07:51:36 -0400
Message-ID: <20260812115139.576303-7-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812115139.576303-1-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX1vecvEeq5/1c
 u5P04XBfEkjKqZmOUyjYF8krWU+c6jYy8BOU08+s8Mox758MBWPeemq+OYMLvLIUg8Bfx+4uKal
 l4fi8C89hXpyYAM+jLO2uOOUl9kxcmvjN50By7fGw2DrHmca6mO18bN8fiaTwAmn9XTNjN333Nd
 IR+zDbUaL8qJ07QkKSZV9QC5WfQohd2W94g9BC7hdjF8ydqz3xfuMkU/K2uSD5e2XNCf6/xTTuT
 2wVpFWY+7twUv8IzXU579gt+RqnY+MsNCc6ysBvhAZ0cB9EyTC4eQzLvpZhyShObfDFVRjhcnzK
 ea4qmZhsc08rtom8mOWhGCD4H9PFR+4oeo270HbwIFtFIX6Omp3o8YYwgOqVhhhTA4qisqWrPRy
 U7L82KCow9bwDJ+94G8xxgDdBHzv+fwl7574GrQL1ReqAArYEiWQN4RX2SeuQUITHbMjDQzBl9I
 L6e59DkQT5nrXhtbnvA==
X-Proofpoint-ORIG-GUID: XLV49F9vP9erkG8foBpX0-4lgouwECxs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX9x/U1f195wnw
 M4ipFidgy+LSK3BvegMt/VfVZPlN+DBn2xvFYcOPfKlfDDh11AehXyB6+hbTwS1PW1KROvyAU5Q
 U7zY/FrSYN2aAwjxS0LRW7XukClwoWc=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c5e61 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_H5xUuJxPEx76qSOziYA:9
X-Proofpoint-GUID: XLV49F9vP9erkG8foBpX0-4lgouwECxs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120093

The DECLARE_BITMAP(apm_filtered, AP_DEVICES) macro allocates the bitmap
on the stack without zero-initializing it.

In vfio_ap_mdev_hot_plug_cfg(), the vfio_ap_mdev_filter_matrix() function
is only called to initialize and populate apm_filtered if either
filter_adapters or filter_domains is true. If the hot plug configuration
change only adds control domains (meaning filter_cdoms is true, but
filter_adapters and filter_domains are both false),
vfio_ap_mdev_filter_matrix() is bypassed.

Consequently, apm_filtered is passed to reset_queues_for_apids() with
uninitialized stack garbage. This can cause reset_queues_for_apids() to
interpret arbitrary stack garbage bits as valid APIDs to reset, potentially
performing unintended guest hardware queue resets.

Fix this by zero-initializing the apm_filtered bitmap at the beginning of
vfio_ap_mdev_hot_plug_cfg() using bitmap_zero().

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index b6d0c988cc81..cdc9bf5c5e53 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2840,6 +2840,8 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
 
+	bitmap_zero(apm_filtered, AP_DEVICES);
+
 	filter_adapters = bitmap_intersects(matrix_mdev->matrix.apm,
 					    matrix_mdev->apm_add, AP_DEVICES);
 	filter_domains = bitmap_intersects(matrix_mdev->matrix.aqm,
-- 
2.53.0

