Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C96390C83;
	Thu, 16 Apr 2026 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776375568; cv=none; b=QpMuH32hTn5DKo4r8vJG08PGpQ44H+vzZeWjkANsGiEJft9J8cjLeRlo7vEJLZpCFe+ZFQo8ShRZ0EwD8JmfYMf1KdVkZ4rf1bbjPDWStNxuE/3DXLf6bT4UIPD+g/rlAd5LhF3KCm2CoKIJh2IzzeEuJ7G1uyCUL7mh21ORx50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776375568; c=relaxed/simple;
	bh=vEX2YgnVtzG/kWcq17f0/dxZGqpGdFexUjQZXcgX1Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHkcXh4faAFTurr3HSqCHQuii607ZdO9SY8mmSa9BCSWeZ1IxSm1AoVJealreTy1Jj4OLUVmbWq3GsYasL0jQUUJNW133ICxkAJo2Ezj4bL0P71jbPZjuM/jNAo7mUu99qLp1Tfb6jqEvqbAg+uUJFTSg0UL8ubRZdz8quPoIok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TN/gJUMr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TN/gJUMr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GJBMMN1860717;
	Thu, 16 Apr 2026 21:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CpOcsvGu0vq9yafPL
	Md8795CqxepEPd0x1m5IZSMpAw=; b=TN/gJUMrR0fe3CPMQ6gfew5ECjscyYUOr
	9aZEe4LG6hNbmgaJ8TVEnUYQoLO47G5T5tJu5Hkj0SMJPNSiq8Icf8Pkk0xdOcg+
	FKmrN/nFwBPq8+CU27CJlQl6x/zIz+Szik2E1c0TzLhhC8XiwKAhCBb5iaAHH/4Z
	B308D+j+CQiJJ+CbmM0sFAGzusxXU29RqFbgYQrNRzEGbgCIDFGze7rcczCoSRx5
	E2/glO2a4wHTF2T+cYuzofaXVNojw1s2UdHo1ojPUWyVhXtn5/hL4t8UFnNvC34H
	d30CMqW7yzTcH1X9xN8cahz+ZZGhAq5+xIlRRTIYpByERfHMx5Xbw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pppcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 21:39:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GK1aNF003610;
	Thu, 16 Apr 2026 21:39:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnmpda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 21:39:23 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GLcudd24773120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 21:38:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 299C258059;
	Thu, 16 Apr 2026 21:39:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1F8358057;
	Thu, 16 Apr 2026 21:39:21 +0000 (GMT)
Received: from IBM-GVXK264.ibm.com (unknown [9.61.246.192])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 21:39:21 +0000 (GMT)
From: Ramesh Errabolu <ramesh@linux.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>
Subject: [PATCH v2 1/1] PCI/hotplug: Add 'uevent' sysfs attribute to trigger slot events
Date: Thu, 16 Apr 2026 16:39:09 -0500
Message-ID: <20260416213909.705753-2-ramesh@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416213909.705753-1-ramesh@linux.ibm.com>
References: <20260416213909.705753-1-ramesh@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: NF6MTuV5Mf8VJ2-Eel-WDikZuXEc9FZz
X-Proofpoint-ORIG-GUID: BMop2iUy01dMTHm49ru5Y80RheRUHDyv
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69e1570c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=CMxJa-TJIm8yq2BzSosA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIwMSBTYWx0ZWRfX1VENHlwvzd8b
 YNs4DXZheBpO/l5ecA4G1rsWZ9xZn/7FvkoJUJPPPDFmScB9UKu4oCgrFKEH8qx5SLJ2EQLJXav
 lSCSAiYV3X8lB4utyjR3F+/CXWU7hVwI1pcmB0rxbIhQLvhqCqYgwqWsNVXWI1Vmr2SOxAmCTQa
 kDYUk9Bo57RdOEkFCJA8nqNT4Op1KkUoFXnVWngZs1NDbA50SHSwFelG3VlLTT00bSiUeOaScyd
 QBGkOCnFzvftYwx4010iAaCJnFvN+IcPjH2pINXgBo17Dnkv2rY7mpO+GDAczqIBohBoqGSnpXU
 +s4Rnk+9B83fEC4v+9r18Y67NU0dzjaydkvlEpT5vJi9Gfx0BZdooLYSVXAhts5xJEX5K+JXxsN
 OyHU3L8eqzs6TjZsGA202k5NGK0zMEvDX7XgaucHp62HhP0j+LlCMQMx3MZfFl7fY1mq/jrQEaT
 HMeBtR02LKE2RE1Gpxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160201

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
---
 drivers/pci/hotplug/pci_hotplug_core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index fadcf98a8a66..c3634b1cc7a8 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -176,6 +176,21 @@ static struct pci_slot_attribute hotplug_slot_attr_presence = {
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
+	.show = NULL,
+	.store = uevent_write_file
+};
+
 static ssize_t test_write_file(struct pci_slot *pci_slot, const char *buf,
 			       size_t count)
 {
@@ -254,6 +269,11 @@ static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
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
@@ -306,6 +326,9 @@ static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 	if (has_power_file(slot))
 		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
 exit_power:
+	sysfs_remove_file(&pci_slot->kobj,
+			  &hotplug_slot_attr_uevent.attr);
+exit_uevent:
 	sysfs_remove_link(&pci_slot->kobj, "module");
 exit:
 	return retval;
@@ -313,6 +336,8 @@ static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 
 static void fs_remove_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 {
+	sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_uevent.attr);
+
 	if (has_power_file(slot))
 		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
 
-- 
2.43.0

