Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929660;
	b=1Ln5eW3Uv9qtuKj9BLghPTcODb0L5kAS7L9nIsRvetY1qbElLgBDRV2J6mt1mw6wenuD
	 aW8+dnY0SU70opv2l99fh5CtaLoDToexaJ68PATgRkydIfYDR2xTFibImZFfXWt6Z52yL
	 ONq+uZ4v5ESWH/42lWK+YXnb2zsk6ctUDY3K++Oztz8hru8RGnmApCD8O/UF88r6LbApr
	 CTQz95XLrlsI5mPocN0BxMlhAxVerA1U53pYwymfAi5CuhFJOBpJ1VICgbaJZ7GJWKraX
	 d107i4lTgwbdMlZoR4G7fxeI4pf0Wtq0jMMN9W9Q4ZZzX7dPWpjgPXmSmiiPzsnUz1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929660;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cRImLx5dLXwC4aZvAd+LIfkYnFZY54GHr5TiPnpbInE=;
	b=TH+yMZfZEx0n6zUrfVzuQj3EMRC2eTcu0GHHp16kd/9i0C7l7dxuqu6E5mx2u01NeS36
	 RoHIKHYmK/+J1Yma2v0KQg20bjZGw8pvsUn+ZT5XRrOGhFoYx71AqBvRdkPVBaPOu8DtF
	 4QkvGMtHJX6lqucHGyvFLlaz3AlhQa+XqRw4dNC0tdU+8g/4r8JpSpJ9F5kyk92PxH4CA
	 R6qG3o+9kqIROct1QjLnWqlZsn9BOwZ1ByGb6FToGBrbX4P7Z8eeBUMVRpoNxUPqllsqu
	 VIY3h0JurX1C4CRDSAlrZIhPaWuwZKld/3DU8ow0S33qALeFp9rtuh+DlarIXqZLWAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZRqApd5k;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5E606A32F;
	Tue, 17 Nov 2026 15:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08C5E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZRqApd5k
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQqbf2730846;
	Tue, 17 Nov 2026 15:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cRImLx5dLXwC4aZvAd+LIfkYnFZY54
	GHr5TiPnpbInE=; b=ZRqApd5kAP50zP/d/0pQZ4bIXODCvV5LVzpOdJ6QpJB4S5
	Vmeb56Q36ao9fJgHKr76U8ylPQfiboVQnlcqnR3QOLgjz4Qr30MZKS/zJJJYv3ph
	jeCtILk66Fqx9hoVyY7xDSpwOcEnIyztHaZulUc1Y9pD89bZkNLsUzSm7vUfs1Nf
	9uipyKKzqMv4os4LLdrRuSynCqkWmpz71bJ+wCsr+RZXMaAwjJ3Phj4vKiVp9AiJ
	dAVOqDOBJ/HGUoq6PrvxENUTIsvV7sXWndVGfiRV47/wfxcPcvCsqOWL5kgiEUSo
	2x7QAK9SoWhVLiQ/eLqZPu4i5XCKfBxPk5rh1h7Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfc542j5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:34:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC4tvn1514811;
	Tue, 17 Nov 2026 15:34:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02juckk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:34:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHFY8j944958040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 15:34:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98FBE20049;
	Tue, 17 Nov 2026 15:34:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C5422004B;
	Tue, 17 Nov 2026 15:34:08 +0000 (GMT)
Received: from osiris (unknown [9.111.0.235])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Nov 2026 15:34:08 +0000 (GMT)
Date: Tue, 17 Nov 2026 16:34:06 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 12/14] s390/sclp_ftp: Replace get_zeroed_page() with
 kzalloc()
Message-ID: <20261117153406.32016C4e-hca@linux.ibm.com>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-12-e518c99622c6@kernel.org>
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
In-Reply-To: <20261117-s390-sclp-ready-v2-12-e518c99622c6@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX7tW/KpOHGqgx
 KB9hf3BwQQ3M1Zp0KI8nfaCNgoxja25UPwtxXh2j2rpIoS2iFBCvKDn+aZQ/i2nXkW0KURXVyNh
 ulb3uR0WKdQQL5D0clhH9ae+Wv6dzks=
X-Authority-Analysis: v=2.4 cv=Fu6QbGrq c=1 sm=1 tr=0 ts=6afc73f6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=oQSlCnxA2W13FdGThSAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX9YJHoEBdfUJs
 sd8Ekmj6MI/tTMruvyz5cVFMpXD83yVF/emttZCUhu4pExcf1GrY+wAeVb+fWhC8eh8c11WtVCR
 ydPGqSbaisTULgwQZQfC8OfpqehaGlSnBX3uu2rU1OKAAl28UGAfzeimkvbpKRkdJHEyU4vJxAI
 jMhC1uefpb4HRcuneTswbpPX3aMl/jGPYJp2ejcmjkQzzbHgO++iRVMVC6vTUo2YBnVGGUf+oJR
 +ggceJjksi+XHLBgmDyW4dPLtx2wyCZ8Ls/yRQZTmYq8iusXTiCwWxwxvIEeV1YIXjuDVfTtvm9
 lTCpqKJxsHhscA88pFmudYAMDve6jcgdfjPBwjNb5m14Skl/hmwKETts+tvSqxLy7WAwhhdnxI0
 oXeRHJbTNSC1gddR5XWaiNVo4uZCRTetM/QtxRSht06zFFOUGpViZNvoieYXXkdBN1OjdjRjd5u
 e836q+9acyGLcVfJAvA==
X-Proofpoint-GUID: r6MQuHWPwaGD3PGuoazSz22i6fl7WIJG
X-Proofpoint-ORIG-GUID: r6MQuHWPwaGD3PGuoazSz22i6fl7WIJG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170061

On Tue, Nov 17, 2026 at 03:07:04PM +0200, Mike Rapoport (Microsoft) wrote:
> sclp_ftp_et7() allocates the SCCB used for an HMC file transfer request
> and sclp_ftp_startup() allocates the buffer for the SYSIB 2.2.2 stored
> by stsi() in the debug code.
> 
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> While on it, make the SYSIB 2.2.2 buffer a struct sysinfo_2_2_2 pointer
> to get rid of the casts.
> 
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/char/sclp_ftp.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

Thanks for the series. Will be picked up and routed via s390.
