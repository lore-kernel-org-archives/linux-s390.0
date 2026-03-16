Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD8B338592;
	Mon, 16 Mar 2026 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688563; cv=none; b=WlJ3Ltf4Wr040WCWkZQFwKGj3U4oNNC+oNHvPYw0UbdA4F4Z/9yEYARDDWhvoVcHM0xLHg5uKBVo5Tln0YvNXyjgwrRWNODg5+eHysbPicbd0d6UVN+nCvSno58MkL9kXqMC5f+mUYauSqoVofhc/cq4yJ+7uSlmn6iO36+91Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688563; c=relaxed/simple;
	bh=TY2zpKNifG/8eMBOZOhi6HU+JgCTeK/+REWlaOd7vW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4JnYNr7NEB3im4qDrPe5S37c4eS9D3i2vo1csBnBKdbv5vzPbe+2Nw+FPb0wFd2ds+f/e0BJVyEuKTB26JilLIgrMT4MPhg41H+hH/jHydPnA3YR0xedL6zF4LoryzKWd1tI4st4ZUlI9NZ6ZLx5rR0WUA7Ruvku3cddGaXGxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IlSsUfKW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IlSsUfKW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GDmT7v231841;
	Mon, 16 Mar 2026 19:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aOTMZASEbw1JAk72/
	rixAqSaOEQh2zzVQjtzAMAH4bo=; b=IlSsUfKWh2MHVcW/Ip801uPGZJppXLHxv
	NNy/qB/QqVYUIjFd2mpoUUMU8XbBW9ZNiPrF8aWCyQSg8kx/uesFbU2W5K/91EmB
	+uFL90eDo4iwbNVR3jD5m/8m/Fe0W+Rp5mUR6128YefIA6j+Xapu85RchYD/fXu5
	Ysr8f0nQRVSz8htcrUJMj88WcMXnRT6GqfSKStE+JKFXJQii8rGF1uOPd9pzDMGa
	luclLrms7TgzncS7dErptONQdqNsgqd0cKp9IGqDUE321JKZPgB9tGuyQxFwshyP
	/0qyLv+1W3M4g3yaC7K8gLy7WXjv3YPUCrhwHGsKTIu42x2T1c0vw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs1d31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:15:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GGZPJp028452;
	Mon, 16 Mar 2026 19:15:54 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq15tt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:15:54 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GJFqwL4588032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 19:15:52 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8032B58055;
	Mon, 16 Mar 2026 19:15:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AFA158063;
	Mon, 16 Mar 2026 19:15:51 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.131])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 19:15:51 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, kbusch@kernel.org,
        clg@redhat.com, stable@vger.kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v11 2/9] s390/pci: Add architecture specific resource/bus address translation
Date: Mon, 16 Mar 2026 12:15:37 -0700
Message-ID: <20260316191544.2279-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316191544.2279-1-alifm@linux.ibm.com>
References: <20260316191544.2279-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b856eb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=WI2LcE4NPZyv2LzpnzYA:9
X-Proofpoint-ORIG-GUID: 9B3VMW4k79C6H2lLa666312DBvUpP6oo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE1MyBTYWx0ZWRfX5NpBeL/2x8Um
 421P7c/cW8Q92JxG2L8c43QxPU7hGOcEf52+z9/QnHwaEjQZCnzef95zeqXCMSgFM7t8laVEQx9
 cnqBAJJiczPHVxijvFWrU5JzRRibvqHIEgW6PjfAji+k+TH6i/5vNVpcbnRllZJb4sEzZEedxZS
 vIxKJyD/U3KniKKTLCnNtRrU0iZ9101QTTuv/eEpHBGno62FH8U+aXNDBaupNTjIJ98/qYMUleP
 DKrIwE1sqEQo+MkPWWq+W9X9Sfwpt5EeFvukRgW8pqNiPzqygCdH1VvcrRRH2AT8ptXkCcrFGY2
 TSC6MLrCZf+TiUvo+pKYUisKLU4bcgAYSGhFNigWnkshb1bL+yZF3vlkpbVUeFz0OAVBCuodW6Q
 +iqMjcyP5UfLYSfRUgXnc7M8CK91DxHOobWDHsr2qbG1suGNhmzG++/OFi2lcEcpDhD9OoRP5hE
 OaZAPRmd+eYfNPeaBTg==
X-Proofpoint-GUID: 9B3VMW4k79C6H2lLa666312DBvUpP6oo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160153

On s390 today we overwrite the PCI BAR resource address to either an
artificial cookie address or MIO address. However this address is different
from the bus address of the BARs programmed by firmware. The artificial
cookie address was created to index into an array of function handles
(zpci_iomap_start). The MIO (mapped I/O) addresses are provided by firmware
but maybe different from the bus addresses. This creates an issue when
trying to convert the BAR resource address to bus address using the generic
pcibios_resource_to_bus().

Implement an architecture specific pcibios_resource_to_bus() function to
correctly translate PCI BAR resource addresses to bus addresses for s390.
Similarly add architecture specific pcibios_bus_to_resource function to do
the reverse translation.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/pci/pci.c       | 74 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/host-bridge.c |  8 ++---
 2 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 2a430722cbe4..87077e510266 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -272,6 +272,80 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return 0;
 }
 
+void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
+			     struct resource *res)
+{
+	struct zpci_bus *zbus = bus->sysdata;
+	struct zpci_bar_struct *zbar;
+	struct zpci_dev *zdev;
+
+	region->start = res->start;
+	region->end = res->end;
+
+	for (int i = 0; i < ZPCI_FUNCTIONS_PER_BUS; i++) {
+		int j = 0;
+
+		zbar = NULL;
+		zdev = zbus->function[i];
+		if (!zdev)
+			continue;
+
+		for (j = 0; j < PCI_STD_NUM_BARS; j++) {
+			if (zdev->bars[j].res->start == res->start &&
+			    zdev->bars[j].res->end == res->end &&
+			    res->flags & IORESOURCE_MEM) {
+				zbar = &zdev->bars[j];
+				break;
+			}
+		}
+
+		if (zbar) {
+			/* only MMIO is supported */
+			region->start = zbar->val & PCI_BASE_ADDRESS_MEM_MASK;
+			if (zbar->val & PCI_BASE_ADDRESS_MEM_TYPE_64)
+				region->start |= (u64)zdev->bars[j + 1].val << 32;
+
+			region->end = region->start + (1UL << zbar->size) - 1;
+			return;
+		}
+	}
+}
+
+void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
+			     struct pci_bus_region *region)
+{
+	struct zpci_bus *zbus = bus->sysdata;
+	struct zpci_dev *zdev;
+	resource_size_t start, end;
+
+	res->start = region->start;
+	res->end = region->end;
+
+	for (int i = 0; i < ZPCI_FUNCTIONS_PER_BUS; i++) {
+		zdev = zbus->function[i];
+		if (!zdev || !zdev->has_resources)
+			continue;
+
+		for (int j = 0; j < PCI_STD_NUM_BARS; j++) {
+			if (!zdev->bars[j].size)
+				continue;
+
+			/* only MMIO is supported */
+			start = zdev->bars[j].val & PCI_BASE_ADDRESS_MEM_MASK;
+			if (zdev->bars[j].val & PCI_BASE_ADDRESS_MEM_TYPE_64)
+				start |= (u64)zdev->bars[j + 1].val << 32;
+
+			end = start + (1UL << zdev->bars[j].size) - 1;
+
+			if (start == region->start && end == region->end) {
+				res->start = zdev->bars[j].res->start;
+				res->end = zdev->bars[j].res->end;
+				return;
+			}
+		}
+	}
+}
+
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 			   pgprot_t prot)
 {
diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index be5ef6516cff..aed031b8a9f3 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -49,8 +49,8 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 }
 EXPORT_SYMBOL_GPL(pci_set_host_bridge_release);
 
-void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
-			     struct resource *res)
+void __weak pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
+				    struct resource *res)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
 	struct resource_entry *window;
@@ -74,8 +74,8 @@ static bool region_contains(struct pci_bus_region *region1,
 	return region1->start <= region2->start && region1->end >= region2->end;
 }
 
-void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
-			     struct pci_bus_region *region)
+void __weak pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
+				    struct pci_bus_region *region)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
 	struct resource_entry *window;
-- 
2.43.0

