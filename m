Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95B49551E;
	Mon,  2 Mar 2026 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483620; cv=none; b=CsS1hQEWTbbVHKTcXSV4cUxTBcFieQ2Oa/ak5gBmilQCZmN74h9fKHFAngc+75Ikhb0EL3a3d++DLMlHXpZ/8kyMsp0H3NmxywGtk2KcQhPfHbYY6EVF/gTEf2/Ur2tG2SuaVKsVrW3vQaRR5IvKnYCvdbxIT/UQlW/4izEnUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483620; c=relaxed/simple;
	bh=TY2zpKNifG/8eMBOZOhi6HU+JgCTeK/+REWlaOd7vW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUV21oEHWwTTeYN22Jy2dhbw/yKC7hJyJWhmmBl2SfbrQH1F+gHPlsu1CX8u8jDLOePVMo8X5/nNX01w1V8mWbrXheZ0ObuGkbbTQnQ65nts0Ju6XwrST40uO/2Qy3Jkl7+jvE0KBq10BkSC+2wsKVSvFGONgyAXrL16egsep/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VmEKd/+J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VmEKd/+J"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622ExvAJ2444784;
	Mon, 2 Mar 2026 20:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aOTMZASEbw1JAk72/
	rixAqSaOEQh2zzVQjtzAMAH4bo=; b=VmEKd/+JgBi4KVR5Ou510WtBCQ4ZLg7EZ
	Y5yp9A03nDglFvZcJmHiZEAlyq9BXHmFv5cbR06IpXNFCPOTBBWhyOmxBTaf0RTK
	/Re+FT5POE4r8nF4JSWTDYNW1//Q2CeEwRq9H/X6YCCrJhuRZxc+iAIPDPBB5Y3F
	KKVZ+v+AUIqb/RSWYhmSQ53BWrZiaXYDAczcTlWuYnsJCGs7J+hvpHkSWqvNmiPQ
	DnLGJ8/URG1rFbDO9pMaC+6i/qtNkTkUFHWYutBgdZJYUEKxzXjlA4YKaIYQq0vx
	TfDk10+eP/uJ999ZctTaV74iz63PoSlAvA8bNg2gsOy8nUh08LRfg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrj0cvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:33:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622Htnim010284;
	Mon, 2 Mar 2026 20:33:31 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6jyh6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:33:31 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622KXT2l28115560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 20:33:30 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E79758043;
	Mon,  2 Mar 2026 20:33:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54C0558053;
	Mon,  2 Mar 2026 20:33:28 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.18])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 20:33:28 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, kbusch@kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v10 2/9] s390/pci: Add architecture specific resource/bus address translation
Date: Mon,  2 Mar 2026 12:33:17 -0800
Message-ID: <20260302203325.3826-3-alifm@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a5f41c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=WI2LcE4NPZyv2LzpnzYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE1NSBTYWx0ZWRfXxPhqmDqGWCmB
 2nDUUKgF6fXPcGF6ufBeMkuTJA3y+o4EmMFqR5zuF5Ork1SrSoYpTOgoFhH3JRwa6sGOpQnIZ+N
 9eLS/pqBPnZ7rTDgroSBnhb8Lk0mVuhiIWmhfWNOH5mhms6nO4jho5jlFd86s1+bY4en7W+Ur2L
 kWNdWiAND+ZVtk8DJMMnZmtHeZXs/73ZUT1yyutl9087ajdlr1Br4dGnHMVzHObXHWJ1PFKtg1M
 vb5bvFMdZsogvdwUo/2IMA5qGsGV4FAlbi/2/coHPG8ZroZ13gdISBae94p9QdpTMyfy38jUhPm
 nwyJtgqD/leFrOAwuldQGBbp5/uSgKKUelecohqP1nGcSwWscqoUcnqzv7isB9iK7jr8P+0JAye
 Nf5vD0VF33GfB3/H1Y4UvQgOaeaxg46W6Ch590dMPBDJaGmVuEeUKnmI8ANH0HLAKAdcsdy1Gyq
 0ArDyCdICGYeb3PwyEw==
X-Proofpoint-GUID: ckjWtIpOtDE9aYvjqpl9MLL4EZLpemSV
X-Proofpoint-ORIG-GUID: ckjWtIpOtDE9aYvjqpl9MLL4EZLpemSV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020155

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

