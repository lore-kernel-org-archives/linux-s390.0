Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5771CFB6;
	Tue, 25 Jun 2024 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297111; cv=none; b=MxE0hNeq/5L1n66SZeThJYjEnItBuRF2LlA5v0zjAjvH1WMiWIOe7YSZ4wrvPYfoo8V6Fe6qm/n2mK/YqjD72qFWG/c/QMYWYexuMmuA8sU0E4XYxj5T5bFw88wsTYYGScyzNOHTZOav0ltXlKR/QFOSM1ZECrt3o6KWqVCL9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297111; c=relaxed/simple;
	bh=Y98yBLsgvVZrd/sJjCAS+Gny4ygYqA77IF4+MwesoLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUmzm5xdZyH6hCrLRd5Xd94q5mHvw0AxIizPd5qStZ5xNXvEJhyjsINFf5uYgHBt8xKQ8mNgxl/ElOppG3M6bGacrbH9lttxoH/rSMnW7rSikt9bLBi8RyPK8xSei5dLJJRKyNW2yA4XDwKR9HmFJAKBE3pa76smM9rcsozdNvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eahOxSKQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eahOxSKQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P5vKiL013107;
	Tue, 25 Jun 2024 06:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=Nm6kpPM5VG7M+pDy2FlSGdBZz7G
	osN2DwveDxNeXzho=; b=eahOxSKQaPcCNIhjOEOkUaBdcZY/707TNfFmCYOfm/J
	VA7E3sRBk4ahNn2MJQmW5bFbzgbnPRaDBF4sNofN/TUJ+s+mNLcrk+qTt5mjh1az
	jGaVs3EjJ7HhuNKRgKkqRvsZQme80hXC9rB+qqzMWx5KRBYqPu6P0AwHVOSrHx6M
	wiko+AMgybLkw2xvZqluusekbiOpEYPn5sSVi3iKirQWyb8ibUEIaRyXfTxSbcww
	A5GmD8kIYDIelZgavwQ0HWeR63qAvmDnd6smNVrMvrqWROBVo1RiN6MZoLQIFiBR
	58WuLIYlnJDu5h3jZ5OPmZYyW/jfVlZBWBhPMq3hQng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyqsnr3q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 06:31:47 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45P6Vkos003041;
	Tue, 25 Jun 2024 06:31:46 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyqsnr3q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 06:31:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45P6TZh3018131;
	Tue, 25 Jun 2024 06:31:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xu55ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 06:31:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45P6VeUl51184074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 06:31:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABEB62004B;
	Tue, 25 Jun 2024 06:31:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8486920040;
	Tue, 25 Jun 2024 06:31:40 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Jun 2024 06:31:40 +0000 (GMT)
Date: Tue, 25 Jun 2024 08:31:39 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: yskelg@gmail.com
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
Message-ID: <20240625063139.9210-B-hca@linux.ibm.com>
References: <20240625013225.17076-2-yskelg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625013225.17076-2-yskelg@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1tFG4w8kGn2bL5xQAM8Ikhxpa4RaOz0T
X-Proofpoint-ORIG-GUID: bAapJyAjG5NKleySZGV69WFyE2ZNJWpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_03,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=93 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0
 mlxscore=93 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=93 mlxlogscore=-111 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406250048

On Tue, Jun 25, 2024 at 10:32:26AM +0900, yskelg@gmail.com wrote:
> From: Yunseong Kim <yskelg@gmail.com>
> 
> A null pointer is stored in a local variable after a call of the function
> "kzalloc" failed. This pointer was passed to a subsequent call of the
> function "raw3270_setup_device" where an undesirable dereference will be
> performed then. Thus add corresponding return value checks.
> The allocated each memory areas are immediately overwritten by the called
> function zero-initialisation be omitted by calling the "kmalloc" instead.
> After "ccw_device_enable_console" succeeds, set the bit raw3270 flag to
> RAW3270_FLAGS_CONSOLE.
> 
> Fixes: 33403dcfcdfd ("[S390] 3270 console: convert from bootmem to slab")
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> ---
>  drivers/s390/char/raw3270.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
...
>  	rc = raw3270_setup_device(cdev, rp, ascebc);
> -	if (rc)
> +	if (rc) {
> +		kfree(ascebc);
> +		kfree(rp);
>  		return ERR_PTR(rc);
> -	set_bit(RAW3270_FLAGS_CONSOLE, &rp->flags);
> -
> +	}
>  	rc = ccw_device_enable_console(cdev);
>  	if (rc) {
>  		ccw_device_destroy_console(cdev);
> +		kfree(ascebc);
> +		kfree(rp);
>  		return ERR_PTR(rc);
>  	}
> +	set_bit(RAW3270_FLAGS_CONSOLE, &rp->flags);

Why did you move the set_bit() call?
