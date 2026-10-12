Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB3B49B1EC
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818316; cv=none; b=jYTiPgTIqO4nP+rSR6RKmnru+vnD0kYFajBwk9aoVQm4qTebRkOO2AHb3LrU3NbRMWFLZNrEa5EIbzXl21aEOKuxbNNGNnR3MyH14i8pDVYPHBJYWclGIyW/YMqonLt5FlxkhC/y3dwxia6ZqAYLwebnFz/DHTU6S/Zmi8U6j1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818316; c=relaxed/simple;
	bh=YHX6impNl4pvcpzyxmcNl+0r/X4WTH7q0mWTY5FBPQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXcH8e1wtYUbq0REcKEJZAWzjGF79WocD/nhbNNnHTHPKSNDGflnze6LnP9HqvXn6k15WOXJIXQI7tjmdCuLIJgVfrYQZTiXr6izse6vPQSpHqOYwAjNladqtigfLo4+1EZzmhhmjr485zF8yofGoG3i8BLUgLhiCkWJSqDmZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N/785voS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N/785voS"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCE7wx182100
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 15:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=PtKJZO9AEjupMYP31yBbsUVsd+hPtG
	ZK9y+Z/30k1hA=; b=N/785voSUHszRO8H1owpL1a3vDXdlxxa1viCunYkIuQPeJ
	Gx4l0qw5oPw4klEEc4nM8aeoVYMTKCs+5Pt/evQhLtsgW3NvFotPx2VKEpRRAyOF
	mGe4RAUrJx8CmtNi+AgFg+p5x5yGCesbSVgfvh+C5lOZTZMIPjJENbOAWDzou5mx
	+wuvO5490tag1dy6D+cF8i0w2YQquWarK+RmPIVJO6JxiMIMAbhbDaZUmXEvpkAr
	iA/G64zlORoUeludr6MjP614/aRS3XUYHlaLbwZ5QoXW89a0zSAARmH6Hm5KixAy
	msGa5V2peZPKz4E7QRsGn3lq9g7zCbxVSivSIO6Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv39jxh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:18:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCJtqd1255442;
	Mon, 12 Oct 2026 15:18:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vnv7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:18:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CFITt950594162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:18:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ACDB20043;
	Mon, 12 Oct 2026 15:18:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CC0220040;
	Mon, 12 Oct 2026 15:18:29 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 15:18:29 +0000 (GMT)
Date: Mon, 12 Oct 2026 17:18:27 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] s390/sclp: Remove redundant memset after
 memblock_alloc_low
Message-ID: <08f3f635-92af-41fc-a113-4bfb31b76022-agordeev@linux.ibm.com>
References: <20261012150404.555918-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012150404.555918-1-ekffu200098@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: pWDq0wKb09BJXowDZACfXfuVn293XBvO
X-Proofpoint-ORIG-GUID: pZVGxxpxPUhQk7GeWGx5WcU-uJBw5B6H
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6accfa4a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=kgFCpbrYtFFc4UQOeDYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfXyy8d+EAeJFVd
 f2dAtQS+pBhQanwYbVFDY2IKJE450+pOgSTLiwTUyMZCladxEM9Ozxf2kZAyLZezvtdjvz45fKr
 fEPampiW7VzCg1vTZLKx6ZLUSq0rXUM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfX6S/V8Ejnk3x8
 QHCRfpyhAmqk3XU1/DScnUj21bgjPzMmiknOuod/jE5fAhGAUkWCaiItzAZI2+WTinMHmVeKPAZ
 FbPe3HfDrwjczpNjAEUhS0EUOpzTx46kn/hZ/ivgld3NkYb427V/tV8HZey6mhTcRx4bte2wLI4
 b+6dArUYoOc3USgouLGnmwkHXIAu5PV9q7wY7DL7rdkOWMaLY/mgu9HyCup+PK4SZBoxybVpStf
 9swozThD1PrFfgsmWZg2jUOkIa5wMwz071cShJaWX5FSwhVGNwAIBwrAcdqS/BW5pRrFZ2jr8pU
 mUAe3IPAkFVxUNKPcuCdr9h2xAO3zCs047YBJhvIJkZxkakObwZOFbGJ2WacQ/HywkArmqluzx0
 GrlqkU5RKmcOkemAA8TmKn5ZfZixCIsFo42hhtu9QttnhY6OkoGL9IPceIuJ3fU7ftb7hSBzZer
 ipgVuRr3v2ZXokJHw1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120060

On Tue, Oct 13, 2026 at 12:04:02AM +0900, Sang-Heon Jeon wrote:
> memblock_alloc_low() returns zeroed memory, so the memset after the
> allocation in sclp_early_get_core_info() is redundant.
> 
> So remove the memset.
> 
> No functional change.

Well, actually there is :)

> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/s390/char/sclp_early.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
> index 22dd797e6229..821b61727d1f 100644
> --- a/drivers/s390/char/sclp_early.c
> +++ b/drivers/s390/char/sclp_early.c
> @@ -138,7 +138,6 @@ int __init sclp_early_get_core_info(struct sclp_core_info *info)
>  	if (!sccb)
>  		return -ENOMEM;
>  
> -	memset(sccb, 0, length);
>  	sccb->header.length = length;
>  	sccb->header.control_mask[2] = 0x80;
>  	if (sclp_early_cmd(SCLP_CMDW_READ_CPU_INFO, sccb)) {

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
