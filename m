Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70479205509
	for <linux-s390@vger.kernel.org>; Tue,  1 Apr 2025 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519536; cv=none; b=aPPveoHsrgzad44rsg7zzYFx70NJZhZA0Sg8FARKsB1rtdl7hMTDUkxiPOmFFficrNG1qJMxQExnbNV/+qflxC3q12DRbc/Zjfx9LL7GcfI4qKz9zXV0LLGHoI9vlpEem8SBG+W4t5Hqw7+XNExbbJhBZQVX7zcnamDnV+Gf6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519536; c=relaxed/simple;
	bh=B/fzMWpYxgWUKsWKCKKi8re/bCqRQKupfBj4gGJo+Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDdtRPdxxc0G9oQZGfQ8Mvpl/7/Hw88xecXGdSRtq7kgeVH1snv1228RGvrsd3e7n2UNVQTGFuVlm8SYxUIGoubZWPi/BHxUgH75PAW1eII1eIlwVkcP6h72hQx3Kyg/9kfITvWrcgt3du9azVWoYyimjEmclxcaCBJq7aIHnbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LRg0nfrH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LRg0nfrH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531E3Uij012010
	for <linux-s390@vger.kernel.org>; Tue, 1 Apr 2025 14:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wW9QP/ufdOA4vT5TajwJuFJysDhcGr
	TCD/7pJKpuPzo=; b=LRg0nfrHSfos+oNLA8A14ukahADLyYhcWp5sD1EeHm9Zff
	D937hph5yMDo9n/rDdxbBX1ESeAbv9QAKWEV2CLaaVwxBSd/DFHtQjPtEScqFcz9
	CthMYuvrWMMsD2z7igovXVc/6lSdow1tiHOYChWVgGPPcVA6fFlOOEoUmJkPrQL5
	s2hD8hUdaQPA/yKZiFQ6HXao7xt4O9ZuVKfHzM0ntTRgvJX/wRq3bgMVKz0DdWUV
	APdiLfrUwauxpQlf5/EutU2JwYeGc7TA+VYb+lzNPIazr4fFM7H+Q1kWIpIgQ8XJ
	w9tnxhIsJpYbld0Cd63I9CoCSBwxRLl3tEpbfRZQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45rhjpra13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Apr 2025 14:58:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531EKiQR005442
	for <linux-s390@vger.kernel.org>; Tue, 1 Apr 2025 14:58:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pww2apgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Apr 2025 14:58:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 531Ewo117471578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Apr 2025 14:58:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0830B2004B;
	Tue,  1 Apr 2025 14:58:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5CF820043;
	Tue,  1 Apr 2025 14:58:49 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Apr 2025 14:58:49 +0000 (GMT)
Date: Tue, 1 Apr 2025 16:58:48 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 1/1] s390/uv: Rename find_secret() to uv_find_secret()
 and publish
Message-ID: <20250401145848.7691Gae-hca@linux.ibm.com>
References: <20250401134331.50421-1-freude@linux.ibm.com>
 <20250401134331.50421-2-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401134331.50421-2-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f-XxMFYc4Zn2BYjDRWlZwteQ0GE3ojGY
X-Proofpoint-ORIG-GUID: f-XxMFYc4Zn2BYjDRWlZwteQ0GE3ojGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_06,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=499 phishscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010093

On Tue, Apr 01, 2025 at 03:43:31PM +0200, Harald Freudenberger wrote:
> -static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
> -		       struct uv_secret_list *list,
> -		       struct uv_secret_list_item_hdr *secret)
> +int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
> +		   struct uv_secret_list *list,
> +		   struct uv_secret_list_item_hdr *secret)
>  {
>  	u16 start_idx = 0;
>  	u16 list_rc;
>  	int ret;
>  
> +	if (!list)
> +		return -ENOMEM;
> +

Without this sanity check, please. Callers really should know what
they are doing. Besides that looks good to me.
