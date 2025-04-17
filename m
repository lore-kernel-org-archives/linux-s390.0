Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36EA22AE74;
	Thu, 17 Apr 2025 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888110; cv=none; b=WlO7qINCdn3Gf3+3oQwbBIxXpHnIBqsQJ0LKWrhvZ0wkcIzAWTOKqjRZVl/CJcB+eXyNYxf9UQymHZ1B9cCK4Mpqk9NII5uZX9CrHz1ZdG6ktaL48hX3/44yE5OvO5Pd4fnhZ55jzWPormLmbTVytJ+E1zehhKpcFYTtDsEN5Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888110; c=relaxed/simple;
	bh=kf+m8xUUgu1IAXHYmHlrOH5iOjyIO6w8HrS0MmeJ9p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUzoSPtKkFOIIHhsMgLd119ByRdo3dAvU6jdG6neOuW6ufHIroCla6jEmbVRM6XKqIPcgEwTQmJBbatK5xEhTYSe+balBngGf/M6PTwJ4cO59A4x6fXEfdsua8EOrTxwCrY6y/56jdoBTnpO8rSRJKA3GoeIaFFwz0yv/+Jf+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r6Ta6fxn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r6Ta6fxn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GLgb4t016502;
	Thu, 17 Apr 2025 11:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=P0UNIGZ6BZF95FYUzENzM8m0X2UJTc
	RGPpcS03p9BOo=; b=r6Ta6fxnFQCjEzwsk5i1covPRqIQA3PfOCVl5Ls3McFTO7
	LnXr4TkRkQk62JSXr3RqkX0x9CqXmPlzlvpcOLU4umiPEzA61PZMFpDAbRTlZ9bH
	C/udTOuxDUQfDUwYUB1G3z2T6jcEaGsIgn6LJTBmyNPTXxT0IQagt+tY2zaK7EXQ
	Y4T8bTB6Y01tldutCJfMVWVEry9aprpa4DcPD9uv0FHdv1f9+ncSGwhNsB8yxxbf
	/oXz7p+53f4rrnWGSROYtp2Zy7GRkYcG/3cCn9+aXxl15r9JtxaeoMPb2kE56pF4
	PjvrPhUJy4CScUzAg2wlf5LJQGdrVd3bUBoowm0g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mpv2y5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 11:08:21 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53HB73qZ002090;
	Thu, 17 Apr 2025 11:08:20 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mpv2y5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 11:08:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53H8e8qv024874;
	Thu, 17 Apr 2025 11:08:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtnmwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 11:08:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53HB8GhI56754666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 11:08:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6435D20043;
	Thu, 17 Apr 2025 11:08:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDBE520040;
	Thu, 17 Apr 2025 11:08:15 +0000 (GMT)
Received: from osiris (unknown [9.87.137.75])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Apr 2025 11:08:15 +0000 (GMT)
Date: Thu, 17 Apr 2025 13:08:14 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Simon Horman <horms@kernel.org>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next] s390: ism: Pass string literal as format
 argument of dev_set_name()
Message-ID: <20250417110814.12521Bf4-hca@linux.ibm.com>
References: <20250417-ism-str-fmt-v1-1-9818b029874d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-ism-str-fmt-v1-1-9818b029874d@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KJVaDEFo c=1 sm=1 tr=0 ts=6800e125 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=b4hR2L3i-z0g1OxD4QEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: OGas9md15izUypAZmBxRwudNy2JjtbZR
X-Proofpoint-ORIG-GUID: wFOPUcrDX8e3s09cCq8F3VSL1aHRiJQG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=864
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504170082

On Thu, Apr 17, 2025 at 11:28:23AM +0100, Simon Horman wrote:
> GCC 14.2.0 reports that passing a non-string literal as the
> format argument of dev_set_name() is potentially insecure.
> 
> drivers/s390/net/ism_drv.c: In function 'ism_probe':
> drivers/s390/net/ism_drv.c:615:2: warning: format not a string literal and no format arguments [-Wformat-security]
>   615 |  dev_set_name(&ism->dev, dev_name(&pdev->dev));
>       |  ^~~~~~~~~~~~
> 
> It seems to me that as pdev is a PCIE device then the dev_name
> call above should always return the device's BDF, e.g. 00:12.0.
> That this should not contain format escape sequences. And thus
> the current usage is safe.
> 
> But, it seems better to be safe than sorry. And, as a bonus, compiler
> output becomes less verbose by addressing this issue.
> 
> Compile tested only.
> No functional change intended.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/s390/net/ism_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It might make sense to say that -Wformat-security was explicitly enabled in
order to trigger this (probably with KCFLAGS=-Wformat-security ?), since this
warning is by default disabled.

Just mentioning this, since I was wondering why I haven't seen this.
