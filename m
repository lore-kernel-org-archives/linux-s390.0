Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6337B3EB;
	Thu, 16 Apr 2026 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776375564; cv=none; b=NwyENbf0zGPmJy5hjnnQpJTn2N5bnCst0DcapGN8xI1Ngr8B5nWnb3dLKhrDX6PnOog0zRoGSJqMThvCiRmNcW0jG0aiuht33s8ozA39cjfHbASwoDyDaw6PV80o8FAN2NP+cxQCqND2HEYcZOMDXMx94EqYzMA4FnZ+RCvszNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776375564; c=relaxed/simple;
	bh=IsoSpYBybOMgdMhQ1ECWPf+Zxx95V0b4FA0cIjVZJvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Re1X2s/v+b3VT1GEDZsIK+HBfFpFpRJRICh8rG1yaj+aDsyGiv5/SaOoGAdNp0zCtY40Nb61hhwyaMEnOC7TNPjeO0dFT1I3tbNPMwaYm/1GtU6k4zDtluF81dlxZbZwcmoC0he9J02RXaaWp/79Ph5Tjs8k5ozvISmVdngBAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jkg89fXs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jkg89fXs"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GFjXbp2130947;
	Thu, 16 Apr 2026 21:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TJMJRfvcip7LAI47q1WMDdx96kSeVZqcugdcAS4iS
	2g=; b=jkg89fXsaJJV6sx1bb17OPmBmZ1m9zulchEDhIKmOn24KSd4RAKDIN9vx
	sc4p9oqRxMRvYfpNjT4BPx0g8douRztp5uIf1YvAqaiX013p0CTR+HRkwNZowKuy
	RkHq54xME8rlXU82X0NoNuMljLc3PtyZMT9tpJUnplzHUMd5zVnzAjpbeEVp3O5z
	TzW1me+CZ2qzzfTHiPFn+49nh+4Rj/36g8grFQfF48bnCF3LEHoxJYPofmfrUpDe
	Xdg9gmCygdTJp4kMp99Qj4r+9cUET3ScyL7HfpK9z9XeM8vDOZiuHG7c8mhhTRh5
	AmxBEt8yUCSSTcgwweoYKegZJ2lDg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nqrnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 21:39:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GLbMNL025629;
	Thu, 16 Apr 2026 21:39:19 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujvgq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 21:39:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GLdI6T24707760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 21:39:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28AB858058;
	Thu, 16 Apr 2026 21:39:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A357958059;
	Thu, 16 Apr 2026 21:39:17 +0000 (GMT)
Received: from IBM-GVXK264.ibm.com (unknown [9.61.246.192])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 21:39:17 +0000 (GMT)
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
Subject: [PATCH v2 0/1] PCI/hotplug: Add 'uevent' sysfs attribute to trigger slot events
Date: Thu, 16 Apr 2026 16:39:08 -0500
Message-ID: <20260416213909.705753-1-ramesh@linux.ibm.com>
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
X-Proofpoint-GUID: zrUvnR8Ofvut76vsnFbtnxK7mj1BRPB5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIwMSBTYWx0ZWRfX9+iaINMglNWL
 CbPMiWXt0UV2EAsADOoQVRwq5YWwy1Ow5/U91Xo0g+CpPacHLrY6iiD+aFwbirO7vZWy7s8R/fQ
 HF6ThAZsBJkohxHyT3z8yB7W3jnWNEze3veL0xyXXCcn8BQQUND9Xw0sxc/zicdPJVfR9/acXAI
 32eEpWU1DMHbHj3/2PWiUtfV7pasguH/YkWvnl99ZGJe0LzL2WfPCa/u2a7JFkJug/V9YwQhXiA
 8u2RPv9BKtBtsX+KGNuhAOQ0VQz5cjPpFX0CMikFhx7SH4IWHEx17em69xpFzLilfuEtfmMLIOf
 CGLW5TSiopq9uMOGpVrNv2O4ZR5OdaxC5S+uLnMWZDv4p4ygXIefrVMF4CMRcrUirdHIj2JPxiO
 BUFA2VlXj3ApO8zdbG8ebkmUi37RRK/biSeGimIAlKtx//QptOJk1WgcL/DwxqrN4lx/HtddCjB
 GCbdTOVh2eLHcptYFUw==
X-Proofpoint-ORIG-GUID: g1IxGn09_EknX-Kqg1SqpahdGKqvbZYz
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69e15708 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=o0zT6PTsBOA1n36uQKIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160201

Hi all,

This is v2 of the patch adding write-only uevent
support for PCI slots. The original v1 was posted
in February 2026 and received valuable feedback from
Leon Romanovsky and others. This v2 addresses the feedback
and is rebased onto the current kernel tree.

    Link to v1:
    https://lore.kernel.org/all/20260225150815.81268-1-ramesh@linux.ibm.com/

Testing: Tested on s390x with multiple PCI slots
 - Write-only uevent attribute is created for each slot
 - Writing "add" triggers proper uevent generation
 - udevadm-trigger successfully generates slot uevents
 - Events are properly received by udev monitoring tools

Changes since v1 (February 2026):
 - Improved commit message clarity, per reviewer feedback
 - Rebased onto current kernel tree (v7.x)

Ramesh Errabolu (1):
  PCI/hotplug: Add 'uevent' sysfs attribute to trigger slot events

 drivers/pci/hotplug/pci_hotplug_core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
2.43.0

