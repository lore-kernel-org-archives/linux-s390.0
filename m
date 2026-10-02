Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1E646AA9C;
	Fri,  2 Oct 2026 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790931570; cv=none; b=Nv7/sKt15ewtIOCb7AFVyDxzPd5Lm4oH4PcLynaF2MkAFeV0Bb23Fud14QOErpBQKt2MKpeBHnaqnQ0Rh6q0AXMoH7a72RhptsK4OG+mr064+nT1j7X6A3Uax+4fd5I5aHOwsmbEKairUHubQ5+4wnZOH4pB4XOa9ZbMxTB8MhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790931570; c=relaxed/simple;
	bh=B6DsP44iZh4oNxUpdaNTp6T1fuyuIzh9/dNRTWLwYq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uB4wzoGL7f1t72lg9fWkKoOba0K6udY2yuy37IJxVal6bplo1sPPZvWtuBWNZcyr77tuUgITOFX7Rz36O7z+Z0P01X5VG7zt0BBkRoOX9awW3NkxXxWoS6QyyRDd0c+Ii+GIBiwCTFIXnALRIemunjH7R0PswJ395ZOsmlZlfWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k54+cnmI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k54+cnmI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69265Xg63921082;
	Fri, 2 Oct 2026 08:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FSKhwGaC+BbjsNgDPW+KzlgLe0akMx
	WViWB/4i2pn2I=; b=k54+cnmI0D6smfLg7wRBvfUIEC7XRmZvip26QIEpE/hG9g
	Tb1cssJTC6BxW8E1gEN6PohwESxV/a7VYhIxWcH1zYcBGSywNoplgllAdfMzkv0A
	Qr/EBixNpDcigguGQxhNvEfNSSkhZxbYMLOOgtabmFwmYWkezp7rGfRlZZ4m+nav
	jYMaZdDBPBTjC4J9DL8Y+FttFVo1GCMayt4hrt6WTnjOvHKvaCUC0fWkB7hew3Nb
	hTHPKl8Akxqa2VbSwnT2JATgQZgIgj9Mmc5xZpo4Lz3tNCGamltQb5rxLnoFu1xo
	xOWFNPKSahCHpwURbu6RxdHICFapvLpLCRawWjHw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptpw6y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 08:59:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6925liRx2054338;
	Fri, 2 Oct 2026 08:59:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1y2dj1y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 08:59:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6928xMS239059906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 08:59:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D22D62004B;
	Fri,  2 Oct 2026 08:59:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88A2720040;
	Fri,  2 Oct 2026 08:59:22 +0000 (GMT)
Received: from osiris (unknown [9.111.12.77])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Oct 2026 08:59:22 +0000 (GMT)
Date: Fri, 2 Oct 2026 10:59:21 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/kprobes: Prevent kprobes on instructions with
 exception table entry
Message-ID: <20261002085921.21787C22-hca@linux.ibm.com>
References: <20260924115725.1108581-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924115725.1108581-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H8mPvPQSyFA8_ipbqg1AFy0fjeusu82j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzNCBTYWx0ZWRfX5rZuChXS8d0w
 jApKVEaziRlJRz44uncd0WxW2iBdeh1uSz2CD18FCPlRekOxO/CRaz7Nm6WHSRwArK6FRwslqe7
 OJAzB2b2COSruxjywAR9h1Mq7LbkMS6/Q6C2pRNZFLuRwrzccY0TD/eY25UmcUWfSU27x49Q2+d
 zSEjWox7Chms+MZZXch712xEPnxS8+PQVr88QHKUVcoTYIq7WMPoL6NOnOZgUTqsoQU7sgMWcjy
 348KCCqB5T6rPzBuM94A6NE4bCH3bA38TGrCAcDsiiUh0nMeuxyVQ8BGTnAzo1Zal0QoVsWcSLc
 E/HO2gp1LRr4I+1p99hys5IDF0BTzB1gX2Cv19CHTir7zgjH/9SRbg8LMQdBSu4150BbNiVrQ6a
 Zl7Sh8rFKgt8Tk3N5gqzk2z//AvZLhJUVvJUAKisb2zU4zz0PGTtTw2aI77v6m9ohd5PFqIxc4c
 UhNhULEKMtc3cWQy7Zg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzNCBTYWx0ZWRfXzSo674Y1mLu9
 6ztOmnGwbJ8ceD4gSryqv/oEjUDTvTP1Crk9sUu3CxIEZt4GAPfx56t0uEUT6Y8LP2v2zuxI3iK
 5yDk2KSA8EtcZBetZVvprY5FFH6nemM=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abf726f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=a_u-TuGqFIQ8ZqSRPssA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: H8mPvPQSyFA8_ipbqg1AFy0fjeusu82j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020034

On Thu, Sep 24, 2026 at 01:57:24PM +0200, Heiko Carstens wrote:
> The mvcos exception handler ex_handler_ua_mvcos() decodes the faulting
> instruction, assuming it is an mvcos instruction. In case the instruction
> is kprobed the decoded instruction is a breakpoint instruction instead,
> which leads to incorrect instruction decoding and potential register
> corruption.
> 
> Fix this by simply preventing to set a kprobe on such instructions,
> similar like arm64 is doing it.
> 
> Fixes: c488f5187a24 ("s390/uaccess: Shorten raw_copy_from_user() / raw_copy_to_user() inline assemblies")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/kprobes.c | 3 +++
>  1 file changed, 3 insertions(+)

This patch has been integrated as first patch into
https://lore.kernel.org/all/20261001103247.1989111-1-hca@linux.ibm.com/
