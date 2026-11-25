Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566961;
	b=3qP0NR8b+1g+d+g70UTku8ksthcX/xXDM5RSevIt3PzgRtFe2LKRBmesB+nq+6yuf7M/
	 tjd5+wGCOC20LhqwN7d/gCVgSODrLoUZmm7JzgTo9DhS3+P2nteGBn0RyxWzYj/8NCwFz
	 E0FSbFBAyFCFHQf+u39oS8offKTPVJYwTAX/9yYCekOwL1rdOl9k8YORUbsNyNiuPFES4
	 iBFIxnxuTls2m8uBsNal58X+J21+aFRm3menmzO2un+CETQwOtfv2q05kVtggR5bZv5Ec
	 Nw7EauLiTzX9SoLQZxfSer89bRBP7hWS4rDMui8wLpfJZHA/x9iExroIo/mrnWrN1lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566961;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1uIQ/BEqFxp/IMAZxD/E6i3YaGxekSMRPcAIy27ypp0=;
	b=rXh2F6nUFRN7h7h0BFgA9koiLCNFHgf4HWCPVR5CE6uT/9kJykS2j4EVEZCY2h9AdlP4
	 YXBZGwDpJ8Cj8LuQ0P5xDbolMcV3ff25w6LfeM5/pQNJlhaxJq8dOPJUJziZ9xmNBhp7Q
	 VURph9Jmx/65Q9ppnAP9UvPEfqA+lJWw+QK1sduZzjAEgpoC30AuaCC7CdLG8ozsC1bV4
	 WPAkZen5FBAnokPW9e/uB7bdxSfMsFiykYlVODLhpbKOSYgKV9DtZF5Wa24kr+c4JzpBW
	 EJf7GDrvRzj8GFYGecQkkUfqlshAuKJflyrI8jd1Xi4Dp66Qv9stlPp8D5EEpgLx5RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TanVvILM;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C987606A31E;
	Wed, 25 Nov 2026 00:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C987606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TanVvILM
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOMZeWY3653731;
	Wed, 25 Nov 2026 00:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1uIQ/BEqFxp/IMAZxD/E6i3YaGxekSMRPcAIy27yp
	p0=; b=TanVvILMOLlA71asTepiPTRf7hDRT6pfCQgP28Le0Psg6v8HjG+fNu6lE
	S4lfI5Agro0dgIGVjFb0BP6t2qWcMqXZshA/z5+j0nDF/MWCTXjhZTIBd558JiHG
	d/90mGVBhoAkfgr03Xvc0IKgxQxzbfOx5TamRtsYXnNBgWic/RPcK8DPZiJDDEXI
	r7mXKXoFZIrIs+rybMBtaOd/65orHgS5r5ur4Ny9juiIaDJJyopvlOqC7ZRSRclP
	NWcx94NqBIX/8/coCkwDAKf/lr2yuH0XjiVbW8kGDjkaC334hSiPPfQkk7mC+UZc
	eKxIDi5CntxSyuM3LTNgle5xPpHyQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv9sw2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 00:35:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOMZARW1290289;
	Wed, 25 Nov 2026 00:35:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5a4127by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 00:35:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AP0Zmuq19071494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 00:35:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 177E958055;
	Wed, 25 Nov 2026 00:35:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2278958043;
	Wed, 25 Nov 2026 00:35:47 +0000 (GMT)
Received: from IBM-GVXK264.ibm.com (unknown [9.61.244.201])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 00:35:47 +0000 (GMT)
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
Subject: [PATCH v6 RESEND 0/1] PCI: hotplug: Add 'uevent' sysfs attribute to trigger
Date: Tue, 24 Nov 2026 18:35:43 -0600
Message-ID: <cover.1795565279.git.ramesh@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b062d66 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RLFbKyCAV2Q4rzo76dmsHbHSXqs=:19 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Uq0Y7NjBEueavDE5bK8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAwMSBTYWx0ZWRfX5zsecp72MnUK
 WeMJRg2CX6NcJLbRSJp9cwyarcAzy4fDZFlY4PyGtLqJc/1/ess+4vuMXHFDZHuUllHdhW44z3w
 Rg/DDoHFWjCBfARAizVhcWYfUwJVcX8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAwMSBTYWx0ZWRfX/ns4RKQBsViF
 U7NjcqaFyeaBQEzswu+tUzmMpB/h1KEa0GBUsT+FwqCB85R39licmnMNmBIq18sa+pJ2/5laWBR
 MvUg695jW1uzlxMYdopI5Yq8nFZTQEBFDJB7Ay4lQ1XqEcrHKkdaqO7m2Ft/gsvzzH0ndbYll4o
 FjxWT6NHRoRzLAsR+4e9lJj30x4mfAZOZ6k91Y2+RwKuFA4H1ffbh85xDpJt+bBr72Wuji95+mJ
 0gcocN1B7wU3ivnW4tEF4jSJzv58kBszz30FDJDT8nIDHfI10c60ACKmYVpc5T9KP0/8rnfGRkg
 ZE9DJxwA0SC5akej/TUn9UNz4qfgjR7DnT1cX9zcT48GZ99DsoNANgy3BsRSZCtchIQR/QiqVwy
 AOgbz+OtLxPRoesv1mbSZMu7dF64WbRcva3TogeGspzJViIg2MDPmvX+DMhcDXijIAYsL2M5LTT
 MNkn+W32o0riOUC1x8w==
X-Proofpoint-ORIG-GUID: -qmhnZctGVyZOTa5Yk8SQwb9OF3ERaJA
X-Proofpoint-GUID: cMDr6OlzB3S74VYoy_tU8Lsn4HSUfsS5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250001

Resending v6 for review.

Rebased onto v7.4-rc4. No changes since v6

Original post: https://lore.kernel.org/all/20260807180127.62471-1-ramesh@linux.ibm.com/

Ramesh Errabolu (1):
  PCI: hotplug: Add 'uevent' sysfs attribute to trigger slot events

 drivers/pci/hotplug/pci_hotplug_core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)


base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.43.0

