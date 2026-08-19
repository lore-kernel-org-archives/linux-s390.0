Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16537B3FD;
	Wed, 19 Aug 2026 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166271; cv=none; b=hTiWmVsrSSzFTdaBXFd7NgDK8oTXNmypRZ+Yy21oEOMM0CzYCx8kCKJQyfz/PzrXYzlaYqOyIp/vwNJ29PLHeszWlfrSqw9eq2pGlWgf4W5OgHgSc+gXxG9a0dlwp4KzLZ94rhr+wynG8eTVhcebXQ7kBbQO65a1H2CI8JXt3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166271; c=relaxed/simple;
	bh=5dBdhTubzr6zcWH7loMPXAYRIAcJu+OVtioPsV6mlLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r5GXmfW/3NyF896uXl0l4qaPyxb2I1uE1f+lXVEs7bu3OSGsRySt321/8XB+Clcl8GtuVT4BSUOv5A9diy/3rVU5WgJ2XUzZrdvOt6IJVmB3jTQA+WAZ8cJ57peRfaNODt3FNih94n+8E8VOqWH+VmGwII6aGwJkdvZocvlxapw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DWpx9xjx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DWpx9xjx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JI1kJ04100382;
	Wed, 19 Aug 2026 19:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1EVA9Sn5/cnwcEFxuRGX0MQXr/7IKcueeNTu/ecri
	dI=; b=DWpx9xjx0LMb0wKRb49iLrK12ZyienMbIwV75HTF5Nphswm/bxDNFe0+W
	K2i1LgMgfFrHf2UKZrObJaGEwYgf1Gbh01rI4z6A/Z3GEOLobEuzK03cN7nQUs/j
	lcY1l2q3yjAbFvw3/fqg5pGOkDdOuMZi+kTX1Lqg6V4QAgbAd6ZtucqerLf0v1E0
	nEvtiNFEKoPTW2W2jklo/TyqetEFnGMrMEfZFo8xY24sFcasn46i1rriEXNeCEPc
	MsH4s6enZg+LgTpc2fb+jvCyce2fJOHcHW4TjKDjCaVI1Go2nnjmRw76M4qsEPmS
	eOeQOOYahpQf/VoeCnfU58a1TXmsg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu45kk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 19:04:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JIuJUe022871;
	Wed, 19 Aug 2026 19:04:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngj9gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 19:04:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JJ4Or736569564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 19:04:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B669820043;
	Wed, 19 Aug 2026 19:04:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9870B20040;
	Wed, 19 Aug 2026 19:04:24 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 19:04:24 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH v3 0/3] KVM: s390: Improve floating IRQ injection behavior
Date: Wed, 19 Aug 2026 18:41:09 +0000
Message-ID: <20260819190408.247843-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE0NyBTYWx0ZWRfX7ErflLVTqGv4
 I7PH7r1Hx7TaXqF8Ow/sQr6YNBVrERj+g9NpvgRhu2CzpN1BroesEdGhx/Wcm8Qs893WjyFDU6u
 gK9dJ4xiWOxmiCVNs9RVktUxBSjExsY=
X-Proofpoint-GUID: 6Q54aP4qS1TuQnVCWJ8aCNe4hbEzewoj
X-Proofpoint-ORIG-GUID: 6Q54aP4qS1TuQnVCWJ8aCNe4hbEzewoj
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a85fe3d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=xTi3Lt-ftUr7KJ_HG0gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE0NyBTYWx0ZWRfX7M+ylMFP7iT8
 +XEk3zNuqO206EcFK6gxRMBdHUo2Kf4Imj/cWleeC/O1dxh0OoXuLRtaRvdp/VGzWdVIv+bYW65
 F/7hlpHB5e9TSPWVBykJYRvh3R+3NKTIjdVjK+CAtEKXckYDiRVd3E8o+LEJQGFgkjc483UqDOF
 SNO6UW88CUTkiggA2cFhZUXonY89y77pDg8n63K4LjeFzbFSyjCX3QhBi4ZLZ2PKM7BOe6BqgJy
 e7uAy2ptJ/EagjP5g8OcwjbL0kbNwBAdwzqlTM4Z6HSi6veO7bhEZmxZQzU8kN/UkuYKdFMIlcB
 6E+Ae0QK749QztU8M51ZhNdrdhUgC7/xNoNaI6lTyzUFrEeidlleKyoe7/DDBd3TNjEcaodC9Wl
 1cai0ggSA5yqU/iHZjTB2FFM+290oYO5uiYnV29WgJDQwVo7hTdP7xn2W0Wt+NsANf2P8nR+noz
 rPAXclSL2XfrTAd3TFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190147

Multiple fixes for the floating IRQ handling triggered by the firq
kvm-unit-test sometimes failing for pv vms.

Only waking up cpus which are enabled, re-kicking after the
instruction notification for pv cpus and a general redistribution of
IRQs on entry (pending guidance from performance measurements).

The floating part of floating IRQs can make it difficult to make
absolutely sure that an IRQ is actually delivered, especially if the
OS doesn't regularly have the masks open. We might miss mask
enablements if the intervention bits don't get set properly and the
kicks might end up nowhere.

v3:
 - Separated code into two patches
 - Added a patch that fixes service injections for PV vms
 - Added IRQ filtering and kick all if no cpu is enabled
 - Fixed the IO pend type translation
v2:
 - Rebase onto master
 - Added IRQ type check before delivering

Janosch Frank (3):
  KVM: s390: Improve floating IRQ injection behavior
  KVM: s390: Kick PV cpus at the right time for service irqs
  KVM: s390: Add opportunistic floating IRQ injection

 arch/s390/include/asm/kvm_host.h |   1 +
 arch/s390/kvm/intercept.c        |   9 ++
 arch/s390/kvm/interrupt.c        | 156 ++++++++++++++++++++++++++-----
 arch/s390/kvm/kvm-s390.c         |   3 +
 arch/s390/kvm/kvm-s390.h         |   2 +
 5 files changed, 150 insertions(+), 21 deletions(-)

-- 
2.53.0

