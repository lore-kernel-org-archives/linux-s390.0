Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FC0353EEB;
	Mon, 15 Jun 2026 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515071; cv=none; b=JI4eD1iCQEJbClP1p6Go+m7qhqvEosREOFY/I8tyex/SmI7e9mOLAHsDMa+6CFkgJYAcgdCcYfHRAMexCiGaZJEUjcQrFWnd4xRtLuQDorEvmSEbQhUmVeummprdHwUwrW47UDfWKNUk3QbvxA0kIM03xwivesNEFc6z69W66aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515071; c=relaxed/simple;
	bh=FxM0d9Wm7XLPqHFpfixygnKBugI4AfNq3ZA98i3gmCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bd+RGtup4kCE3gBr4PPlCVrh0DmKN5K/JBU6q6Q17LPRTdVuu+XauqHynvB/rKLYf/FHXfdB2G+q/2Q2u/qEmS9CVXs2js5dZP1W/k1id+URXlmGCn/acpRiS6rrr1FfpO0SS9wMe8HwY4zr8yF8eh9svU415u/0PC5ddY9XcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EvYjR+HR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EvYjR+HR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6ImEY1614127;
	Mon, 15 Jun 2026 09:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VGhIZ2/8lY3WC3l3jR7MIK1rj1y5B87i9DI2pwFpY
	/4=; b=EvYjR+HRWvzYbYhmdbqb9FONAnkGA4QxmrGNrjQmkA9uMALjrBuO7gi3V
	Wc4K2MMADfmhC7pqS92E1M19eZ7wmXMdvxMxvfZkMzEbavK2KsHNhiT7eHNvtTvP
	oSj5E0YHPoJcixrjQMnumjTm9u5yhvlJZbY2CR0jvfJ/RIooSZnRreSBG972N9rB
	kuZTx+iTzfxco6YHT23acgHdYhoknh6GhMkDPm/RtDC7OCx/m6Wu/pygk7X3+A1e
	QcSkn89md4CNzujR8AE4+pABQyV1hOgVmA+/+zTZMx3Y3BI3d3b9dZDO/a0s48aF
	L8Dj8woE2/A9A29vB3lYjO48VeY8Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h7yv78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 09:17:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F94aRb001110;
	Mon, 15 Jun 2026 09:17:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1gwtgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 09:17:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65F9Hgi929294966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 09:17:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D81E920043;
	Mon, 15 Jun 2026 09:17:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5C252004B;
	Mon, 15 Jun 2026 09:17:41 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 09:17:41 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v2 0/1] s390/mm: Fix handling of _PAGE_UNUSED pte bit
Date: Mon, 15 Jun 2026 11:17:40 +0200
Message-ID: <20260615091741.76724-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX0yxCaUnWVpOV
 X4qNR6agmH8bRnW1vdexUvIefXoMUTld8mCbnNQseLlOkT+f/UiJACZDpdAbqCF5Jn0V+i9bCoM
 tMQevCNC8hp7ojPu5uvU6oCCt+kmlVI=
X-Proofpoint-ORIG-GUID: eJ_QV3R5bomO08t8VBy-kerJl-1DGEaP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfXz06eqbQ00dMx
 4GKoNZiZOVEKl5XKOm10PVLWrxigLj4VdAJdWlyPWDr6YokXnutadN/Wk1oCrwx+JVKnnLAwM9L
 nG4gSc54qCj0LIc5U8f3Dyt2pynqRPU3tjGc+tQrsrmfCCYx3WDLiMsIWJzVGKyNwP/E9nAY1Fc
 NwVr3GLiwNLo8n33wK9D835aCUA1x+24tZcTnq0Ck/oYGMsP+1x6616wZ/T7vryWNrOH4VppJGX
 CteQqNTv3K3BrdEjXzNCvpun5XNTBVtZ2a+nqSZXtsvBTShhVzEqDbS4PAtUXMzKvVNIlI5gwXq
 HwCWX18auAtqmNlyL6lIJURTeJOapQcOyfL8mpcdgIQr1bPfdJtV/D0MqXuwmZpuDdDLennGO+g
 rJXaITpo6bg7xs2V7nJP7ymQx8EtjzVhyV0K8Pub0xKDAVhwrVGkD9YysvABgTlRR5qjve1UAZm
 FWIZtHfJRWyJE6CokGg==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a2fc33c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=6evSrKiG03KN4j3D8AUA:9
X-Proofpoint-GUID: eJ_QV3R5bomO08t8VBy-kerJl-1DGEaP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150092

Fix handling of _PAGE_UNUSED pte bit. The bit was lingering around
longer than it should have, causing issues.

This patch replaces "s390/pgtable: Unconditionally clear _PAGE_UNUSED"
which also solved the issue in practice, but in the wrong way.

v1->v2:
* Completely different approach, entirely new patch

Claudio Imbrenda (1):
  s390/mm: Fix handling of _PAGE_UNUSED pte bit

 arch/s390/mm/gmap_helpers.c | 4 ++--
 arch/s390/mm/pgtable.c      | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.54.0

