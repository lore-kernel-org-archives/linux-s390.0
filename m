Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E082441D658
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828650; cv=none; b=GNV9zHcEtSTJRrYOe1/q3sR3jJgqB165rsp9OiTtujunNo+vxwYSAdybWRvVgfl5QqqMeuSnY0JIaLiuSvWkngGK2dmOt5Gd/lkSkvAzZaRf3N+6KoqyoqnIVMb5gdL/yaMhpRKl1HBRh6rLMAJIISsbtO74EHj3TTyB4oUYYgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828650; c=relaxed/simple;
	bh=y1+ZfWlIyjPpuib+RE3Pcg48seTrU3XHTR6lTvF527Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVimuIeGSa7V4k3Zu7FsMQQpE77891YG2UwJYuDSh36fIsIfOqTs8tZ/2qxXsTdHLu9KadMt0OhOPU9U04uQQrDMPO1yFyJf30+7cGkQcYaW9Jc7c8FuvQK2jqp+cHwE0TI1tfmHJDky4Uc3YbULWYTYPQeN0tUsvfVteOjlJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iLdIwCHh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iLdIwCHh"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741K2Ed3660601
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 07:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fSJFu9EQJeoXBJqvRiC/E51AM34lLe
	/I9RZrsrjpwP0=; b=iLdIwCHhLb5ZNUdmgj53FI+DVZocIIE+OEXrWCOQjToG9B
	m+zLvJ+WigvGRC1dAwtlaDPO/IMIbCRdtlw3TggBVQJr84TP+9PoPkWaPYW9/Bs0
	rpv1I2MzgfBeJWg9NRu+GXNwsvv5E6sAnSNp5KUJDiuHb57+OYeU0bTyfnIBkjbk
	xz9S34k5tqFkr8is54ylGCTs9/WuTasx5licUxj3umvM3wBbf4TEyHp7JFxXk815
	WhQ7w6bshJ2OSY/eCNM7Mwb7sfj2EILbuh0pSbIvs14JYQ9u3NpLLfSIAHuTHh5V
	XksutaUpxw6y0oBNkhoS0SJC9MsmN7QxoJR6EaXg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4vpm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 07:30:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6747QR7h020994
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 07:30:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh8vr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 07:30:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6747Ug6j45875566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 07:30:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B89812004D;
	Tue,  4 Aug 2026 07:30:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DCED20043;
	Tue,  4 Aug 2026 07:30:42 +0000 (GMT)
Received: from localhost (unknown [9.111.52.241])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 07:30:42 +0000 (GMT)
Date: Tue, 4 Aug 2026 09:30:41 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v11 0/5] Improve code in zcrypt msg type 6 handling
Message-ID: <ttj8i75@ub.hpns>
References: <20260803083339.212885-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260803083339.212885-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfXxSFp5nsrCk6b
 cJjyobwfK3A5p4AQqnLmC/lUO8Pue5mAeO09JchtwCUgii0z1kyzsRxFzYc51X1GvFEnC8RFf82
 QG4BF5vpp57DMUVQCet6/KGrTj3WjqA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfXwGAkZTOpy/SS
 khTsb4lDSX2Wx9P/GM9c1+zg+Z6oYMV5FCjQ0OqQHktwQlB+OTfcKW9PLCQylcBfrmoTU2scLrF
 n/bOu3h/+US/m5soWjryCqlki6wL0AYF0/HzXOPPn8Iw4d8qQUE79Pni7mmw0Zg9w8iGjiw3mP5
 3uEOxKZiQ7VrNdDEYQ48S94jHUu/NdG+ILb2KOW++N6vfjnzjZeojU2u5wf6Uf/okHaaUNIOmdc
 qKqlmdcxPzZ/dLf6vlYzUCaaoM7eCdC0eza4fYwhziwTd/uWmjQTbCM815k6r10fTbpVRrya/zK
 I46AqI4ekvAFbJPNdEWonZ203k+992ye9bzskpdHU0T7qKvCMWsYnUIC5b+rAalU1Q5tJAPcpeX
 cuKYGjK+LQASdQeoVrurAGKq1Zd/Jb2InF2SmLlidEJ/Hh6Q3Q/tlo5mnhACIpW/JFg/qdhXVNV
 qgkjNYy7SooHQmZJjAg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a719527 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=LebHbyWCPVEYkwr_IkkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tOGPmBeMGfpCk4MoCMxNptzpwd3n74MO
X-Proofpoint-GUID: tOGPmBeMGfpCk4MoCMxNptzpwd3n74MO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040057

On Mon, Aug 03, 2026 at 10:33:33AM +0200, Harald Freudenberger wrote:
> Rework the limit and overflow checks in the both functions
> xcrb_msg_to_type6_ep11cprb_msgx() and xcrb_msg_to_type6cprb_msgx().
> And more ... all related to the length checks done in these both
> functions.

...

> Harald Freudenberger (5):
>   s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
>   s390/zcrypt: Improve CCA CPRB length and overflow checks
>   s390/zcrypt: Improve EP11 CPRB length and overflow checks
>   s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
>   s390/zcrypt: Pad trailing CCA or EP11 message with zeros
> 
>  drivers/s390/crypto/zcrypt_ccamisc.c  |  20 +-
>  drivers/s390/crypto/zcrypt_ep11misc.c |  16 +-
>  drivers/s390/crypto/zcrypt_msgtype6.c | 366 ++++++++++++++++++--------
>  3 files changed, 278 insertions(+), 124 deletions(-)

Applied, thank you!
