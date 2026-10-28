Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190310;
	b=5cYhqI4MuJehvzoLUNnXILaEa77uDVuEy0YI7ToYrKDsH37X2GJOyme/f9OO3dTiNM7K
	 W50/tdqPRbL68M3agKKoACfArgGZB+iMdo95GpFiAEBjcoMkNelY6bRBf135HoT2y8YP0
	 vE0BUD05bR6ppDzyKz8qsbd95LzrcFvsiAB4dQ+pKvWblDz841rbo/lgQMY+4DHlVlWmb
	 Lt7LSRjG2EkB5OZeZ/zodUit1Wv5gpCjQVmNWU5k8Zoet7+PIWFkzqH+YRwBuie8D7sdc
	 DVURBcN//u+wQGvCxRrdwfTurI4Oi7/spWYYztWl/MUyBkOVEoHuHOnUURqtF9BZVLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190310;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+cHxjlvN8VOyDiFUXngXTjITFg1sgmv8T/ntGX/9zrA=;
	b=exB57TO2bE1U9RX1l0o/eqjtC6Kr1cDdBDDrbQla+P4bpuboQDHs5evE1gR6WTdSwU5m
	 ptfeRmq2rs4k8YVDtFyz/D6+/TcrELmf7+C6gAPXMuDKuBNjIBGVGMp1ISCfu2/yCTxzE
	 bBmEAuBDnzvew4Bq79BoSKeZQJpabwLRWFj5Q/CQck6BxNvLD5VPJjVadaQdjb48mj3Pv
	 +YDYF3zKMULm9hjoXoplU8XxwU9aAEVQSZ21fgQj1UF45u1tBuBaOp5XZjE97+qPY/JVB
	 3oB1CHeockiKk3v3/3/rYRVWE1ELBGtN98bHD9slAz+1TYPo+YeNPIrmLTUdhbDCzlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QErtFuBe;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEB5606A31A;
	Wed, 28 Oct 2026 12:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CEB5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QErtFuBe
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBi5xP1345741;
	Wed, 28 Oct 2026 12:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+cHxjl
	vN8VOyDiFUXngXTjITFg1sgmv8T/ntGX/9zrA=; b=QErtFuBektbiHHF4suxnKm
	rDQQ7a5/Tinlk5LDoTHhewb2xFgh5GTeKn8FJfZP4En9eFJf4Ul9VpCpLs01kCrh
	cHhO9hjVRdBZ1DfCpjUWr4fErPqOWHSghpRpTv6T6ihsLyeV/pQ0nPVs79V+0T3v
	C8CTAcMixHRpzP6S1h1q2KM07Pkrplf4NURIqXZcHhA5Ott/QD8H2UIDnR9APUCp
	o94IWXnjKzyhvb1dLB2/rb7u+lis3TzmScnBB/e9AwslCS7hh2zLlJtm8HhVOKit
	gdFsFxac6RW7OzLbLXIYoUhco3hFqJwUF5GK3BxjD/c1l96p+sdCJVH9LfcnTR1A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm644mfv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 12:25:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBo1ah1501987;
	Wed, 28 Oct 2026 12:25:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7w4eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 12:25:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SCP4wk38928672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 12:25:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C76142004B;
	Wed, 28 Oct 2026 12:25:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CB0D20043;
	Wed, 28 Oct 2026 12:25:04 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.73.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 12:25:04 +0000 (GMT)
Message-ID: <adce2896-9c2c-4f71-ad3f-a319d801a617@linux.ibm.com>
Date: Wed, 28 Oct 2026 13:25:04 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] s390/alternative: Serialize text patching with
 text_mutex
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-9-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-9-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0OCBTYWx0ZWRfX14plyNZ4YFLH
 ruxWsAtkS5PSwdEGKzkOAthykQSXoh/3DJEA95gY37D0CZ+Dx6g7D1XrlxXlDy0pCh3ma7iX53j
 LbQAfyO9SQZNMoQjJwgL7PoimdVNMXc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0OCBTYWx0ZWRfX/WbqcPByJdlJ
 Fm1IMjuJFPN4qG4qvzQDoVBXo0wGFmnIGftHqMOc5gk9SwX6zlPRANUBrfN6dIDFtjYTb1OwecI
 e1XOFPydJzbTALs7sm4gvQ6oMpTbZ9yEAZ9rsAx9Sarf/Muc/kisuACWkeShwmLvCVRDzFe6o8w
 njiKgDrauqKpDumzvOg3DRgSTZtoclS6Xae+K6qqIvSZBi1N7UqrYJXGasAZUwwl4aRPmL7QqYh
 0K/LpLErytd2E7s0DTg12b48T90Hd8qZpItJxOul83L8DUEuTEvFnLfI+ovbUoPSCvM0XQfJhH0
 vl4yb+q0phRVC/QF4L+SudrCndIe8ouTFnPtwQBhPYqCMM+Sbe2eA/ruFElyKpEJRCB+NBe4YAu
 BcdNmWT6zSVXN3oG4Z3YgBgi2BNiPtTpN3xd4eAKxd5epd4x1uU6vSmWQoaEZhtpjGvV40OnXJ8
 4VE2eWKG5pCqoDdH1gg==
X-Proofpoint-ORIG-GUID: wWZLr-p43YW3C8gV-MahScC2_ycUrXQp
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae1e9a5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=lFAPrgHvWctSVXuBu1YA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: wWZLr-p43YW3C8gV-MahScC2_ycUrXQp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280048



On 10/27/26 15:30, Heiko Carstens wrote:
> Acquire text_mutex inside __apply_alternatives() around the patching
> loop.
> 
> Serialization is not required for __apply_alternatives(), however this is
> part of larger series where at the end s390_kernel_write() requires that
> callers hold text_mutex.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/alternative.c | 4 ++++
>   1 file changed, 4 insertions(+)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

