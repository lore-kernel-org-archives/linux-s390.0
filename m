Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D03B775F;
	Mon, 16 Mar 2026 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676546; cv=none; b=r8INYsLZ0oA6Hgc4xTSHq4lh8TqGXqYCGaxhUaGsoZvJAXR8/2NF6fopdo8B3i8YpSL770IfmXNp8VOWByEXZ39j9Zfhu1cuK4elUZMh7tI7PxxjmpU8kx3L1ze6mvhuR/3cHB/8jbsN2Az6FJeErQ3jOKWjssK6zUfgeE+n5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676546; c=relaxed/simple;
	bh=5MWtFxoDHrNgI/eKIQ0N+z9mH6+sV6DIchQPAvWaTOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJNNuwpx82JOApie3XyPqPP9JZBp4aqVB+xJm3l3h5NzIODdzHIYJfaBgy8iyTZ0G7u6ZsepvTgtJrZ1c37b9n3/J6mQK8HTrO4VUr0Lh5cpCWK7ziMtR77Hucdqux44EMzyKCPfQ6lsAugN3PXOP2mld2dTvcZvOMdF4k448ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r1Vmx3VE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r1Vmx3VE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GEElX8640729;
	Mon, 16 Mar 2026 15:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=aPgLkvGkgmafVonkqxkgvps/vyZFW6
	NDM5QIvv+zMj0=; b=r1Vmx3VErn6OpRE3sSOrCk6ngVD5pXuI2c2Hak49CPM0wW
	m5cQ/5DzLuLZnm81geGLKvDLQ5KmATm7SXkTQXc6WDm3sKDBOwesJpY8vEWouOsc
	TuTvAYX32nNzFhGpjKRjSOHnCTtBSooxTGXNQ0oWurEp7/Nj0LA4SVFBkVkV/XB3
	ekpRgn0z6hYHNoDKebrjo9R1K5AziEymRrfGtweshzP5/X6xUA1bcJeLIO2gD066
	jlSHv/r2LNAWeLLsIX6JssYQTqeJdtgm0cztCgvJNtZHmTvb8ehq5gVzp+jle5lV
	PmD3Y+onno4sRq6wQw4fm1FYk2cToMn4Fu0tA+AA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyau88fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 15:55:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GBoX5P028510;
	Mon, 16 Mar 2026 15:55:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq156nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 15:55:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GFtYPe49086842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 15:55:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B585120043;
	Mon, 16 Mar 2026 15:55:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B44620040;
	Mon, 16 Mar 2026 15:55:34 +0000 (GMT)
Received: from localhost (unknown [9.111.82.185])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Mar 2026 15:55:34 +0000 (GMT)
Date: Mon, 16 Mar 2026 16:55:32 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: gregkh@linuxfoundation.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: s390: hmcdrv_dev: remove commented out code
Message-ID: <ttc01kk@ub.hpns>
References: <20260308103255.757461-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260308103255.757461-1-jkoolstra@xs4all.nl>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExOSBTYWx0ZWRfX/gVE1Drav1jP
 /3va7H0WAsWnOLuoqOz6QguuAYaRWtoIDO9foe05gwpOBOFLe11Jh/zXeFz42AAj5HXtQqCEmed
 TfT7A5AwIAacv+zZA2Q6WUtMy4mZfqwJjfTrg3N0tE4rtQzfQokMjz5JMYW0DTxOPV/30171h/X
 2LVBwDEas3GWBdPEH7hbWO/IoBXBkfAdIz/fiXbWNwDtTW/knyuHqBc96ZWh/T7P1K3uUN87zKq
 xMnZKBUU3duubwbnzhEexInd0f+gXeaN8yFVCW3Cv/Sext0tvnLQnJAnLX2ixfIF9G5+tUSTFNg
 ZlK9Y0d7wP8/Qm0L1R6UMTZ8U83cRBrri9aZp86ZEQ8pVpDfpYXkz4aCu3j0ortzBRUIP7XqVy2
 fdp71TF6KSI0fijKML6a/iATpR1iOOD7yJoaIwGcBby4Hxh4m3qbY5YkAl8nvSoYkb+i1HEO5WB
 wkM+4Aak1RZoIiBlkkA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b827fb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=xOd6jRPJAAAA:8 a=cNYUQNqnkqSJGoVTLLYA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: QwSIEArygizdSoP_3aoKjstSFmvHuu6C
X-Proofpoint-GUID: QwSIEArygizdSoP_3aoKjstSFmvHuu6C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160119

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

Applied, thank you!
