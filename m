Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF13DD854;
	Sun, 20 Sep 2026 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789921105; cv=none; b=fBTW32I60wK38OxU6xdqJ1spBzhtp2d9Pyunv2C/pbSUYSJsTlTC2nXEeODs3DwLFDfuqsyxj1QDWeldsh34RAmDLj1oBu9CtLxVN5NncHArT3v3mxMjPhTAEiFfiAF27XPREsJnLfeKGiDC69dav0o2daZfvgu6+yrv1FAF+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789921105; c=relaxed/simple;
	bh=FaEDEARm9tPSE/mW8wKLIjwkjh5sT5Ir+5hdszg+qNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnS5gzj3Z77A+chyuWgO92jAMtM1sDRjGE3yWtwE6rNa54KyglgISM+a3RNbft6/6SKdT3GpOX1CEkKusBOpcXOZhjuC2iTjdU0auiSnx7ym6clM8MG2gHy403LnBsNfqgWshZI+rZeatRW1FOpFpRkq4GImfnkGMRjwj0pmK1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eqOUUzF3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eqOUUzF3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68KFZNoe3025774;
	Sun, 20 Sep 2026 16:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=N/fAj1ZXZLHk+yRvTK0HntQEfg9VPk
	RpfWeJEwIwg6s=; b=eqOUUzF3nzY92SbOf4rQqGo2msFlr9BlvBqLi75sTvPNhZ
	l6J8ebXwjgySerQbxUpPbY6Omys6tb+vTYzvcTOXM5DY4iA3yZanaFVGGaEj9S0Z
	rznKWC6ahFlCci3mC/iFdjnLB7TRemDaU1MnptjsBq43NvZON5+CsNUSisyyY22H
	6LrkYNT0yxmSzWcR24egkTi7QZNeVZ4MYAdRfrz+lFUHu0K+3HhTbkClXsKsXmoF
	XnI0RGpBr9NIsn6BaVkWmoP7ddFEG+gO0lVFLpIrylhKACDNLXD1Lqio4mXO+nPG
	MMfBcS4AuOZdvU65JqUTEIHCMc/NnMDEgPuUiewQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg250av-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 20 Sep 2026 16:18:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68KFHart4109324;
	Sun, 20 Sep 2026 16:18:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq2672-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Sep 2026 16:18:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68KGIAos51053054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Sep 2026 16:18:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61D0E2004E;
	Sun, 20 Sep 2026 16:18:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAE522004B;
	Sun, 20 Sep 2026 16:18:09 +0000 (GMT)
Received: from osiris (unknown [9.87.137.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 20 Sep 2026 16:18:09 +0000 (GMT)
Date: Sun, 20 Sep 2026 18:18:08 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] KVM: s390: gmap: use assign_bit() where applicable
Message-ID: <20260920161808.18515Ba3-hca@linux.ibm.com>
References: <20260920022642.3145674-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920022642.3145674-1-peng.fan@oss.nxp.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _osZz1JiFGnaXE8xanwp5jwcyiqKbOt_
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab00747 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=8AirrxEcAAAA:8
 a=Bt1uFUFQdObFgzDsZCwA:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDIzNSBTYWx0ZWRfX5M0G9JtSrPfR
 2qRPMMUQ5vUTMLYNyhzt4nnzQWbzaOmsENjIZquV+HeZS0nfq5xs6lPNSj1OaI0UyUuZi9TytEG
 RiEjdIcUbI9F/1mak6WeeBVj8e+vFvLLLuHVHkUtm3z+TeLVW2TbhPyE3jm9pqQaJTgh7vEHk+3
 UwBAShwif1BVNlB0FDf74VFC1CijXplh5axA8cJKL/5FjFRbgxF9E41aifwmzUPlrFN/6cUWlWn
 90Xup/RBmZVEI+rp4s6u8irMBBPNr0QY7oGP5oseDVY2r5ajdWbYR2Ix/AWSmFr3xIhKKb3D9G5
 MJKuo3wXqT5Bfj3ydAXanVstZQlbUmojEJ+FeayCV8hRe9f8cE6p0kLD4hAkVfZEW3qcQbVr03/
 n+WxyIhWUq3Lx25VIF6h2QhFUW7l7qbMpiKL56BxFJMSril+bDr4oli8JpMihSVEfzHfkt+5+MF
 WTbhPl0SQzMpGQ+919Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDIzNSBTYWx0ZWRfXw+XJbPCihTdS
 PF85z4/OXxYd7QHOz/mNYyyLAyCuyKm5D9EoVQaMiYrl3vgiEezdNh+p2iG9Kt8l2+jrh3eGtEf
 LujDAIBb7fjM92Fr/Wu8hVHt/faBwAk=
X-Proofpoint-GUID: _osZz1JiFGnaXE8xanwp5jwcyiqKbOt_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200235

On Sun, Sep 20, 2026 at 10:26:25AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/s390/kvm/gmap/gmap.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
...
> -	if (test_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &parent->flags))
> -		set_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &child->flags);
> -	else
> -		clear_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &child->flags);
> +	assign_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &child->flags,
> +		   test_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &parent->flags));
>  
> -	if (test_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &parent->flags))
> -		set_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags);
> -	else
> -		clear_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags);
> +	assign_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags,
> +		   test_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &parent->flags));

This turns something which was easily readable into an unreadable mess.
