Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DC53BBFAE;
	Fri, 19 Jun 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884336; cv=none; b=qVCT9sEmPheK6a+EfMVXs5dhgVzMbh4B/vVHz9PDaj8rLtXptv4c8Y57zCbHpfNJqOrecydqQu6pLVvL/aV/K6vB2IlbJMvFrt8d2YZhaeX7sM/pLR3Ovw//wAJxT1H2dc2JpQHW/g8/fV56RwC0yb9ps3vd/3rPjkiTlLID71o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884336; c=relaxed/simple;
	bh=PteWhntZMlSyh8epypLEhndtHdHIRE48k59zNUelkLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KS4CWxZ72krgijyEy9gZVl5K7Qyf68lydfx8r5CyTJpUNeHZnok9FaEGHe12zscmSA1iGtMijvpCK8JWVFT3+imK/mzvOWBehCpBRi8o+/xb3nK9QNhLp+tl1taCQnveL5hBjJRhzJdR+M7BPA1Y0+kdVvZSyhwQO/A9PAlyjHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bHVaHjqV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bHVaHjqV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JDIVxc2292977;
	Fri, 19 Jun 2026 15:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cuUKlGAPLYl5/GoYFEQciCkQk3JtsOD/Mdu7na50q
	OE=; b=bHVaHjqVvjdveX0KyG9eUJRnWoYX7+TAI3fIxMONNPeeAqRZdS7ycOw5y
	s630yKcz8HOgUD46+PJFO98Pr6C8jW1P/Pu2GJyAK/2pUPQFohX0y85gwgj+JIO1
	GMw1rUdv1e4wNAIWCGV5ojB6gH8/MzLyxSi3oriFneXOzb+d070qyEbudGlJudz0
	6ztYt8xW+OJdODUzPUIIJ6+O+YIv/LaLhs/vQXJAA42PXL1INur5A4Qb+7uKjYU+
	wMFH3p8E+VE71b909hVkdhJr77tGHz3evss272jaHnhhCVsmqpCIxvG4EH8ovoUj
	nkI6jGRcPjn7vP9JFsEZxtUY0O41Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxe89r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 15:52:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JFnhqA026516;
	Fri, 19 Jun 2026 15:51:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172hh67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 15:51:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JFpu4E36241686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 15:51:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 249782004B;
	Fri, 19 Jun 2026 15:51:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1853D20040;
	Fri, 19 Jun 2026 15:51:55 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.54.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 15:51:54 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v4 0/7] KVM: s390: A bunch of gmap-related fixes
Date: Fri, 19 Jun 2026 17:51:47 +0200
Message-ID: <20260619155154.307572-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE1MCBTYWx0ZWRfX9sbH8Dx3bfe1
 poU6V6gTSqcwJI86G861xMkcFEIkXnodWWtcFQOCrjkyAnP3fToeYYeCIi8+U+ZbEq8Sbm28vO9
 g0P6Zr6L7sg6Oh6Y4yfoQb4Zq47zJtS7TnSE1w5laWJ7Bo+2pigkJ7iLAhjQ0Lfs6bziiO5obrl
 vCPJSAyepAzOzUg+Q5uMX0bYebAjzUuOuWIe0d2OnpfxI84pC4xJCqM6fGfn/syVXiS4YG2BSDC
 hJbZNOa1eqTi48vG3AddixfFTltibNixBHSdfLeZA+ePdV/Bd9HqoGoJXTI00LaCmWwe9z4Jqgm
 B54TlRMKR5qdQrqiz3frOUnIwdD6H8Cixl2VV68YHx4g/Spgt//lZJ3bWjiB2uf6joRVI+UbZbE
 a9qpzeW10wStF7wtJqUIXmnkqP51k25/SciMboCPE0tp/HhU9Qntv9/0bczyDxMhrVNnZ9FN4e4
 CxGWkLxE8xq1GMfdLgQ==
X-Proofpoint-GUID: yB3vtfgZzSkAAQgDR-gxwuItJ7QQtT2B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE1MCBTYWx0ZWRfX821qqmvbvM89
 eDoMYD9MTXX5sJuPHdmDriKq1pTxYYSOIdACVe6ZPdXflM+nQNLFM+6ze9SZqpyYtmpmCrdCqcP
 caczBYvFzwzu0VzTONImemLPaFIqAgU=
X-Proofpoint-ORIG-GUID: yB3vtfgZzSkAAQgDR-gxwuItJ7QQtT2B
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a3565a0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=ucjmMn6u_Xy7mvBSwZ0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190150

Fix handling of _PAGE_UNUSED pte bit. The bit was lingering around
longer than it should have, causing issues. This is yet a different
approach from the previous version.

Fix some cmma dirty tracking functions.

Also fix a few other small issues in gmap.

v3->v4:
* Improve/fix descriptions of patches 1 and 3
* Fix handle_{sske,pfmf} under memory pressure
* Fix cmma dirty tracking and its selftest

v2->v3:
* Fix _PAGE_UNUSED in yet a different way
* Fix a potential overflow in dat_peek_cmma()
* Some minor gmap fixes that are not actual bugs yet

v1->v2:
* Completely different approach, entirely new patch

Claudio Imbrenda (7):
  s390/mm: Fix handling of _PAGE_UNUSED pte bit
  KVM: s390: Fix dat_peek_cmma() overflow
  KVM: s390: Do not set special large pages dirty
  KVM: s390: Fix code typo in gmap_protect_asce_top_level()
  KVM: s390: Fix handle_{sske,pfmf} under memory pressure
  KVM: s390: cmma: Fix cmma dirty tracking
  KVM: s390: selftests: Fix cmma selftest

 arch/s390/include/asm/pgtable.h              |  4 ++--
 arch/s390/kvm/dat.c                          |  5 ++++-
 arch/s390/kvm/gmap.c                         | 18 ++++++++++++++----
 arch/s390/kvm/kvm-s390.c                     |  5 +----
 arch/s390/kvm/priv.c                         |  8 ++++++--
 arch/s390/mm/gmap_helpers.c                  |  3 ++-
 tools/testing/selftests/kvm/s390/cmma_test.c |  3 +++
 7 files changed, 32 insertions(+), 14 deletions(-)

-- 
2.54.0

