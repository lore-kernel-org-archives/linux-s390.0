Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DAF20E03F;
	Wed, 16 Oct 2024 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103880; cv=none; b=irFoTemG3LLVFjKbpIAphXwiL7fl2ETGRg7+lkB7PFCUbPO8krWLwxiiqOxk/hJdfLv21D2PZk300AI0h/Uq8Mav2416QbEM5FjnagfzN/vf6UWVB/7AEPSJkQwgsfVJHPlmz9PZqRLQMDM/4fh3/QBa4FiqQKaZo+VytZW1wj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103880; c=relaxed/simple;
	bh=Ps8lfftrHz+eYH6LZ19tvlTQRIFQTkgYYQKUnOg+GN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7MeVFrcNjblzi0Sd6ljfgv18T0eaRnGK/LSBabrcm5fVHXSe8HWlpxAhVTHUgbykqLA1TGOkK0TGkmhp5mFB/Fyuyxe+ZIenh12KZmsYfXqVDr5cl0bkZ/9eFOIp5h67mVymydlUKwxMWAZV+tV+FR9aN30ueKqATUdSj8u3Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sT9hNur+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sT9hNur+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GIKaiw014368;
	Wed, 16 Oct 2024 18:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=n/vzuDg8dd2cQXoLxVrojumWNLu2WM
	5B0RoY9HpaMGo=; b=sT9hNur+tyId4zny3HFv9EI7qrEzLyi0aT91FIBs3if2Yi
	o/syahTpiqPzsSeJZ9H9RQEUJjuoUaOU1dfPRpwribkx+uUlV0l9TcJ88kIUXiGy
	KXRBdCUe/RBzrSjbRBohw9/Epd9sLk/Ut6J+7233zI+u7zbYv46mPrVwbGMm/lsO
	B3wLxjQOSxG+snc1iLK7D80RcUdNISsRtdud38l/pX4u13BWWTMQbUB/Qn86MjDN
	d5EqPK2IpF2FHzFceC1T1BEMRD6HD1XGSGI0l5PCzzy9fuJYjppuD+Lg9pGpsJz/
	iCdQorV7onPm6XrxVSt9Pilj16j0ZT2wyedo25+A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ajpc838e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:37:53 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GIbqUP020563;
	Wed, 16 Oct 2024 18:37:52 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ajpc838b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:37:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GFb4LE006666;
	Wed, 16 Oct 2024 18:37:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283es3569-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:37:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49GIbmuL29950600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 18:37:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CC6C20043;
	Wed, 16 Oct 2024 18:37:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2D7920040;
	Wed, 16 Oct 2024 18:37:47 +0000 (GMT)
Received: from osiris (unknown [9.171.30.171])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 18:37:47 +0000 (GMT)
Date: Wed, 16 Oct 2024 20:37:46 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "Ricardo B. Marliere" <ricardo@marliere.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] s390/time: Add PtP driver
Message-ID: <20241016183746.25478-A-hca@linux.ibm.com>
References: <20241016115300.2657771-1-svens@linux.ibm.com>
 <20241016115300.2657771-3-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016115300.2657771-3-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pVzF-2odreVl0wqk0ooc8vlnTOrWZ2ms
X-Proofpoint-GUID: z1uE51r3gkr-F93r8IkbMaxIuhnvP6MY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=544 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160118

On Wed, Oct 16, 2024 at 01:53:00PM +0200, Sven Schnelle wrote:
> Add a small PtP driver which allows user space to get
> the values of the physical and tod clock. This allows
> programs like chrony to use STP as clock source and
> steer the kernel clock. The physical clock can be used
> as a debugging aid to get the clock without any additional
> offsets like STP steering or LPAR offset.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  MAINTAINERS                   |   6 ++
>  arch/s390/include/asm/stp.h   |   1 +
>  arch/s390/include/asm/timex.h |   6 ++
>  arch/s390/kernel/time.c       |   6 ++
>  drivers/ptp/Kconfig           |  11 +++
>  drivers/ptp/Makefile          |   1 +
>  drivers/ptp/ptp_s390.c        | 129 ++++++++++++++++++++++++++++++++++
>  7 files changed, 160 insertions(+)
>  create mode 100644 drivers/ptp/ptp_s390.c

...

> +static __always_inline unsigned long eitod_to_ns(u128 todval)
> +{
> +	return (todval * 125) >> 9;
> +}

This should return u128 so the caller gets a non-truncated return value.

> +static struct timespec64 eitod_to_timespec64(union tod_clock *clk)
> +{
> +	return ns_to_timespec64(eitod_to_ns(clk->eitod) - TOD_UNIX_EPOCH);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Misplaced braces. I guess you want:

	return ns_to_timespec64(eitod_to_ns(clk->eitod - TOD_UNIX_EPOCH));

> +static struct ptp_clock_info ptp_s390_stcke_info = {
> +	.owner		= THIS_MODULE,
> +	.name		= "IBM s390 STCKE Clock",

Please, as written before make this simply "s390 STCKE Clock".

> +static struct ptp_clock_info ptp_s390_qpt_info = {
> +	.owner		= THIS_MODULE,
> +	.name		= "IBM s390 Physical Clock",

"s390 Physical Clock"

> +MODULE_AUTHOR("Sven Schnelle <svens@linux.ibm.com>");
> +MODULE_DESCRIPTION("S390 Physical/STCKE Clock PtP Driver");

"s390 Physical/STCKE Clock PtP Driver"
