Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68053A1A5B;
	Fri, 27 Feb 2026 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772218581; cv=none; b=NpVEYeUKIUYx/dmdszWJYqnpX8iXpllgzWhojhLuQ5vOLuE8zGddOvMm3jLV8yuvKkQpcg7NK1tqSWvcAr4j3r+WMnN8Je+IjqLQnCuCmIv7UuewEyVMTRKF0sDpSCGMX1BOtdqLmuB/TrxWnVqo7jaWEahd+ThofP2ZS81UhGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772218581; c=relaxed/simple;
	bh=1jyLB/AyQrOFgSX3nGEbl/j3VCMp5R9zzUPm68laGCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdmNySYFbqajXwLwXoRQ3qjDV/znk1uDzdUkhSmW3d4Hks3yuK5vgxNswFWVIFe+LoXlZoEOiHcF+izLMb2TmN/Fp138E0MfpN+4uTQ7EYFEOA0wA/qjaXfzrgC/yNw295iEf4HJSZCGVjrUhvVR0vtz2ZpTw+fHEjQan2+9zUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g5+Iq2wt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g5+Iq2wt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RFAtvr3015564;
	Fri, 27 Feb 2026 18:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5bidXqPcJ2A+3zy+FklCt1bZHLQZrq
	rpQ32euSrfk7Y=; b=g5+Iq2wtMSq8AUqW2iJddVGrfxPuTYKpL5sFW3Ib9sApwd
	Ur8AmuTuyIcUb92tgAXn8Zi3NHAdZVk1Rawj9MeIviOIz4WQb2EWQ6p+G+Xn0x9b
	cv0Fu6O4I1GkGFsy1/OPA7kGqQ/1/CKA6PK+ZV3DDuXUMVG3fI8MuWdSm9WxWPDq
	CDjsr+UIJZni373PByouBkpdvpMO53/2d+wcAQ7vWq8HMikT/YW1nUmXsUUfLhfg
	BS0XhMMyEuehJetxCeIqA8AiJqSXuFXLKPhfl5iDVx1BzWm0kI3Xsb30g+3sxlrK
	Zl8eS/m7gc8Uh+NE/nm32vGAn6ktH+yuLlcRPseQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bsd5s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 18:56:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61RIa9iD001659;
	Fri, 27 Feb 2026 18:56:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1nkpxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 18:56:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61RIuCDC33489354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 18:56:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 237C12004B;
	Fri, 27 Feb 2026 18:56:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C4AE20040;
	Fri, 27 Feb 2026 18:56:11 +0000 (GMT)
Received: from osiris (unknown [9.87.139.163])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 27 Feb 2026 18:56:11 +0000 (GMT)
Date: Fri, 27 Feb 2026 19:56:10 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/xor: Fix xor_xc_2() inline assembly constraints
Message-ID: <20260227185610.23687A21-hca@linux.ibm.com>
References: <20260227092107.1120216-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227092107.1120216-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kxY8c-Tc3PRAb8eJVB-uySdlXd_l0L0A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE2NCBTYWx0ZWRfXwdEfOwLhW8qU
 2OVvt/aVk5LjO0j4nTHE1Yqmn8a1hP9gOlA8oMubW2dre+JCKNLIG8Ls99oJSW4DHUqo9oEjQT0
 bvTAYVVNeta9aiAkcOXYlVPz7PonWhXbFkAMnhGVCUy0tuRBrxgQMFpHkfgHOi0+sa0tPHgIbGv
 O/bTmUFOLCMh3pPI7DU5mTBh0tvE/qewbs6BNBVw1i8H3Qdw1GrUomTXcYQzo7ZlVXKryc0bSxX
 inG7nit1H85sdJuzpEg7ACsSW0/HDbQl+PhW0bY5ZsndwloRyfaNfeaY+Moo6u9F1xvkjAMBbdD
 b00ESPiGCAvg93pCPaXBvXMASJ+vRRS29LK0lAQCqFLbexK4x9AiNSMYtzUaZOGTZwErWuBsdzq
 5oSzIs8Q/fS/haqc+bWzfWC5lT7YBg/8mcW0ziA1dboX5LUC80+PJa3a5HAi5ony7vBymLoNgtx
 HeiOnz94AWuRWJxE6+g==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=69a1e8d0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=I-hCE_8guc2hzVsXgW8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: kxY8c-Tc3PRAb8eJVB-uySdlXd_l0L0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270164

On Fri, Feb 27, 2026 at 10:21:07AM +0100, Heiko Carstens wrote:
> The inline assembly constraints for xor_xc_2() are incorrect. "bytes",
> "p1", and "p2" are input operands, while all three of them are modified
> within the inline assembly. Given that the function consists only of this
> inline assembly it seems unlikely that this may cause any problems, however
> fix this in any case.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/lib/xor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ignore this patch. While looking at xor.c again I realized that all
inline assembly constraints are incorrect. Will send an updated
version next week.
