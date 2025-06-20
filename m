Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23C128DF16;
	Fri, 20 Jun 2025 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425320; cv=none; b=AXk+gjDvmGucBInBwukrGAcXgKHHe1lYAkqBiETcCz2oFwlDGeBDAb7mdXD7U5iFmAlUq1i+gRCpYuPmcRU06LrqRB92MhEQnH1E7l94pG/SdRSl6PIjkxuNxrFBuanOSOETxJJAur55Ktd4/J69lVY+hpFVkgsni7NDDDmE+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425320; c=relaxed/simple;
	bh=sl16O+zLdoAxhBwTDWwR8Z/4VjeN3LItResauPeKQSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw+U+SH+RFr+INt0t8sf5PWgMxnnBXJTk18A+R5gypWu9iqtOJN2AkyIaXp0mx15imMa2ZrVK7B/r1F2EqAQwMg91tQ4BOT6AGaU56w1h61HpDP80XXbNYaVXoC+CLch3BKZDUwjDfqPp5EM86GiXeZ14si7LGExYTuOK51GY1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tfxkp+ii; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tfxkp+ii"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K5rNhh016161;
	Fri, 20 Jun 2025 13:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=IrCspL3sH0I13dcYdS2FapLVUtxT0I
	RLHKutb4EwL4Q=; b=Tfxkp+iiGcqAGMVK5mOQJKcJF3IxsDL2Nu7+u5Pw9//kZd
	IukdSNQsLZacvdG0/EzUkIMUEV0JEHt8+rCqesNT8CHKVpc5c7/f+KKUGPEl9HSQ
	AoCkRfJv7JKdX4KvG9epGWXHvy78N0cglqd4fXic2yZFuZsGqTnjfQBnVXhWGOuA
	XFDCHq638zYAMS9MJc9UOg5/8TP/KNFTx7zt+AI8AnHgGlv2JbOkszEqjW/tQ8sW
	g928ywXpIWTsptTMrCVsXI63Fpq1gq9UAX08eCaMO1XxdNzjD8fG5MrFqZD4SLd6
	5bUWytly2/gxO2FAu2VrTNinS+vYLi4Y6fY6XFIg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygnub58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 13:15:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55KAjMEg013960;
	Fri, 20 Jun 2025 13:15:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 479p42twnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 13:15:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55KDFA3424052424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 13:15:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5E872004B;
	Fri, 20 Jun 2025 13:15:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 435B720043;
	Fri, 20 Jun 2025 13:15:10 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.95.118])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Jun 2025 13:15:10 +0000 (GMT)
Date: Fri, 20 Jun 2025 15:15:08 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] bugs/s390: Remove private WARN_ON() implementation
Message-ID: <aFVe3NiJF2EXT6dL@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250617135042.1878068-1-hca@linux.ibm.com>
 <20250617135042.1878068-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617135042.1878068-2-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA5MSBTYWx0ZWRfX6sfJ4XZCgHuZ 7ZVfGRupHHNxBepfv0NMCN+aB3jRbK17x4d0xbNTeT8jBKPEtubj0EWuY/yDTqNyOLuidDA2tvI 6oKgBYBaGl9xcJuhpF/c4D6nxaDz8wnV019Q48+hbv3Vv8488VTqpmGJQIL82wZrPa1VnA9fEHb
 UQAKqNxLp7Uom6bJRpgu6Nye5YH3i+zIqTTROYd9n0iPqUmvRmqMj2mky+e83eNl/h/h+OpqzE4 ARNfLZeT8WUxWHSD8bDN5V4QGNTMpNa5eXj/+jj6M5k9mXkFwqRRrL/Ldbuzdc7DmTpXF7G69LC YjbtqXAuhvV4ZG2e3HJmqhzEXK6jlC1dSR5NszCNlmUh8zn9xqiXNXp1X17jePHIh2ZtYGTp2CY
 iUZ1yxkOg2375mqs2vYEt7vcDyEXG/8Ebuy7u5VGX+F+oPmrvVTGK1WPcsAM4knzQWBoyibx
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=68555ee3 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=EgFjL9AIMeZvIkpzK9UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QiqInfYAjuU75Rs8kBMg3Y8TTKPE227H
X-Proofpoint-GUID: QiqInfYAjuU75Rs8kBMg3Y8TTKPE227H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_05,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=588 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200091

On Tue, Jun 17, 2025 at 03:50:41PM +0200, Heiko Carstens wrote:
> Besides an odd __builtin_constant_p() optimization the s390 specific
> WARN_ON() implementation is identical to the generic variant.
> Drop the s390 variant in favor of the generic variant.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/bug.h | 13 -------------
>  1 file changed, 13 deletions(-)
...

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
