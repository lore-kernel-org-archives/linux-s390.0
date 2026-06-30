Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6713D1A98;
	Tue, 30 Jun 2026 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838565; cv=none; b=qmKNk9jaNfJFLWyKP41Ptamll8k6pzc341UpeCkdwz2xC8StbxCFxw5hp/F1wyZy3Eot76yUz843vQwfip4Sv15WwjTpd9mTvLui86nGNqzFEPXbqUecbeHt0yKVG8yzP/5R1r/woBzgEAY3buYXYH6G8YBDjmjVqSbC2OYdFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838565; c=relaxed/simple;
	bh=I7AbyQaf1bi8OASH7zySyEb5FKzpriPQ2bn1gXOhMDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GoLFcyhGSY08OOKGT3V/Eju2EuTwfv/t7BxFuM13ex3y7IY91X9uiEnbJ0orE9ZewFAaitXpBxYJx+3bbOnyVauckMaquTNrZ+D4UzAo8fpw56S6nO5rcSOcG27j2YknLbjAX+YF+JHeg8zYzSgofh8UXxocBXYAIiTH8x9YRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J+IuSuTS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J+IuSuTS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEJGtd2430647;
	Tue, 30 Jun 2026 16:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=38djn0gwXmRmC0z/1ZiID3vOSfiynJ3KfCQ3pCiWW
	t8=; b=J+IuSuTS6YNegztuf+YldVVdFc3Ec8qZJjPBguSEdDr1HwdActxvO2V2J
	6r2N3+ElUMbVjO5tV3VELtNq9IWJwD9S08E+FqjZ7fKBhrohh/+KJC/c58ETbJNq
	PsBlgdVxSA5HEjVlH+TeZfUJ5AK3yCJKvZkF8sFmETiswRL/S7sTk/dqW7sjct9l
	Qp39+v+Gk4tOCzRLppD+v29xnBCLeH5KUgo4hUV9kpQHBBSAH/k53gmJKgFk0wpg
	nkqc/rJUd4qHZ40O2mufVR1EvSb3FFKrVG2SOxiLr2AMFXEqu5HWbJRCal4talmY
	HdLD5Ux/l3ojUjo93a+BUZzTkJ9eg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfyywb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:55:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UGnu8p030384;
	Tue, 30 Jun 2026 16:55:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gb3wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:55:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UGttF26882280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 16:55:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E9CE58054;
	Tue, 30 Jun 2026 16:55:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 948AC5805A;
	Tue, 30 Jun 2026 16:55:54 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.250.12])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 16:55:54 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v20 0/3] [VFIO] Error recovery for vfio-pci devices on s390x
Date: Tue, 30 Jun 2026 09:55:50 -0700
Message-ID: <20260630165553.725-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a43f51e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=q0gwpn0l6oMsUSZbeGEA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX4jJ0YJ4fsI4d
 hn4pqiNxWw7IkYWP9zfod8OqkKuXEnZMRcQE68KH2d2EYa9ci6p/dBGXN9x5UG6tVtO1zEDdBrw
 G/cRbJcW8T6KRbl+grYb5EULHAS3dC8=
X-Proofpoint-GUID: _UVhvDw22nHGGHMuodkXtZgmjp8CWuWk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX54ii8vXjapmB
 chduY4zyCN/nWm31mOodKQnCekpn8seUSMQLiOkzajHDrnwS9Q7q0BglNHMYIZe/RJbZRnLUAMH
 LPUNfLJky9egftg4PCsAEjMz4SPfZK9/2lSLmfb/W0eTTlHIx5o+WedKgcz2RaKpWo/kejnqIEH
 CQAJfrQ8qmsvzHLmjtE3Q4F2RuxuCnUGmGVRUJm0ujDA26Wvj4BgMggI9My4Ng57CNMN7n+8Odo
 VPK8diAh6prhSuAvXIB51s+BrKcd9TEc/axnJ7RwcGnXYaaVtYRbu9ckZ6Dc0UyQGq1DHOeHpEP
 UMTvzAxlDg1Nc7F8Fdnj8N6zc2BjMxIVF7kNdLRcPiBp4J6aopT5tdPgqkc8Jl7jXK7uda5ZIje
 BpiDKHlVnMRtEP9Z56As2NPDtL4P2V0R76XcB6KfXdkZl9jM3Wx+W5+ZpP51y3GglgZiR/cKPxl
 rYM+7r0bsCqEfLWl+iA==
X-Proofpoint-ORIG-GUID: _UVhvDw22nHGGHMuodkXtZgmjp8CWuWk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300160

Hi Alex,

This patch set includes only the VFIO patches of the original series for
error recovery for vfio-pci devices on s390x [1]. Breaking up the patch
series into PCI and VFIO only patches to make merging easier based on our
discussion [2].

Thanks
Farhan

[1] https://lore.kernel.org/all/20260520171113.1111-1-alifm@linux.ibm.com/
[2] https://lore.kernel.org/all/20260602163344.1eda12d2@shazbot.org/

ChangeLog
---------
v19 https://lore.kernel.org/all/20260615183616.2902-1-alifm@linux.ibm.com/
v19 -> v20
 - Change device feature uapi to pass the error data as opaque to
 userspace (patch 2).
 - Rebase on 7.2-rc1 

v18 https://lore.kernel.org/all/20260603182415.2324-1-alifm@linux.ibm.com/
v18 -> v19
 - Fix hole in struct vfio_device_feature_zpci_err.
 - Remove reset_done() callback for vfio-pci driver.
 - Rebase on 7.1-rc7

v17 -> v18
 - Print a warn with dev_warn_ratelimited() for copy_to_user failure.
 - Rebase on 7.1-rc6.
 - Break patch series into VFIO patch set.


Farhan Ali (3):
  s390/pci: Store PCI error information for passthrough devices
  vfio-pci/zdev: Add a device feature for error information
  vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX

 arch/s390/include/asm/pci.h       |  32 +++++++
 arch/s390/pci/pci.c               |   1 +
 arch/s390/pci/pci_event.c         | 137 +++++++++++++++++++-----------
 drivers/vfio/pci/vfio_pci_core.c  |  10 +--
 drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
 drivers/vfio/pci/vfio_pci_priv.h  |   9 ++
 drivers/vfio/pci/vfio_pci_zdev.c  |  63 ++++++++++++--
 include/uapi/linux/vfio.h         |  23 +++++
 include/uapi/linux/vfio_zdev.h    |   2 +
 9 files changed, 216 insertions(+), 64 deletions(-)

-- 
2.43.0

