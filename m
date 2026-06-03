Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E03E5ED1;
	Wed,  3 Jun 2026 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510627; cv=none; b=Cuxn0ySRTgfA9SkRXNkkUsgkpitc2m9yu/XQ11gvyFcvVPZs49vJkE7PfWg6iAjHwNq+krLRuwl5ki3Hpfw4Xbb6leMTll3/oWYNIFtXd4XpvGyhUtProVCrb9tEF1JDIeUc+NpkwzF08+h/XhlsWGINocEYXYduyTzuAogJA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510627; c=relaxed/simple;
	bh=fpXkfZQXNzLCZ2LykkJctSOfOTToT/DpxY9prrVCwvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvN5eVQB6d0+X67/wRfAyqBPnPfrSG04l4X4Q9NTRo0sDQvR5im5Jj1ONXAshH9H7lRd/XGjFXHgQYRgsEG6bwvT60O7zGbaL1IxIICu7dlr2hSUSPw4CM27LcVmVlWvmu6h4Kr7Ect188LHvHK/BH2oskiUrZacjqCKxwDaNxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E858XnBm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E858XnBm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537b5he1089524;
	Wed, 3 Jun 2026 18:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=l2/X+5jTe4MP4IjTxuC/AIp3wqannANSoQewR3pww
	Oc=; b=E858XnBmG/9/apJQ5ysumYBX8Q0Eqf3Ocwop2ywe/c4QeJHM7xM7sRtua
	6RXdc8UwynYGQJ8yn7A0/ORV7BiGudt8WslG14PN5XH5SeeXs+Goz4YcO3g/14p7
	YXu9lBHWxafuTx9GRvkUVsEhb3qxjzlv7h/CrzngC63XdIeb5Qt1iOVhw2urVQpa
	dBBAMLchC6QlgZUUmqZcf0op71KjS9psl+1Mn5E60EeEpUifXX64WpmRnfFZTw4n
	eBWhhFPdn6zfGmwUBxXqfkv5ScMRd6aEIiyg1r4a8v5A97/JGl9zGQYtLbAWS7Mj
	yYns5MOwkpHpn8Ci3Wk/0i+hVlZmg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqcbcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 18:16:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653I9AOA005431;
	Wed, 3 Jun 2026 18:16:52 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k9h9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 18:16:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653IGppR20972056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 18:16:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E3AA5805A;
	Wed,  3 Jun 2026 18:16:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DD135803F;
	Wed,  3 Jun 2026 18:16:50 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.14])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 18:16:50 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v18 0/3] [PCI] Error recovery for vfio-pci devices on s390x
Date: Wed,  3 Jun 2026 11:16:44 -0700
Message-ID: <20260603181647.2215-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G9cHJXAdcgystO30zZFn_uq0rS9mqwc7
X-Proofpoint-GUID: G9cHJXAdcgystO30zZFn_uq0rS9mqwc7
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a206f95 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=DzepMB1HdUfOtg11wVAA:9 a=zZCYzV9kfG8A:10 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE3NSBTYWx0ZWRfX8uxXqe2/wNWQ
 2dpGe7uy1ugT59N+TSVi1/aUehrXNMojfU2zVOmjkI918266wUBJHDp1qfZYlWBagNvqn3zj+oM
 T1pGDA6zJvxBbUVEI3BV/khS7tpzhCzE76yXsolH03e27IWaXZgLSvFD4YypscdO7s3CH94bGBR
 7ZDWQEsW426qmQsfsf+2LLFeDkp8pW3JtxXwwNHQDLg09WrN6FiWZbwq5ibi3omKgKqzsIAxuua
 k2cEovIt4gM0AiyMqn7qneT+kBluqtUm7+5yA7L+//dtq7Z+eQwzZrbmnHfhP5JBjaQ5IOzNj5R
 yb4do/St+Ml73PccS4p2twNWqZnLMhC0hzf6ChXC8ljyMQawlldETprAwpjsZouASYTnuf6flG0
 RPGEINdvkciMD2TrGcxSeSegswMm+Cdgndhv/+41buUho4eMLCJ/cOWldxnbW33Tlelq6bdmcGb
 MocbES5pXXpzBvi/MQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030175

Hi Bjorn,

This patch set includes only the PCI patches of the original series for
error recovery for vfio-pci devices on s390x [1]. Breaking up the patch
series into PCI and VFIO only patches to make merging easier based on
discussion with Alex [2].

Thanks
Farhan

[1] https://lore.kernel.org/all/20260520171113.1111-1-alifm@linux.ibm.com/
[2] https://lore.kernel.org/all/20260602163344.1eda12d2@shazbot.org/

ChangeLog
---------
v17 -> v18
  - Rebase on 7.1-rc6.

Farhan Ali (3):
  PCI: Allow per function PCI slots to fix slot reset on s390
  PCI: Avoid saving config space state if inaccessible
  PCI: Fail FLR when config space is inaccessible

 drivers/pci/hotplug/rpaphp_slot.c |  2 +-
 drivers/pci/pci.c                 | 32 ++++++++++++++++++++++++++++--
 drivers/pci/slot.c                | 33 +++++++++++++++++++++++--------
 include/linux/pci.h               |  8 ++++++--
 4 files changed, 62 insertions(+), 13 deletions(-)

-- 
2.43.0

