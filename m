Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F341C2F7;
	Mon,  2 Mar 2026 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467385; cv=none; b=nIJQgbTt0pyxOz2cm54A11748UpRBGpT7gpXLwSlnJfIA4GUz/dxHcYS3khAPuDM0Ehppg9Pg6Bh+BGX06TGBI9FbT9fiBwIOc/1gTldAbhtbGYWWuw/e+CMghvG0PAM+wPPdSnbUWUQrIVbgGuUStXN/DQrgWMTXY7eWa79u/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467385; c=relaxed/simple;
	bh=PHSFWXAO/8tDxgUzmp0hBMYN435oyAENP1t01oLBRkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO+Jo7JIl9yepigRCYqZ6447Z7nJZg6Vo3C4jXjs+8ZrzsFXdEPZbFhO3Oep6oWt+iSSTW+QDo5z7GD3qKbbp17YMU+WkLLUkG10nN5krujMvEGi55i39FZ411P9lgaMXmWNNeDg5SE0ysOKu8XjxJf/ditso+wSUMaZ33gOgOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TLu3suZL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TLu3suZL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622FPP7Z2517891;
	Mon, 2 Mar 2026 16:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=OuXHZ/kBzZTKeYClFFrnMZp5VCSC0f
	Cg+j3H+VJgIho=; b=TLu3suZLBKDYzNXcFA++GHn05vsMVIQDAqa96IfTyYbwTJ
	nWWS/Y1Xl29szmEgy0SA/UYWZUZxuf+yWY+oBuh2Nxw3EBV7kM6CIkdCOs2fJ7oP
	5yrvo6d53ugybfYQ/9WO5534VjlCLS47bm1WsVjWiyPs1sUtaKd+3OPywapeZz0A
	46Ybf4IYAhNDGeat9hMpUoSuKjtS4Kmv2fcLEwr+O/9BvHI7rQPUdapWgL53QBz4
	NQRm/WR1MxYR13SWuuNpcG0uSscJ5xha3OguxN6OM7jO/wqFRzZOdprlZ7uLlzlK
	O4s2+joGC12n40NvfgLaaQaIoi3NvxSOXXyGND6w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrhydhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 16:03:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622D0fVP016398;
	Mon, 2 Mar 2026 16:02:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmbpmxst3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 16:02:59 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622G2tDS26345938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 16:02:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D5DA2004B;
	Mon,  2 Mar 2026 16:02:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 298C920040;
	Mon,  2 Mar 2026 16:02:55 +0000 (GMT)
Received: from localhost (unknown [9.111.42.248])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Mar 2026 16:02:55 +0000 (GMT)
Date: Mon, 2 Mar 2026 17:02:53 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/3] s390/xor: Improve inline assembly constraints
Message-ID: <your-ad-here.call-01772467373-ext-6845@work.hours>
References: <20260302133500.1560531-1-hca@linux.ibm.com>
 <20260302133500.1560531-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302133500.1560531-3-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a5b4b4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=iSRlMUYzGjX7e-hBr40A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzMSBTYWx0ZWRfX4DD7kkNRI8Rl
 puhVxb6I3T2KopFkO7F7HcGH/qmyoln9FWmRBVWR0GA7IUuTeKNU0IY4qe3qBMTYSvFKW1d7dad
 xXfJ1kUTY4ec2oJhV7A4EDAO29Su57YaKLwi8HjJUfwVgbP+hQ7bdeLlv07HJ44/N2zOx06aQ5h
 GLGK4I8O0C7vB2K3jK8HOUWwTaS5Ze+im79SDQMUeRooBs3mSCaRRqGBQz5KbrLH+nq67hol3IK
 z4O8mVJRpnYhesrgbmmj0r7si/aW8HID4Fbn+hUm8mNIUAxJUudxmp2QwKBqgDTVuFd30kpioym
 C8Dm+2wUq/YF8WZyyDZQQF93n1M9jMNQI2aoWWdOZLh7XYopgCgHtlwVf6kfiTFmw40ysWKX1WJ
 bqOwqs7lhSsjxOEnItHKlMJQ01Exxp8JLgwC5pDDNTCi6XtWPjPAKyyzTHEcNFA2j05v2dslIA/
 dRpCPFoFrq6Sx+0z4uQ==
X-Proofpoint-GUID: DpNh5UNWGqWAGxSK7U5X5LPUTfJei0NW
X-Proofpoint-ORIG-GUID: DpNh5UNWGqWAGxSK7U5X5LPUTfJei0NW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020131

On Mon, Mar 02, 2026 at 02:34:59PM +0100, Heiko Carstens wrote:
> The inline assembly constraint for the "bytes" operand is "d" for all xor()
> inline assemblies. "d" means that any register from 0 to 15 can be used. If
> the compiler would use register 0 then the exrl instruction would not or
> the value of "bytes" into the executed instruction - resulting in an
> incorrect result.
> 
> However all the xor() inline assemblies make hard-coded use of register 0,
> and it is correctly listed in the clobber list, so that this cannot happen.
> 
> Given that this is quite subtle use the better "a" constraint, which
> excludes register 0 from register allocation in any case.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/lib/xor.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
