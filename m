Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95243B05BC
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299857; cv=none; b=TKWlvixmYabEW+EMlTeXM35Yt+2OqF3tsDaeNP74p/mpODC9L3ur5eyfJhLEhMEQOUBq3GtK71mB8vMXNjc2T4qRDD/rI3+pBedJyTikaMk70b8hYzdcW6eAkwxuhW0Xzo2Nxxlr42if0EjZtkNsHpla6gieYIll5RF+nGMeccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299857; c=relaxed/simple;
	bh=Jndy6jpl2BLiv6gZXBbZaseWrGHstU2gmUwE7Sh4Q98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ik3iXEPiepD5WJy1hkmVf9AAe/HwApPjk4bQMSToOPKBek+4nvWrmHB1kWrIGDC2Ur0xbaMMqjZRSdz8wdklx2513Ue0j46CIF50ztgH0y8o7JOmRvzHgeT5dyDXFRM8bhaoBQAXyePGCuXEYePdLIjDC4FDmUcfL7JeZZOf8Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A/3a0PJT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A/3a0PJT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L5WE9s603333
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c/ZCCz
	TL4Ij/4dMM98lvb+2Y7N3osmaf43dT03leo5Y=; b=A/3a0PJTfXEXGIDVyA8Ron
	mvjPgiMhK22IC+Ft6jRgqzW8iuirJbUTi6IQL9sXaFxs4O7Ra+6DDwgZpVM9ywqH
	hpnwHTrgmv+rQ2nKIpkYjRWvimorr3keFpn9RFGe2o1ia9cNi3dnewD0nFOUhUku
	axmf1Pnhj5vNPo5CohyZtcqTB1D2qHlUVHN9cwtBxDrNWkWbnKskWr0ZwtKSRlar
	iG+AWN9u759ETL2a1K+ueAcRLmHYJ4PL3Jlc+FXxe5FPnHw7OkgXneS4wyk8peQK
	LXZDIxoR6IsPzOZs6TBqIPnMOxyoKrmXCGezIXQeetO6WdOdWzJsMuXghOqMHpqA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4fts3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:10:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L7uHSv007281
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:10:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekke0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:10:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67L8AjSH51446156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:10:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73E1A20043;
	Fri, 21 Aug 2026 08:10:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C02020040;
	Fri, 21 Aug 2026 08:10:45 +0000 (GMT)
Received: from [9.111.47.69] (unknown [9.111.47.69])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 08:10:45 +0000 (GMT)
Message-ID: <3cb08085-d8cd-4d8c-8be7-84839b6bfbcb@linux.ibm.com>
Date: Fri, 21 Aug 2026 10:10:44 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] s390/crypto: Map EBUSY to EIO when key conversion
 fails repeatedly
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, ifranzki@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260820141957.19091-1-freude@linux.ibm.com>
 <20260820141957.19091-9-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260820141957.19091-9-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a88080e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=lWm6zUTfT8hWOGOvQAkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lHVC3MxVMwsPqC1ZPFgJHBl_9EclGq-6
X-Proofpoint-GUID: lHVC3MxVMwsPqC1ZPFgJHBl_9EclGq-6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA1NyBTYWx0ZWRfX5oIdTQ50J2Ng
 6SH5wZTMDYqqkTpCJKTWpwzo4tl9Pn2fWDPzcw/yxFdGz03vZtjmbSOburdrCWnd2ho6C+gHZQJ
 UWlyOMzMFNOx765qPD/h9lptvdokOZ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA1NyBTYWx0ZWRfX7duLKUOaT5dt
 2kDeP5taBMpCquZ8BadYCI06UGpx9FFTj+G7RAAMJ3tE6IEcRcXzlhv0ZqWBZea1ybCc9oMBjH7
 9mhrBMBeEEUrwavkXhEQ9ygH3M7kQbWTnn/NMO1LG8pCv44tV2I0A4g7/yUjCQ36M5VyHGkTy80
 M1bV4JtRoHxLfrrXL3AUq0q0VK6VhmyCtUAWUjRQgIdfvcuZlmyXb5d7shWXir/i/GmrNIvLDG5
 2i8z9vOiCM0/5IKQOxtO/96IyztvFNhaBNrtJPqYoDwWwrUCNKBRW0jJ+iVNEqhXVdq95Fb3wSU
 e1va6e5E76tVNXj6OTwQ6oRjZVsItD3l2spedfRmmNQn5Mwk1uqp2CDZzmoHXt43e475jlCyTH+
 ivuTjCBwXKTmA/1S1F5G/KzXiWmlZOKei2OhHiHVDWOT4e3qPSXH9ooFRksN3PKiJeUJ99HIvnN
 SYMEXpTAxOZCLtYgnyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210057

On 8/20/26 16:19, Harald Freudenberger wrote:
> When hardware persistently returns -EBUSY after exhausting retries,
> the error propagates to crypto_finalize_*_request(). The crypto API's
> completion wrapper treats -EBUSY as a queueing status and swallows it,
> preventing the completion callback from firing. This causes callers
> using crypto_wait_req() to block indefinitely.
> 
> Translate persistent -EBUSY to -EIO after retry exhaustion to ensure
> proper error propagation and callback invocation.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Please add fixes- and cc-stable tags. With that you can add my
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

