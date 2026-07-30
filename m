Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3609436F8E7;
	Thu, 30 Jul 2026 05:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785389172; cv=none; b=pMSsq6T6oku8id8BrpEeSJWToO1HJ93vEkZFdOx9nu+n/V3bHLEI6DzRsFdcXHqxsCqZLfW8suulUR02J5MysvuAsFHy8N7aia/bdMuIzcZzqFBYYqV/GealV8SkRkQE2cmRvqklmaRvznpQmgZR6KSuARjeYwYSZq3g9ne2G7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785389172; c=relaxed/simple;
	bh=CoxxLeQ1VCvU2y9U82dy/fAeyrsJGrxlS2QO58q3hG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQsi6//eVldiv5hL4sdXHWiE6oqMx3EDCs782UhXQ1D7XbOa4p2fh/Tn6FmJwrcGe6KnmfshuRM4DZpo9OqiWcpiA2LbDIEh/uMrm7crClSt9/OHr3Ie7gVGiPnHD+1lv9FhWxeoanH15CLjUgbOVqLnTLnTyjgrl0aMhROMlR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UeVTxwea; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UeVTxwea"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3mMQV1949572;
	Thu, 30 Jul 2026 05:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=CM4zLg+UU5P1fZiHkrA3x7PiS8BsB8
	Lv8anjw7dCgmk=; b=UeVTxweaDMU9n+i+oxMw4srqOJtqlFNwwz162NeZuCO9Hh
	AE8jTmuN8PhMr0Z3FO9e2qf0fC/6t7mED2l9eLJQR3LPvIinGGNdjTYEbCywh90J
	dYkUHOs6abVug8ixmsa5DABkf/KQTyb4XaMfyAFWkgEzwdYp/Wd1IWsWHJJnwN8m
	nn6vogM9brxlyiKGwD39U8SoqcbQ+JZWBbQdkmIZx41QSH8/qgFUmTTOhgPeYtRv
	GU/yCA0jUEkKBml5Nmi5R/hOZszk/gB3QwNDjR0NSSe1DK0qCI/PB3gmF+ssiP2X
	5lDvkF8yc6TEbNUv2w/ciRMWwEq62cEEt0KZEZWQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd5afu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:26:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U4uOxV003531;
	Thu, 30 Jul 2026 05:26:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y9mby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:26:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5Pud215335824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:25:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8579620043;
	Thu, 30 Jul 2026 05:25:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C01120040;
	Thu, 30 Jul 2026 05:25:56 +0000 (GMT)
Received: from osiris (unknown [9.111.86.48])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jul 2026 05:25:55 +0000 (GMT)
Date: Thu, 30 Jul 2026 07:25:54 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: s390: Remove cond_resched() calls
Message-ID: <20260730052554.13600A04-hca@linux.ibm.com>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
 <20260727162430.1599396-3-hca@linux.ibm.com>
 <20260729184548.38b7c791@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729184548.38b7c791@p-imbrenda>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E0ecYWKi28WktlLBMpw06OxnKL7h0cIu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfXxZtbPz1U0dLt
 0OhZ81n/tOKN/yECJXVsWvWIKz58w6Mzh83Y0XytAvxC1dppyj8uJiyQYBtTyjXknt/PbYGjQXw
 wzDcEAzMb+Ho8s3h6sAxcV6NJKaDhnE=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6ae069 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=jwJq253xSbm6PIsPZTUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX6ycI7WWG8WiQ
 zUPrgif+yYaabnVYtv7a76rGax2aPzbME+9Z8Lf2iLCrup1Vtl/02lZOW6mGCDTwHTUz3CHZIO/
 gr9YCzZQtOJ1mXvprOb+pQ6AkaNxmCbiGnxKVRaaWqxUGCdaelQkQ8otH1auKz+55kjNUiA7ays
 p+xubrLPkSLrLuNGgYBTsrdN26tiOVJirN+VyYdnWOsIrYa2/4cWmbP+pwCT77IvAC8oq8puT2Z
 EFzSPDHTJ95rGTZ0iWHPLWSbmyuAjN7pvXg4ogVaUjfr4D73k/3W96b7aDMGM+UWVVPzbWEBTl4
 AZB/uK8yG6eSBLVbJzAJlaYWhQQyj3z8SpL4262Sqb7QXJrsnJWu25fYIkzFzydXLRKGHz7bVIY
 Bok99BnS0vse046PlCZrfOObSJN87i7p+8LO/GdgZJGndpaCckh1gqhqjO2GPvlTkJPgSuINJG3
 B88U6NtUM00DL+vNNfg==
X-Proofpoint-GUID: E0ecYWKi28WktlLBMpw06OxnKL7h0cIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300033

On Wed, Jul 29, 2026 at 06:45:48PM +0200, Claudio Imbrenda wrote:
> On Mon, 27 Jul 2026 18:24:28 +0200
> Heiko Carstens <hca@linux.ibm.com> wrote:
> > @@ -461,7 +461,6 @@ static inline int uv_call_sched(unsigned long r1, unsigned long r2)
> >  
> >  	do {
> >  		cc = __uv_call(r1, r2);
> > -		cond_resched();
> >  	} while (cc > 1);
> >  	return cc;
> >  }
> 
> so now uv_call_sched() is the same as uv_call()?
> just drop uv_call_sched() then

Right, I missed that. Thanks!
