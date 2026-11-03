Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723858;
	b=vJyRfMcz2NO4AUZ/3xHtjTzHXJ54oLzu1f5vWdQhuILIwI1++yXFI8h6N3wAv/CApODz
	 0CQ+8PYsgzgNF1hK4jwLLrENnf5fdS387DxioOsRTNLkZ88R/S/I+IAGVwTv+GuRWh/0/
	 f0WoXfovViGRjCPnRm4zB3a8qtyORRLoEUtNrlb8ABT9AVWpxYRd0iaC+/FGX/4J9a2KQ
	 wW+2FYzEvoMKejt2qSyo+uAuPJVwQ4+eeppKTFX0jOhg0u7SHoXdz/pRnqF8YgldtBHPm
	 TLWamHD8wOlV2F9n3IDQXW3mI4VdfmvQ+V1t5+pIpfYzpDPyY2BYMbBMEMy7et+eamg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723858;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7XkGbG3ZreJ3g3XCJQU1byivid8nFcUliR5Eu/URDuM=;
	b=Hn5xlSj+yZEgiPkG/6hWqynP7YRHGRu/Actg4MjeRE70ukurnd2Zuxur/985aJCQe87d
	 KbCyW7CYbL8/7Q0D3b64hIJHNdlG61XRIfRWlTCkMAJlwYPhTee9AqtYhn8jxMZx8w0ur
	 CBUKhuka0sD0pZtg/swUmDzVf9ZD5Uh/evFMTQ086PM7dx5Xp5JPSbopQW6oTwciLR18K
	 ZxjCo/PJlNGStSRcRxRzWcwroFqqrhX05GFfcr/ADDTnuWmUIrl/spgFr+GMhtBm4YVQp
	 5EvMIf+vVfggOH4MwlAZUs/YGJifkwkkhwIrRalVRqphtHQWMvNKyRXYb/BgqRfTh1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iNRayfNx;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EDF606D815;
	Tue,  3 Nov 2026 16:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36EDF606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iNRayfNx
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EEAi82027548;
	Tue, 3 Nov 2026 16:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=7XkGbG3ZreJ3g3XCJQU1byivid8n
	FcUliR5Eu/URDuM=; b=iNRayfNx7KP6lvWJ6AKOcTUth1te0Z48hODQXKz9xS8D
	/L0L/LZfZN6VzVlBj8gX6a4Q4Cl7aYqwWC/hrK9K3vGlKxcVE1gHf3H4zfRyDWsY
	CXIRzAlTteVtrhpiWZv0Q9gCkcd9pXLEIDgJyYaU2LOAnpDPjak6BG0nMECYup7n
	t5eATdD+VML142kUDXl2bmdm6zY+HmMALFfvQzhXjpPix0toYk6r0dQekInY2aZ5
	fjN28MIEtNQQHw2SsmoVfMd2J9R6h9Ou3VL161azaFuoqCltfjML7NLD/NUZHu/j
	n5rUKlqLXI7hVa4Z91E4H7TSuCM5kJj6YentcgxxtA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826pyc5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 16:37:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EK1092558164;
	Tue, 3 Nov 2026 16:37:21 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqcrc9urb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 16:37:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3GbKOi41222602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 16:37:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A749658059;
	Tue,  3 Nov 2026 16:37:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A29358043;
	Tue,  3 Nov 2026 16:37:18 +0000 (GMT)
Received: from a46lp21.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 16:37:17 +0000 (GMT)
From: Andreas Grapentin <gra@linux.ibm.com>
Subject: [PATCH 0/3] KVM: s390: arm64: Fixes for arm64 KVM support
Date: Tue, 03 Nov 2026 17:37:01 +0100
Message-Id: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAArxL7naCmUl0lQsq2WqIHLkUQ3T3pc
 xhmHmCMhAx19kDEi5j2LYHKMwhzt00oaEgMWmqnlCwEF5X0XVyd8cu1+pHu82DR69I6a0atTID
 UHhGT+b9N+74fp5/S3GcAAAA=
X-Change-ID: 20261103-s390_arm64_kvm_fixups-b285654f214c
To: Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Grapentin <gra@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=gra@linux.ibm.com;
 h=from:subject:message-id; bh=jHLcle9l49TtS+XmeknS26ssV7Eo5vngn9V9pifqYM4=;
 b=owEBbQKS/ZANAwAKAXUg1t0k8konAcsmYgBq6g21L8ZGNt14p0N2y56JyutgIdUbwwj1SQqT3
 8N9/xOFhP2JAjMEAAEKAB0WIQRrKkreGscL2VvlPix1INbdJPJKJwUCauoNtQAKCRB1INbdJPJK
 J6ulD/49uGyB500yyZpYRxM8GWGToYzREeXBFdIAMWqNyS0eKgqxpPuYaPWSXFuFGyo5isfnUBR
 3lSYaGehL7J9QrqBuwGh86AstkX2vvzMKryF9yisJHa9MVvAPIinX5fa1XvCEHttdoBN8MukVjT
 dzBdVK0KEon1yBaqDKL7YnF4Q1TvdXCznMpHlijR3SmCsZj9eE2+eHwaUGgGbkYHYiR8LHtAHJo
 5kFG7sc4FkTGxahM5488+yjYCMGP2hxLikw+a8qWyDLvTqu4EQIDqJqcQRIDYHf3IjE93ZX/CO2
 ogy9K+gAuWaF/MFBpR/++rNridkb8IfVSs8j7snceLhpLaIziKJ1XTb8P9iJ1YLU9f0D/fBGKhF
 0emhmq0JyuehNO2TcvnUIWtsjGXXd6jXGIEQp+q79HuIVgiItau5uhKB6EPYM7CFKJePMELNekP
 BCddWQoKfYhd2IjTWsx+aU5FDfItvO8oHOW2Qq+UMbOLAduRMVYDpsWwWCeMhjBdYMf7i8ObHkX
 sVPt5Q1tATZRAOiputUn6nQ0ZZoJB0oBHMHYFUc8FLE9TMyWmIKWX0M4Ye8iggsb8pP5DhN8tPS
 DhX8iX9nG9YdheIUB/W43Xc9laba1nOrzCgLYmJzn2hPrK6iQwegt/mHSTLmfOnRAN929DDlfhW
 fFcITjNvYzjbbNA==
X-Developer-Key: i=gra@linux.ibm.com; a=openpgp;
 fpr=3B910193D094AA78FD974A04D8BFC37DD553D93F
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZBauaj-ukwFFkSR8NLqysR2ljswT07gb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfX70Gj+NQaL8VA
 3jQBcEIjlaANgfa+o2rvm3XOTEhnC14Kd13X94ToCchmABzIPGcHZNY1Lsm/duJjBTNvW2uVoHW
 wdVkBqvPIGznqNKQ2OfFdw92eSkGmyC9Ei0kHhTb9K1ase1jZF8I7wX0jfuiRxhuGLpkTBSIj0Y
 mub0bxcGeS0xlvb3KKPkLX0mn9o1TRH8TAfHQZa26BghvIQSuXmTmm7foeWSKaZ6KcRuxzL9bWD
 JrpOuvYrDEqao+nckNMZwnAAsw7+33pHMKMbC78N+vkGfAzr9JmrxS9CFoG3yCEZObWS0FlqKYx
 Jw2xR6ovlOqArSd9N8RLEN73SmvB7ShmF6uypFcGNLGWU2Eqh1pneSQjP0J0oeFt942dEdyuhKe
 9srD1o8ebGGrLhvZHdRQOUDmCLAWWG4UkqILZzjDtwqWaqV4FITYecL0vMYYx4jvkIXZvXPAhdZ
 ae5bhUePAQ0s/bYL0ug==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfX4Yvn1kSx/Jrs
 vgjE6vjHvxvwbULvyqlERrvgFW5+tgKQ/jKxi2kAYjWHaNi8w3EJzD7Zq2BwmHRuSzyON2ZGN6i
 NiqHdqina3ybD/ircfvtXCGfzkaMFPY=
X-Proofpoint-GUID: ZBauaj-ukwFFkSR8NLqysR2ljswT07gb
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aea0dc2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=dzDyAoYdbE52XmjKz3IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030064

Some fixups for the previous series that introduced arm64 KVM support on
s390. Forward-declare enum vcpu_sysreg because we are definitely going
to need that, then make the module naming consistent and iron out an
inconsistency in the definition of vcpu->arch.pause between s390 and
native arm64 KVM.

No functional changes intended on either arm64 or s390.

Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
---
Andreas Grapentin (2):
      KVM: s390: arm64: Declare enum vcpu_sysreg
      KVM: s390: arm64: Fix kvm_arm64 module naming consistency

Steffen Eiden (1):
      KVM: s390: arm64: Turn vcpu->arch.pause into a counter

 arch/s390/include/asm/kvm_host_arm64.h |  8 ++++----
 arch/s390/kvm/arm64/Makefile           | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-s390_arm64_kvm_fixups-b285654f214c

Best regards,
-- 
Andreas Grapentin <gra@linux.ibm.com>

