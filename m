Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791866;
	b=EHweDtxuvGa1fVGN7nQmRuiRldzKJSayAUGc3VVOneLoHzjQYtDio5Xqttp0hMEbsRfL
	 bQn+xe1efbWW2y5MWv8V6jMeWu6gwaeZoCOLbKLuQLGoVUR2H+G8cL+FHdq3+lS+GWa1F
	 KmefjwzVLI5A8EbPah81mUS9AfUA4l92pkKUOxtYbQTbA3+aJ5idnSX29jlEDdn4EtUYm
	 agCP2sgm6civsR2THE8b4WEZ4U9aCEIwKs1LZe0c+vt10U7ejpysoVdE02YKjG/1mcaMF
	 ElXFBiOlWW7YSSO+WMtHBsw4m37SGB4DU5mkQTfx0V0aq4kLkLO9/JZVgy71He3AqBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791866;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sugU6St8EzJa/rDxEmIRnCawp7I5bdjUngSXIvHm99o=;
	b=acmZVCDgvcEYCghipjFrlrGSazDboGOwDHWS2r/4kNJc7E9GIZoM/3+LziFbS9iGMavo
	 2L7lZJ07XFcodNOALK0AST3dVT4yTyQqRQNtj/rOC394RpZCCvMUXUu/nDQWtmX5IgQsO
	 KdYP0ozdv4zRyCXYnLBb0iB3A9nxpzrEIvSeRRfAnhhpdij6eWbypsOWaze3NFBgwWW2H
	 0wrQMChJlPpfroduMGLBYug7YDsB4n8dG+jHaWt+bJSaX6Tks3bJxOiAIlAaV3a9yIZBw
	 GF9rYfYtRHsVvAeby+SyeDZzkkHhNTOaKufZln2+6dqaSyxPNGT4FuGsNc461Zj7xEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="tuJAxh/D";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D493606A31C;
	Fri, 27 Nov 2026 15:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D493606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tuJAxh/D
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4gjq3234333;
	Fri, 27 Nov 2026 15:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sugU6St8EzJa/rDxEmIRnCawp7I5bdjUngSXIvHm9
	9o=; b=tuJAxh/D+34rvUZ4eRFtWyvWNZ7Qn/RfdOGvToAcoJ1QyVZgH1EscFGZm
	ZJVBckqXvf+gDy0L0En1C5ruPz2v+M2HIUix29TgxPxIkupNXMdzrdSEhGYWJsdM
	k5IIhVdSn3NTiVlnoeyVhNvIC3A9RVZMc/jUwriQGK/03hTDSeuh//syZdbrkOD/
	o0bDJ7Up2cMLM5iEolIb7X8XRjtx+QqhhwdCNMn/vnb+vRtJS+cwn/RkvvexpFO9
	I49pHpWI2ilqeuj/QX97hKBFyLs/3kjGwYTXCLhgqgkVjSRgb1ei8/a2dwR6ai2f
	dAw1XTiHopfFEPYoaL5JeiZyWvVfA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvnmfw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4JnO3245601;
	Fri, 27 Nov 2026 15:04:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx992a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARF4ChA42926554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:04:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C75620067;
	Fri, 27 Nov 2026 15:04:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1C4520065;
	Fri, 27 Nov 2026 15:04:11 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.43.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:04:11 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, seiden@linux.ibm.com
Subject: [PATCH v1 00/12] KVM: s390: More fixes
Date: Fri, 27 Nov 2026 16:03:59 +0100
Message-ID: <20261127150411.221072-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
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
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b099bf2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=kGqrgWd52AmznxJEOmgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfXwYBF+se42HnP
 B8rYx0/p2Wo+/GnUB4qi3dr8bvWlWqqJEDwaaP221SVjgkQiN59GYSMjDkw4ngA15J8M3aO20Vm
 56URJJuwY2ki/2/5pl7sKqFPmFpOQrY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX3zAheSr8q8O0
 OZ3XDIJZdfD6ZqRbJCBU78ex/Tdy1Sz3E+t52BBAGWQcE4eq6LyxHKDXOs4yYaYsDMbRvlIPhYT
 2zBn9aczuXFAdLIivT4Ip2AfC7T5cdmS9m0c1y/Usr931IIXpW8R3cmtG5iNmA6lSCvR8gFjWQq
 baglZEyvHUx8DH0nmFjgBj0SFnpjgClV2y5aRnM4gaFNf2esFwqUGAnXpsvbz1Llv8wngeMpbdQ
 aeDYPdF1Hx7a87qQtKNDCNI3u3eRlg+Uh7FhddhYNqG/WsTceCdJX/5YUk47LqU78J8XoyXPcG/
 ox1Q8wzjRt+rQh6GIcBM8DHp08NRtU4zXNqbDU0BXwDQIx2xxp3AMwn7EPvmo9MwC/Zfts2LgIs
 iNNSugJRX2EaIcLHc/qpZB0aJUidXYqQ1eQ+jTxSwwyBasHEjoj7/fd/AN9d2rKIVtrDIwgBgfe
 mquQh9eHRVIYwRJtXLw==
X-Proofpoint-ORIG-GUID: iAyTunW5mn0HDKfSRtVi1ZaHSNda9jRp
X-Proofpoint-GUID: iAyTunW5mn0HDKfSRtVi1ZaHSNda9jRp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270058

Fix a bunch of gmap bugs. Several patches concern proper handling of
the soft-dirty bit for migration.

Claudio Imbrenda (12):
  KVM: s390: ucontrol: Do not mask -ENOMEM when translating
  KVM: s390: Fix potential leak in kvm_s390_get_io_int()
  KVM: s390: Introduce gmap_enable_cmm()
  KVM: s390: Allocate page tables when CMMA is used
  KVM: s390: Fix dat_entry_walk() with DAT_WALK_CONTINUE
  KVM: s390: Fix soft-dirty handling in _gmap_link()
  KVM: s390: Fix race in gmap_clear_young_pte()
  KVM: s390: Properly adjust page size before calling _gmap_link()
  KVM: s390: Fix *_test_and_clear_softdirty() functions
  KVM: s390: Do not unnecessarily drop the soft-dirty bit
  KVM: s390: Disallow 2G pages for guests up to 2G
  KVM: s390: vsie: Fix improper shadowing of non-present host ptes

 arch/s390/kvm/gmap/dat.c       |   2 +-
 arch/s390/kvm/gmap/gmap.c      | 228 +++++++++++++++++++++++++++------
 arch/s390/kvm/gmap/gmap.h      |  14 ++
 arch/s390/kvm/s390/gaccess.c   |   3 +-
 arch/s390/kvm/s390/interrupt.c |  13 +-
 arch/s390/kvm/s390/priv.c      |  11 +-
 arch/s390/kvm/s390/s390.c      |  19 ++-
 7 files changed, 235 insertions(+), 55 deletions(-)

-- 
2.56.1

