Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF062D7392;
	Tue, 17 Feb 2026 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771318969; cv=none; b=tSUiAFdE05CkUm15U5PE5g+qd+uUuOIUxuwCt4uYSuosxeHbX7BVX9tOnPxqfzxVPq1BbwsohwIeEpYY4ITyyvW90VHCiZDstqFc9GIStTLMwnQyfwMuiMDjMKjot4KN2OrHYwydh9wKYOctODdqhEM3J5tH+3AVcI7ZqIHdDxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771318969; c=relaxed/simple;
	bh=NXY4vPoihPR/ziH4pTKk4O+AP+fgHB0bVs4oIxgshwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1wCI3x11P7f1kg/VxcHbK6MG1Ui6cXcDjB3HIs5KKbf66JngEZyHp8enBUj6L0cz3gg5K0RKqC4HmtEfI0gkpkttPsec6o4oaoo11gnyuTVMqsphxFxqxEq/cjIG1KSkr5E4dRDiYCPTmWJ65eOul5PhthuG+ayqPRnWHNmGEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UGz/Tac5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UGz/Tac5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H1HHwK4015987;
	Tue, 17 Feb 2026 09:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xHHYlJBaAeYm8bfKjm2+/KTTm0E36XqiLX1LIDLX6
	X4=; b=UGz/Tac5cWe9S2gox3rWC/Y8SJdeagFNFUyHM5tFLjuDK89oCDyOJFLhF
	YPe4w9N56+yIQ0oq9HKbRZVuH20aBnXYIl0A0Pq1aNhmWM4+vQDuvnW0C4GGjpod
	W9MMKbQ+MqUO+uUjSHV5YkcHuXM0IGsIhrM++yecs8LIvM/A3+jEbKKy085gague
	UkgGSy+NEF+Xe4NquEUsz3LpY3ip/qSIdAPg4RKKCec4aBmj2nqR1gH26ZLBtKkI
	US9GpzuY05hJHPKCU1zymLV+pccI7A/c9RvuaSQJgn7sf2jBmn7PRh7VZb74pFCF
	e2xdLZcO9ApV9DAeGvWOZMc10iz6A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj642dsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 09:02:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61H8npuW015679;
	Tue, 17 Feb 2026 09:02:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb451skt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 09:02:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61H92gt86357324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 09:02:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F96820040;
	Tue, 17 Feb 2026 09:02:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2115B2004E;
	Tue, 17 Feb 2026 09:02:42 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 09:02:42 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, freimuth@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH 0/2] KVM: s390: Limit adapter indicator access to page
Date: Tue, 17 Feb 2026 09:54:21 +0100
Message-ID: <20260217090230.8116-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zW7KfDnP-StYHqwky69aIKrTcOgcn2oq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA3MSBTYWx0ZWRfX5EmbGKv8QIB3
 2balVWb2yoIlmKtGs3+YbDpyMH8CNjT/fc/ZjSsQ26tWM/eFOVTH8oQ5IN8KXtVutxI1gMZzCE6
 m7XrTOQgd50jPaWIZJlXTrFoZmZvJzRkRUIzndxfAOUhn5jReXTkmGLSiYGGeD6gI+8OgbaqjXW
 RATPZs9biZfT2ngqbRZvNGmQ4+jYoR/0TqOH877QoNQLWgfZEz+Zo3zGOz/U0yFSoqI1SLZQb2v
 /pJSQVmE8iKDOgj51frjcExedgRztJRPv8u5+VSFowgNKOtNWkk7loMM9AW+w+qHdPkHVlhWxIb
 S9pnqJmOwzZwDMp5wYFfInMYWm6K0x8BlIRC4QEc2o+6glB2K13+eOgSkLFfJQPlVtsSbWyO/pR
 S9kX8mvtmVjBepECbKW59utiaJBHBlgf/SqF/rtbnEA+pRq5BSZqs7JvDYCTMATAHlXEDphLVbV
 oyF+nRGrTZkhQzFZkMg==
X-Proofpoint-GUID: zW7KfDnP-StYHqwky69aIKrTcOgcn2oq
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=69942eb6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=8hHfqOmpiw9s73ohtJkA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170071

We currently check the address of the indicator fields but not the sum
of address and offset. This patch remedies that problem and limits the
address + offset combination to a single page.

The selftest is very rudimentary but it's a start.

Janosch Frank (2):
  KVM: s390: Limit adapter indicator access to mapped page
  KVM: s390: selftests: Add IRQ routing address offset tests

 arch/s390/kvm/interrupt.c                     | 12 +++
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../testing/selftests/kvm/s390/irq_routing.c  | 75 +++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/s390/irq_routing.c

-- 
2.53.0

