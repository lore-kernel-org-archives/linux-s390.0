Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6E416871;
	Wed, 22 Jul 2026 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739989; cv=none; b=Ujc3TSsWP+XTgOnXxiE6COVr//4uVosyh0JXdAeOQWPhxTLzeBt6pToQblgwNrkCNNEuGwjMxznSYxLGhc5S/T3RFdNU0Ikq037n0K2GOYU5fhf206n72JNkUozikd4AWj5smavjpbU9Yt6rKE6p4jzrzQTHdU+ju1K3IgqNQkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739989; c=relaxed/simple;
	bh=6lEdi6ee562bX2a98JJnWtIj6Ba/lGKcogLJMl94lyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEyKU6WB3R/cRtUQFpdFn1t5H0gN62WtcCZdx3qfsKWZIDHjcUkS2IOZhAP4kCdBWyHPs0qiPr61CDW/UX2sx3e+vEBKzSY026o2vuNikzsw49UfEdOA4DUap2HDH3eBDMFPw9WaoWkEE1EsEyW2Mxikl5Pig5uUHf/rpzV2IC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GBngBB11; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GBngBB11"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFfrPU303462;
	Wed, 22 Jul 2026 17:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xRHlaDrJccecYNTrY
	KvinLH4od394PkGb/NgKoPEI1s=; b=GBngBB11TagXqT806tnTQ1+xYSnbGE4b0
	ju+duagZxq/3WshTPhhgKU1Hd6cr6ySautqK5CHduZuQnHKYXmZhPQBYW20EScRS
	TiSCl/qsny7kKeKEKA7RQjxrLhk2dF1AkAF+4NzsoxG6+8/eHgtxtZWbsc7VPg5n
	v06tw3hmHprQKttXnAzFN8UCnUWrmfVyG6RPHxfXYHcBtduockT0fBMvfojQXDun
	zShhbHVoTnc/cL8Nn5EnnvKhNdBmOvZ3McGq/naAYA4NJ8EgeVrIVaJEzFPwlH47
	83P+3HTuZWcHPPACaS95L6O7s65QA3H88rMt5PkZjMnNwo4Rzq7ug==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kax5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:06:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MH4c7k025835;
	Wed, 22 Jul 2026 17:06:26 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk0aj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:06:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MH6OlL20120272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 17:06:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A720D58053;
	Wed, 22 Jul 2026 17:06:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFDDF58043;
	Wed, 22 Jul 2026 17:06:23 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.249])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 17:06:23 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v4 1/6] KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
Date: Wed, 22 Jul 2026 10:06:16 -0700
Message-ID: <20260722170621.1686-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722170621.1686-1-alifm@linux.ibm.com>
References: <20260722170621.1686-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a60f892 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=G-uFRffD-WzugI8hyjEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfX2zE9CWrQ6hUF
 qXuwxwvSEB097t7xproeMSCRRNGF6TFnNP7+VhLYSPS5aEnzEPxQvXwxtx9QU7T8K5g8QR5Px2b
 5UCyHExOkDJaJRfzvI7NyM1JzXD+JctOb9Q6Gw3eQFKqBdavt2CY3UPBo5vvuiD+fzP631hPRdD
 23ownmIq99DEAN6r8Uv6xjPqVGnBNHbH5pNgy2YrjdiSaQGr9Zyu0tZMuUpDxnYN/qRy3XP8FM1
 Z9yjcfYVgt232D+KSFhJU4kvx/4KpjaQDs0mJUvWyZiyxqx1spIqMZ6Bz36Xr7F2wqrKTZlQA0k
 v3utnAIELQqbE8EPmurPzypjqLW1dHkPmtgZKk/DgDgt6T2m5I7TB8dQrOZx2D/JMtLIFExC91K
 kL8aqizpbaRgblKt8hVzoOhDF7dQ0dqbi0QbNEQZhUpR+DIAhzPlLVo7mTpooE7gUPJY8nqlKZV
 6d1Lno4cg2oyMNZlwbw==
X-Proofpoint-ORIG-GUID: XzAYuZqNXAizA4YQ13kxWkjK9UMX0uzx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfXxWsRc+mxLSq+
 k7PXgXufDEmAyFkJQZgxf1pd1kk4UETs2+ZauSnAQfwMzLiiNnzm7/p2XxWbD95wpXJxHLbzFDd
 A3iIVgV5XomtwMnLwFpHYQhtfOaxXZU=
X-Proofpoint-GUID: XzAYuZqNXAizA4YQ13kxWkjK9UMX0uzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220164

The MPCIFC instruction doesn't allow registering adapter interrupts without
first unregistering. So reject any request to enable interrupt forwarding
if its already enabled for the zPCI device. This also fixes overwriting and
thus leaking resources when the ioctl is called multiple times for the same
device.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 720bb58cabe2..d2a11cdf6941 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -237,6 +237,10 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	if (zdev->gisa == 0)
 		return -EINVAL;
 
+	/* AIF already enabled for the device */
+	if (zdev->kzdev->fib.fmt0.aibv != 0)
+		return -EINVAL;
+
 	kvm = zdev->kzdev->kvm;
 	msi_vecs = min_t(unsigned int, fib->fmt0.noi, zdev->max_msi);
 
-- 
2.43.0

