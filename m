Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770942;
	b=OctqALPd/+NIPr/+qSl/M57QyrfP2PFudlLlffkoFIuFFdPUbSnZcgYuYUcp4GcdeEeo
	 wqw+fNVZfPHuU+r9n1DxLAGRECwZv4AvxUw9500smB/dcFlGxzmUZ+ea7lxQ5JEAoKelO
	 kV4ZDjbyqTcABkJGx+D+13BHBiLdIRt7pk2xOoGNsKjBlP/5aTid6bMSlyeK95GNA+Gz9
	 VCYlzKr9WGrfTaUh96wOd2H8MRj898J9uu3hzQipwyIBboohA1dxeOYmzcjN8FLK6ha+m
	 6En/+MCinvL83yjo413L92Ki5YA3LzLe0KWLfMXIFtVxlZZEX30/GoYtVfxMegh6EGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770942;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jo8QsYGZ4RvlJ3drr6V1YbI4WNizNz92rkAuoKR76KY=;
	b=TuTxvuCCS67bsaD8QzC8YUZml6rDE3TlF6rNwgjKQcR0TojOkLBUnNzL45bG7rjlSaeX
	 L4YfcLISMrZj5YWepFuTdOtuDTIIoLNnCynxGzjt0XiRiVOpoKgquJ/ALMByCbfDmXDT3
	 CwQR4v3UeZb6axFWyEZcoMyLhQBov/Ve1RtypH0Z1jxIh94BwSGYqYVOfEvV9SJjoYFA3
	 3dVGbiH3pe4I3cFc5/xpePiNbj3lOLVg6SskjaPZ+1Hc6lDJZX3OrZkrQjeXn6hJTUoeS
	 L72nCJqraIt7sa+5CcDDz2Qe4uMSosj5FDJO0Qu75OEUz3mXhbOk+FOKicRhERSDQCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=auinMt9h;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291C606A31D;
	Fri, 23 Oct 2026 15:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1291C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=auinMt9h
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEEPtP2036730;
	Fri, 23 Oct 2026 15:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jo8QsYGZ4RvlJ3drr6V1YbI4WNizNz92rkAuoKR76
	KY=; b=auinMt9hIbaNwIaWqftezG7ZhKOFCIXe89U0HNmXECj6UeExY3tHerf8p
	BB3mKOJgSfjHaMQcJMjJUdR7Hp7B0FJiw9Gu071Li3IfE6iqee0t//qDlVU0F7ES
	Di3TbrmQlt/DXRqRKyP2lAh3UPwlBH9eRAtuS7hzqw3CpEnSvuPudBa9CB4/tUu/
	MIrsAZsg19dQNTDiUx4H1eSgAT9Z457Tob/5kHMPDbK+SoaUA3jbrSoSx7OW6Rtq
	kPPNwoeRNpZiEhPM0if82zX0sfOPkUg2kUUTI/GzwsoljwwOBvDpTcJGV3IunU8J
	vhVNcx3SYkg3du9qaSLjsKysaT/Og==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58nehr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE65gN2165774;
	Fri, 23 Oct 2026 15:55:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfkg25h54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NFtW1Q31851204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 15:55:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA4CA20043;
	Fri, 23 Oct 2026 15:55:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C713420040;
	Fri, 23 Oct 2026 15:55:31 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 15:55:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 00/10] KVM: s390: Misc bugfixes and improvements for 7.4
Date: Fri, 23 Oct 2026 17:55:21 +0200
Message-ID: <20261023155531.206113-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfXxMo6xdH6lOpw
 e1LAyL1xcNOBcNSNS7hUGl8mRrTvIrF+KahO3ZMJbpYVhlEppPuZJNljIWChtwKDkv93421UrFQ
 u95VPTFobvNBB2UxFvmONPYjKBYEbgo=
X-Proofpoint-GUID: S3CYBoVFaUhRl2I90jx7L42yvhfgwTVp
X-Proofpoint-ORIG-GUID: S3CYBoVFaUhRl2I90jx7L42yvhfgwTVp
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6adb837b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=cNWNC48MH7RgBYr4PLMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX4gggBQaorx7/
 Q87VI5DRGZcO2VYfKAes60p/S0FhIPY/NRqCC2FEpdCmwiOv8SGpcLA3t9rfckm4jkLWYRY+YpN
 JftmkEy4f3cBgXiSQ3XNd59dt+rwS0Y7d/aD7S5ZxO9E1bMLKQ9xFccA3whYuCgxtcvQDGOvE+m
 E0jad+Z1ZLBRJnlbJHoX5T9/KsUTrGZpoyo48UC6Flf1iRCiEzzmmu5MfgGNIU+17/7XYLBsGTk
 eCWhT/DUDMkvBfAJpC3tAkXkCvlyjg5OVlW5PX07zJ/wDOklvcF7m7y6f2fjJGD4TWizZlTep4h
 jKqK8J74tgtqh6Me+o7RpK3BJd2Z9HC3I8/rQ03VXQJplx8o2yM+h/PCsLCFFE7NKqh1ud4ylBt
 LbAsuscIIDeFQ07nw6Zk/X/CHEduC9z65LcPKNAqzW3Po+/JYgx2U+CeimB9xHpXng7UrqQiDD8
 iCIntWAP2Vh+Rq4Uf0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230061

Misc bugfixes and improvements.

Some are preparations for future patches, some are preventive fixes for
mostly theoretical issues, some are quality of life improvement (mostly
for the maintainers).

v1->v2:
* add "memory" clobber to idte_crste()
* remove superflouos gpa parameter for unpin_scb()
* clear the zero bit in the PGSTE when unmapping, add missing barrier

The remaining issues raised by sashiko in v1 are false positives.

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
 arch/s390/kvm/gmap/dat.h     | 200 +++++++++++++++++--------
 arch/s390/kvm/gmap/gmap.c    | 283 +++++++++++++++++++++++------------
 arch/s390/kvm/gmap/gmap.h    |  38 +++--
 arch/s390/kvm/gmap/kvm_mmu.c |   6 +-
 arch/s390/kvm/s390/gaccess.c |  27 ++--
 arch/s390/kvm/s390/priv.c    |  15 +-
 arch/s390/kvm/s390/pv.c      |  11 +-
 arch/s390/kvm/s390/s390.c    |  46 +++---
 arch/s390/kvm/s390/s390.h    |   6 +-
 arch/s390/kvm/s390/vsie.c    | 140 +++++++----------
 11 files changed, 545 insertions(+), 422 deletions(-)

-- 
2.56.0

