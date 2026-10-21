Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588576;
	b=J6S6F664XQ6cEQIfWP77dt4/ZClsnp8NQB0evInTFHxggY19ghFvcZCYtInf1S4HPPx+
	 K1/TTQykQWxuvLlmQtTQcQag+856YWNqdP+PrImVT/l5T97daIBGXBVKfP4BR9BSv+tOS
	 OEaVt/Q1hPvzx0GCjmKaL7jOQ9WBm1N48Xpe11GHHLEwi7gIW3KcI+akq7KMbU/d+tJw3
	 CApCebLVoZbWkAbpOQBG1J2CCGkLRDIq0zA7DY92mNS1PhPSWUo5iA6hiCQge9TfvHO0m
	 /2XKzZGZvaZBQ7wlOV4qBM2WY6dRMOZMr2qtcohPbR+O3PEZj2YKg8b7OO+m/1t7Iag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588576;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iU1xaOEaqgLqg0ZhKNyHaBi2E8KIoL3aTv+hG1zdXRk=;
	b=ghOIZTtRYmRke6ASQJfKYhmM9OF19SALqv870GTIAAeyq/paFz5VOTfKljmcXqG0HWi6
	 37So5vxUl98DkmF2U4m9MU4mH8BE3w+Nd2U0FiJLVIfq5scIwIEffvITo+Rn/tmKIMRJK
	 uyEhPKU4Rg+1YOxsMWo8rSlzgWi6ljnO2twNnyMoUcjt2sUWvTLm8PpRD7RN1JeB9lIPO
	 r1TM8msup55dwK3//r8qhsXZ5G7bG3XCHrPT/m0AaGxo+BozpP307YktfCDgqxpybpU1z
	 BlP2l38KbJuFJAzj5x+kkrId+QLjjF4mHienqub4NwAZLkpjReWOP75kvGMIHcT6Ipw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ViI+tHSu;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06357606A319
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 13:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06357606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ViI+tHSu
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBiujw1008715
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 13:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=iU1xaOEaqgLqg0ZhKNyHaBi2E8KIoL
	3aTv+hG1zdXRk=; b=ViI+tHSuLDjcYkIGVGjNIEOMBZbXLqevl7FZC1Nt4zGs3s
	QNn5B5vLujFaxz1cxTVyVgbS/WCgpS7wnt6qaE3BNSbmkTNzcQP2WjCSvy+lpDp6
	JTRO08ZdNVn4JHNuNkwUPrRMrbsTgh9rAtaSTwlULEv5oq1M7qSikzvKjSh4ZOP4
	wkvfiJ1kDk2VgAdng4sdotoM3vcEapwPtGosq4xr3gtG2MyKZO9kZaazWDCsiAPV
	QSQuhDDpnJNxFY936EagyF62FntLXawjWf8V76hRVNoN6/IoY/a51Dx1ovv28uRp
	75uO0hRJOHUvxhGBPLEjZIxELSkQ+lc4lB972JHA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5aryju-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 13:16:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBo0Kx3085670
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 13:16:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he8vhvyxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 13:16:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69LDGA6M17105302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 13:16:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27E0D2004F;
	Wed, 21 Oct 2026 13:16:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02F7E2004E;
	Wed, 21 Oct 2026 13:16:10 +0000 (GMT)
Received: from osiris (unknown [9.224.90.220])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 21 Oct 2026 13:16:09 +0000 (GMT)
Date: Wed, 21 Oct 2026 15:16:08 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH] s390/appldata: Fix error handling in
 appldata_generic_handler()
Message-ID: <20261021131608.10194A44-hca@linux.ibm.com>
References: <20261021120426.1148360-1-gerald.schaefer@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021120426.1148360-1-gerald.schaefer@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6ad8bb1e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2P35GisBvM6LwD4rxGgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 5m4QxbX3fpRfzrAg8M9rhoQoR31hb_um
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MiBTYWx0ZWRfXxu1m6YvqtXY0
 Y1TKEbauXtxQ53ZlYjDbQ2/fnUgB/tTrpy7pNL5rGTyUPctmALqNo2/nGhK6uZqiIqUTneuiFRj
 +nmfqpRG3G1D0sBECaFDJpBObA69EwTEU5e/k8/r2Zwccqu7/BtuTWefsW7LiT44GAeHanP8Iry
 wdtODPGUVaJaD6lNYcY1JWkbb8pGJANzvcSEfNASKfVvsAaX92W3qYKx85UdAMa67JanUPqUnSS
 TPeUtvior8si/97+UtYSRVbSq2puqprEORAnG2ufME9dZeeeSwITIUUhimmCCpF/W91VNTK3Xuq
 cddKG1DESfqsJy6VDKSoM6/vj092RZSF8s9NNVyqmvuFYosvP8dMNAnDAwxmPCAAJG6bBR9fXTZ
 vIoDCJ0od8/3h32ZC3f6GafuNmo2Axl8xlJpHJJjf9KGD1zhOYzSWPnLJ1D9Og6eVA0yhI4zXKx
 votaUzbWBf+QdDFiHTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MiBTYWx0ZWRfX5mZj3W3+tjOB
 4Ddt/yVIi86SoYWLGNlQI6M3tn5qkMF9wKNG77ITeTpzUGC9ammhZkdJ4efaSpZHJK0gX+rXRWA
 DycjjWRpmr0Ou0U1cQjvCwP34VtCFfg=
X-Proofpoint-GUID: 5m4QxbX3fpRfzrAg8M9rhoQoR31hb_um
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210052

On Wed, Oct 21, 2026 at 02:04:26PM +0200, Gerald Schaefer wrote:
> appldata_generic_handler() always returns 0 after starting or stopping
> monitor recording.
> 
> So "echo {0,1} > /proc/sys/appldata/{os,mem,net_sum}" returns success even
> when DIAG 0xDC failed. A failed start would keep ops->active as 0, so
> reading the sysctl later would correctly reflect this.
> 
> A failed stop would falsely set ops->active to 0 and decrement module
> refcount. This would allow the data gathering module to be removed, and
> the data buffer to be freed, while z/VM monitor service is still collecting
> data from that buffer.
> 
> Fix this by returning -EIO when appldata_diag() failed, and only set
> ops->active to 0 and decrement module refcount when it succeeded on stop
> path.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---
>  arch/s390/appldata/appldata_base.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Applied, thanks!
