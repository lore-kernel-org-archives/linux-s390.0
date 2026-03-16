Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9670396D0D;
	Mon, 16 Mar 2026 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667266; cv=none; b=QQi+dVUEHfXT/Zqf5hzXeC6ty8Eo+v9V0HIKub1VVxpXBrhZs1+BPEcas9ycZEzmLDGCFG0b6RRlEyiN8Evwm/9680WdxAvsLmyYTgSRjvJJh5DAnqIgRMtSLLqjXvcMPLISwF4rKCHrCwFlNZHNVVK5Q6pJEAoI6lStBT958cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667266; c=relaxed/simple;
	bh=fbYicSD0v3qqcsTqBY9nZ7W9ax5VPw/ixQxkXWvHPGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/Yn1fRzS0Pwp4jNA9+SxWOYpO4L8k16FtDkK6B2QJqhL5PoCR+wnN5F0Vhw0uyk69WpdlrhhK0SD27rR9DoB75qUJZQIsQkbip6yOi28iEth6T1K/K84kP6m8Lcsk26C2z7mm623Y+frFHV63v7Stv6bL2vYiKwia2nq2V+x84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h1+W0NZ1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h1+W0NZ1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G3Zdnq1512429;
	Mon, 16 Mar 2026 13:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/vUQXfllOM08O91I6woHuAZLT1QONo
	IHebfZbhdIRcM=; b=h1+W0NZ1vDygKlHajyFn7y++/j46qPaPW03hZuY4XEcOog
	twcYheyvqI1x439lKMbQA0x7qhDiIxFxWY4b+N4959Qe2a3noKPaxeKvnSNLGEht
	azXl/dPswW0ZL4yhAQME/7NA/tQVAwohyli1ycq02AcXlAvGpYTDbc+XhcVji5Ze
	RaOM3oTdd0D8jxiqmOa2Y/hDKjxXRrpFp90dwgKOMmKmjca69UxU8RlHuwBg9EOQ
	zJprLVaJ2H64iYjNLMJoKfukzGUQWjwJz/tPoRIfHDdYBtjZliEz1im82vrTeVOE
	rSmMwuVy49Hmf4OzL9eXQcVgkBdb44fATTUQsLCw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hquns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 13:20:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G9j5mL004585;
	Mon, 16 Mar 2026 13:20:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s52s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 13:20:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GDKl3o40698274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 13:20:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C775A20043;
	Mon, 16 Mar 2026 13:20:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3258220040;
	Mon, 16 Mar 2026 13:20:47 +0000 (GMT)
Received: from osiris (unknown [9.87.141.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Mar 2026 13:20:47 +0000 (GMT)
Date: Mon, 16 Mar 2026 14:20:45 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>, Vasily Gorbik <gor@linux.ibm.com>
Cc: gregkh@linuxfoundation.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: s390: hmcdrv_dev: remove commented out code
Message-ID: <20260316132045.17080F90-hca@linux.ibm.com>
References: <20260308103255.757461-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308103255.757461-1-jkoolstra@xs4all.nl>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VvRvMfSZ0_90k_tmhHrxtZiETym6W81-
X-Proofpoint-ORIG-GUID: VvRvMfSZ0_90k_tmhHrxtZiETym6W81-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMSBTYWx0ZWRfX4FUuLKoRL59T
 nrlasiWvVSZBgzF2w9NuwVbhzjxJDkWhwXzt+3byooH+JltaH2cJSUcIElhPMFZjZW/xiDU/Rs5
 1/Ml0ztadPe0cYVfQF4wSAtVM+3pwF3IbJmrrW4ynbocOt4L00qbdLXhWWz8Zp33PlDES+D7/iY
 n5LAD2YA04uEDWdlQACDrrvKBGKSC+IEXFC1Bjn3OoKGCTpC1P4pcVayH2xIoc2ywRTKsLGYVng
 Lnz4+kLfbFyw29i155DRG3FpYh0RsMi/+FjAHU875BakBWm9JMr75wFohU95Ui+IYbqR/VS8l+e
 xw80aT4hQUkFdI1DMBHTxkcHMEPSfWSrKuMbDJqcuOThdHGw6NfbeECckc7mtBEM4DXL47S3BB7
 hALUTU+yU3RZ6zGr1S1B6I401PQk8JUGLmi+xuWbfhW2ntiw8udG9qq7q7mGOvve++feTimAAqB
 7WIuQ/pxYkeyQ1C/x4g==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b803b4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=xOd6jRPJAAAA:8 a=VnNF1IyMAAAA:8 a=cNYUQNqnkqSJGoVTLLYA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160101

On Sun, Mar 08, 2026 at 11:32:51AM +0100, Jori Koolstra wrote:
> The create_class() api is retiring in favor of class_register() (see:
> https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/).
> The HMCDRV_DEV_CLASS define is hiding a use of create_class(), but it is
> permanently disabled as it is commented out. To avoid supporting code
> that is disabled, the suggestion is to remove all code hiding be behind
> any #ifdef HMCDRV_DEV_CLASS.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  drivers/s390/char/hmcdrv_dev.c | 114 +--------------------------------
>  1 file changed, 1 insertion(+), 113 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

Vasily, will you pick this one up?
