Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8482D32B11D;
	Fri, 19 Jun 2026 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856302; cv=none; b=dAO2jr2HgCTyQHNXKHcFxw3C3SMACbeNZeWjHIQ8KiGcTihn+70nVePx+V1gh6DFnQP159epiaHWuQ88LNHzKgiBeAAMZpPDgQpDssXHzsRrR9bh4c+OJyA5Fx1Xd0FcGyQIy9V5HfB99MBFu5QWKMB3Ylhioq6rHx3l9kxxmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856302; c=relaxed/simple;
	bh=DImwO3Pwrj8JJLQ+Np1P1gg+TPx/thrlTUDT1mHQAI0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlTmyua3aD8cmrCwAyifilMzhtgg4pTnrvt3BNrV9yoSSqjpCxwj0znGyhtYRdlmool5yorpzDffZ53fl+nCwmj6qo3A3y11w7h43uJD/w0eI/t6iH8QYlKt+z/FPjiyXOJqwkIa9qa9uPSz9TR/XSy6daKcSWghuvHrnhPK9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aZOSjR4z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aZOSjR4z"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mkgo1587853;
	Fri, 19 Jun 2026 08:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=COG4FdvJb5fj3BqS3FuEBXQbFX6Jb2
	11+uX8J2bEeSI=; b=aZOSjR4zzhPL94ddUDgVgLXZGqEFgfSc1XKjiSYPxqiV66
	a9HYLeBqtSFRFdnKlOke5pXJ7gsFGtiiUqXUS4CzyFrAAxCFh0hg075DazQveTo8
	k0W0WcCSSkcHCnzj7rXxS01C2infQEBT+n4kQTg1mQsJlfhvx5SYj5vLdvvziH7m
	L98CgELRD77pDYFmBJRVgL7z8x0rTKN9m+HZlpQWw3oWsxn6XhFKli5M0FBfm+2L
	ZwzDe8YXqKxY8zwUQ8RQYg5pocRUYYHZBVCebL7LFgAhfbOjAn2w9oNzWvWVBrSp
	WDbEr1OoZru3QybKGL3LfwozlC7pkqB3fkqkBhww==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxc8wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 08:04:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J84c3e009398;
	Fri, 19 Jun 2026 08:04:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172fua4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 08:04:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J84m1x56230150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 08:04:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC7112004D;
	Fri, 19 Jun 2026 08:04:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92AC620040;
	Fri, 19 Jun 2026 08:04:48 +0000 (GMT)
Received: from osiris (unknown [9.111.29.105])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Jun 2026 08:04:48 +0000 (GMT)
Date: Fri, 19 Jun 2026 10:04:47 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Bastian Blank <waldi@debian.org>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Add build salt to the vDSO
Message-ID: <20260619080447.18590B46-hca@linux.ibm.com>
References: <ajQY-s7Y4mNPQfgy@steamhammer.waldi.eu.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajQY-s7Y4mNPQfgy@steamhammer.waldi.eu.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cWqntshOSxQeXECUDnZdKfhKIOI56US-
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a34f823 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=xNf9USuDAAAA:8
 a=VnNF1IyMAAAA:8 a=xc3iDBjxya4Mz0NzEQsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA3MSBTYWx0ZWRfX1vQBX1DZolrf
 jyHxKd4vAGATY8pDvOlLJVYLZmoH0gCUpBgePW8tXpVFW23rDhhpvX2i0rfbtu8JpUgDEVGIvqB
 uyz0/JuNqoICHQx1B6FKhuG1pdgR4+c=
X-Proofpoint-ORIG-GUID: cWqntshOSxQeXECUDnZdKfhKIOI56US-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA3MSBTYWx0ZWRfXzfnCFXBaeOlv
 mKcfjBTsQIpNmDFQA2dATls7anvp3USAIELKvGjw9ADpSVqv2S/7+x/FQkqXpYTpEWw3c1R3+a2
 iBtAUyiqOkFtLskN831bC7RMn8thWWrbHU6a+D/x8WV0KSaQX0IrAAhkWorW65gUQx5JR0NNDBB
 1+qXosb5HBvyhdiaN4tJBS3umvRG6dIT/8zz6gBFFSBX22HX7df/W0SnYHYT9KtNZKuhtLw+bMu
 txnCxxiy8ishIOXL7pgxR8ibW74xA0Zi/umlMC7CSxmrSx7o/uA268iiJ5J3DM0ZQ8Rmnq2uxOR
 gdmeCyJ4bvHyQuPFeq+iD1Psu8s1/D/BFKYKWNVc/gYVK1Yyc4MRKbbxeYlT20G4LdyZ1rEokE6
 aB5DYIdblJGzd9dDlKNdB01IL8ILi5HHo8YnYT1rZQG8W6+FNxgxG2woLn90yUWdMoJH85uod9b
 JVext7TxBvj8MMaV4Xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190071

On Thu, Jun 18, 2026 at 06:12:42PM +0200, Bastian Blank wrote:
> The vDSO needs to have a unique build id in a similar manner
> to the kernel and modules. Use the build salt macro.
> 
> Signed-off-by: Bastian Blank <waldi@debian.org>
> ---
>  arch/s390/kernel/vdso/note.S | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
