Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFAF43DEDD;
	Fri,  2 Oct 2026 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927683; cv=none; b=nokEuJR9VRee65XakYtih0bQNp4aVaej/6+qT2qbhQDoqQRYssdDN1sryCinJtWyNpH92uS32A0VFnI1Ygqf/3nS+ZrtD6bsvzgRAIAkZqkY5tf0p0QyXCBtVPPrxjubdCWPydd+rpIjnhyMEk8+h6TBsKiH4VDLHD/uKj6wVas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927683; c=relaxed/simple;
	bh=xBa8fZK9FMebxfu7SgGkLUi9Q7lNYbI/ayPo3kUuVf4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qpJ6zDO6hM2UCvyfq7In5UGGSK/9cqwbE5hBFNCs6hLaSxI9JWENAO/lwazr65DkacNvwBGfnKtKZSnZVWGtk6DgcwFH5YuEfkjdKuj6srwEjtl0QrMFi/X0fE2fTJZQSE3VJXq2ixs2sllMxh177Nq6E/KhuQOtvoIKfac9ZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q7z8n0Wt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q7z8n0Wt"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69265Lb93916687;
	Fri, 2 Oct 2026 07:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=H+pXxWvA4x18JZVCRq3fN6fWma9hLXIl3ow01/e0eEA=; b=Q7z8n0Wt6fvq
	RthDTsO1EdSBtaXNC7JUEi3leWbj6uuSTRp6M579R39vc7xopK/rumklpwyEF+/U
	Mr1drEvBOVecofSDn1CYSIIQ9YY4Lhid+r/DLaHKU6IF8nAVAwwI4pl0ocUBG45w
	aLaPGyXmHqoHHwJ/W68XDUP7t7Tozk2orH0cCxDg2wrA/+BI9s+VyA3ZmWG52efs
	5g4XUzyadlCL/9mV8YXwoq2kkwdcKcK8dQHHpltCw6up8GPuiOO2WM/QnI62LHnF
	NvSdZu3AyCtQha9qJZKJArteiFb6kC18gcrpXNpofbR04m3DGNl/4p8sBQsMIZmM
	/I0T98OXcQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5r29p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 07:54:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6925lTQn2090140;
	Fri, 2 Oct 2026 07:54:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h1xk120sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 07:54:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6927scvY25625240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 07:54:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40B0E580C5;
	Fri,  2 Oct 2026 07:54:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FC7A580C6;
	Fri,  2 Oct 2026 07:54:37 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 07:54:37 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 09:54:37 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan
 <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Holger
 Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan
 Hoeppner <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda
 <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 20/32] s390/ap: Convert inline assembly to EX_TABLE_INSN
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20261001103247.1989111-21-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-21-hca@linux.ibm.com>
Message-ID: <2cbabc8254cac6351cb4c5859b55c256@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzMCBTYWx0ZWRfX3top1dWb/PQF
 DlXxV7G/sForIpcijRSOj7pIcK0GZULKu+kiFOXyv4DJ4nYq0sE+9Geuz+0zOFmqS8gmv91sTJj
 GXJJITTRtb5/M0cAFry59VKQGK0c7Hs=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abf6340 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=qRH4R9lDhd6ZFPtW4MgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: l0cPYB1JgiF2MuFQgyiWWqcz_xCDzMBX
X-Proofpoint-ORIG-GUID: l0cPYB1JgiF2MuFQgyiWWqcz_xCDzMBX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzMCBTYWx0ZWRfX63xYtpr8Qmvb
 VmSuDmgLXZ1hNThqO8CjJKqnITfuA0Mxh8fTNZyLYbva0AaS/e7EkXpmoyyETCJaqdyLaWhS4d+
 yXgsukDINQ+5s2MAZPDqWj+5UPynAI6e15QvIWX3491QWf109IT4O1o/okqpoel5FlvLyAvWN4P
 ji/IiHEU0LTpQPi0VlpHOU8QZbsjopmNSSF7Zc+Rc3CVpyC7M6toCFo2zsJYvpTRzZ5Z2+fe3Y4
 rUr5VWLPRsQwTS6Yi5Q9EFPeYWd5WWa9ZzCr8uGqCi8EyZx5c11cSEsteyBEPoDU3nDVbAZKubB
 f4nYCYH6DNtSqwD0WttDyQA9NDPmGW0jOJjl1Bfc0Oopl6dWhg2+liDUCbxsWAPp0s+IyQDh1+M
 Xf5TOKItfNXoOxflfYValtjOXJlTLQoxAQn163dphCTpDyjmF6nzyC+2L3yWpk7L1HKqZbn6/sH
 /ymUSyigHJva+04gdYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020030

On 2026-10-01 12:32, Heiko Carstens wrote:
> Convert all ap exception table entries to use EX_TABLE_INSN.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/ap.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
> index c91b6ace199d..b0f8e3946a43 100644
> --- a/arch/s390/include/asm/ap.h
> +++ b/arch/s390/include/asm/ap.h
> @@ -91,10 +91,10 @@ static inline bool ap_instructions_available(void)
>  		"	lgr	0,%[reg0]\n"		/* qid into gr0 */
>  		"	lghi	1,0\n"			/* 0 into gr1 */
>  		"	lghi	2,0\n"			/* 0 into gr2 */
> -		"	.insn	rre,0xb2af0000,0,0\n"	/* PQAP(TAPQ) */
> -		"0:	la	%[reg1],1\n"		/* 1 into reg1 */
> +		"0:	.insn	rre,0xb2af0000,0,0\n"	/* PQAP(TAPQ) */
> +		"	la	%[reg1],1\n"		/* 1 into reg1 */
>  		"1:\n"
> -		EX_TABLE(0b, 1b)
> +		EX_TABLE_INSN(0b, 1b)
>  		: [reg1] "+&d" (reg1)
>  		: [reg0] "d" (reg0)
>  		: "cc", "0", "1", "2");
> @@ -272,10 +272,10 @@ static inline int ap_qci(struct ap_config_info 
> *config)
>  	asm volatile(
>  		"	lgr	0,%[reg0]\n"		/* QCI fc into gr0 */
>  		"	lgr	2,%[reg2]\n"		/* ptr to config into gr2 */
> -		"	.insn	rre,0xb2af0000,0,0\n"	/* PQAP(QCI) */
> -		"0:	la	%[reg1],0\n"		/* good case, QCI fc available */
> +		"0:	.insn	rre,0xb2af0000,0,0\n"	/* PQAP(QCI) */
> +		"	la	%[reg1],0\n"		/* good case, QCI fc available */
>  		"1:\n"
> -		EX_TABLE(0b, 1b)
> +		EX_TABLE_INSN(0b, 1b)
>  		: [reg1] "+&d" (reg1)
>  		: [reg0] "d" (reg0), [reg2] "d" (reg2)
>  		: "cc", "memory", "0", "2");

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
