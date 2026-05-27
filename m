Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326E40313F;
	Wed, 27 May 2026 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885622; cv=none; b=KIw5b756BW1vv5GqFVsAUWMOXGRxDkDaSSu4WTHIWpkayqyEQxuY0Y2HDomQXb7ycU3OMiwnFB8lHWX1OybMPtHLsjFU7rO20qa7LQ+Fwo7fRedn65v68OdUzGqO1CbCjSP6/AOZ00zqTg8TyjoI0i5oUWd+HvHy6nueq8E01fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885622; c=relaxed/simple;
	bh=FJjCOXbUqHeXWsVKALgYeJNvOurvLP75b2ghhpnixGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWfMMj0wOuBFcniAp2bZG0bHfSuZ3qsnG8sklNpu7YzP89DhtRGKoOGfXbVUPOFozwZigYs80CD19uDnVbzISbdo6yClvwS6Ni/HUSbov7bCGvF+fr/57PuxtBLTNl3oTRAzkyW5oqAu3H2BzfCGVcbDUZ61uf7t2Ws4ckS8uEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T4qP5cq7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T4qP5cq7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QL4afu346180;
	Wed, 27 May 2026 12:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=StyEW3oRmevMofaZQZXszF1FP3XWw9
	ZAcTOiOkvHCcI=; b=T4qP5cq7NhDHoLa9TWeVDyQDnukKXerm74QZiNOb466r4h
	h4kNjncl5G1CyPS2kvfhxWRFckoi+q99SH2Nr3dnJmthHB7elyNQpfU9bcrgd5pS
	al4+p/xDlfsSROzyPFtw1BWgev8X854preWFF7tqmzeqs2DB4+g+H/SDUvZ4Lmsu
	iEIwWtYmOEw3SrNtz+xCteJ7r+yDQnKBWuq2VR6Qm9U097AUWEbA31U8hiAg3fyz
	jbNvynZbVQJjfErIk2Vy9E2xkk5P9UcursIRIRz5oImO8rMBV8sV7/x/GsKLXwdx
	54OZGPln2Wa3+SCio04b1+DTr1U65RdmREX1Ls1A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nusc6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 12:39:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RCd6cb018999;
	Wed, 27 May 2026 12:39:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb2yau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 12:39:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RCdb3f19988742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 12:39:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF2C620043;
	Wed, 27 May 2026 12:39:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0E0520040;
	Wed, 27 May 2026 12:39:37 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 27 May 2026 12:39:37 +0000 (GMT)
Date: Wed, 27 May 2026 14:39:36 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Manuel Ebner <manuelebner@mailbox.org>, Kees Cook <kees@kernel.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/string: Remove strlcat() implementation
Message-ID: <d0bb1df4-3dc3-4641-aa04-eb6c7294fd5f-agordeev@linux.ibm.com>
References: <20260522143111.443100-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522143111.443100-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEyMyBTYWx0ZWRfXwSu4Xql1tzwp
 0DD5DIfYrXNI7Gg/aCrpB+ILSxN3d0dpYrmaX/k/O4+5wCZnpLX1RlNQL8F0qpybXMJz27wJDnj
 VbIipcUxZ5x7FNadDX7CHUAXJyDP4FfHiJEt7G3NUyoNUMjhBr+8NwHjzWAk0YGDxsW1wfPSOgr
 OKYKkt0A1webkL0qD9lccTTAgm5XXnNitN7tdUpp4vwVX90u5xqtgIoI5EavgdVkN3bhFWMWowU
 bTd8u380atr/Znoriu5RhXXRNN5HX2SAa8551D8VA9eYMaZURV4llpSsTSdpFZacjw+L+tRCWMv
 /sBrFTAlWJH2qd+4wMRQSQ63EmTpyXk6uVGS2v9j80O43/s9n1TJ6EulyCWBS1BnwrLVdAEWvJE
 mVOS3oxdJlbGHy/1cTIwCTWjZB9qVuTosnv1lpU1stRS8kdvkUNac1Nzrn/eXDCSZW1Zzdo2clF
 KlUSYiGdySzYBt4hv6g==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a16e60e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=b3CbU_ItAAAA:8 a=VnNF1IyMAAAA:8 a=RxOMAaN8a31L0COw89EA:9 a=CjuIK1q_8ugA:10
 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-ORIG-GUID: VEnR5gnEsE43VhNGRpW6quw-MgDWtTww
X-Proofpoint-GUID: VEnR5gnEsE43VhNGRpW6quw-MgDWtTww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270123

On Fri, May 22, 2026 at 04:31:11PM +0200, Heiko Carstens wrote:
> strlcat() shouldn't be used anymore (see fortify-string.h), and will be
> deprecated / removed sooner or later [1].
> 
> Therefore remove the s390 implementation of strlcat() in favor of the
> generic variant.
> 
> [1] https://lore.kernel.org/all/20260514160719.105084-3-manuelebner@mailbox.org/
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/string.h |  2 --
>  arch/s390/lib/string.c         | 26 --------------------------
>  2 files changed, 28 deletions(-)

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>

and pushed.

Thanks!
