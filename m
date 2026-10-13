Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01153BBA0F
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899069; cv=none; b=N7ylgbA/JJPShvSXCIavI4bOuHKa985IaQTl2f1oRb7iTc3HHNKM8JHVIQSHdA0n7nCFtOZDugatnZnU5RQbyLYd3w5PcKmTSNBElRRCmSmb7syF3FZ6pXlWWuV+Ff6h5s/p2xpa/F3oBv927HdFGpx3K/oi05SbhIas2MtArR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899069; c=relaxed/simple;
	bh=3HLIbuZaldfPTe7wLjQqsbBTZrl6d21vBw9sLLf3S7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B22Lhc/WiuOIH/E8S/FhrVwLsNpsSgFYzRYhIT2ZGpL0eGat2zENvuMtvr+nKJVgiyNBfH0xgnSNH+o1qUw7oOh44jkmdZ3ryKD7cUnqzC5gOwOENJBs4TfFuU6fx1cGZn3/NWxt2ID2nsB59XXU4lNwc6Pf7mPGjev7bhqnLUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Toz8FnAw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Toz8FnAw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2ELpo1931558
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xFJ4TWQ7gEAGVsn8JYErfwZSpr2xQktIOwsipo19A
	M4=; b=Toz8FnAweoCUDwfTiqsrjFanS68LAdOi2gSFruCVWmV3ii3CuUTxynLme
	8m9FcvPiuB3ul8kDQu2LHBHZQsu+ijlVhe4c/MTgV5aiCIXA3nL60Um/LnXMwYJW
	YgHoxMiN/cmBbruIyYl3THR0/WEuglW4LtWBnd0985TUrdKwTXWlDV/JjYZ88Wwo
	K7D/wa1sv8cbt1VsKvlMWRvkLzH3vD+TNWbqXACzLW1wwTABZLWmPMs4Wgv5uvj1
	Q+9qzV5ZIe+tcdzBIgOh/ye0zxAL+t0llHF6aCOkn8mRHvGTjEQW+e1QJjP0QP2S
	qLgrWb7WyJ6MyzPAmPT3FHQQygowg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w5yn1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCV7pf2660311
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppt90s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DDiN4M32309986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 13:44:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2811E2004E;
	Tue, 13 Oct 2026 13:44:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02D8420040;
	Tue, 13 Oct 2026 13:44:23 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.94.37])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 13:44:22 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 0/2] Support APMLM field with PQAP/TAPQ instruction
Date: Tue, 13 Oct 2026 15:44:20 +0200
Message-ID: <20261013134422.64155-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NCBTYWx0ZWRfX5JjNB3YGSt5c
 iRgSx2ur5CJj42cF7vO9l0JDWCpPjFQJ8skbv1Na8xlzjs1opTH0qVLNrfOvtJtJ93Cdrkxg0lC
 CFMP1bFOui/zXbGUujss5Hi00AFginI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NCBTYWx0ZWRfX4U9UXXNpHnto
 gkCskXOEAhoS+TZByHGGnHoMNlFUmvbqIVrvk6MF5Fjwh6cy9tTPBlUDkDRdMdas16xY74orink
 IvmtvzCtFsMB2r/9D6XBxAXr3PbfUQRpn1YiVu6W33w5iA6LPrPRqkfEuref+3Od/X5dvcWjRK/
 1lamrZD+aQtVHQ+7JV2wgd4NMPrD9dplrnKf4ogK6Jj/xPPi3ifiqPBO04gX1jfMpGpeBeK6BfG
 a2tl4N4sdN4kwiyZSTWGTOtMnIdMo6k8+bMYlD5YeE8rJb4ZpAr3OiCltd2Qk8l6vJfU48fePI6
 N8BzCzG9Qb1bT1KC2meca46N+6u0BjL/z3KHqsDp4j5E2baDzaQbfWlGTnIie4rTTF9JVv/UxF1
 9xQVe7Q71WN8/XSk1eBYw/mD2FJ6gi9gGZhAxTUGumHMko9zCrVkP0SiWKBAeeVsUEwf4w1GEn6
 KccdN/gNObytNo4Gb6g==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6ace35bb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pPaMA4Bp9U77yAhfZ5MA:9
X-Proofpoint-ORIG-GUID: uAXDOFqF18tJvULNi1E8GE-ivEe8x3vy
X-Proofpoint-GUID: uAXDOFqF18tJvULNi1E8GE-ivEe8x3vy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130054

There is a new field APMLM (AP message limit multiplier) defined
within the GR2 register on successful invocation of the TAPQ
subfunction for the PQAP instruction. This patch (series) covers all
what's needed to support this new field within the AP bus code.

Changelog:
v1: initial version
v2: The update of the bit mask TAPQ_CARD_HWINFO_MASK was missing. So
    the new field apmlm could not shine through.
v3: Shashiko complained about that there is no upper limit but the
    combination of apml and apmlm could lead to memory allocations of
    960KB per AP request/reply. So introduce an upper and lower limit
    to crop this firmware given AP message size limit into reasonable
    range. By default 12KB...72KB but the upper limit can be adjusted
    via module parameter.

Harald Freudenberger (2):
  s390/ap: Support new APMLM field with PQAP/TAPQ instruction
  s390/ap: Cap AP maximum message size adjustable via module parameter

 arch/s390/include/asm/ap.h    |  4 ++--
 drivers/s390/crypto/ap_bus.c  | 11 +++++++++++
 drivers/s390/crypto/ap_bus.h  |  7 +++++--
 drivers/s390/crypto/ap_card.c |  9 ++++++++-
 4 files changed, 26 insertions(+), 5 deletions(-)

--
2.43.0

