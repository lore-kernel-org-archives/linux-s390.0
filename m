Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6037CD24;
	Mon,  2 Mar 2026 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483621; cv=none; b=ufR/w+PmArBVbZdSl8v8D9MTFnwTYjBXvLtKZEMaUiVPlDUOmM0+AgAjtWFRjTmuS0rHDRfQBBcktBpabm9EDAbjGrniE7ZQDeQ/tFhHryVDIyKVMYpCMr1sUtOAUI15PYIyD8tNRZiNpCUV1jegiUtaVNW0GAhIMNMcZxQQ6/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483621; c=relaxed/simple;
	bh=K8z6vzQuEWx6h7ENVIZXQnK4WzAabV0qh5WDamoFsxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otLzESmEjQhIsm1Dbi3zwN+/HvOrFKO1t6V0Rn5Rbrx3oEkl2h1Axt/Ct+R3uLuv10gLblkFRGFckBjp9QteCvMfSjz45aF4Qy/19TRIYuO19NSNAOCt8xHIbSTsgq4kSRI/IF2Gtviz3vdU9H+QmkAskr55DnnemobBqcWNHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X6reM30d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X6reM30d"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622JOjkG573073;
	Mon, 2 Mar 2026 20:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Cjb15mnhM95Gk/rAz
	w8XWdQ5qG+FSZX/kcSugrKkgu8=; b=X6reM30d8PfB3eA1dnZxmN7y90Veaxd90
	9kHztAceakVHosA6vFRKtwgl0OC9jUOFFuCAWCEs5P5F6q8NMZG3tTigdDAzU5eS
	tef5NGDike2H1EslhqcptpBk9eLPcNz+CK4bnKoDFfO0SMhCmZQqaoi47L0TOjDT
	HhCw+8MS8vbYHH+TUJunr83DFoMsZ5Av85CEnIfbuHSpfxP8hfe4HMoSt558D4bD
	2Jf+jTE547VCENRwHVcLpjieCyw3V1U6QPa7GlebbD+wFVdwlJb3WRCyasvzFcuK
	Lj/zlsRRgpVt8WBqHSPj0fTRK9QvuagOuP44xMAoWgtMeBZF75x2g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjd8d9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:33:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622H7vtT016407;
	Mon, 2 Mar 2026 20:33:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmbpmym1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:33:32 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622KXVDv22676222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 20:33:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2848D58061;
	Mon,  2 Mar 2026 20:33:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA5C558053;
	Mon,  2 Mar 2026 20:33:29 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.18])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 20:33:29 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, kbusch@kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v10 3/9] PCI: Avoid saving config space state if inaccessible
Date: Mon,  2 Mar 2026 12:33:18 -0800
Message-ID: <20260302203325.3826-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302203325.3826-1-alifm@linux.ibm.com>
References: <20260302203325.3826-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a5f41d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=zIJZGsahcqu1twqqOCkA:9
X-Proofpoint-ORIG-GUID: zhqdtWmTLQBdM7LM7pfQjsekEfVohs9z
X-Proofpoint-GUID: zhqdtWmTLQBdM7LM7pfQjsekEfVohs9z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE1NSBTYWx0ZWRfXwOYnluNFpfK9
 8xGG9cuJUAhwsaKfffJU3VF6s4wI6UhZDgquEJrqIh3cfCn4tKu5aa+Ia0RvMh2eYPoBfKTJoKI
 BTvWMYcW7zA4uO6Jt6lmiCwtDQUj+v2f3UBKQm+zntNXHR+oXd6SaiKIOrrrQPBoE5AVelNaIhV
 eUHTAdXUpfKvwh82ncDZXj0uBxcSh9pIngN0C2zzI/jMFGvyXSOOaIcVMPcSVw9psR7TPHc2coi
 jFweGRDOzFMecPTLqy2zTfdM1FWoG48iH8xZtlh5lZJm1xx1r40cevW8fHry3v40jnB5NhWmitR
 sdgKYBSwCQmsEXs5iduptxFfSil4sRuFO4RPG4C9wCCjSa9WmafR3qaR/1pEJL3vwYCU7Dq+HI5
 NpZ3Akc3FQ10YpdQCHZDze/13vO4aHveShnRMSeNiAPdcWY3EyYVCYclHbKyt4/4If3+mjR7M47
 qTM+XeIPzmQVd/BBrmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020155

The current reset process saves the device's config space state before
reset and restores it afterward. However errors may occur unexpectedly and
it may then be impossible to save config space because the device may be
inaccessible (e.g. DPC) or config space may be corrupted. This results in
saving corrupted values that get written back to the device during state
restoration.

With a reset we want to recover/restore the device into a functional state.
So avoid saving the state of the config space when the device config space
is inaccessible.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/pci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2781577ddbe..85a4edf756bd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5015,6 +5015,7 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 {
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
+	u32 val;
 
 	/*
 	 * dev->driver->err_handler->reset_prepare() is protected against
@@ -5034,6 +5035,19 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 	 */
 	pci_set_power_state(dev, PCI_D0);
 
+	/*
+	 * If device's config space is inaccessible it can return ~0 for
+	 * any reads. Since VFs can also return ~0 for Device and Vendor ID
+	 * check Command and Status registers. At the very least we should
+	 * avoid restoring config space for device with error bits set in
+	 * Status register.
+	 */
+	pci_read_config_dword(dev, PCI_COMMAND, &val);
+	if (PCI_POSSIBLE_ERROR(val)) {
+		pci_warn(dev, "Device config space inaccessible\n");
+		return;
+	}
+
 	pci_save_state(dev);
 	/*
 	 * Disable the device by clearing the Command register, except for
-- 
2.43.0

