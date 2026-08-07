Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404BC370AFC;
	Fri,  7 Aug 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786125700; cv=none; b=MT0HPMiIUj95XhAJh2NkKjFjFp2sT5AV2gVnJ+p59gtgLNFF9lZIjXv7CzNiVjfzoYZoFECdRzMezmygHJBOsfITceHiVxlSK6f0DADHZDIoCN6NWtmV6vbuBTc7skM+wdIKHiIx9JOn+RJDI+8wsbUgj4CBmUcT58jig+C9A/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786125700; c=relaxed/simple;
	bh=OOr+Wff/xEuI8eX1p2dnP/IYftgWz7YPQEf/kzMRaZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+zYCHxcxT7ZRD7k3UCrHZ124g2Pbz1VqDZNlyS7DpKV938HoC5GXGXy1x9iq8vWCgurYmLWAwrMA6oDWw8bsOcX2+BGRdbaChvIctuFO3xSJbBHRVzrikz3vH1HW353wu/lL4zGyS1Tg2xwI2NhSNA6o2Qsxq5c1mEXs2tBSJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ejNlKmtW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ejNlKmtW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Glagp154018;
	Fri, 7 Aug 2026 18:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2SXBq08VVaX1hGm52
	qWDjdxiGylHya0tiucHuSv74L8=; b=ejNlKmtW79mlTnc3P1R1dCFBZQucHWbpp
	VsWOU6NCCoeUcTLimFlO8+tjkaqne0p35EVY8Rl55DkwjX5LXdplvb+Nyw5z91Ka
	nCRxMsFI4ngyCBjg56V2nEXw6YE+gniG/JUqdgcH4Fxuwe6wptInHekPIqKS9Nah
	hUfnqIwV6l1JpbSCbrCj0yS8zWtgFfXs7PSd3RhSy5ih/tUbuff7CLWXQBtutjhK
	s5ha+sktGNnHJsmSUHJLqu2D88MCQsuzkRNZJnWRAWV+jJqvYdk9i0rrYtMYgCPe
	kcWQuor98S5/BFkx/zgHGobIkTWMV1YptJm9p3d+FexMjhPXAFtpg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01n77x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 18:01:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677HuMxP018503;
	Fri, 7 Aug 2026 18:01:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhrpu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 18:01:34 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677I1Xi047120676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 18:01:33 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32B1F58058;
	Fri,  7 Aug 2026 18:01:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3C8F5805D;
	Fri,  7 Aug 2026 18:01:32 +0000 (GMT)
Received: from IBM-GVXK264.ibm.com (unknown [9.61.251.189])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 18:01:32 +0000 (GMT)
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
Subject: [PATCH v6 1/1] PCI: hotplug: Add 'uevent' sysfs attribute to trigger slot events
Date: Fri,  7 Aug 2026 13:01:27 -0500
Message-ID: <20260807180127.62471-2-ramesh@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807180127.62471-1-ramesh@linux.ibm.com>
References: <20260807180127.62471-1-ramesh@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: x4j_Gi0m2nPCLcVfOX0DFWs5PF7A98Pw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzOSBTYWx0ZWRfX7NR+VExYLv0Q
 /ehV6j4+0zZo8H0joSF04Icsu0nfkFQva34vtm/F+6ETu7rYv5cJR+DlaDuMUaaCw0ajg0Rx1X4
 dQs5LcNoIlODQ3fSRKyNnFmg4Tkg1I4=
X-Proofpoint-ORIG-GUID: npgiPb7eqGsBH1tUWKV67rjkuQY4M1Rc
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a761d80 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RLFbKyCAV2Q4rzo76dmsHbHSXqs=:19 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=xQ9kGAJ0mIG5ymL1pEoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzOSBTYWx0ZWRfX/tXMee+MkomV
 1AUgidA6WrE6i+k9FadoEQ4CGJ/x0aXLaEsmzJRzCCVRnw3QPeRKa3+CEd9RmrYjIqNemdffR1o
 2nBQ2oCl5PT7VGcpND3+xO1K3TPDiGNYSyAlMtEtWdHoQ02gGMv8HtYyXZPM1cFEuYSTfNyycfK
 UvWFhr4tAGBWqMSELeHFq6mDd/xYlLG/GH+yQDAdB06nhEUExSOwVZoGV9Zv/m75NFTy3RUPHt9
 iJ2yVS1tJJ0uBJ6r56xW9CG9r5WnvGe3shy0M4gbltS6C4RtdYCXLM0g+3zdBJaxDFHqHX/vs7D
 UiQE2i9vAcxtcdNxTrrj4SOTT28WNmTqxEd0igtLAKB04+JXTjM15yQFQ3mlpN//GvypBuseLqd
 gh3/IxI69Og0uhEDouM1pxPd8rf9Ko3qal90NoHabU8KKmoOnBwmvWJDcfMnilyZsV+pp3fxJoy
 2OIAvAQREzHiTGyk7iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070139

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

