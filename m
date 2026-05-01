Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796DC421880;
	Fri,  1 May 2026 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777663584; cv=none; b=sDkRKohTzQOzuXrG+mQ4tgL42JpJjDbGSR2u+6FHha0eDee0U3Az6BGRRfRH80FLM2Wz8uzkvvsrYx5kD2VY7RZ5UsGNKHxS5sWPsWHBxYjRdra0C4d2mBTkdTt0YqbyPylKE7cOTqO03jxFCrRl6iufebDyd0MjN+i4hrsJaoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777663584; c=relaxed/simple;
	bh=dBq0sJnhfoP8Tez8/KUMDcxe/UyGYmQ3Xi0ES68YqTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aEJEF8DLlLnTuE4HxY7Elty3cCFCuFvITV2/2T+7XSqO3M9UFrvT8BHMD9Iu85VCHaQ8MX1C+nf09quFzUI117LaRBLi3yhNkhnmxESm0O05BnXM9N4C73yNYmunAwI+BpqEqxQTWmOETjnq2GHSQFOnP8lZIHpnXUpHD5Yutfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gC8zKcXX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gC8zKcXX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 641B1cS51815471;
	Fri, 1 May 2026 19:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=L8wV5YXVaWrpE3pQEZq968ph9XJtzJsYTg918arJU
	a4=; b=gC8zKcXXOMDtAuUIEu4/G1IXApTgSW2OSo0ikEeIYSextL45TAx472veL
	CGqpVl5dyco7HbAuG3ghyBNHJOVZQeFAR0rXaPvks+ALgmhtclkj+zXByHzZFsv2
	UYsXCRnpRDhPLPD541kcJ9yceqm+3NgIQBBrRM5SGqL5wNtdytu45nVVSd/FTq+G
	Nm0q4vkNmijS/LzH4h5BNp+UinnCZpVG2V0m7hqApmoYLxIzE2eugFirTNZ3LoO5
	15UqEaAbeK9EHOLSGQGqmkia/A6GUSOZNefL9a7E/L0hhOn+eWuBQlwSMqq3hUXh
	nxTyvFYczOXCTpAwUcetjUsDB2Lrw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn45689r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 19:26:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641JNlUd003993;
	Fri, 1 May 2026 19:26:19 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5grq84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 19:26:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 641JQGDu17564186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 May 2026 19:26:16 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D74458043;
	Fri,  1 May 2026 19:26:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74B505805D;
	Fri,  1 May 2026 19:26:14 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.247.25])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 May 2026 19:26:14 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v1 0/3] vfio-pci/zdev: Improved zPCI Function Measurement Support
Date: Fri,  1 May 2026 15:25:27 -0400
Message-ID: <20260501192530.9429-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: chXpimYzk4VtaUPgZMRnKwS7ARQO7kat
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f4fe5c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=7DWl4jR7z7vEdJ3r2sIA:9
X-Proofpoint-GUID: chXpimYzk4VtaUPgZMRnKwS7ARQO7kat
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE5MCBTYWx0ZWRfX8S5z0BiZ2cyR
 dGwx+l+Oc1o+cT2FnKTd9142j2Lbe1Ptrxxx4+7IdzrwAayrCAGUA8s4gAnjfoOwutfkvKZv0e+
 3de13uT2iIEuGde0ZM3MY4/6xPEy8+VseZgJhmY4yLpZ8wJVUmh2dtm/XgDX3NYMAfmmktC1zfy
 EqP4w+JUn6tnkckV/eQoSlZFRaWZrXml99HxjnUwJUdm5dUdK1kgqXtP/5sHX/r5sPZThKaTFxh
 xHKqunI4sjsfQ1imaDUgU5WE7AwRSwNJJqi6pV9dbT1YV/ean1o1qc7xlr/Jzk/d2jWDA7CItcs
 ASWrGDpoQRDxdSGDhhqG1Oslo/DxWe6RarB+Lg2By9B+lg7neuIwjBQTr6eQUJsaUmoAg6muxw4
 TMROb0NFBw96XO3ZyDxSAH1EMfpT4ONWq3B/3ziAWysIqv6N04wh0C447I0lJ+/narhak42dNKI
 M1MILB76mU6a6d8Rchg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010190

Hi,

This patch series improves support for function measurement for zPCI
passthrough devices on s390x.

Motivation
==========
The firmware on s390x machines allows for tracking a variety of statistics
relating to zPCI devices in a function measurement block (FMB). However,
the kernel currently lacks a structured mechanism of sharing this
information with userspace, beyond /sys/kernel/debug/pci/ID/statistics.
This can lead to shortcomings when running a guest on KVM with PCI
passthrough devices, as QEMU is unable to provide an accurate FMB snapshot
to the guest.

Proposal
========
We propose adding a new VFIO device feature to zPCI passthrough devices,
allowing userspace programs to read the latest FMB snapshot as it is
written by the firmware. We ensure that function measurement enablement is
preserved across device resets on the host. Furthermore, we guard against
host tampering with the FMB via sysfs when the zPCI device is in
passthrough to protect the VM's state.

I'd appreciate some feedback on these patches.

Thanks in advance.

Omar Elghoul (3):
  s390/pci: Preserve FMB state in device re-enablement
  vfio-pci/zdev: Add VFIO FMB device feature
  s390/pci: Fence FMB enable/disable via sysfs for passthrough devices

 arch/s390/include/asm/pci.h      |  1 +
 arch/s390/pci/pci.c              | 71 +++++++++++++++++++++++------
 arch/s390/pci/pci_debug.c        |  3 ++
 drivers/vfio/pci/vfio_pci_core.c |  2 +
 drivers/vfio/pci/vfio_pci_priv.h |  9 ++++
 drivers/vfio/pci/vfio_pci_zdev.c | 77 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 43 ++++++++++++++++++
 7 files changed, 193 insertions(+), 13 deletions(-)

-- 
2.52.0

