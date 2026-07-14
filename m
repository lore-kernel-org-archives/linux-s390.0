Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443E3F86E9;
	Tue, 14 Jul 2026 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021957; cv=none; b=e6TGY3beUPIwD2UuBalSTvyPzzAjRt7u1afTe8f4h6QmaYy4qzYP3my6E2i6JkGduiCdAop+Gz6GJMeHGDX6bfL3m4gWSMt6dCKa3NyfAu5SuT1EJvEOlOfhcYBxGqTMIehdLLNbDatjyTatrlyjdcYjEV6hUNYkJNafa1MNnmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021957; c=relaxed/simple;
	bh=LjP6zVEszZxg3F5iAxw1XtBYT2amyYPTSjfcsyGDTAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXJdLCgXC1m2IiapWTf6qHcb5oo5docq9ITmugiiezO2zdt926+I/ZIwkTE7aJpzmUb/kA1lsPPWQTI+0lnZNXglUAjTyfNThyjswMQEFMi/NTW+bFyzzCs2C7osP2cXrJdUO34gEPiulUwGAREKkkXObmiEW48lE+TLnrBsEDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aVyTGD03; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aVyTGD03"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6g4xU2860218;
	Tue, 14 Jul 2026 09:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FExEkCMraXnLTjEr5iZDiBMKN8/3pd
	KRWUw443facME=; b=aVyTGD03M+2+tthrINgaE1WavFgtvYlhAXZJWX23fnifz2
	GrVnjVImhjLh+NmJQ2pBXTnSseLL41d8g4GGM13mMZixSPll78AqFMPu8QUWMQVh
	k+UBAQqHo8DH1vXe9gpLGPo9aahyzfcIBWzzGK0binsGjUyE+/nH3vtS+uGDXIjf
	/tuwGBt2PQ0P51Np/tOyPBEfdSKCll+dfWI7GG8RFZTHqBNoLRrFWcaPMkzSgZkx
	Pl4FyRcFcrSrpC8NDmO+XgCVwXMXXtg/SIZb1b0d+K99J0+5JMs7FfoWhmXsFV3v
	CSHI0/JoO/l8imoZdcEb9a00qugN00rW6DuEBTkA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv335x8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 09:39:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66E9YZhh004217;
	Tue, 14 Jul 2026 09:39:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05q29mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 09:39:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66E9d6Nm16449844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 09:39:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FFE92004B;
	Tue, 14 Jul 2026 09:39:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C93220040;
	Tue, 14 Jul 2026 09:39:06 +0000 (GMT)
Received: from osiris (unknown [9.87.141.23])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 14 Jul 2026 09:39:06 +0000 (GMT)
Date: Tue, 14 Jul 2026 11:39:04 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 2/2] ptp: ptp_s390: Add missing facility check
Message-ID: <20260714093904.31731Ab0-hca@linux.ibm.com>
References: <20260714084921.3926697-1-svens@linux.ibm.com>
 <20260714084921.3926697-3-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714084921.3926697-3-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5NiBTYWx0ZWRfX6J6moGWoKChS
 azuniZ8ZH2dT7qbRVxkeutPB3AbzLZixex17asahQv+rClFu1nxBoqlre5CFnm3+/uZqLgEoui1
 bK+Jq8ZYCcJzosAsF8Bw892Q/CYeVss=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5603bf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Jsjisl7J9IPTTVUQmIEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: gQgwUVYN1pwEUtoCw9rAjhEZ_RmEY_CB
X-Proofpoint-ORIG-GUID: twaboGV-5FAmjcEbszytQ79azwBVwONK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5NiBTYWx0ZWRfX8JtMOtuFMAqE
 T8Gpgh4uJmvjSvsflwQsH4a1CyLShZWpLfhvqZIKG+GWuYdzDXCbuh8E/2yr9UAeuG4WZtuyCLS
 9LUgkSLbvSyDpKsE/LVL7ZRX85ywgUtBUta4QXKsL3j8Yucw+03DmpQwW5L3K/pprCMgsbCLr/V
 RE86Kaa942gMeDt2cRav358NHLGEqoMTwGm5rmYw+i1KG0s+0Vcmm0s+2KWr08PPEmXzQDiMJuV
 2HjYhUW1TIumLd/CRB5TksJDfaXcJNz3Pk/2saJ7j1nCLnDNWyWF/Lot+kQsULJBS5QLs+KCTkP
 Ct09SRxdfJwD/hYNZ7QpzE+Qg6Lr26CNtve4XhCoY/nQ5+4xI/r4JSZ2vKjwM2AQ+YFrOTFomLF
 l6g31kqTOvCgkUf/BM8uNeaS3izaj+rRkQ76wMSMrzqrWnPZX4jMC20EE1XFpsUQXfLlHeRLERg
 JBhei1lx4tqG+WmPhYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140096

On Tue, Jul 14, 2026 at 10:49:21AM +0200, Sven Schnelle wrote:
> Only register the physical clock when facility 28 is installed.
> 
> Fixes: 2d7de7a3010d ("s390/time: Add PtP driver")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Cc: stable@kernel.org
> ---
>  drivers/ptp/ptp_s390.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_s390.c b/drivers/ptp/ptp_s390.c
> index 7299c3aae65f..3ea94648cdde 100644
> --- a/drivers/ptp/ptp_s390.c
> +++ b/drivers/ptp/ptp_s390.c
> @@ -108,6 +108,9 @@ static __init int ptp_s390_init(void)
>  	if (IS_ERR(ptp_stcke_clock))
>  		return PTR_ERR(ptp_stcke_clock);
>  
> +	if (!test_facility(28))
> +		return 0;
> +
>  	ptp_qpt_clock = ptp_clock_register(&ptp_s390_qpt_info, NULL);
>  	if (IS_ERR(ptp_qpt_clock)) {
>  		ptp_clock_unregister(ptp_stcke_clock);

Wouldn't it make more sense to check if PTFF-QPT is available via PTFF-QAF
before registering the clock? This would also avoid the need of the first
patch - since then it is guaranteed that PTFF-QPT will always return with
condition code zero.

And... we wouldn't have the potential oddity to have a clock registered which
doesn't work.
