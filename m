Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60B149C69;
	Tue, 25 Jun 2024 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308380; cv=none; b=BYNr+cAc6ikx+w94xHNDRvfWYvtPEsE/HtX9HiW0Q4Li94Aer3EP6PVvrNy/Ew8SrQDGoOuESlsma6xf5yf2LI0ZAeZLuIKe87KysIOzoLCmisVJhCci68REHt5VfbuIl6uhedXjQ0HdduKDGwpAfwAO2OfVyiZfOdP8bXLRypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308380; c=relaxed/simple;
	bh=Uj+vX9vJhAkWlvIbiKewzFW3iCxu0HQgvtrD44a/DA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqPrF3YONwHq3MDyPxHXHNRJBIcMGrOjDEQMU3KDGT1fjWrl5eXOLaM+Dwxv/ivQ4fUoWXANpazxcq71ZqR11OIaIiAiMtPDem7PXiOBj3bMqKtkvy+fFSsSfVtLY6v4WqyXbRaSGHliLjBC0XlF1VfvH3FIjHWCSeC7JUjRV/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e9zA65pR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e9zA65pR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P9U82M011916;
	Tue, 25 Jun 2024 09:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=5
	akyIZv32Wp7AeFyr6oY3tN9Qkc+jjwAa17BaZu/Up4=; b=e9zA65pRMo6ytDoVR
	dUxxgwT6EqDKMCVKTL4kyoWeZp1IMQy0R0PNn7l4WRnabSTJgQhiRqewlOMGRCSR
	0waVH6hibwvXHTv7Xb+4vTTja9D7C7GQ2Ckq5Me09JTJ2iG9TAfzz/5UujGlV/rD
	afoASJwFbSvvjrEyMnoOHYFLd7jIofBpTj7xqX9iE2fY+qjiuPAeZOUrs24Y+F5G
	JFy5Ffxs75mkpmG5B6hgiHj9Xgeo/QxehXAAYR/iBPogRlvYqWVxq/pit4fXawvZ
	bTiwk0eQyhmsaavF0ggCickILyJAGxR2SLLyMcAErimbMD6DsxJZd5rX90HwJobb
	pbpIg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyua700ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 09:39:36 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45P9daQo025032;
	Tue, 25 Jun 2024 09:39:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyua700ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 09:39:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45P7d3qf019672;
	Tue, 25 Jun 2024 09:39:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xpwp0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 09:39:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45P9dTuj20054294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 09:39:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB7A02005A;
	Tue, 25 Jun 2024 09:39:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81A0120043;
	Tue, 25 Jun 2024 09:39:29 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Jun 2024 09:39:29 +0000 (GMT)
Date: Tue, 25 Jun 2024 11:39:28 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Yunseong Kim <yskelg@gmail.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        MichelleJin <shjy180909@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390/raw3270: Handle memory allocation failures in
 raw3270_setup_console()
Message-ID: <20240625093928.9210-F-hca@linux.ibm.com>
References: <20240625013225.17076-2-yskelg@gmail.com>
 <20240625063139.9210-B-hca@linux.ibm.com>
 <c88ce35f-eca1-421a-a75b-e56fb6abfa06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c88ce35f-eca1-421a-a75b-e56fb6abfa06@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ThOasYvWRY5EHeLv5l-LrQfjMVVh2ESo
X-Proofpoint-ORIG-GUID: 98zifP1RSwvDGmoJ6zeCQQvhTrHtOWG3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_06,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=340 clxscore=1015 suspectscore=0
 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250068

On Tue, Jun 25, 2024 at 04:44:47PM +0900, Yunseong Kim wrote:
> Hi Heiko,
> >> -	set_bit(RAW3270_FLAGS_CONSOLE, &rp->flags);
> >> -
> >> +	}
> >>  	rc = ccw_device_enable_console(cdev);
> >>  	if (rc) {
> >>  		ccw_device_destroy_console(cdev);
> >> +		kfree(ascebc);
> >> +		kfree(rp);
> >>  		return ERR_PTR(rc);
> >>  	}
> >> +	set_bit(RAW3270_FLAGS_CONSOLE, &rp->flags);
> > 
> > Why did you move the set_bit() call?
> 
> Thank you for the code review Heiko.
> 
> While writing patch version 2, I spent a lot of time thinking about this
> part. Previously, even if function "ccw_device_enable_console" failed,
> the flag was set to RAW3270_FLAGS_CONSOLE and returned.
> 
> I think it would be more appropriate to set the bit after everything
> succeeded, so I included and submitted this code in v2 patch.
> 
> I’d appreciate hearing your thoughts on this!

"More appropriate" is not a technical reason. Please don't mix
different things into a single patch. If the set_bit() call needs to
be moved then you need to provide a technical reason for it.
