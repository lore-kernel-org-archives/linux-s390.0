Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9B3353ECC;
	Thu, 22 Jan 2026 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111110; cv=none; b=kloJqxaWkxYbHtyff9X0DzbJ8F/S7nCXGhCYOISuMoi+JZEhxEKV2z0qkdg7TAyX3gwu4MG6FC0/MF//0TTL3Y5RBOffomUOVqV152A2ndUg/TjFtAVUUuXkJWeHXk8bWbSc5WJPjxH6c7uGuKLfL7Zc8gQ3nWZo/2sXyqZOmAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111110; c=relaxed/simple;
	bh=rpGbw6aPatBFoO1n6MG8kM9PgC511SMrfUTMIJhpc3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zvf1Slh7EK4VJLpblURlDiR93wA58agD3DzPV90PSuKbzGJN6OUBDciTc5VhG4tCT76mvKyhRXq/OqdEoblQ0BdfxORmMv9WCpMqQGVes25QNWjK8rtA7IftingyNJ3NzIW1VFhW1xUobZly2C+eb2TxMZEy5NpCAjEqWihdGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N7MFIPD2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N7MFIPD2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MCSYnS007700;
	Thu, 22 Jan 2026 19:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y9znmSbPzfrs06b6s
	0xx9RdEZOPm29RJowDzYc/AEco=; b=N7MFIPD2/kNCHnc2I3eN0yni9a+O0tfi9
	6Qa2YEXEIXoZ0RzNwAgKPYU0A9Tk5gWtogNihtUpWiuHOjGK2ultxp7Gy7MgNEoF
	+ct5+JK6272bbvqDIJlH/RTT/8nlYu+dtkiZhMZXXv00VVV4fjqJS17IIBdmkVqL
	DgM/Qcdg/zKYhJgaLSE1ViaIWspo8xcZcpRQUyELai9byI0V0Fzrq9NIII/UK2Xp
	EJJU8lu677euz0Dw0ikR8kBnsRISiTRQiMpWWoiRX6uVbj6BQMKR7UprdaqdxUbX
	D5IS3xpyQQPaltCac91JYCUsM/H/Dv5QjMrU9SbzoB5FwriRzDCFA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukjgra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 19:44:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MIkCXA024640;
	Thu, 22 Jan 2026 19:44:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxas2t9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 19:44:43 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60MJiNm525231914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 19:44:23 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EB1658056;
	Thu, 22 Jan 2026 19:44:41 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B437758060;
	Thu, 22 Jan 2026 19:44:40 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.216])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jan 2026 19:44:40 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, julianr@linux.ibm.com
Subject: [PATCH v8 2/9] s390/pci: Add architecture specific resource/bus address translation
Date: Thu, 22 Jan 2026 11:44:30 -0800
Message-ID: <20260122194437.1903-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122194437.1903-1-alifm@linux.ibm.com>
References: <20260122194437.1903-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE0OCBTYWx0ZWRfX+//u5YZN6dlt
 eMwOc61cGf7ag5Wncjm708VwJnyoYm0bMxPjSD1KOonp883x2zopbQsXVpmsvo0IU3W7LaXxCqw
 8ZOkeHbHl7xj00kZh1Fd730WJwhVSeBDuMn4+ZbJQVlqb31ZZwTYFtRnzE3/WBKcESLcfrJaOqo
 pLeWHP6RopHO9WWy117OkRjrCS+jf8NdyO9fBTXpmcOwDEZyFRzaI7YZmRZn3s7BOgK0cW3UnCa
 NL4PRfYeZlEtno2VewyW/esxLp+G8PhSRcwDSHC5kUptKAM3hIe3EQXBqFR5R8PiR+j2XlYy0+C
 cpx6K6VwNaaJ4VmqUdLolwATbi5b1zbkipA4AfKWETwLyDs5VmBeY9LK0me7fUC0XO05pIMmFqa
 nXYiY2UYTcq0PLiW7Nw9oTdpGtgYNWCmBRVHHD2+WN0mrUPcntbbGaHdsn10nl4j5hZmGfO4iX4
 pcRQG3vY10aM8WdZbaQ==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=69727e2c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=WI2LcE4NPZyv2LzpnzYA:9
X-Proofpoint-ORIG-GUID: RYunstVLvxQQISuc7w9rxjfStLq4SJCZ
X-Proofpoint-GUID: RYunstVLvxQQISuc7w9rxjfStLq4SJCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220148

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
index 57f3980b98a9..81e7e6b689d1 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -263,6 +263,80 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
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

