Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161232;
	b=oj36uU7h0IvdiVcZ9GEJ5TMmUYxqWdbt+OVtGiqvu/3fA9bFJUA8+gQvJnnjBIT/Y/oo
	 rOgnb2gzxQGGz4BERYWEGpPRraopIJZx+DPSLEuZOw5KR2c2w4v4gicG6plK4Ut8Ez8M/
	 qxisWt772Lcouq5kIGck6B5gJcSdlJxDJYHBcyhelNsJ0cU6xWW/TVqLgErC4tcHTunLv
	 PEijhY7hHCYRkRS3DdjOR5sJ/FB/K1QhUV04aiTxftXvVmDx0bsV/e6CrHQriBS8CB15+
	 6baVDhQBrrhZw6Ma9ufQxQVsHfz0hDQtRjNIuiuN4A/CGaTBfR9sD0xyGkU3bXTsiNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161232;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=y9G/rTFcoqrMrDBhGox+oHuJr3URS+Dyd+OkPFUNrQM=;
	b=mWIVZ83z1MpvHXZV9RqW1iEL77+V+agDZ4Ki7wpCDZ0aRz3+8tDjpMCKd8alvxFJyeCF
	 7frPSl4pjYuSZP5atfbNy0Gzz3aaEV0osjnwOiwovUtkZ+XHqMgjaPsvJvgjepwQVZcej
	 da9izZhvUr2MGTFt2CtGwGxxFezkSfxQibRX1CZKJazRuxothaM2f+utQacyzJIzujuel
	 5Beg8UjM/nAaPU5pL+O9dLGni3h8BUq4W1zU8VtG/WX8hO8+2MsYzPfTaUzcI0t+TR56Z
	 c0RI3RMNJ4dBbAfscRjzOdvoZXAgY+D+JSf3g3bkoLlJBdrcVulcFinKFDzvqUsbwFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="iCo1/T2H";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FFF606A320;
	Fri, 20 Nov 2026 07:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69FFF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iCo1/T2H
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3uV0r2135549;
	Fri, 20 Nov 2026 07:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=y9G/rTFcoqrMrDBhGox+oHuJr3URS+Dyd+OkPFUNr
	QM=; b=iCo1/T2HmK3gOLxS8GD8kCv2Ebx8fJTQcoVa5sV0YUZ49rs2wqi40HXzM
	KFB/Tcns5nHRmVjk6RUnS34zmnVaMGHLStugxy2/QIlEDEpRxGMbe0Y8DNnuj242
	aG6bwGiz4ObrBoy4Bu86jaPDUDwd0CSf9f7oeTnkiBZdlXvnIWGBVKtgnk4rIFm0
	uVRrZ75kAVOGt3kkUzf9JHFrAFDAXPe+swmkFs73nYUcWSeFsQhJH1IDpjT0CV+8
	OO/QWRyooN+MxeoJvw1ROnGRSEvim3gKjkrf45mZx7boQc1P5cd3ohMOR9fJuHKq
	awS/I7Ut0+EoCqMwk2Uah2hLhWZ3A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105npyhd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:53:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7o6g82242262;
	Fri, 20 Nov 2026 07:53:49 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd71hjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:53:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK7rmWi17171150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 07:53:48 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 047A758061;
	Fri, 20 Nov 2026 07:53:48 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C368E58060;
	Fri, 20 Nov 2026 07:53:45 +0000 (GMT)
Received: from b46lp13.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 07:53:45 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v1 0/2] KVM: s390: fix migration mode teardown in memslot handling
Date: Fri, 20 Nov 2026 08:53:43 +0100
Message-ID: <20261120075345.116521-1-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfXxBwwBpZwx2sE
 Dp5ed83fMzbqIjEQlb+1mkSL6zlq6XJnE+z9DiHUJsTHalhHWO5vR8pqzvxu35x/hIKrKR3AXee
 EVzAshgHp7QRHkF4bH1SH/qr0M6UOngmYrndhRSQJ/g8EpV5SZd7RL8dUp0MeersPnimmbSNVnN
 6tEKL6LCFPPxieCW42mCwaB8uRmrpC5m9j61g+FYBwi58SVyW4MSsqjCulCz5xI7sfgvqYfeCTA
 iQWcI3CZBIdoFihdD9RuIKHKf2dVrMTg6W0LfXQgp8jrW++WKw1Ogo+E2rWkSI2qJQxmJU2kuUg
 QaXNzyeale6zSprQVyz5KXw0roYgjk42zBAXTf6ceJJR+InqRcjpHLOwkh8Q+obmlAH2BtYCSI3
 2gT5r32gAha/wOSobrgwunM3ySAmi3VMGeZTz6xGCcxNk5csNY1NG7N8Xc121wtn4yejhj8Rpvj
 bkkWW1lD3wNWwRB9+Cw==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afffc8e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Ahw8-xPTm0j8MKtnx64A:9
X-Proofpoint-GUID: GKhnqizs-uO1Epr9DP4WYfkTtSB8-Wnh
X-Proofpoint-ORIG-GUID: GKhnqizs-uO1Epr9DP4WYfkTtSB8-Wnh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfXx22f2QZksVhS
 J8cL5PXs0xQng60JiI9PO8ewd3Bf8aBbtSXyY1wkuUBoSFt0Tf8QlFCsmK9oXkKURTaNRB38LcW
 V7UKl5bI0bQL+FYP7I1d/M7/O4ajQnk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200029

Two small fixes for migration mode handling in
s390_kvm_mmu_prepare_memory_region().

Patch 1 fixes an error-path bug: if the mmu cache reservation fails
after migration mode was already stopped, the ioctl fails but the CMMA
state cleared by kvm_s390_vm_stop_migration() cannot be restored, so an
in-flight migration aborts over an unrelated allocation failure.
Reserving the cache first keeps both memslots and migration state
untouched on failure.

Patch 2 is a cleanup on top: kvm_s390_vm_stop_migration() cannot fail,
so it returns void and the always-false WARN() at its call site is
dropped.

Gautam Gala (2):
  KVM: s390: reserve mmu cache before stopping migration mode
  KVM: s390: make kvm_s390_vm_stop_migration() void

 arch/s390/kvm/arm64/arm.h    |  3 +--
 arch/s390/kvm/gmap/kvm_mmu.c | 18 ++++++++++--------
 arch/s390/kvm/s390/s390.c    | 10 +++++-----
 arch/s390/kvm/s390/s390.h    |  2 +-
 4 files changed, 17 insertions(+), 16 deletions(-)

-- 
2.56.0

