Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548673C1D79
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832095; cv=none; b=APPY29evRmAPX7zNlzbe1e2CKtg7FTW+X4BrhIfPq4H67WxKUvrkvTErvLN2r1W1MH8YoivTrmtcFu4WqR5yjg6Mk9/E6iTlAZlaSBI6eoRbDLahOhwPw8SlVoNLYQ775zAfovkzAEcGLtVWdkD/FblHqFtPpHp8hDqGesoXquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832095; c=relaxed/simple;
	bh=PK34yPja3dUKNyH3kuUpXCrcMmRZcqS+OskbuviI8MA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f+YZ6M9634I7q8gt0LuRtdVCY7ZTexBafWWMJqTacInV6m0BrUU5m6cUm7M8Z233QXAZmHOiTLl7KD9THLa2GIY0dN/q1O+SK1wOblaTeL0Biwt7/ZHNIIPNlc5os9VBFweqUp/Mf94drB2ioKhUqvMSGVvi23kJrhtJ7eSJETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kVM4nr62; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kVM4nr62"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9VqQP732034
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=vhroy/4CRTzUvmZG5xGJx4fmpYM3Lw6Qv1YAUrr0J7g=; b=kVM4nr62
	D4EFVeD85f40FfSI46v2eTqxzU5N7gcfhKgAZ5gO+jX8/XTxgOrIiKdhcsg2MBir
	9EbEMuJztmGFya/oC3HIxH99347ZjuVWC19uPcM8bXtE7jwePJUgC3AJmUdlRqvv
	ZB4/XXR8gf+wGUYSzBLLaV07p9B/V3mNLXwuAFsZb5wcxFO/7/YYuXHfFJjdz76J
	yfKEwWsmFV+5q+lUfEccUm06ko9dG4RCp/P+/23d9RWEd421lOxKI38kLE/RNIsV
	oaEXEzAVistMvVCaWPOCBDE7hC8b96UkBHJkxDss1KES5wfwSdprQk9O/8xcn6o6
	ZY3nC553ifohwQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er52mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RBuIRj006069
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k7urd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RC1Sn245154620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 12:01:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 023622004D;
	Thu, 27 Aug 2026 12:01:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF6FD2004B;
	Thu, 27 Aug 2026 12:01:27 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Aug 2026 12:01:27 +0000 (GMT)
Date: Thu, 27 Aug 2026 14:01:26 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 0/3] s390/boot: Fix couple of early boot edge cases
Message-ID: <c00-03.ttkffvj@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YoH05iGeWpA7Z6zauD8GlAyAA38-H05I
X-Proofpoint-ORIG-GUID: YoH05iGeWpA7Z6zauD8GlAyAA38-H05I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwMCBTYWx0ZWRfX8RrodUWMtzRZ
 Te3+PJk21Nk0YvUUFfEoTbhDvi1dN5VBNqaLy6CoUv4Z3zRNnZr1eHhFSmpT1Gsr/duawm5bYUB
 J8eXJVLE86xI+M6dfoF2JR9JsLjt5ZgabxmBU2Uz0UWmyLeDfJrjchcMEr+a7RAmWeCdECA02BA
 8bMH8epYq7WV6DO8sYpmxpLfZuhuRL1Run7bqdGJDiqRp57R6zYzJq7LOH++kBBvEc1AxjeuCg2
 BWINDV2ykJP0lRT8QRcvzE1BNcnpvOu47Y3ZGBPbTsbf7F+h+UNyx7QXrUsCk0yXCs52OIfCF+e
 ezowHhewFjZDzdFgiepGwI5RVZAKi9QsAtJvbZN8ZomngybpjbcDRHkAknPVUV6Nnp41W/kPILt
 lM2669zC77o1KKFBdcPYdVYpdxxfPRSKn+XASB24ITex50VTA5KrhhxmdgE4GTro5afzQuX9o0m
 qAYuchtFdS4Nx4jiomg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a90271d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=Teaf-JRiFPwIdo81I4gA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwMCBTYWx0ZWRfX4ew5X3Ro1ffx
 3DzLUYkZ1WyheIsUXTMV6WIgOCrRfcGATwjPdRBx+cFIHhqxDt6fffhJtdHHsz4EMbxknuYI7ac
 lquIHaxUazpf+7x/sZS6UkiPM5rraLQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270100

Fix three independent minor early-boot issues involving the physical memory
search range, full command lines with IPL parameters, and unbounded facility
ranges.

Vasily Gorbik (3):
  s390/boot: Fix physical memory search range
  s390/boot: Avoid IPL parameter append past command line
  s390/boot: Bound command line facility ranges

 arch/s390/boot/alternative.c  |  5 +++--
 arch/s390/boot/ipl_parm.c     | 23 ++++++++++++-----------
 arch/s390/boot/physmem_info.c |  2 +-
 3 files changed, 16 insertions(+), 14 deletions(-)

-- 
2.53.0
