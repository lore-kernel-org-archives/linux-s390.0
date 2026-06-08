Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDDC3DA7F3;
	Mon,  8 Jun 2026 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939224; cv=none; b=CJRwuHiCTzEWp8YaomiDahXI8xw+KKt9ivQRh6ediP8k7PmiDdZrrsuoRvcpoZxEzv9uQslirn0s962gm/bWUTNimBw3Vr9Ys564ZS0Jj0m/RhFbZzCRhw2XTUvPtqkFkMcAFvzp4fVnBkwkxNinpHQQlT1kRhBupYlH7fQoz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939224; c=relaxed/simple;
	bh=+/MJbz1Nx9N5DsM/+uCTrYmoBCKXQgRFW6ylS1HpNR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbPa+u+msfJM/L8xbRA+o4VVVpulhh/+Vle+yT8c6ynHZkf+01gxol4KsBosEkyvYVkKzKXqEzmfs8nGrs7lS40ZNoDmn43KqLopt3Ud8aEGHPJNUdIITYukkQz26+Tt304OL5U6R5AxrSDs6Suqz3RYxPCMfj7fwlk9gzVKiTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l7Coh9Hu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l7Coh9Hu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6589B9Bv2074794;
	Mon, 8 Jun 2026 17:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SsqudMM6wancz+w4e
	1ii3g/z8aangAqp0EsDxJEqIJI=; b=l7Coh9HuFLooES7Wg+OKgWCv6XzFgnESy
	o2FjZPyjAgXw+5J2/NT6WNbLGilOUnKv3n6ECi2o4Ic/5Bc1ihEiT0/8+DNYLc4p
	j8QX+/gdl5Yy6xkWAsqIpngA+lrRfSlrEQ4yf44olu0W2zqI4nsGqkeUS4Vyq8la
	EjyKHQlu4pVmdItDyEYlaMioEIHvVna7Zpmzo7LLXpGoIctRCgGAL5q/aq5c/yl6
	NCh3w5ukznrFR7W5cOWjZM1yQfTNw70C9KQFkQOSiKD/1InlPjJjAidNb7ks7R0k
	PAXVnCZynAyQ2w58I7sj7wZINTFwkEYULxUbFJ1Arl9pRmu5s3njg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb958eyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 17:20:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658HJbbT019348;
	Mon, 8 Jun 2026 17:20:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fx5g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 17:20:19 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658HKHXW29819480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 17:20:17 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16EA758055;
	Mon,  8 Jun 2026 17:20:17 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6FDF58054;
	Mon,  8 Jun 2026 17:20:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.12.78.81])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 17:20:15 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v3 4/4] s390/pci: Fence FMB enable/disable via sysfs for passthrough devices
Date: Mon,  8 Jun 2026 13:18:50 -0400
Message-ID: <20260608171850.62829-5-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608171850.62829-1-oelghoul@linux.ibm.com>
References: <20260608171850.62829-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a26f9d4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=LQOIlC5QHTpW1RRPx_YA:9
X-Proofpoint-ORIG-GUID: oeAvw-mMcnLW6W8SdDO7KRaq9dk7piA8
X-Proofpoint-GUID: oeAvw-mMcnLW6W8SdDO7KRaq9dk7piA8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2MiBTYWx0ZWRfX5yuQeHLGXYr6
 vTgnwNZePhMF7cVUQYaVGfa7NcCEy+DryGrFPh+jtdXenZNKzK7sOhnc6uTbcBhibzChl7xtDO0
 9ittDgmnrDfayOoXyah1YVFZV2Bu/ebAHI+yPuATVhTEHBshJCsHo4S0NQHpY40Ng2qUaPmckaU
 W3SXcPxfsd4g2v5u5CUqzSGBGgk7aruyLi4qcgax2cGSPiOGTSDpY1AMhp9BdIaPn9k56t5KHZs
 tgYvT8uRR07eUWMGHddlKABY+5UBq4ihNRxVTcL8EjWuT6rw2Cq83GdhBqKS7eKCHcH6My594oQ
 PJGh3qHHGClbHadbBh8jFyYZbIvPYgzH6s8Znls1uYW9B1MrDA0YG/1kDlzomtiSJCAPqJaw+mD
 jV75QyUCh5ZYL6Z9Bh7VYRoPN4BJJhfH0lYdsN9C8VYAs05QG3SLRW7kyF40WNvGEfcSp/w8XKA
 2eDxHyb6rh+EUn8WPjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080162

Introduce a fence over enabling or disabling FMB via sysfs when the zPCI
device is associated with a KVM. This will allow a KVM guest to use FMB
passthrough and avoid the edge-case where the host disables FMB while the
guest is still using it, which may cause partial counter resets and
inconsistent reads which have no parallel in the architecture.

With this patch, the userspace driver, likely QEMU, is still able to enable
or disable the FMB using the VFIO device feature introduced in the previous
patch, effectively securing what is associated with the VM state and
isolating it from other processes on the host.

For VFIO devices that are not associated with a KVM (i.e., for userspace
drivers other than QEMU), this fence does not take effect.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_debug.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index c7ed7bf254b5..a2dc79418c21 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -149,9 +149,15 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
 	if (!zdev)
 		return 0;
 
+	mutex_lock(&zdev->kzdev_lock);
+	if (zdev->kzdev) {
+		rc = -EPERM;
+		goto out_unlock_kzdev;
+	}
+
 	rc = kstrtoul_from_user(ubuf, count, 10, &val);
 	if (rc)
-		return rc;
+		goto out_unlock_kzdev;
 
 	mutex_lock(&zdev->fmb_lock);
 	switch (val) {
@@ -163,6 +169,9 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
 		break;
 	}
 	mutex_unlock(&zdev->fmb_lock);
+
+out_unlock_kzdev:
+	mutex_unlock(&zdev->kzdev_lock);
 	return rc ? rc : count;
 }
 
-- 
2.54.0

