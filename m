Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEBC3D75D3;
	Wed, 20 May 2026 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297085; cv=none; b=JU04Pt8zjuNNXaYdGXxYARVuDXPhx2dcwNVFKcnE7mfcYxOWWBiCOJ2B+RfYfqNnxf3+cH9JU1YRAb2BnNGb8QJOSLYJLIqQS8mR95oEXH1rmPTvY0Bu5KRuk/6sTlo9coSFO52fgUbrNyB9tzhGJ6wLER0/ihKe9m8E2AOh6p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297085; c=relaxed/simple;
	bh=kDMLUv+qGFXTZff8n7B9SWz1eb0xmrDVNGip6EZGbB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpziV/uNPOg2EkjwKF5g8daRBfRNg3Ei6QTqWtuNYvPpG+B2sT1I2Nt4aoafWl7XsC4keQlCYQKhuwHKvwz5++qVvMyi6u3SwTLBb9LYumI+xzzSh4fbOIXkVhT2ZqT4SVQOlxn7P6QIrgo/B6V8UE74qcxtVxTcmpl2i5ez+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kWDzuTT8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kWDzuTT8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KBXoMv685729;
	Wed, 20 May 2026 17:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RsjEQ+ztMbfg0FMP3
	X8XOwCXQZzCQzdBTpV6PYewqs8=; b=kWDzuTT89qWyaOQHDHPtn19CxQa6DQG8B
	FRecaBXKqYKqAWQb4AN0CxQYKXyGl8hhpUsK6Xn/BWr+RJPbr1qbDK/uJavovw0H
	01sEDNa7fbb4G4+FdqhyN3I6era+TYi4/FS/TxWMJIZjh5ol6H9IOK/KdDaqE8hU
	EsUf3kb9SAnZB4Lp+hPXn0tpB5G2A+w/3yQJAIc/ge7jG8DTtDZatPKRRaVlxhD2
	Tv7h0fvcPqkc3zniCOAImHFV65cabkvXDn/olsNTffWE4jcTyYIhxDl6SEu3J4wp
	vq4BRIpeF4SizxKUeHO2KKejMzogowcRevCwPj5nIjxAidgOgT6ZQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88j51e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 17:11:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KH94gK006673;
	Wed, 20 May 2026 17:11:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w0dtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 17:11:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KHBH3X23266046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 17:11:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97CFE58055;
	Wed, 20 May 2026 17:11:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9766F58065;
	Wed, 20 May 2026 17:11:16 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.46])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 17:11:16 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v17 2/7] PCI: Avoid saving config space state if inaccessible
Date: Wed, 20 May 2026 10:11:08 -0700
Message-ID: <20260520171113.1111-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171113.1111-1-alifm@linux.ibm.com>
References: <20260520171113.1111-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: dTSkuoIwsT6r_4pnnZTyrJqIwm2ArIRq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE2NiBTYWx0ZWRfXzbUUA9rcyFss
 tTvmpR0hoE4wvWs9RXdiJGtok9icfL0whkWAGyM1wz4La2FcGY803hVCz6BSaRL51fWUSc1mi3T
 IDVvB4jbR3iGKowwpKdmhdMNSq4iXETwEA2r2Yh0dsGFy2uxn80Z7RhzJsQAuRjFemk7WYQQOPq
 luGLYYCNr4voM5+UWQT7vJ6kWF5gHLFA5AqsU5miOyhFhDJ97INc7o8lVGYjibwjg+vgv83GFrR
 KwK6nRrIuR5VuQQ6+7+fNbvbBy6/+B238Sln3+TnQuGoVBucAL/tkXSKJ+ff+G4yXrc3mnvci2Q
 JdxPfaDlVxm6ceIV6b3VjtTn8FiENvM3yYxewKM2NUxZ9ugsZdRE2UzHbSPodUujMfDcqry4mRI
 mQTFMfTzCm526WRfBk7znql2gWbN92ORMPmT8hqe+5Hs5jUqy4gkm/9Ri5v+Gn9dhNERvbNPY9M
 vBrSOKejDRz4ty+9+xw==
X-Proofpoint-GUID: 9DPUXEWcdtktxtkbPdpLUkbh8SCODS5r
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0deb37 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=qS04rNcGil1I7-YeviAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200166

The current reset process saves the device's config space state before
reset and restores it afterward. However errors may occur unexpectedly and
it may then be impossible to save config space because the device may be
inaccessible (e.g. DPC). This results in saving invalid values that get
written back to the device during state restoration.

With a reset we want to recover/restore the device into a functional state.
So avoid saving the state of the config space when the device config space
is inaccessible.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f5f8291482b0..973d23e41c48 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -722,6 +722,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
 }
 EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
 
+static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
+{
+	u32 val;
+
+	/*
+	 * If device's config space is inaccessible it can return ~0 for
+	 * any reads. Since VFs can also return ~0 for Device and Vendor ID
+	 * check Command and Status registers. Note that this is racy
+	 * because the device may become inaccessible partway through
+	 * next access.
+	 */
+	pci_read_config_dword(dev, PCI_COMMAND, &val);
+	if (PCI_POSSIBLE_ERROR(val)) {
+		pci_warn(dev, "Device config space inaccessible; unable to %s\n",
+				msg);
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * pci_find_parent_resource - return resource region of parent bus of given
  *			      region
@@ -5027,6 +5048,9 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 	 */
 	pci_set_power_state(dev, PCI_D0);
 
+	if (!pci_dev_config_accessible(dev, "save state"))
+		return;
+
 	pci_save_state(dev);
 	/*
 	 * Disable the device by clearing the Command register, except for
-- 
2.43.0

