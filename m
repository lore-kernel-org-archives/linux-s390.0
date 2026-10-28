Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190269;
	b=aDNN63YTMnAXyehCn+euPHezCnpeIr8tSscS6Qf9ZAktlmvVOyRacxrKfUZiJt/OThHN
	 D7EjMPhcBxO9PDv2jeaYUB1kUwe1QJoZElMbfonPXgt08jDxxPxtIs/Iq5VvI16u6+Sof
	 SSzqwB1lEY9792+musEFvElLgtp7xNhcY8JI5KYjUgmWL+iCthN7gOk+O3hCr/qRUt+Xa
	 hu/1Hlx1p+iT9LkCfMY4BsX8h1D9NvrHsC2MT3sSD/pBDrBRt3hWclwPM5vTpS61PUr3F
	 YLrLb6A0WXp8mo03sdwwds8DfDrNuYylGLseInMy2us65o6+T+bilBUqEFt8vqs3g2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190269;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VkwsenjxlICO21oX9qWYCdyTytlg9Dgl3JAZ7Fjkr0A=;
	b=BGp6T2gYarRAfIopo1VH0MV2Sc79Mk/IAaBhsQxnbJGfWPYDE9a6hl1u0pn13/TNcg1O
	 lqw1EKF72W6a1BzPGVVcfkOz4WIA9zN1w3ZUZAT1TUkIkCrAwx4qat3Dp41e9/fAqHQZX
	 Nox4YBEiZ7b44hZ7hJsgWlbrywoaP0f4ph1IN19tPeD0PFdQRL1MzilEsKhZVxpuj056B
	 VlofzA60aCqfnQ1Htib45Fh+Vw2V6drQEUyquzRAje3706WacnLtx6ZsNCwDFfv+poim8
	 Pf2p5G96DqnepOtm/XkmkKvKB1w95ZRspZ+L1+0uHAKO6be6c9GlL7kpof9IFea+Nzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VqD55CmN;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C560A2602;
	Wed, 28 Oct 2026 12:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A82C560A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VqD55CmN
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBiKoq1346117;
	Wed, 28 Oct 2026 12:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Vkwsen
	jxlICO21oX9qWYCdyTytlg9Dgl3JAZ7Fjkr0A=; b=VqD55CmNZhEUkFsrDnbPdo
	8UAEjI7NbhOJpC7y0GcPygnXVjOpA/SgQ2rK4xb4Z4v9hjdKUWWEPEoCGNRoQoEl
	7PgIOC+Gh60Y4iCM2ds7kBAsSc5loUcGFSZ4i5UeYg6NVP7PqpVgRxZpoFAAmXC9
	G5hGTWtoDkrpddfaIQUwfDbNVihKdBpAHGlM0KfSgcuUv3P4gawjIpJF3DHQwv8C
	nTjkfytbCe2w8ZnyN6fjsYn8hwmF0f+Y7d8y2pTh/E8KyFd2XkFrLQy9uy/AB9oT
	Id8yi/oaCbnFIVmr+PCRTDgjmqL2CzXdMIALkYanu8SkIxzIol3+qGR/Zx/jt3/A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm644md2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 12:24:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBnwMq1501920;
	Wed, 28 Oct 2026 12:24:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7w4d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 12:24:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SCONMJ53412186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 12:24:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CBE520043;
	Wed, 28 Oct 2026 12:24:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 434FB20040;
	Wed, 28 Oct 2026 12:24:23 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.73.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 12:24:23 +0000 (GMT)
Message-ID: <044018d6-3348-4e44-841a-7eecca8a6b66@linux.ibm.com>
Date: Wed, 28 Oct 2026 13:24:23 +0100
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
Subject: Re: [PATCH v2 07/10] s390/nospec-branch: Serialize text patching with
 text_mutex
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-8-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-8-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0OCBTYWx0ZWRfX3P0rNuW378PH
 1xtwBfQYPVKkc4MZTokgRnYtjXdug7r6Ki9D9qO7TxisSMMs76qjoMAktCbhs87t29WO8NhhUuB
 SeY1SPFVYsSPYdHNwF2wroOMZhC3Q7s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0OCBTYWx0ZWRfXywYMWRYPrOIr
 brQpOfqVv3+TNxP2pjztnIYjJmJCKjabQMHWp1DyntFnnFkM4RGHcGZAzGDVABBo5EaQh5bFsZP
 NrzY6KramC0yeovR1qK+qiJuthvZ3y1JVUO2QnvIaN6uuvACkRRRD4x6yoFDZy9SKQrafrD3qyo
 V9FCrisSMWg28jzkqY2JqX1uPKLbKyaOdQnuxV/X0n/69Btg3k6jXePVEqbyF9Nl4f2omL/UexC
 5J8Gh95r5YZtk9F3VqypGMq+kiVAiFjSeys69/0DHtSb8oVBI3QZv/MSss3pyeAzDZO4KrDYEAr
 EJiZGWDKPt2g8uvDH2OnM/cuianHg1rVSJzP4FQPPtKGI0DDzOYYxi452L0mcm0RhyJTuG2x06p
 j7cvwmXR5oRStAT3pnTXudmy5nnBDcTrdDHVRZPAaWjocBxAYSnVGZE5GIlDz49yxAGybRxYfQr
 SlmWXsZdTNbds+vunbw==
X-Proofpoint-ORIG-GUID: hXjVeIlDBR8nsDYsbBD9GThvKFxfXtFR
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae1e97b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Wg7rNa81uObU55Q5iCsA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: hXjVeIlDBR8nsDYsbBD9GThvKFxfXtFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280048



On 10/27/26 15:30, Heiko Carstens wrote:
> Acquire text_mutex inside __nospec_revert() around the patching loop.
> 
> Serialization is not required for __nospec_revert(), however this is
> part of larger series where at the end s390_kernel_write() requires
> that callers hold text_mutex.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/nospec-branch.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

