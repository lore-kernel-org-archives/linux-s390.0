Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD4248EBC4
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331867; cv=none; b=fpGaXWIfHAPG1cR1YraaWN5HEDoHgawugKpc5AoyNLtmAt6+g7Uqv8aXdgV2HN+Kn4Ngxm0pkSenDsS3n3rHssfM1aWAdnvaXp3MBG5wbEs8lmCbTVyGIZp/omsQNTFD+BdzR/mp5CnKAFOYSuDen03q90bWIzuHfZ2wDz8SrP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331867; c=relaxed/simple;
	bh=wl9o5WZSQe75Cws4d59Y9J3P78eh55KmGMOPP2x3xZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaCJ2wmj1aYbuHJPSxUskdNgJvvrhmpJMLcJPJuuc4NVSQ5GgNa73OLxV4G5nWbzwcqOWA5iZqxf4nljjG0kE3lSdrdClg3XsRVEJCFs9TN+WFMflsuIoOYiG11f/ufgH/LEVItCWcwfcxGEQx67/P3UrqQA/TLM+plDrVMBXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KeUwU9ky; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KeUwU9ky"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TDHsU4127728
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 13:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=PhxQNLm+7uXcNAJpf1QCRZjLSG6yqd
	1EVxoC65CwjEw=; b=KeUwU9kyjTx2flJkjP6Q8LkLsU19nvtwYQo8xZsE0TDiLh
	y+NtRqwy+k7DdQwGdVBh2VjdY70dQTdwj3B9ie/xJMIP+Ui99gr1GP7KOqALQicv
	SIe5dL7Hn8e070bImr0pirOLbVmkfYMbAMyOFFbjSL3uwmlWw4bsiqHL1S9xw97P
	3dlfJlAaeyGw7Le5PE/JSWTWV2sumTNENmLLb344DfGtIeZ6VCxt9rBD3erQfPgp
	UEnNbg69uM0wZXzJj5OmCbKvlucnbMJpyiK0RnK0TBU9FwkWu+E1BaYEKOU5mzpi
	McWZzRnUBTAT1L+DtLmtbsoCsYvlpJBaTEtPjaaQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xtwwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 13:30:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TDQRV2019233
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 13:30:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y6kjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 13:30:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TDUpiN50135534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 13:30:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE8A820043;
	Wed, 29 Jul 2026 13:30:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BA4A20040;
	Wed, 29 Jul 2026 13:30:51 +0000 (GMT)
Received: from localhost (unknown [9.87.133.185])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 13:30:51 +0000 (GMT)
Date: Wed, 29 Jul 2026 15:30:50 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, ifranzki@linux.ibm.com
Subject: Re: [PATCH v1 0/2] s390/zcrypt: Validate length in CCA key requests
Message-ID: <ttixuve@ub.hpns>
References: <20260729093616.4184642-1-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729093616.4184642-1-dengler@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KCIr2dwRM2LMlD7fE0aWYr5KKQxghrvZ
X-Proofpoint-ORIG-GUID: KCIr2dwRM2LMlD7fE0aWYr5KKQxghrvZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExMCBTYWx0ZWRfX7D8jcAAN0UFj
 bkCbIYuTTN1ni/zz/Nqo0AyQM6fS1DMrWmvk/3zVCvKRmdOrl96SLCPJkjE6lrbUWYb9lUnl48u
 B8aFSMV8JcTOaViRxCOjEdi0ij/Rb8I=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6a0090 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=r0tFQrFAznK0qOXvjb4A:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExMCBTYWx0ZWRfX7ntY4sfVrdWP
 zv9ffbX8MHk8ye3ywfMkOrFrq/QSrt/qHXkEDtmbqdWeDnZc5axqn2z261ER2H40JVG2hh66EeS
 Je5usqETGVpPkmgpuuvzDmhyoNg82wouCRxlLdT4D9aWWzvTXQW4SRfBPVyr3fakUI4kjODUlZu
 ls9aBBxeqY8Y+I5ehvvVmncWlPYvhGJlUTIszrkc/9FuOZm9AIJxF1A2/mIgrzdM5LPuIPCO4uV
 6R0mVdS9O1QjjQmK5mVpla5LvdQtL5jv3MlFEAMjgHY6b2MZ0Cy0+zwI9GOykD22tgIHlh4p2eF
 enBAzf3WMMgQygiJ05fBuu76eqn5cUUguhT7Jd2VzJN4132XmSoY4gYWZfrFGPQ1UiF8EHbkjBw
 sdP/x+xmWwy0tRyD3aSG/ihmgbe6/fXIIWdtbLH6IfR3zn7ThV5fiUBKYS62kddzzhtmNjLuQBK
 lCQFK7iT3+/b7m5ld7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290110

On Wed, Jul 29, 2026 at 11:36:14AM +0200, Holger Dengler wrote:
> The series contains two missing length field validations for requests
> with CCA AES cipher keys and CCA ECC private keys. In both cases, the
> length information is used to copy the payload to the request block
> without checking the available space. Malformed requests can so cause
> out-of-band writes on the heap.
> 
> This series applies on top of Linus' master branch.
> 
> Holger Dengler (2):
>   s390/zcrypt: Validate length for CCA AES cipher key requests
>   s390/zcrypt: Validate length for CCA ECC private key requests
> 
>  drivers/s390/crypto/zcrypt_ccamisc.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thank you!
