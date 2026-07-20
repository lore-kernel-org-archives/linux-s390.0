Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B023A0B3F;
	Mon, 20 Jul 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570308; cv=none; b=pBLglLS9lVZQ1huf8hSIXB2WTIDzPse28QYrhjQs6MnY5VaqQHzGYygFvq5iBI626OcqeAtC/GHiyfl+/QUh2LEmy4M5oy13Wtmy/y8Oal6Re05vURcKgJDcpsz7j/MuOqpvnoNWzQiwTI9VdYKuXm+lma6dvQu5RdSghyFDdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570308; c=relaxed/simple;
	bh=Zqn+ZS+6JBljRgBujCcJ2I6bxGplhx5N1Y+D759voVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iYg7BSleBMTQ1oIfE1DHWqheZCyo1GheZpwvigLy0xvlsgCQ/7L3piXUfgXIT3vw6ncBpPqGEeCIQVtJ+Y+szapFTqkG+pUIOikux9m6CpZGjMiVcPKgRu5c9UE3AqBbRMuQfpOlS3SDbywU0ZZSo1H8i+wIEs62OACfCJU0Ul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eUVaL6v0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eUVaL6v0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBpoW928624;
	Mon, 20 Jul 2026 17:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=AlSVMpaYFPdYcqKKvdWIxaYmhuXJkztZVvwLQTzwv
	ss=; b=eUVaL6v0DzdFzQrToeDcSfcHaBIq6AdYd+2ZnXK5m0/uXxgimS6FpJwoy
	bWYIh8ytmHZ3uw/kW3eIyE4oSaLX3cRPPR5vjZOZJy4P13PvPFqZuv/INbJS6cJ6
	qUEN+phPmspaqg0ImW9+WqCq2UEKSkEJQsg0Xu9lBdo3d2Ck2CVMrbQw5OjKQfFC
	P2feFGKryxSK17ZIoMjriEn0ASDKv3xmIolsLyPZ12p7yArm0ATmIEbfsaKsbqWD
	jotTVAdpI4EO4TcQwaGax8ZSgmQ9mnPujXkM5rJEajCtl58LUctlDdFotpFVz/kV
	tSZNMT8dxwPEzfLaS9C0Za9LEWhpA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77a8ujx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:58:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KHnagx001676;
	Mon, 20 Jul 2026 17:58:22 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagxpkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:58:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KHwLSs28246654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 17:58:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4979E58054;
	Mon, 20 Jul 2026 17:58:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B6D65805A;
	Mon, 20 Jul 2026 17:58:20 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.89])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 17:58:20 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v3 0/4]  KVM s390x PCI fixes
Date: Mon, 20 Jul 2026 10:58:15 -0700
Message-ID: <20260720175819.1723-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kTnscvkXUvHQJDt7TPChrbPY-wAF5pYx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5NCBTYWx0ZWRfX/29CStJJuwBq
 yTOQWnnl9kcWEwNkBh+qNmG8aE9Soc4wlcgCotADic9Dl80NlR63Le9FiXukS28Fy55DzjD2NHl
 9KC6QRYMdpKiAOGL/9RiD0buLVmcpg8=
X-Proofpoint-GUID: kTnscvkXUvHQJDt7TPChrbPY-wAF5pYx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5NCBTYWx0ZWRfX/KHlQ6vYB8Ja
 38YmeqFzr4jcBtqYkWMmumHHMGlQM0fHbOfk9N08/FyjeZYP9ADsu4+B3O6iiu8MWsJgYNGUNhW
 0cNkPDeUmfFuX4Ymin9WWYFhtN9TJ/aMoyJcYlhcI4Me+BKuR8J1BemJqxNgTv3qXWVsPxvoSVI
 LJLKxThYBjwyxbG4asGQ2g1tE611q6kngBFq2KIwf2z7ymvSmw7zmuSzf0xRalr6XSLM23BYzHR
 kxeDenPY+FDan/dIXUuyzZb5yh30ZVL/lJF9wYmXxwED5I7nST8fvd3thNh2AajLgKefyIVVeDW
 AS6IpN4BxcavskxAdc+e6HZ+01OsbZQpMHpoefWBWVVkT8VbXq3RAf7fC5jdxmhaZAoabblpQc9
 YVsyTJ15DhmlQfXOhBFrAchHKkc3NBxzq04Dp+RoFrg36a8n+1oPBT0qusBckyKSdVaWuSMI7jF
 bx/fsfTYpi59Kw+vo2A==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5e61bf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=xMaImaq-nirgh_4BfFQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200194

Hi,

This series attempts to fix some the pre-existing issues[1] found by sashiko.
In v1 of the series, sashiko correctly pointed out some issues with the fix
for AISB/AIBV spanning multiple pages and resource leaks that can happen
over multiple ioctl calls for the same device. Fixing these will require 
some more rework and will be address later.  

[1] https://lore.kernel.org/all/20260624063447.85DF51F000E9@smtp.kernel.org/

Thanks
Farhan

ChangeLog
---------
v2: https://lore.kernel.org/all/20260716175241.1039-1-alifm@linux.ibm.com/
v2 -> v3
   - Remove overwriting guest FIB since we don't use it for 
   re-issue (patch 4).

v1: https://lore.kernel.org/all/20260713172600.1284-1-alifm@linux.ibm.com/
v1 -> v2
   - Drop fix handling AISB/AIBV spanning multiple pages.
   - Fix memory accounting functions for the case when interrupt forwarding
   is enabled by one process but disabled by a different process (patch 1).


Farhan Ali (4):
  KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
  KVM: s390: pci: Fix missing error codes and memory unaccounting
  KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
  KVM: s390: pci: Fix resource leak on IRQ registration failure

 arch/s390/kvm/pci.c | 82 ++++++++++++++++++++++++++++++++++-----------
 arch/s390/kvm/pci.h |  2 ++
 2 files changed, 65 insertions(+), 19 deletions(-)

-- 
2.43.0

