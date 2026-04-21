Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A23B7B6B;
	Tue, 21 Apr 2026 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776806908; cv=none; b=D/RkOh5yDfWvk22kNHK7A9wU6jLhH56tVoU5Q94y15hcFu8li/kxbhVz8JS+8Lkw+Y3Bao3uZxL5uVOV95eMrG7ZqAkNWDFFPWYr1NEbuMF3j5oXnWRHo5mA0/NpaVqqzeKBlnd90cYWhsQkA7Dzc2flggkiCw8rSSWQiTUw2vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776806908; c=relaxed/simple;
	bh=gLO72HpYILTjhJP3ADM6YgdW1vay2WGkfbYmUAKTFL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4FgUZiFIKLaMiuREFN5gUKUEjzWHiONwXpqGlhKg49HMgsOgfCw8Sqwq0GwcX9rq7yVyWt/v0K92A5EoLBkTVKmARsGwjgYypFP2ZQxSJT+e1MOrrLeUlgrAWdUnF5QLu488dFB+aSfSuZDITijlbXgEJRbm+fbkvwVeK62f8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cafNqEFM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cafNqEFM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIm30D679320;
	Tue, 21 Apr 2026 21:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7JjQ/P7hm0zpQ7/YHg7UQkUE4x9+XgshMilrWg0Z3
	Hk=; b=cafNqEFM9DZbbuLm1UoqscKl/aPDksDwKYFo03n/5/6URRdAUjtS/7PIX
	cAR1PThsHupsqFH6I1B2QwcxhWfNHlTMQ6tIU4Y/fEO0tFjvDDU+uPAL4rYZv5Q6
	C2JPDEV0wFfTtd6l3I8TBGBJVsq9eVD/hvaFsuPMLOFveojx7V8oFwHL+6MKvuJC
	L4haWkshO8ZxjC9MOY827XtZUzN+gXoFTiBeaiJMr/yQem4FHOogHxDqQy9QA/7d
	/nvcGVb7Ce5YhrF3Ad5mHc2q/Vw9t8UUY5lWxnXWIrWYBsfT5Fvg8H+t/nblZt5G
	+pOxQndZqmUsoXqyHg0sNR6unv+lw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7ggk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 21:28:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LLKRqW007617;
	Tue, 21 Apr 2026 21:28:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgga9hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 21:28:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LLSN0427329096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 21:28:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E90D45804B;
	Tue, 21 Apr 2026 21:28:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D69C58059;
	Tue, 21 Apr 2026 21:28:22 +0000 (GMT)
Received: from IBM-GVXK264.ibm.com (unknown [9.61.249.207])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 21:28:21 +0000 (GMT)
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
Subject: [PATCH v3] PCI: hotplug: Add 'uevent' sysfs attribute to trigger slot events
Date: Tue, 21 Apr 2026 16:28:18 -0500
Message-ID: <20260421212818.4481-1-ramesh@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Hy186v1r5P2xMCgPA6DuL5Cvqq1jmcsl
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69e7ebf9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=CMxJa-TJIm8yq2BzSosA:9
X-Proofpoint-GUID: Hgbl4nBtl209U3aHG8EJ3c1K7NwgYmtP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIxMiBTYWx0ZWRfXyyMxe0uWTYAb
 qH/cCSZC+72qeclS/dF/hypyHWDvUiVOdT4Inp35QCGCrh6nEZNalaRuDkdBv/N5rYPTUPRF8h0
 E9RB2vn67onxGMWPv4EM1Jx6SdncWQ1aI6EX2dsPwON7rsSSZ+jibilDHCiIJSc8JRBWYrrpuWZ
 k8pqLmmz3O6hQ62FtYLleUOLPTTjkD8ri7mo5RQs0Z4Ri2Pi7ShOKCF5NhNEhdW7V5B9xFKfAJT
 KBa25v+aBKSqu08oQGXLj2c1WmHxHY+UX9DSDA3ZyeympX2imkwTRTNpNkK5jZktOFYObtlKTn6
 yqGszPDuFCtHtg3XbBgDEAanO83plYn6vm3u+RYY6aayDln02AMCtiYpmOyrLdxU0kqJQ8bbQsp
 yZXwZ/6DcIBr8gpzI7Ez9sgd83cIdCT+yc5qIjW2tku2Uh21t3Rsyku8q8zyyR900PhIlmJIzKM
 9zoGp6LRVzkPMfb5Vuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604210212

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
 drivers/pci/hotplug/pci_hotplug_core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

Changes since v2:
- Fix commit subject prefix to "PCI: hotplug:"
- Add Reviewed-by and Tested-by from Niklas Schnelle

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

