Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED495382286
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619225; cv=none; b=msZr78XVCoenajFdc09KxuoCtn5Sfz40v5whWML3S8N1NWSmc4+GZSkw6MRl8HUNgzxkw6W5olTyVMc47OSmGazHLdv3BGpwlRW53E/JTBsWuOEwnEY7aXJ3eojns6sKbfgCsxleACvztN+kAKmSb2SV5LQCx1hNysKv6DtGhm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619225; c=relaxed/simple;
	bh=mPRn9Gf4FyNcveqVZRCFHQMwRUQjemZVtoPsaejvbW0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mP66TY5fBIi9bYuz+WFlqzGHagWnVlW31gZWwIEU8VLFDJeqqdVWQF+DX7vKbW8uPj3OYYIriNJ4I1vwZRlFNKSP6OulVnTxeQq333UEyPXfrWrNwM4a1bAy1EYwyv4Y4FSYVT/1Jpoy3sDATwSWVUTRA63UhYjHyBLyiCLV5Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=atBMltBg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="atBMltBg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D99New1951223
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=B1LCwwerQYWEJCV8bIQFLSAvoLwVTVE2Qdx5fKTW+zA=; b=atBMltBg
	da5vOZFWr8dWZNh8Jazmn6SPG/5Qg9uxyWmrkThmkkLOrB0HkykNZBXR8CWp6IQr
	Q/eh3iQ/tQVbgNfqHtygvFOKIeRTWlwv/ljBQthqpY2PbYLJIXBWvOWbQZdirYtW
	qKyYpZxz0DPcMAYlvmPlxvAaMSIsqdQqh4srbAiH68huc8DhmossmGQuuD9h0Bk9
	TgJU+9X92UXKdL5d6VVevfMxEkZzpO19PCyS5ZFZLhpyDA1LB5oLUx8se7od2xk6
	sHTneqGqxT3LlZ6787kNKfx7mYxmgU7iXsx9MMFzSLbtB6xQ/Ac4EVgOV1iS3Kqn
	aST9FeR7WVUZgw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwej31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:06:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DAuOYa004544
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:06:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk2qmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:06:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DB6rYC52232534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 11:06:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DC8A20040;
	Thu, 13 Aug 2026 11:06:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56EFA20043;
	Thu, 13 Aug 2026 11:06:53 +0000 (GMT)
Received: from localhost (unknown [9.111.42.87])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Aug 2026 11:06:53 +0000 (GMT)
Date: Thu, 13 Aug 2026 13:06:52 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 0/2] s390/ipl: Fix missing re-IPL parm blocks handling in
 dump paths
Message-ID: <c00-02.ttjpfvt@ub.hpns>
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
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7da552 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NBBEsAxjE9aso72u2tIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _fIu0T3bE1xwYBQc35XI2ty0kfsCRqck
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA3NyBTYWx0ZWRfX3nAQbfOP6EbZ
 k3tA+f2h0ZSLq7d3XhXMGneTasNiKIyczpsDkAvZq7VTfNs9X9jgBbLL10tHxiktifF+mY5SUcZ
 cVGMazv/ar5gzug6KDlKzpgNoiCK1tofirJ9Ywg741TdMBs8pc8+9ic/R5d3hBQqeLP3vCHZjzz
 ofe8w0aAM8H1xfY3DuHhELDwW/36aKtX6Ta0wfbMJs/SrALfv1KcH35u871c4P9xJiXB7mvi9tE
 K19I340yJZJgZD02OoLtn5k54Qs8IU6ZUQqc1Ev7Bvl1BMkgNV8hRRieNsgkI6dOcT7Vs+z+Tht
 NwpoV5if0twRKc3mL3B8yg4KbQMuDTnP+qwQLwD9+CDHYFtJHewdP6lzyHuTxpeMV0HbT3bp6Vr
 9tp3w6ey8a8M8PyC8PbS0AYAanya3dFM56kvKplxDRH3jIfudmmSdEQKCpJb0R7TLz8AwmmMZyl
 b8fIQWiIhdTVFc5w69g==
X-Proofpoint-ORIG-GUID: _fIu0T3bE1xwYBQc35XI2ty0kfsCRqck
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA3NyBTYWx0ZWRfX5xeFc+dPC71Z
 P03f74oytXzb/FqnRN74qQtTXCwjwdo0oUSY5bPOLVyDGyVAQzgjoVRjMvTBqnYtKyhh5mHnKuy
 y7nJmFZLJ6KdlEFvF9tdF/0HRABjTEw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130077

HMC FTP boot and QEMU direct kernel boot do not provide an IPL parameter
block. This can lead to NULL pointer dereferences during kdump and
stand-alone dump processing.

Fix the kdump and stand-alone dump paths separately. kdump continues
without a re-IPL parameter block, while the stand-alone dumper completes
the dump and halts.

Vasily Gorbik (2):
  s390/ipl: Fix NULL deref in kdump without re-IPL parm block
  s390/ipl: Fix NULL deref in dump_reipl without re-IPL parm block

 arch/s390/kernel/ipl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.53.0
