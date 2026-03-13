Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0BE3A6B79;
	Fri, 13 Mar 2026 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412852; cv=none; b=XoRE+wFW1i2DT6qrqzUoL6qDc9TUINytQsWN2M3hp89OjSVnJPeSJAmstnady+bvIZ8ir6jcDyuZXPYTblqLXvd5dQJL+aiDMuXMMlcXZUwZayLIKVEHJ3mQh5NbbCi1WZnc6901CB0/O/YnAS1TdSr2ZIo85NPZJmzhLrKACWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412852; c=relaxed/simple;
	bh=5cizI4RnQ0+sYKvc9ts3bTzV0kKuXbFeKHHv9Tr/FW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQweLyarpHTamvfZOfn1HkmrLnuFCiWUlnkqbc9DB4Tdl//bia9amYh8AaVKc4+qKGc2Ljjk5Y54bp10otoBSRDR0cbfuHMuLz03hzAMTlOX8FeSMBwEFylwQnTUJDqttO+JWaw1u6Y3LkDNRw7Rf9ttr5aTxhsbK1k0bQXOqRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kEX9QF8q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kEX9QF8q"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D4bdh92302591;
	Fri, 13 Mar 2026 14:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g8eH4A
	UCHFQrNsfFrG8n2p5dtYByJuzeHJBKD1ogaUw=; b=kEX9QF8q6YAuHlG7t7Ngi9
	Uhk0c1CnohsB1IFGObs2aIUUIoAh4bDXzOUHfGtIUZxUGUEQ1nsIgE0PBPs8TI7L
	zVErKO+XsmHjmsEK7UxzW/T7lSQW4UMwYQbSVm0V8c439RIodf7CKGm0IWjUrkDs
	4vtIkNRuHhtf5oTmSQhrjDh8EV5OIC+W3aySaxbaF9EEYHm2C+RYgagxIHaMqDfK
	D2dA0WmjmTGzT846j6OdvOPx/ryMG0oXuSDfN+hIo0dXHTSrRwAfuWzFAHcgWka+
	aBIWA2WvkF0//loZbeOH6+YMRrtR1cjlxjP54XsjOWpjf6jtd/4cf5kGo3Powl2g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh95yyd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 14:40:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DALNgT006031;
	Fri, 13 Mar 2026 14:40:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9q101-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 14:40:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DEee1m53608786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 14:40:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DA132004D;
	Fri, 13 Mar 2026 14:40:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 065532005A;
	Fri, 13 Mar 2026 14:40:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 14:40:39 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Fri, 13 Mar 2026 15:40:30 +0100
Subject: [PATCH v4 3/3] MAINTAINERS: add VFIO ISM PCI DRIVER section
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-vfio_pci_ism-v4-3-4765ae056f71@linux.ibm.com>
References: <20260313-vfio_pci_ism-v4-0-4765ae056f71@linux.ibm.com>
In-Reply-To: <20260313-vfio_pci_ism-v4-0-4765ae056f71@linux.ibm.com>
To: schnelle@linux.ibm.com, wintera@linux.ibm.com, ts@linux.ibm.com,
        oberpar@linux.ibm.com, gbayer@linux.ibm.com,
        Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        julianr@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExNiBTYWx0ZWRfXz4s+sgYSwP/G
 dnhd6WEBJ52Ll+AKtRey+DZ1b6aA1rWs15/bZXzteREoAkjzgm2BhL871JGocQe0qklXrQwBOP3
 t3xCokO7T+2QxBeYzXFtf0Hz66V8xu5SwPsEI4F9vo/+ssChzNUZ4ZH5eEn3UhlhU15Twy9DAOB
 dO/qEVmOAL3If0HhMCzNff+tTMJU3QvyAjJCAAW8kZv+yvFO0hlKroRX4RD2jWe/3tUR3tLfTPM
 8qhMa++UocpBqMLmJ8TXYZwBoahj0kgkJ66kJQpIiQ65riUcpzzPX79hW7Kxuc7LUg+fUFj6/+D
 QuQUDemwNeH1CjR+bo4yoP9okynkZjvAtSCgm7kZMILQRITG5CTSEfBplzltiedF6xiQY7QknCo
 WVsoGkZe/mEn5Auu7DC8Z0AQIioCRyA2C+cFnseIbtIk3iEonAedszmXOxZPHzhP4ZT5rtsFYMZ
 +DbRDhuT9ArVXQiXj4Q==
X-Authority-Analysis: v=2.4 cv=FowIPmrq c=1 sm=1 tr=0 ts=69b421ed cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=jBZh5NATpTL4zB9YInYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: D_crtwemmBm8RXVxefYg9AtCrk9rIT9s
X-Proofpoint-ORIG-GUID: D_crtwemmBm8RXVxefYg9AtCrk9rIT9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130116

ism_vfio_pci is a new kernel component that allows
to use the ISM device from userspace. Add myself
as a maintainer.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc3bcc641663343e9e49281a1b409c84d383583f..1ea2aab4a9bf1294b0f6a1a8c4cdb74188813816 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27703,6 +27703,12 @@ L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/vfio/pci/hisilicon/
 
+VFIO ISM PCI DRIVER
+M:	Julian Ruess <julianr@linux.ibm.com>
+L:	kvm@vger.kernel.org
+S:	Maintained
+F:	drivers/vfio/pci/ism/
+
 VFIO MEDIATED DEVICE DRIVERS
 M:	Kirti Wankhede <kwankhede@nvidia.com>
 L:	kvm@vger.kernel.org

-- 
2.51.0

