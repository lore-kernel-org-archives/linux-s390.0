Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4C396D25;
	Thu, 14 May 2026 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781680; cv=none; b=QjmNX6FUlh4xMdlpjAjTd/Riq54nsizDAV7kAUM8UiML4j2xVzUq0qEUxUueoInqK/qSXI1Ia6N8iNG+YSLoqa5NdhHUvPykoKXte4XWpjRy843dfNgH96zl17wfsfopKHfNO4UUO3tO2xaJ5lVyHOdf20bTimAUs/gBjJiwauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781680; c=relaxed/simple;
	bh=P42YvZxGI5G2cnEEMsTCKfL+1dhOLbI9ogZtc8OaZ64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBU3xVRC1fSDqQEDI/vqFMiYq7bmSJJiltl9Y2eV76uRJWkykvQZlr9qD4RtvcuKaZX7Oa0A+QsLj4xAe5tWViKP0dHXQPe9Yz4/zyiKF7yHqLK89Jdk9qVpi6NjKdedJp0KjjB86U9dD8EameqkO+9dhR8WM2YNHPD7IAolkpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bnmS5GPp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bnmS5GPp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E6UItk3773722;
	Thu, 14 May 2026 18:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HZIwTW1oOFUsiUCSp
	EO91NJ3o0zlBjIUbldT7Oqbc5g=; b=bnmS5GPpj48gD7qA5LRO5HjxAvfFeWMwC
	5L7q36+61w1x03wnFyLNiizmQtNJRN9MJFBFFflY3ZqvPTKzpRX0tgrf+0RZgKY+
	V9A8V9HCLktUVyD1fg+jEkpR4RyVQecdAE3/ZUbqHU7FSNfm0kan5Y+if9B3F3cZ
	zdmnK1bLk6sVCKyuQjCS6/quqRs7mwDQUuGR+Rnxt38cFcABBf+Fu5A6dlf7IMGS
	D3/fOncBWK00oHXEuwmDHF2JxEfyBkefkXJ/TDbeVggahAyV0kZV1VL1PDw46URH
	WWmBj8aYE+Wrgux/ITzxrbtvqwca7MKEF2XplU6pi/VNx9iDdjbMw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6w618-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 18:01:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64EHsWLV029409;
	Thu, 14 May 2026 18:01:11 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfh5kfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 18:01:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64EI1AKg16843386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 18:01:10 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FE845805E;
	Thu, 14 May 2026 18:01:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 575E258056;
	Thu, 14 May 2026 18:01:09 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.43])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 May 2026 18:01:09 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v16 6/7] vfio/pci: Add a reset_done callback for vfio-pci driver
Date: Thu, 14 May 2026 11:00:58 -0700
Message-ID: <20260514180059.1553-7-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514180059.1553-1-alifm@linux.ibm.com>
References: <20260514180059.1553-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a060de8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=hcTHx3Z5Akp3fEzgVBYA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3NiBTYWx0ZWRfX6ESYWfb7qsx8
 fH47Blhj3phIu5hR6HtgxOLUKYbA5nsqELF2J4vb8qLWhJZ3VAmkh9UuMnRUBz3GFU1m37Vx1aD
 1/CWI6RYu6cPMnwN93qiVozf9iZaVj1NR62AbbbvjvY4WgiozlmKigik3vA9L4x9s47+oBRXgpR
 wWP5+VORCyC0q3bTS67tty4zkUqi/ksqr5AuE4Ng7nTUFj/bY0vjyYxWkedAJjI5Wv/v5HaHkrR
 9kGqhSUr5sky4H4dY6hLk8ftxVtSvo2eNpmJRJkRN/tSWnvJ9ca7nMUhRvQZVPGXxktreu4dXc3
 WgdV9CCOxbYefP6NSDL2PA05oQSbKArbp8HLV5WeOL9f0/IjUZWFVh93xjfGp3aPt/CldUPTjb3
 iplOBaZrMXpUc16n03jKlcLOlnaPOsZYY7jh/T14V1Soz6fHqgkzFkIYAuLPf3WYSkdX2mLpQ91
 4u5it5Ofe5xNNkUdabw==
X-Proofpoint-GUID: 1hdz0MKJ_M7M0ZZyjcGqEQrDpUl6uLFz
X-Proofpoint-ORIG-GUID: 1hdz0MKJ_M7M0ZZyjcGqEQrDpUl6uLFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140176

On error recovery for a PCI device bound to vfio-pci driver, we want to
recover the state of the device to its last known saved state. The callback
restores the state of the device to its initial saved state.

Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Acked-by: Alex Williamson <alex@shazbot.org>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index f47a49ca67fa..6358b59fab2b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2255,6 +2255,17 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
 
+static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+
+	if (!vdev->pci_saved_state)
+		return;
+
+	pci_load_saved_state(pdev, vdev->pci_saved_state);
+	pci_restore_state(pdev);
+}
+
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn)
 {
@@ -2319,6 +2330,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.reset_done = vfio_pci_core_aer_reset_done,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
-- 
2.43.0

