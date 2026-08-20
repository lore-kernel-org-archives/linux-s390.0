Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49753419306;
	Thu, 20 Aug 2026 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228160; cv=none; b=etdb2+5lq6vqDT/hdUhLEQcHzHfkfyWBs8Z7WCfzEmDFLz2m3c9vc2xj4V3RlaakkaVNEegaTUT5Vj7zuKKhno64Arsv6cZvM1XsjHHVu7PsFTUYfrka4w2QM0nHKk2l0sw0RoxR68I+F7uH7kih2I9ECrxfGj6+9GpM/tnbm/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228160; c=relaxed/simple;
	bh=OmxrDNO8JEe3R4tWr3ecaXj8L9xWxuO8o+wFUevTOxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mA8F+u+p8mkNDe6vE0v9oSUcXbVkWmU1gUC2FfH96TRazS6+GdZPPXQX4jcw5DrCSzGawmBYKHIV1hC8gxCtfPxZ66/M0O5pUmFlO6BQMosH0sGW2JIFzdZTiLGXj7r4cLFhL3Uihk9YnMJ683H4GYzMEQfE7gO8ZpJIveK+3vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nTTOCM08; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nTTOCM08"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K9LDK32794786;
	Thu, 20 Aug 2026 12:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=eFyM8sIzAKZNGh04dX3Y++L4f7PCIoCsCv3HZOhur
	TA=; b=nTTOCM08B3zBmU9QALik6XprVvzrmjEBMCwng9u6f1ew0OFp221c1KfqG
	lrXwrgi4p0oFZOaEW/dAsx3gWlbM04d6ZqMLsdrSfbgXIZJ8hkJqnmUlanfJg6LV
	cmKFultf9q0qD5vCqhpX6zz+HrljswOGD2zv5HSnZQp9Td8TJNwI/TIHlDU1Aq+/
	uR5BvcC094WOP/xjgXeNhi6b9P3x7xQxn3yFEqkV2HMsvpHR/MbuhC9EKEhjzi5t
	m0QLNUUTSnRTdsvNmKmRem1yolxnQR+NZf10WPqJ9ZEpnLWIK7tyXaEcjQkIkmA7
	q5rIYypI/49HiK4Drc9xRmpUyUQmg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0a4sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 12:15:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KCBHR8019295;
	Thu, 20 Aug 2026 12:15:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqejws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 12:15:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KCFscw28443050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 12:15:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEA8320043;
	Thu, 20 Aug 2026 12:15:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4B5020040;
	Thu, 20 Aug 2026 12:15:53 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 12:15:53 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH v4 0/3] KVM: s390: Improve floating IRQ injection behavior
Date: Thu, 20 Aug 2026 12:12:15 +0000
Message-ID: <20260820121546.24694-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b6eBrZt2fu6aTjE3dYk3OtGwdyxbEn_C
X-Proofpoint-GUID: b6eBrZt2fu6aTjE3dYk3OtGwdyxbEn_C
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a86effe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=xTi3Lt-ftUr7KJ_HG0gA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA4OSBTYWx0ZWRfX10gdfwawW4LW
 r9nTgUtnp/ty5ZYyqkxf9vMasY3af96B36SUC016Gdd28mMRsz+bcPjlHDS6HNkefURU5WJgA2G
 chgzmP2AFxPZjzx3Wmi7eikiHYeAW1s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA4OSBTYWx0ZWRfX8l3W5CjjDZUW
 WzZsKFR3DiuUwifELAt4nbmDSkCde4vaxB4SBwP6g8TVKtRahnWArAJKej90Xy6RQhjJuzHSzJT
 Tf6qzNTkfaseZfxjcdkM10tK5alnmdb+3UIsDxueQjRQYNmqBR3PVEQOSln+BiaAKAqFZP89j/l
 WmVI/SMHE4XbNFQN8mRfUbOrYAOLLl02NBCmDZrZBEEA4n6iU/7zuJ1T0rfwIVDbqD1xkPWs6RO
 DlHSpYId9FeG1Or4IVPBlg7RYO7IULQ/7vn+665VOTXjk37v4KOqQRcAzCUNjOSmCfMvRuIzm8s
 XUtppiJhEAu1NG3T8GSCnDeH/FQnjmrwFWkYQ6jSp2KIjhpxyNl/EWMYY5ySCmYGjcnSIZm9QRZ
 ZXlMM50qdJDC2HXjuTQOM1zi7eH8LgUeX/rTG1/v4N54CW7REg9XajXnj5Is2023K8VeLIZWFLe
 Vqip9Nsun6OZfq3qeiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200089

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

v4:
 - Replaced pv check with mask check which does not need locks
 - Fixed bitnum to bitmask translations that Sashiko rightfully
   complained about
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
 arch/s390/kvm/interrupt.c        | 153 ++++++++++++++++++++++++++-----
 arch/s390/kvm/kvm-s390.c         |   3 +
 arch/s390/kvm/kvm-s390.h         |   2 +
 5 files changed, 147 insertions(+), 21 deletions(-)

-- 
2.53.0

