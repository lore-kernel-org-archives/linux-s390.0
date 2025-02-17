Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1798D225413;
	Mon, 17 Feb 2025 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808087; cv=none; b=ZuEhz3GdbPkrHmfalnwbiejOtp7+NrbIPR2s6axWb3Xg8Hf42YqxlEJ8CSDUvRMDPeOWfUHBrP9sdspCzQJTVAzv7JCXTA5abo3fPpc22v0n/nITtI4/GoaO2ZnbUTGTaLRJ0NBViYW3MpAiD0BHZsuHsJQTw7elprA+Rirl2GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808087; c=relaxed/simple;
	bh=IuVTqzQkxtSgLrHGsZfIOOA0G7iyiJzOcS14TT2AgaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ld2odzp8xQohDoI+AEfMjMSMBUdT7kVt2+MGwHGWm1XrV53LnLwqhLaww48h5D/W3+kKYotyym/n03DE+Yr4cBEjshhtFcXjFxIYzknqDDUWB71ljJhcxzWZhx0RwvZBlrR2Vpd015HwFvDoL7edgxIC0ritI7Ei+qN1BxHbZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nzyn4iKb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nzyn4iKb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HDgVX8012418;
	Mon, 17 Feb 2025 16:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SoehcMeZOdOgd49RfeiQ5M429ABE1P
	ZNhcT8Mtuo+Y4=; b=Nzyn4iKbBDOz0i1unhkV8jYiWDeHxFsP4KHdKeQMG6cFlt
	mpF0HuGrvZLNiDC94BVGMKWKD+7DHD1GJkGCHndTsWtyf3ad19GPCS5uXmHLZG55
	3GXQozCMEXC07Zrb2sXHmWL3YrV26wA9bT7tW5WKIdu/vo7TnJ5TWv+YHvE5BRr0
	JztZv9iNNoN1HkROvuWrfDW34eZJkGC7/SJ9nGpiTjp10qSvpeWL6HWw3YMFMHZ7
	9ClCxh8RbuuY8X9pUwNtGb/BD3me97KMLQqK7LjIaauHNBepLeOXslXQr1glstz1
	o7YFvVbqcxs/wtRMFCT0sldt0XCEbofjO233vlUA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uuy03kn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 16:01:24 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51HG1OIQ025147;
	Mon, 17 Feb 2025 16:01:24 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uuy03kn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 16:01:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51HC0ghZ008164;
	Mon, 17 Feb 2025 16:01:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u58tf014-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 16:01:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51HG1IFR55378300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 16:01:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2E3E20040;
	Mon, 17 Feb 2025 16:01:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6018C20043;
	Mon, 17 Feb 2025 16:01:18 +0000 (GMT)
Received: from osiris (unknown [9.171.53.224])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 17 Feb 2025 16:01:18 +0000 (GMT)
Date: Mon, 17 Feb 2025 17:01:17 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, schwidefsky@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] s390/sclp: Add check for get_zeroed_page()
Message-ID: <20250217160117.21424B3d-hca@linux.ibm.com>
References: <20250217153146.2372134-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217153146.2372134-1-haoxiang_li2024@163.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b5OYOY0KcivQa3x2-argEvWA6JiQ4sbc
X-Proofpoint-ORIG-GUID: NFaKHgijFbTpfRZ82bIXgcYm51ePZ0aV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=513 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170132

On Mon, Feb 17, 2025 at 11:31:46PM +0800, Haoxiang Li wrote:
> Add check for the return value of get_zeroed_page() in
> sclp_console_init() to prevent null pointer dereference.
> 
> Fixes: 4c8f4794b61e ("[S390] sclp console: convert from bootmem to slab")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/s390/char/sclp_con.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
> index e5d947c763ea..7447076b1ec1 100644
> --- a/drivers/s390/char/sclp_con.c
> +++ b/drivers/s390/char/sclp_con.c
> @@ -282,6 +282,8 @@ sclp_console_init(void)
>  	/* Allocate pages for output buffering */
>  	for (i = 0; i < sclp_console_pages; i++) {
>  		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +		if (!page)
> +			return -ENOMEM;
>  		list_add_tail(page, &sclp_con_pages);

We can add this check, however if this early allocation would fail a
null pointer dereference would be the last problem we would have to
think about.

Anyway:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
