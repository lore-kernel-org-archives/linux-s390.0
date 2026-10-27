Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100769;
	b=0oF7XYjIzJUPzgKoG7d40umBPnj/dxkv/fI97PIuuSORHLdp9/5XFH28zPIyYxHnFsK6
	 j1FrSO4ipouVdYlT5WPJFNOREoVf5KC8Yc5f7M/SUsfVQ9Lb4bVbwrEUIaMiHVYyP7o58
	 kqU0xu5FOz4bGHcF7dtrMkGiwVQbVnUHIsYzVna1UyfSBBeZ1DKyOErMwVnUkG6LUSDNC
	 dHEr78dy9pMH35cl7XsTLtL+3PPoZgAHCIfONWs6q5DQEM7VSXzYaNZ2eyd1O/QOi1TgY
	 IRcV3VXIw3l3OEoLOA/NZLAJHGO7NoW5RGmSZL31YB7rgRjPgRAj8+lNcfzs331M3GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100769;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+IUtqXHF1BIuNElEMOvuQx5szZj7Fk7Jx4Na22QQYn4=;
	b=Ehlg2pEmfNBQaWgOYfmqtHawBTQiDSVdyAYx0bDHFNU476KtUu8MUUOtpSvCN0/eRem0
	 AdNcK1KOHup3BWexPOdADalXIQCM/Fu91k26Rupglg3dFi/PQtqfx1Cy3U/ErLaiqzdXV
	 WU+kLEj5ehGxUCKfH5tslYzvwWlGaOMu+an5R36q4pxXs7iGk6uHdBDfL8LIov75PkNaE
	 d+OlqL3+cs6Fw4rpK0+KF/8/VRr9CqXxe4USFjQbGbMYiEGKcSPt6cDt+lkOGJqBeAfwS
	 Zwg+Ksv+bzOapVJM2Yg9u7S2LXdd6NgdrBwouf2OhPpyKiRaIdzo7AiNEhB2i8uusNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OE4qCPWg;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30765606A337
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30765606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OE4qCPWg
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5ioL01624813
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+IUtqXHF1BIuNElEMOvuQx5szZj7Fk
	7Jx4Na22QQYn4=; b=OE4qCPWg+LQF/MgueXYWNSLRATig5lBgau/CMORKSnscrI
	IfqsENalwe7EWCdx9P7sjLVyNM6SeAqhRFFtcmIqSOkJRgrxpPDk39vDXPKUuYDa
	6qt76yhDi6eEz2G8BSw5slHdLLf+VproC97AL+fbMObcfc+Im3SvnLxoE1pmwe1H
	2UXDIdoIxntR0NU6RlklG8oESLjmTuy7oTJS3KNU4Y3KFAGN7nBQngvpwTCH/yGs
	gDbAOYLM7F4nSjvRJxDImToyGdYb3a2AkZp1roOECHxmHCM3OxP1nH/aJK83vXIM
	oMHmgOdp4Byxsyphsr0bAycvFIjZe0L4D2uQUsFA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm63y4qb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:32:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RA14Js3992237
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:32:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7r9t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:32:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69RBWhtU16056740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 11:32:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5D7120040;
	Tue, 27 Oct 2026 11:32:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8245E20043;
	Tue, 27 Oct 2026 11:32:43 +0000 (GMT)
Received: from osiris (unknown [9.111.40.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 27 Oct 2026 11:32:43 +0000 (GMT)
Date: Tue, 27 Oct 2026 12:32:42 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4] s390/diag204: Introduce diag204 rework
Message-ID: <20261027113242.11789A2c-hca@linux.ibm.com>
References: <20261027-diag204ioctl-v4-1-d5e90b56112b@linux.ibm.com>
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
In-Reply-To: <20261027-diag204ioctl-v4-1-d5e90b56112b@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NCBTYWx0ZWRfX/S0L3eAHsk8B
 DdSkUaSNkkXiP53A6Mh9U48Kq/GhZAI4CP1DSn4JYinQluQHZP7jdH6Hg/WVxNCjW/0CriP6t7+
 tcrW+NMv7Iea6991nCxXmLCvQTG466U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NCBTYWx0ZWRfX9bDJPrZbj9ub
 yAiJn90rub5ZHtNjXR6/SxgmI1t2ZLeXLwbczb8foruI2uxNI8jQcZqn8JZSE20QXHyy7A2EjGl
 gcj1sxsJaUqM2b7tB8fnSb72/M+VDAkSDlm8CoH+A9E0IpCBIXtixlU5AR0lrv+PvhAoBiEMj+1
 1NdMFZxMUGv6HLycaqtKstW+7W0j2l1eohwFTCWaS3X/gDvUTUm8Sc1TGdLUTpeCx1cFHy8vOl6
 Drxh1NbKTvvaspA3XOYKhlEiQYZNTQnw5LG2xhZujao5v/b0tTx0tM1Ttd/mBKf77w6x0yqDPCs
 d1LIdJy+7YMNblAkzv6ZjZnOiIcYqQ8uY2htx3yudR7WQRXSOjGcLAa6BQuBIBt9a40kkSWumoD
 7r1g5pvGKBqA25gOMLIHzKbMBDruvT03lEymJFA8OG8NXmkqnytUVKU5oGW6LYdts6EAmGqOT67
 /zgmKJqWRPgmGTAw++w==
X-Proofpoint-ORIG-GUID: 6wAAe7OBHPQ8AqNA7BvZW4r7F1aL5y9g
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae08be0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=k24BNLjQvS1XU3IMQNMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 6wAAe7OBHPQ8AqNA7BvZW4r7F1aL5y9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270044

On Tue, Oct 27, 2026 at 11:40:25AM +0100, Mete Durlu wrote:
> +static struct diag204_cache g_cache;

Before you send yet another version: what is "g_cache"? That seems to
be a horrible name for a global variable. What does that even stand
for? Please change the name to something more descriptive.

> +/*
> + * diag204_store() provides users data retrieved from the diag204 facility.
> + * Since diag204 is an expensive call to make, it is limited to a call per
> + * second for now.
> + * diag204_store() first checks if diag204 cache is present and valid. If the
> + * cache is valid, it copies the contents to the users buffer.
> + * If the cache is expired, it first updates the cache and then proceeds with
> + * the same copy operation.
> + *
> + * @buf: Users have to manage their own buffers by using
> + * diag204_allocate_buffer() and diag204_free_buffer().
> + *
> + * @allow_busy: If diag204 supports busy indication facility(bif), users can
> + * specify diag204 to  return BUSY instead of blocking until data becomes ready.
> + *
> + * @allow_busy_wait: If users allow diag204 to use bif, they would also get
> + * the option to specify an interruptible wait behavior by allowing busy wait.
> + * This enables users to interrupt diag204 waiting period via signals.
> + */

Is that AI generated text? That doesn't read like normal kernel documentation.
And since this looks close to kernel-doc format you could also make that
kernel-doc. But make it shorter and don't describe the implementation details.

> + * diag204_init() has to find out, which type of diagnose 204 implementation
> + * we have on the machine. Currently there are three possible scanarios:
> + *   - subcode 4   + simple data format (only one page)
> + *   - subcode 4-6 + extended data format
> + *   - subcode 4-7 + extended data format
> + *
> + * Subcode 5 is used to retrieve the size of the data, provided by subcodes
> + * 6 and 7. Subcode 7 basically has the same function as subcode 6. In addition
> + * to subcode 6 it provides also information about secondary cpus.
> + * In order to get as much information as possible, we first try
> + * subcode 7, then 6 and if both fail, we use subcode 4.
> + */

This looks like it was copied from the old code: please fix the documentation
convert to use imperative mood when you move it.
