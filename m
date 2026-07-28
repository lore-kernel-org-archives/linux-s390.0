Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E53C09E0;
	Tue, 28 Jul 2026 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222333; cv=none; b=O2oNWj4+MksyUUC7GRlrj1s9kgrbk/hWqW6iwPz8651OgHX2O1jQnYpHPRdxiwtNLJJur6/ryMSeGIKMonwQOH7Q5AgWMszc0e371WrZwBuzTG0LTOvTmSd8CvvURFq1k2wTFMYeZXjhR0xU4YuW2iImZ0ork7wSC6f4dyXgUX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222333; c=relaxed/simple;
	bh=dtn7qjC9RiPTBBKf/7O6RMXJTbcvwpu5QOMrio4YYi8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kmSmb3t1iEKfNo7wURMQZtvyreRvgmGotxhAqLmGlfnNMGLrnZw9MQl+l9b7A4Ff/kEKwFdIj4T+6Nh87vLd/IlFGtZ+1iiM5OGI/a26sUswQyZmK4bRsFb/lyb7hD9VB/n7qLFIOn4fEqOPN9Dk4tiaMQpaVDkG76K3JJoLzRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DKMEroxZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DKMEroxZ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3m9rW2245702;
	Tue, 28 Jul 2026 07:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=kaI2CdVOqz0BWwCW1/bhzpZ1zqAu2Pt0ohUjEjrDh84=; b=DKMEroxZXzvM
	DleQWgLrTrft87Z2KDxar7pWT/9gpIBVw6xmC5rv961ZgzGuPf7Sm4GVIx6W9xYX
	KZChvDJIghJPTGFEmDyVlBrrHm7gWmwABNbPJsdAR1WA6qBDFgP9pfnWTfDtz18M
	Fn9P5N4WbOFwShpCoYE+fXNFJlVkA7xeoleHAioR4+WrLT5XnjkXxdQRe+nR7jXD
	xvZ2qdOcrJy2WtPs2AIQEkZA/BJ9NKfI4KnFkxNBlv5TdAzaekcoNjB+hhVjCON6
	RD8WQR6l9/nmWieI26Cu7808zaxWtJoChOrYdbnhn6R3FG1XRALIYd/eRgj+89iE
	RFbwW7RVyw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycbw91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 07:05:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S6uDvD015684;
	Tue, 28 Jul 2026 07:05:19 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq8vbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 07:05:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S75IJc33161962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 07:05:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F31458058;
	Tue, 28 Jul 2026 07:05:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FFB358059;
	Tue, 28 Jul 2026 07:05:17 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 07:05:17 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 28 Jul 2026 09:05:16 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Holger Dengler
 <dengler@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter
 Oberparleiter <oberpar@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David
 Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] s390/crypto: Replace cond_resched() with schedule()
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260727162430.1599396-2-hca@linux.ibm.com>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
 <20260727162430.1599396-2-hca@linux.ibm.com>
Message-ID: <f88846b24b1250f89b503b6ddfda318c@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Add-fjscn7n5dn0mGoCIC8W2tqQKZa60
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX68PTFrVD+mPn
 gU+yq6+TjYa1ReC5L2yyKtowAvv3o7ZXmZ84dMDVZmFBGAVZPGzvqekC3gHuSk9L62oVmeenG2f
 lRYyKBdSSv7hKOMXWQbwTIcvcqsAw8hqH5025/zABf2NX23VfFrXtb6n0A92JTISWMIWHQrN2yL
 N4hgqyVuSdU0qiIlTMvNJVeK+9HTepvjmpcUrWFBKQBqskqblV0txTYr3Rg92EcH0LZ5y/jqeYB
 1ichoqibCeyPZsQBrLm/+Be/iIeAC1acmYjz7EwrVM0AzAWuCI2qmVv6+UfW5ThE9Txnm+VY7ZL
 bGZ9B8WUYJtkC6RsVAZH33V2Jq0GE+eLPSHHPe5j1B9Oju0fWCxdYZ3v1JIhKYD++MxTYB+qwPT
 wlvrO+lGFxcsut0+ovB9/pTi2yW8mWrmxt9IFRW5NCkV3wGBz5o2fpVsUqi8lMZmmfasbuRGqUY
 OMZeDb49nWjnqlgPBEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX2wgH3ljXcmXk
 XU5gbnWN1HyiDAleCR1ZWgzRvYw1TdXPM2/HQ0/+0+81OBiJ1Ci2qcnEJuPHi9T2wfanKynvAeN
 V05ujqx0+Zadh2RAsQV0OxKHI7ofuaQ=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6854b0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=ho2JyYDv265wicM2L38A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Add-fjscn7n5dn0mGoCIC8W2tqQKZa60
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280060

On 2026-07-27 18:24, Heiko Carstens wrote:
> The comment for all cond_resched() calls in crypto code says that the
> process should be scheduled away to avoid instant re-invocation of a
> callback. This is not what cond_resched() would do or did.
> 
> Replace cond_resched() with a call to schedule() which comes closer, 
> but
> it looks more like this code wants an msleep() call.
> 
> Note that with [1] cond_resched() is always compiled away and becomes a
> no-op.
> 
> [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption 
> modes")
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/crypto/paes_s390.c  | 8 ++++----
>  arch/s390/crypto/phmac_s390.c | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/crypto/paes_s390.c 
> b/arch/s390/crypto/paes_s390.c
> index 8cfe6166c193..d02de945f864 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
> @@ -555,7 +555,7 @@ static int ecb_paes_do_one_request(struct
> crypto_engine *engine, void *areq)
>  		 * To avoid immediately re-invocation of this callback,
>  		 * tell the scheduler to voluntarily give up the CPU here.
>  		 */
> -		cond_resched();
> +		schedule();
>  		pr_debug("rescheduling request\n");
>  		return -ENOSPC;
>  	} else if (rc) {
> @@ -821,7 +821,7 @@ static int cbc_paes_do_one_request(struct
> crypto_engine *engine, void *areq)
>  		 * To avoid immediately re-invocation of this callback,
>  		 * tell the scheduler to voluntarily give up the CPU here.
>  		 */
> -		cond_resched();
> +		schedule();
>  		pr_debug("rescheduling request\n");
>  		return -ENOSPC;
>  	} else if (rc) {
> @@ -1129,7 +1129,7 @@ static int ctr_paes_do_one_request(struct
> crypto_engine *engine, void *areq)
>  		 * To avoid immediately re-invocation of this callback,
>  		 * tell the scheduler to voluntarily give up the CPU here.
>  		 */
> -		cond_resched();
> +		schedule();
>  		pr_debug("rescheduling request\n");
>  		return -ENOSPC;
>  	} else if (rc) {
> @@ -1572,7 +1572,7 @@ static int xts_paes_do_one_request(struct
> crypto_engine *engine, void *areq)
>  		 * To avoid immediately re-invocation of this callback,
>  		 * tell the scheduler to voluntarily give up the CPU here.
>  		 */
> -		cond_resched();
> +		schedule();
>  		pr_debug("rescheduling request\n");
>  		return -ENOSPC;
>  	} else if (rc) {
> diff --git a/arch/s390/crypto/phmac_s390.c 
> b/arch/s390/crypto/phmac_s390.c
> index 03ca33ffe6cc..bddfdcee6cb3 100644
> --- a/arch/s390/crypto/phmac_s390.c
> +++ b/arch/s390/crypto/phmac_s390.c
> @@ -895,7 +895,7 @@ static int phmac_do_one_request(struct
> crypto_engine *engine, void *areq)
>  			 * tell scheduler to voluntarily give up the CPU here.
>  			 */
>  			pr_debug("rescheduling request\n");
> -			cond_resched();
> +			schedule();
>  			return -ENOSPC;
>  		} else if (rc) {
>  			hwh_advance(hwh, rc);
> @@ -916,7 +916,7 @@ static int phmac_do_one_request(struct
> crypto_engine *engine, void *areq)
>  			 * tell scheduler to voluntarily give up the CPU here.
>  			 */
>  			pr_debug("rescheduling request\n");
> -			cond_resched();
> +			schedule();
>  			return -ENOSPC;
>  		}
>  		break;

Ok for me but we agreed to have all this code going via Herbert Xu.
So please address this patch to Herbert and the crypto mailing list.
And then I'll add my Reviewed-by.
