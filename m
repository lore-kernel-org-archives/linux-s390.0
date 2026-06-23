Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107AB40D596;
	Tue, 23 Jun 2026 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205459; cv=none; b=ShjryevMU3bYGLTI4TXf0Rdv+PxMvRXf0D3RFm1lxHnVDKyovsm1tyE7EcjEktdrSmkJHsGP5LNqHyj5Kthuruhmh0LzmkYaMRW2kMKobde6nkw+LaRm+sgqyenijNHJa8JnMetQiyuLTDMvXfMA6bXYmfPCO38j62xFI40ahEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205459; c=relaxed/simple;
	bh=jxOv8sgBDBA3TbL5H6V60v2FcnIxAuhuhEvg1ibT3ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZcXkke5gJh+C+1rodOIyHc5ejn1gR27XI2oCIUqvIaQYb7UYo4j3k/2GkHMj8M39/tEFTOCB9Q2Ldh3rJrGwkERitvpllsTFj56RcZvLT62g16JjHs2PTigammn5XWVp4OjevV4zzycfmLlKVYyPpY/Hrs8+niu0xO4HyP7sVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l+Mr/6y2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l+Mr/6y2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6mMC91078731;
	Tue, 23 Jun 2026 09:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=30ooUK
	cWhq1w/zbU/MyM6ICmThDbvIOf9c7k2x9EONE=; b=l+Mr/6y2CMDTgzuqddnchG
	97gWAODKLGKtRH1u7/Gc1u4W+JeJfbRS0EBZS7/v0Sj9SBWNLiL+YJBUUQEw+M9A
	DOpJIzrbJm8hw3wjWbeByZpVvhgeGndKRmIE9l6UpSKc3yC/d66rtSoYQ4Hl0Kc1
	dbA6/PE0/v9O1snxp69bXr+ddvSAbZ/qn9+YhgOaRWkMHumQC1BoREiEF0mySa0b
	C9rxV4UF2TqcDcmvPmMHwyym9FiGG1VJ3u/ANJfxETq1F71swd8GkpZw8PjgZNBT
	k6+NWtD2y8RO1vQK2iuI0MzeB7WT+t/DktdHDxYKmbRg6a/hrjKwqjFOLr+pZygQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsnf7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 09:04:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N8ngs1019901;
	Tue, 23 Jun 2026 09:04:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwaht3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 09:04:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N94CQh45547792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 09:04:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 055572004E;
	Tue, 23 Jun 2026 09:04:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA59E2004B;
	Tue, 23 Jun 2026 09:04:11 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 09:04:11 +0000 (GMT)
Message-ID: <dd6bf1a1-063e-4dc1-b246-d986851cea5e@linux.ibm.com>
Date: Tue, 23 Jun 2026 11:04:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] KVM: s390: Fix dat_peek_cmma() overflow
To: sashiko-reviews@lists.linux.dev, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, kvm@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
 <20260622160739.202044-3-imbrenda@linux.ibm.com>
 <20260622162348.33B201F000E9@smtp.kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260622162348.33B201F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MCBTYWx0ZWRfX4IBYG/Rgie0O
 P/vf++5Fofd9h72W4NcmDaHX6sU67VbIm0pDArQRH8eU/HT4a6eg1D1IrbFla58Ru63oGb9QYEF
 bGqE2ne0BKEluXN/t/tm1O7x3EON6kiGSc/fblrtjcfqDC67bHCBXo8UYuemB3IxqGKjYQbMJJ3
 g5A5rpGq1we5+SR7zU1bXMHxGP3A4YXQTUA4tTgI6zcy/5VfmXe4r4PxRYAvxSWnVzj7tvoXc0P
 LbsiUZVtMYhTatQCfEcxilpqHBWqi4iiSTKuUFlFKVaNXYWDQhaDv4PUdti9Ik+seWLjTXI6iGQ
 pDaBKrVbUzx1IKHMxH5WLw3j4GXUMjCKaPvMXeR4Wy2wouwNdr/mEiXP1k4UGap+fn4ERTsGrXJ
 mD7jVYm2yk3RZyUEJeaR1tE8dkJnvmZ7cqwmrg56GilwLebLYvOVltrQ8hvUFp+Eb9AG3KvUKev
 E4v3X+iDHRKCa9hYQZw==
X-Proofpoint-GUID: d6CdkbHUoXc0HWwwelf66SymezsajplQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MCBTYWx0ZWRfXzOu5/RWEXN1j
 eE0O5BUX2VbPIzrarBYuwp9ScF87MGpV5cZ5b0tYfJKqWi9tbXpjEda3aqwtenAMqH31ctmfD0K
 GA4TcjiHLfEovPkfB4qbnnWjv20WY18=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3a4c10 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=kj-dBZAJfm4ZBbkn5ggA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d6CdkbHUoXc0HWwwelf66SymezsajplQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230070


Am 22.06.26 um 18:23 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Uninitialized kernel memory is leaked to userspace during CMMA peek and get operations due to gaps left in the vmalloc'd buffer.

> kvm_s390_get_cmma_bits() {
>     ...
>     values = vmalloc(args->count);
>     ...
> }


This is already fixed via
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/commit/?h=next&id=c7dda3d0f869dc97223448a06c9a2e5235928e48
