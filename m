Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA7948423E;
	Wed,  5 Aug 2026 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948939; cv=none; b=p6HqS+OeyHs5+bAM4Hx2ga5nR40S/fhwiPpKC2kZc8UMMV6/nXDUIxubRHQKRH3TxzSzQkGYMFIpB95nBl6/OTQ34Cg2nLswDq4tSth00wSQQXkS/iZBFLFlqyh80XuS8vQmBZRcEs4cKp4fBAdYvhjmVVrSda05jiTqyhikLaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948939; c=relaxed/simple;
	bh=S2J6GfTA17MRPi8hVmy1uCqMXutp4PYcAl3ULfkwQ5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVNEKmLhJHF5q3FUTePZOj24QpInG0ENwx9LN/f5uMn0QLQNqjvy7S0qNk5JjQxgcPFb61zX7aiP4+pmJlUjeobMl4tTH2kpicxzdoPJCzbEsLKrfJzpbdSQR4YmuHocLpl7AWI7GKyIXyRrbmY9qwy5gSQYw1gq2loprm57dOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U6uxWKiR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U6uxWKiR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Flwbp2398214;
	Wed, 5 Aug 2026 16:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=12J8MB6C2cv981QXO
	JBi1IBshXR9vjAE306Ivlw7e6Y=; b=U6uxWKiRDaAiu5VxkFYia2SV/gYgqthfY
	kcOa7JGpBkoV+ChnzugAWJxSC3maTyYiS10x/ufUSrhRFDNmT+4tbliWYOdG7Naa
	cIFXQF/6/UFqTrzKMQ3Ij54qPAjcGfxJWdc3xOV/LTHEnIUG/td5yTO7+/4vOZwD
	H5MTHyBii4rrMi/qHGn5uQJ5DO4L0JSOK6MqGx8aK5/7lcJiEF4dzHcRQ0Nw+MtN
	EdIecxrpfgPfVx5fSC54XWNxZ8XxQ0JUUbfZ9GS1aepoE+HK83sBa4EdJ3TFSwqE
	H5AGxINqZZ3Xw9LVO/WjufcHH35qHeexaFY0AsxyWJidHj/h3ih8w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqv1hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 16:55:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675GfIIJ007553;
	Wed, 5 Aug 2026 16:55:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qqjc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 16:55:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675GtO1058393074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 16:55:24 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92ABB58043;
	Wed,  5 Aug 2026 16:55:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93D3358053;
	Wed,  5 Aug 2026 16:55:23 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.193])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 16:55:23 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v23 3/5] PCI: Avoid saving config space state if inaccessible
Date: Wed,  5 Aug 2026 09:55:16 -0700
Message-ID: <20260805165518.794-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805165518.794-1-alifm@linux.ibm.com>
References: <20260805165518.794-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 7wFz823zbD1o4DCd2xqTVqB2Dc6YdmQN
X-Proofpoint-ORIG-GUID: PWo_ybriJhMSCga8pXki8OWWYdcG9kQH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzNyBTYWx0ZWRfX+9L9UUvgmotL
 d0ArEQDHr5FcRxGhpfUuraXsatpnTyJFGPZLQg6xuyhPHLjDDJ7B20l57xWoC4BnhytYX6GPkWN
 sw3RwESs+ybrU6LFuPWEWg4sf0Hqr5E=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a736aff cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=qS04rNcGil1I7-YeviAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzNyBTYWx0ZWRfX9RyaibMKvvjN
 NI3YDNPRvuDgH6nVFRq+tbo+NnC6YTyiedeXJStKbERGVbpi4w6VrgXIyp+g9NCNHKvS69cd78t
 2jM5EA4sfyddyvsUSZYtaGNRaIFTFxNmX0ltYbp7Z2+C4geywlJbDXz6PjrOV8KIvJe6FzjFaQN
 cEboLiwvKmjXr30FwNp5IowvASPqLuAEzqNHzmOMCyG/FDjHMxLeudZ8nb7EuAOYblhRaDjZZ+f
 +X7k/mEY29hBanW1auyQl/PKODgnQAHXotbFHFbZDRqFjzubmUfJmX2NEBPckgcDpoExFnUekB6
 Y88z2+vowUmo2WrYInQoMXgrOm0FnS+vlIu6c/m1HQzLuPOctW7pUwhv69CdpJSi5pX4azRvB+2
 RQorwBuP5674kRsK2nmUG3amxEqwKSQqb5gw1J+fL7JwB6wAIbnp4/niYm57WouoY3jEktBY6dm
 tou3BhLdTNxYo19pdZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050137

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
index 350bae907ebf..e8d7de77241a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -713,6 +713,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
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
@@ -5059,6 +5080,9 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
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

