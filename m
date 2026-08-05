Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765A4418A58
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923885; cv=none; b=fhTz8Bpr2EcixGoAFbGQXX0fkXYlhvWq8MR/Ag+HJOaw3DqVqc7Sknyj2pN+TxyQbhZ/MFW98QwZYQSaqHSffGufFyoYE+j8x68n46c59mZ0DCy16TUR+kJ8nJbcs653irANkwjeQrRhd4xewJ/w8dcGJ7u2RPntvr/q4TIuSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923885; c=relaxed/simple;
	bh=U/QdDmi+52A+XsXdBHRhYbGL/G9mdyrgsUFB8KLF6xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBmexscCcQu4sSc6S4RxR3l1bQ596YI7w/XVHuIYBveiEQM0ukdYHjneZxMQj4b8FmwdNrjwa8MjpoZqWwAA8ytfJnAJmOpD74KUKMqj/aOucbfvBfnwHa55Cmr8+d4L0N89cZPbdxx5oee7wZYCIgo2/6l/gWgZeX8TCDU29qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UCzG/sQS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UCzG/sQS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lmVU1503298
	for <linux-s390@vger.kernel.org>; Wed, 5 Aug 2026 09:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=D7pTmk68eR94Nk9oLYZ/snwoeEe0pl
	UdM4o9lYwu9VQ=; b=UCzG/sQSdAtUFbzgTUCIQse6nNW2DmgYhRaU6kt0W6wXFv
	ufTUMYREdcSWrSh+vgAuOG8NROpm0Mj6AIfoZUCDkVcnHPIK+3xvVF2DALKm7OEe
	fk+xiecsKHOccjZKaYDeODSRA+urmEWaymcQbVZGGTjfwH1Tgov2dVSxAXUbMRJ6
	k4YOB8Zq47FU1MByNkQhs8Dc3h5pcU4ZFHLcwJfW7Cv1QGE9gUbialq2eLEP70Zc
	28XKAXmIn1ErbyFrG63DFoEh5siqbPZj9329RJGm1LCDUYP2E/6Euhp7KsLRF8RT
	d1DR5dgIgd2Zhtmb/aaIZ2vcP24RBNdqMT2zNuEw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqtc93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 05 Aug 2026 09:58:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6759uLvr016359
	for <linux-s390@vger.kernel.org>; Wed, 5 Aug 2026 09:58:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgdtm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 05 Aug 2026 09:58:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6759vwOF29622628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 09:57:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D771B20063;
	Wed,  5 Aug 2026 09:57:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 838A52004F;
	Wed,  5 Aug 2026 09:57:58 +0000 (GMT)
Received: from osiris (unknown [9.111.89.228])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  5 Aug 2026 09:57:58 +0000 (GMT)
Date: Wed, 5 Aug 2026 11:57:57 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        freude@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390/ap: Fix MAPML computation
Message-ID: <20260805095757.76476A1b-hca@linux.ibm.com>
References: <20260805092928.26932-1-fcallies@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805092928.26932-1-fcallies@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qHmbEbrPm3_nQ-pZjnDcpIIltgnXoyKf
X-Proofpoint-ORIG-GUID: qHmbEbrPm3_nQ-pZjnDcpIIltgnXoyKf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX5zANeuZzckfF
 74SsgjHBiJ1mKTEuDIdwAy4MfGhBRUqBZawWvfgQEWrbDF+QaMfW7G1bq/QGxPKh8doDwzA30gu
 TKm/LxpEFfdB3Jdse8gip2WfJs8/nqI=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a73092b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=BLOa9BIZQKHUA9siqFMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX5p4UU0YYKJIz
 jDhRZl8f1J2baGd9VoBp5WnxWjQsv2ht5shhxWOw2uBjlJw5JcgLAd+AXBRk7uWdqfj8YrB+23h
 gd2b2sy3DFWsdAkevHdeP0i7AwJSNQlE3Pu/6Jh0sqjZ/21sSMSVoh+I8tdMRA07nKLCsqnSOx8
 2vHRQYZEEpuJI1ti+itG268Ufwc4nxrnP7PMUyT5Gsjzp9BNgKxKLUVw3ozd6PQoeBbWLPDvFK0
 mWFEki8IMiGM6nO22zycw3NGDLgBmGPEugJDlLQSOIxHidNNEPdjsY1eEOfBSFJIVbATkqa47ia
 tIXFnlexbGdIx4Qx+1YKxlIQvFqEC2YqLY8PO42Ozs25VBRByw7r+AxDdQVTxK9i138GA1MWIlF
 jjwjJYnJilpGP7bvoxRxT/Wl4lDTck02muZy76vfFzuU9u1YxYzmWzsXyGgHYkGUTVYzWsWTYXW
 SHFsZqrvBhD5LeT+qzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050077

On Wed, Aug 05, 2026 at 11:29:28AM +0200, Finn Callies wrote:
> When the TAPQ subfunction of PQAP returns a value between 0 and 3 in the
> ml field, the Principles of Operation states that the Maximum AP Message
> Length (MAPML) must be 12 KB.
> 
> The previous code incorrectly calculated smaller sizes for ml values 1-2:
> - ml=1: 4 KB instead of 12 KB
> - ml=2: 8 KB instead of 12 KB
> 
> While no current hardware reports ml=1 or ml=2, this fix ensures correct
> behavior for specification compliance and future-proofing.
> 
> The fix ensures all ml values 0-3 correctly use the 12 KB default, with
> only values 4+ using the formula ml * 4096.
> 
> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> Signed-off-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>  drivers/s390/crypto/ap_card.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
