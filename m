Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAF4A3874;
	Wed, 16 Sep 2026 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550908; cv=none; b=bV7WjgHeiuiFHACRSRXNDYxGvinJJX0JzrHp1ZCE2LNae6mk75ZYeq7ivMSRHOJMMML71+pgg7Ana5jMAUkjP9wdKaKBfJN5O4Fo/Lrez8YV+1alOQJW/YeYMqsIP3wO0dk31jTwvXawSo8NFPLSMHYUm8wyVeOr3K5QK9euAd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550908; c=relaxed/simple;
	bh=6igF8kRqY0EXYMqWqHtuN5YBJQURTgQrMkcRR4I8jAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/lmBoPQG2zR150iDEcQvx41coT6soI/vh+I/0yAgXIuktGqmK/prXVxV54k/pqVsX5lbbowgapO8ll1Xd1tQ0K9IXFZNyRhmm0oDq3ZMxNDhd8oVDlk0MJtLq4S7+1GyFCtUxClZh4GwoitwND5Atb5aSGbWnwDgqn67GPg8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MN7RndIj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MN7RndIj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLVl7e791542;
	Wed, 16 Sep 2026 09:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=eqKTsTEHQgdrEF0IaXA94EH5N6/r92
	TjKqtPeQ92GtI=; b=MN7RndIjGQMted+4PCMbo/bKWakskDW9seWVKDnLzZmWC9
	iyf1m+LAAKwrJdMuz3O0yswtYACUR1aDIUiNIDZd96CTAzn6I3zWc7JodifFPNJP
	JMaIbWIR1di57VjUhkJvAGAdXUfkMIB1rleJzLg316Qgt1GAMD3d3TvPaaUYJt/4
	MG+Eho4oO/wsSKho9gKSGA7GxtPFtCUYeOV9qpAiJqOYpYqSSJKy4Bdh6DMYvgAF
	iscg6jiMglQ2hfLfjh9lykGRcGn8Xx4uVUqlbTKPQlOVcM/ydJcbUXQLyt7aC0nn
	D9vrk/sSBhpKNDEr25nsHdMfQgkGYr11a9hCf3DQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e3hy4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 09:28:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68G7ZKuL388918;
	Wed, 16 Sep 2026 09:28:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxsdnka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 09:28:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68G9SD7d37618160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 09:28:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2714E20040;
	Wed, 16 Sep 2026 09:28:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6B7820043;
	Wed, 16 Sep 2026 09:28:12 +0000 (GMT)
Received: from osiris (unknown [9.111.77.138])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Sep 2026 09:28:12 +0000 (GMT)
Date: Wed, 16 Sep 2026 11:28:11 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 12/13] s390/qdio_setup: Use kzalloc() for the SSQD
 request
Message-ID: <20260916092811.15587Cf8-hca@linux.ibm.com>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-12-e931086fdde1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-s390-cio-ready-v2-12-e931086fdde1@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExNiBTYWx0ZWRfXw3DE19lOJhvi
 b+fQYDB6sE27QD9eWOhBZOaIQ66FvPha87CoU7PwV6Bv32MPA5x6mrnaYxZpeo+/UqW6j/87wQz
 /GCnq1YFVlKRlD22sdapQklNVzJw5qZWNoY5xXVgIK1eK2CD6m72qcqX6lrK9QJ755/ukhd+Z5f
 gH9FU99+nugo5ADNBCtJBSy+8RKPK4vGLUFRajQCqWK4tXIM7y6WMoWK3OOk4FYeqsXxUj3NCw/
 PHQTxItA8hOpLZ6w1y3fC4DXjOtsuSALYXZ/yM77ThXZQhFIBBmooJO0K8xCC6n3mMoeVrZqTLq
 jGRkvMojYCARIijFKYMS2sM0ccP/5j4xiXgWcnqV1aNqCpsqFks7ntkVO2T7nTK3kLDi4whhjFn
 bhAy+ejLy6uCLky1HTA7BnNkcBuPPgqEvde4DT30j8tte5uxiVwZ8jOO3drdMnxDL8AFuzNhC5Z
 cHlGbKsGcrJowH4ULnw==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aaa6131 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Ue7VF2Eu2BNBYPlTsnYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: aH6S4rG5YzAQ_nfapeuiPhb48dM7Z8oH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExNiBTYWx0ZWRfXxTIiGgGcB4PS
 iJ2h/j3gwdCEe/QEkilBFK4F3tBHg82wrx58FrhBEuqIwW5oiCJ4m0Bd3VeY/WIFCJyEfnKxkLo
 luLE8D1c2P+MdUsN5khKtRGZWrGBMn4=
X-Proofpoint-GUID: aH6S4rG5YzAQ_nfapeuiPhb48dM7Z8oH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160116

On Thu, Sep 10, 2026 at 02:00:14PM +0300, Mike Rapoport (Microsoft) wrote:
> qdio_setup_get_ssqd() allocates the request block for the Store
> Subchannel QDIO Data (SSQD) CHSC command.
...
> diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
> index 7ca8f61a2387b..c0215a7d29a81 100644
> --- a/drivers/s390/cio/qdio_setup.c
> +++ b/drivers/s390/cio/qdio_setup.c
> @@ -249,7 +249,7 @@ int qdio_setup_get_ssqd(struct qdio_irq *irq_ptr,
>  
>  	DBF_EVENT("getssqd:%4x", schid->sch_no);
>  	if (!irq_ptr) {
> -		ssqd = (struct chsc_ssqd_area *)__get_free_page(GFP_KERNEL);
> +		ssqd = kzalloc(PAGE_SIZE, GFP_KERNEL);

Same here. The conversion should change the allocation to kmalloc()
not kzalloc().
