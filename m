Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8AB1D63E4;
	Tue,  4 Aug 2026 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853339; cv=none; b=N0jhKfGh00XXAUbQo2Um4oCYsExyAajf+iAUw3oTxGZtKeUPASHvN/R669VMOp0qaudONdYP3yFY4bKqneNAOLvyQZb2/vHqyNA/OZs7MVr3DusLlRr+YMFOVDNm+Oel4F/sG5q1FEBUrQyJp+jQaTa/6zpiqZpdvPjtm3sd/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853339; c=relaxed/simple;
	bh=JHq7WIUD5gSx+Gc05SO4rhssSmtIikMBnb57TdeWwG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFbMvOqfkdViohl/vgXAQV204clDHC7dvhKELhXgJCklYK99cD99c1APgKqKIEc6ZA+ziaeJQtlW0KA2/YUXHs/E7A5lqL2iByE9kBTFJAQu7FdVB/px7wE4yX5xwzYQTALyp8m+xUZ/YttXgwRKVIFXhE7s0xWG6qQx566rkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dbq3iing; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dbq3iing"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674ClgrF802332;
	Tue, 4 Aug 2026 14:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l6zPDAMyPkDmzH+Ep
	T/zB2Qxtdp3t6jjHjx6O/av8ag=; b=Dbq3iingK4KTiUx6TeyWHLNbw64FPc+K0
	enQmAZ4UJbVdShnWaeJw80cBYvm2Z5Qg/ph7KikdFOvAej4pCp6AnQL3LhtxDTXE
	2pixdF+djte2G5bsu9P+alv3Wfk9IGjJlpDBEAYwsXxQmfE/22qpXZ9723jLb3N6
	QCBgxwnUWXSk33At3Jw+hiPgrPk/6k+6h5BKBYuGmb/mv2J8LhHR7rHVe3Q6FQNL
	6quY4Fha8+XrmBrDtppcXFlys335cWvSTkiAl4LHvamRi46JLcWSyKIB6VotNHxo
	AZ0umKw3myTVf64hkW+bLVa+tcienoEOca59hZKU+j4vASUISMa/w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g5y6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 14:21:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674EBHqZ012102;
	Tue, 4 Aug 2026 14:21:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmha77r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 14:21:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674ELh9F51577200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 14:21:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2017220040;
	Tue,  4 Aug 2026 14:21:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F252F2004B;
	Tue,  4 Aug 2026 14:21:42 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 14:21:42 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests 1/2] s390x: unittests: Reenable tcg for migration tests
Date: Tue,  4 Aug 2026 14:16:28 +0000
Message-ID: <20260804142133.1745878-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804142133.1745878-1-frankja@linux.ibm.com>
References: <20260804142133.1745878-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExNSBTYWx0ZWRfXw5PcsXSbnaC4
 lStob7MtZXrH8XgyJgVVcq3/Pt3uZ4ddgX2DSVhDOaKZWJOzWTi4xYKi37ZiyCNuSLVbVgy2FZt
 9+G2n2PtAbyzgENqkw6P/YsYb690B1Dz9rcVNOqW16d5WWf2luku1IZcQkJl79jNhkcFP7oMQex
 cefAQgvhwt1zoKY8Bt+jv3bE0FvrIqGpAjz+AuF0UfMDW2o0IVjaBw41p/zS1KnXue+s53S2L87
 Gi/iEzeCS9nsJqGIc2oazLDPwWSwSGa/V8A6x+cBUarblvhNRX2yPbT+0qkvvxnDB7aAaTjbAZf
 F+9UUfwunpOT073ZwKGMg/s+TyFD7CySBTRfkDPnyNmtJOourSwqSA4QLanV1XIdfw3eFYaOJ+C
 kv8hW81KrldCwxxMV25yb4cex/sK2DWW/c72Fr2vA3yAZHhwRHed/3nLusDbASKLVHDD5vj76YT
 /uhWE0euv3wCNQTplmA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a71f57b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=uh1mXFUSPedimpaDh2MA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: LNlFGQCDN-zCiDYyMas6vMxRiRkE4LFX
X-Proofpoint-ORIG-GUID: LNlFGQCDN-zCiDYyMas6vMxRiRkE4LFX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExNSBTYWx0ZWRfX85ctyKwepum2
 2jkFxbVhb5ON4nASLdBIdSTx35fszpH2sTQG3sTa//xtwMj6gAUbjsOOo6SHEWHxBwLXb0huljo
 5rns8Bs3G8BpVo+4F5NlAu2Fqgw/U9c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040115

The TCG fixes for this issue have been in QEMU for quite a while.
It's time to reenable these tests.

QEMU fix discussion:
https://lore.kernel.org/qemu-devel/20240312201458.79532-1-philmd@linaro.org/

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/unittests.cfg | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index 8c39d4f1..64bc998d 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -15,19 +15,14 @@ test_args = 'test 123'
 [selftest-migration]
 file = selftest-migration.elf
 groups = selftest migration
-# TODO: Remove accel=kvm once the following TCG migration fix has been merged:
-# https://lore.kernel.org/qemu-devel/20240219061731.232570-1-npiggin@gmail.com/
-accel = kvm
 
 [selftest-migration-skip]
 file = selftest-migration.elf
 groups = selftest migration
 test_args = "skip"
 
-# This fails due to a QEMU TCG bug so KVM-only until QEMU is fixed upstream
 [migration-memory]
 file = memory-verify.elf
-accel = kvm
 groups = migration
 
 [intercept]
-- 
2.53.0

