Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684543;
	b=iw41bAcdkOqNuqXNWwHEgq5U38g3eD7Of4UY/uKy2anspHCdkAbd3bsOWOrqrB6K5pjk
	 1F8onwK2D7GVT6zsJ+c+1MGLV8YDwGE1bSqmX7/R+sLOJWQDtuMxkSfQQQaOIXFd+OxCa
	 5iRSdQfz4Y9K4nmyECN0XdTf0HBy8z6uj+YtDBbtO8Ck/igZaIyX6dKswnQroEBH1+OLt
	 obyEnGKzby9hw/2Y4j58PbZ717SSPCGY7/Ydbf1wrc0iGUk2ETOcA7eApBdyCnZ2yCYYU
	 g++FzKWprcNi8yHApsnj+ZOxN1VUOH3sIVs/e6v78olJhwa0otbDHiD41y2r05M3DEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684543;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Gd5C+iYrmwPapV9DncgRVKR3ITDi9CC4IL+B8TRc+Ws=;
	b=azfgItKSekKEiKyt0dicnjUHFAFAwE6s4PqPP6aslnLPFnrPCJDbvqdyCgp5a7pmrkj/
	 AbGhfuc1TyRqk8+aFgKtDTUWHIdC3dkg60kXA+3ZsFYZ53ajV6oEZo5O9m+eHlKaVLDAN
	 APDbZDgTYrJSGG1P16J0GuH7pQ+Cb4gp2OHBrlXPpRo+JlVkmca+qaFdRPaPeDinp54Gi
	 +B2DwGlO6LdELxeKGK/FzTf/ffy4KYYEYV/Dm8AEYP1YD7CGU+ZSxhsWFV1sBuc0lTgly
	 j5PUIZQHXyBEQnkByL47duiQmfI1cGHSRG0xE0osPT/cHMaQMeu536BNWT3kbhG4VdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PS97cNnC;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625A606A33C;
	Thu, 22 Oct 2026 15:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0625A606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PS97cNnC
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEESIx3182534;
	Thu, 22 Oct 2026 15:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Gd5C+iYrmwPapV9DncgRVKR3ITDi9CC4IL+B8TRc+
	Ws=; b=PS97cNnCusBF8n1Y1prvq5MkO0z9Oyxx98EyYG3is6MYkH6J8yH2y/dPr
	kJI9Ua55Ttikf7lMzXz4YZ/qfDfZXsBdR+AHfzh8mzpxA6BEfvzuElWC9a35b9BY
	AoPnIYug9dLCZ4nWgRjpElAinu0RJE47FyAL4/kV3xhu0SOZeuDFjYu7R7kLhTFv
	ybw0zGd57cS1lGqpqjmJHz2CzZrqhHlUWk58X834hkS4SVeZuBsf5ZRcw6Y1bpWx
	2JyWqT+9YEbvCpZFsT6n+PeV9hNtbYWIJWizbpWBMSPXsSToRTy55cKdFWbeFNWD
	+O9NleiYXQhGlrW0aPca/FH8vtiqg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58fj90-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEZ8ZE604832;
	Thu, 22 Oct 2026 15:55:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hekdgfq7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MFtVja47382872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 15:55:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CB2F2004B;
	Thu, 22 Oct 2026 15:55:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 476AA20040;
	Thu, 22 Oct 2026 15:55:31 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 15:55:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v1 00/10] KVM: s390: Misc bugfixes and improvements for 7.4
Date: Thu, 22 Oct 2026 17:55:21 +0200
Message-ID: <20261022155531.204593-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX/5Y4XK+tMZHR
 pKd25pe2rwbhJLCvA0gI81Dvn1VLIDjO1FlO/3KMZeIAWjquSnAQTzRFymjOdoqgf2bE8ye6g9m
 G9gR6H5P84caSzUuyoNkgY+joWZHyhM=
X-Proofpoint-GUID: n19oOaPQs-3cFbRjXPIWl6sDZ60Zlujt
X-Proofpoint-ORIG-GUID: n19oOaPQs-3cFbRjXPIWl6sDZ60Zlujt
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6ada31fa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=cNWNC48MH7RgBYr4PLMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX60mQdj+FbN0n
 EhKU+//TDYaionC/WDqx36lVdcPpYOM2g74VrWvodFZ/aKFZFPtfHbMWveQkmKmvS0PA7Qzpi/S
 wFKsT5uu/uXeIRpmGr103v30pXxWNa6GlBg/8PH+sN3xxtXsYNbtNA+QYwlosgoq8bHRd+eYT7j
 d9E3qZVV5AOoTrdeXEsb9PUrlp2+d5svqrlpNPZZXi+7/7qrPQIzPRrDcTOv2oEGl6YciaKJ/0e
 pAsomL7zBbbJqMuqOEWRWh7AyW17NrbvxLZsLPvwIwSiW3bSftqH3KXdqRzRPyR7gW7mEbxcRRf
 B1tLP42MPyClOaRcc9cSOdDjj4vzbSi53XnTe5EvkDNA8Q/JIBdVp5o5F1x1+7L4oW3oxY9KJiL
 xfVjSv0jbhhX9vYuEIp0gbDyMJCASs4JmGMVn4Dp5ngL+ahZxbjkHDLsb0cca59s7vqq8idYmch
 nnERF8wSWyCs4VrrHhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220062

Misc bugfixes and improvements.

Some are preparations for future patches, some are preventive fixes for
mostly theoretical issues, some are quality of life improvement (mostly
for the maintainers).

Claudio Imbrenda (10):
  KVM: s390: Move some skey functions to headers
  KVM: s390: Refactor and improve DAT tables handling
  KVM: s390: Move prefix marker from PGSTEs to PTEs
  KVM: s390: Automatically enable storage keys for UCONTROL VMs
  KVM: s390: Replace ASCE usage with a struct with more flags
  KVM: s390: Rework some helper functions
  KVM: s390: Fix UCONTROL inconsistencies
  KVM: s390: Improve unmapping of large ranges
  KVM: s390: vsie: Fix pinning using the wrong flag
  KVM: s390: Enable 1M pages by default

 arch/s390/kvm/gmap/dat.c     | 195 +++++++++++-------------
 arch/s390/kvm/gmap/dat.h     | 196 +++++++++++++++++-------
 arch/s390/kvm/gmap/gmap.c    | 281 +++++++++++++++++++++++------------
 arch/s390/kvm/gmap/gmap.h    |  38 +++--
 arch/s390/kvm/gmap/kvm_mmu.c |   6 +-
 arch/s390/kvm/s390/gaccess.c |  27 ++--
 arch/s390/kvm/s390/priv.c    |  15 +-
 arch/s390/kvm/s390/pv.c      |  11 +-
 arch/s390/kvm/s390/s390.c    |  46 +++---
 arch/s390/kvm/s390/s390.h    |   6 +-
 arch/s390/kvm/s390/vsie.c    | 135 +++++++----------
 11 files changed, 539 insertions(+), 417 deletions(-)

-- 
2.56.0

