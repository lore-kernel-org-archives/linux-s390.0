Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566966;
	b=Ad/BHuQQ6zNcGSYOy0SebdtU/JaKK3SMquc/qhFWHevxO/uDzGkSyhSnKJLsGTcVMKYj
	 6cZai/eg5Ef3Nd1AH43SRFXzvl0Qn06LsHVpeNODh4nAUoAIRI6NXyG5mWU8m8H4nqfE4
	 LEtgqX/nNY1b2AW6HSSFIs1Li0K/FYUBGy6bdu5mcfCTA2OKo9Vvx5v8/+CiBz5PwH2md
	 RH6sAek9noUFFQsnXqVhJMOQBypUcN7Z/NOnFoG9JbYQu+te+SQFP3WRuIkkhVQ1ikY5N
	 WbNLdF8L/EhbhQUjuKUftz4eeAn7+UNnvX3Y0EhxETFESUZHzTGYJKad3X/243BKd5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566966;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2SXBq08VVaX1hGm52qWDjdxiGylHya0tiucHuSv74L8=;
	b=SMaHUfwKlTA+sJv8OqfRmcymQqzGsk+7pIArQNA5PfFSD8gFIwEbVx9wmb+fdSxk1fJI
	 pFhZ4NBnD8W1xnz5sXctqlSMKntO8OjUqtdOO5gPnoru38EM7Oe/PushXKqSigzBF7nvc
	 sZx9iZOd91kZSHn6ORH/tc73dDUJxH3M1OIZELc7Cmhqp/Tim8b+6dMmHZdcSY627F4m6
	 Ls4X7r1IUAv2NO8VsgXT2EwWtWyfbz7PPoHgKNomt4SeETEW/Z8k1FfqK6CWC1c4F+brv
	 dM8jMA5+J/Su+BAyJDAUpfU7oiwEGZCVZlcheAWzP1RLV0LoCmiwfKyUl2RN+MiWTww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jh0nL5Hz;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC65606A321;
	Wed, 25 Nov 2026 00:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CC65606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jh0nL5Hz
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOMaJsZ2443369;
	Wed, 25 Nov 2026 00:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2SXBq08VVaX1hGm52
	qWDjdxiGylHya0tiucHuSv74L8=; b=jh0nL5HzbOdA/ucJLn355Rcz5Vd/noto2
	GIRzJP1xkKTvExjFWye2tF1R0/5t4V+u05jsA8jOP1EQL8rweFMmWa5Nhm4eSCIc
	czixnUKbzaapmOJTDycCcipiz+PRlvlVg9v+hmv979etYqUod1v5GltBiJ0reLkg
	8u3KssQMnf1/BFeBOULr9KZiBxBaqXb+5HHX6J7H9aenTfKeP4a6RN4k0hTJRuWI
	h/bat9D9Zu/RzjHrDmRC/qWlkWsc2RFjZkqgkY/q9edr492Owr7FtuKKNxc0Df/0
	2f9m0GZR7NGVubOW6wLU8IWSW+uCirtXFM8CJ5fFkRpi3IsV4FU/g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4hmhx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 00:35:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOMZUhg970083;
	Wed, 25 Nov 2026 00:35:53 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4hcjvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 00:35:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AP0ZpYP19792576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 00:35:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A99735805E;
	Wed, 25 Nov 2026 00:35:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF49B58043;
	Wed, 25 Nov 2026 00:35:50 +0000 (GMT)
Received: from IBM-GVXK264.ibm.com (unknown [9.61.244.201])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 00:35:50 +0000 (GMT)
From: Ramesh Errabolu <ramesh@linux.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        driver-core@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Leon Romanovsky <leon@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>
Subject: [PATCH v6 RESEND 1/1] PCI: hotplug: Add 'uevent' sysfs attribute to trigger slot events
Date: Tue, 24 Nov 2026 18:35:44 -0600
Message-ID: <12826c88951e0a19cbe56daad681bbe750ac01e9.1795565279.git.ramesh@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795565279.git.ramesh@linux.ibm.com>
References: <cover.1795565279.git.ramesh@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAwMSBTYWx0ZWRfX+UMX18Lg/acD
 wea7DlPLDD3EJ45TpLufitCpCpdacYzwgAPI5JXMysFqAZXY8bFsjDVj3XeR2+s3O8hAdjmhkg+
 zSsYJFyuwpik/w7Hfuci+ekNjluev+Q=
X-Proofpoint-GUID: D-4N5sqajm5yLu502KPthUOkpSckz0UN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAwMSBTYWx0ZWRfXzFMUlxcsKtlO
 9QcP4TilBW2TZFgl62/8MSrYR4Uc1vM6ZWX/vkhTbNa1eJMnz6FQK9DbrsCVvoWx55QNiMGa8dR
 JbnTh2l0w9E+W8BjfFWwd519kdVkdQHT6CEeLURRlJWF2wFc3bxgz93T488HbwbRbRmfP1Xqp00
 KcMsYYG+17Iy5bHgh2TjG528PYD+w4Vzd6pJ9yRrj125jFHwepajGPc3x4K4M3N8BNPeRniAR0F
 5MRrkwZM9xwzcsbhr+bZcMHZIL0k0J6EVWMF4BY9jimHXN66aBkW/xmge4mWzKKL8y33idJ4Kz6
 lTl3LapqCyWwJRnHEVrr1b8i2Y0V1mmUyoSs3o0ZmGlCPrjKd8KT2m7IrIjyVGD8iHXdfCvBUCC
 RAIdMbnHZ0y7hn1IDLqrA68aat+PPw5nU548cuwHd0QtsrgI7jo6mYEPlIjFCMSVfVQz55+Nx7J
 g4sQqH855xzrBHAL6fg==
X-Proofpoint-ORIG-GUID: y8u6OYBzVqV7enczXYCMWMcqgurvPrz4
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b062d6a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RLFbKyCAV2Q4rzo76dmsHbHSXqs=:19 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=xQ9kGAJ0mIG5ymL1pEoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250001

Add a write-only 'uevent' sysfs attribute for synthesizing
uevents for a PCI slot. This extends the existing uevent
support which emits a KOBJ_ADD uevent in pci_hp_add() with
the ability to replay such uevents for cold plugged devices.
As such events are only emitted by hotplug capable PCI slots
so is the support for synthesizing them.

The change was validated by manually triggering 'add' uevent
for a specific hotplug PCI slot:

    $ echo "add $(uuidgen)" | sudo tee   \
                /sys/bus/pci/slots/<slot-id>/uevent

Signed-off-by: Ramesh Errabolu <ramesh@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index fadcf98a8a66..bc8fa2f903b5 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -173,12 +173,26 @@ static ssize_t presence_read_file(struct pci_slot *pci_slot, char *buf)
 
 static struct pci_slot_attribute hotplug_slot_attr_presence = {
 	.attr = {.name = "adapter", .mode = S_IFREG | S_IRUGO},
 	.show = presence_read_file,
 };
 
+static ssize_t uevent_write_file(struct pci_slot *slot,
+				 const char *buf, size_t len)
+{
+	int rc;
+
+	rc = kobject_synth_uevent(&slot->kobj, buf, len);
+	return rc ? rc : len;
+}
+
+static struct pci_slot_attribute hotplug_slot_attr_uevent = {
+	.attr = {.name = "uevent", .mode = S_IFREG | 0200},
+	.store = uevent_write_file
+};
+
 static ssize_t test_write_file(struct pci_slot *pci_slot, const char *buf,
 			       size_t count)
 {
 	struct hotplug_slot *slot = pci_slot->hotplug;
 	unsigned long ltest;
 	u32 test;
@@ -251,12 +265,17 @@ static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 		if (retval)
 			dev_err(&pci_slot->bus->dev,
 				"Error creating sysfs link (%d)\n", retval);
 		kobject_put(kobj);
 	}
 
+	retval = sysfs_create_file(&pci_slot->kobj,
+				   &hotplug_slot_attr_uevent.attr);
+	if (retval)
+		goto exit_uevent;
+
 	if (has_power_file(slot)) {
 		retval = sysfs_create_file(&pci_slot->kobj,
 					   &hotplug_slot_attr_power.attr);
 		if (retval)
 			goto exit_power;
 	}
@@ -303,19 +322,24 @@ static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 		sysfs_remove_file(&pci_slot->kobj,
 				  &hotplug_slot_attr_attention.attr);
 exit_attention:
 	if (has_power_file(slot))
 		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
 exit_power:
+	sysfs_remove_file(&pci_slot->kobj,
+			  &hotplug_slot_attr_uevent.attr);
+exit_uevent:
 	sysfs_remove_link(&pci_slot->kobj, "module");
 exit:
 	return retval;
 }
 
 static void fs_remove_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 {
+	sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_uevent.attr);
+
 	if (has_power_file(slot))
 		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
 
 	if (has_attention_file(slot))
 		sysfs_remove_file(&pci_slot->kobj,
 				  &hotplug_slot_attr_attention.attr);
-- 
2.43.0

