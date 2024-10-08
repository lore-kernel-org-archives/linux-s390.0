Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DFB1DEFEC;
	Tue,  8 Oct 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397997; cv=none; b=uF2oHRBwcDkajQpSQiZbHrHrNxHSckeqc4P8dtZpFHQLkVK0gKUW1AMmyLLGyNCEWMIJbM1xpZpIG3+BY71/Hjwif4aQP1P2kKRW5ZSSV2fpp08qkt0eHU3qEeKsD1JRiuNxz1yYGfnpsgDzZfmZ2fW6fCLra1ep3IZMdXbmsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397997; c=relaxed/simple;
	bh=9cfXzVwqV3YDkOBFYxzR0uO9BMz4wHvAooOgTm1+v5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsaOzOCfYdaCkJWP7P7Pi+X46cWrHXxl3WM6NaUl7mNSfW4tVqLoRAPMftfNybnhf/YyRnomBym745r8EGgrHG6wWnwsYLbpYIANcStYxUikLApgsR4qCxgsaBLeKVySyKb46FOZp2qeWY67AlSHRt2IsZjz0TXPGHZ72G3ze9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AkIJcx+y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AkIJcx+y"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Anbbr003573;
	Tue, 8 Oct 2024 14:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=h8+tsLjQ3QhrlZLEn7X3olsqPxp
	rYWszln0rwOWK3LE=; b=AkIJcx+yRA3oRwJuXL7RRfUvzFA0hdyWm9Et1I+wq41
	+Za+3/9RW71fNCd+R5HtOT/Kc2xQfhbOmu5PT8bG1KCcRzhsQY/PIF1epR0kdY0m
	8M6iUaM6MTWFX7PPLpHmMg3ad8evE37x1u4Qqv1/5m8S0y9UoaqMlncAbwRYwpvR
	YPxInSCRW/tgDm42JUOZezP1m0YxFREnMkIeKgOJyfrq4tJyg+jZXsBa1NErFO70
	ArJpaLahkNvyArY0ekj7ojgbijBTMXL6CFFsjF1JSRo0H+hAvVzsrC2Ixs0dPxkj
	vEmWYSSf0KPBZ+dq0h4kr3BXCdbYTeXoyg+N5tCUhYA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4253axscn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 14:33:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498C7AEi011535;
	Tue, 8 Oct 2024 14:33:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xmx5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 14:33:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 498EXAGv54002172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 14:33:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EED52005A;
	Tue,  8 Oct 2024 14:33:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C11A2004B;
	Tue,  8 Oct 2024 14:33:10 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Oct 2024 14:33:10 +0000 (GMT)
Date: Tue, 8 Oct 2024 16:33:08 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] s390/uv: Refactor uv-sysfs creation
Message-ID: <20241008143308.27223-B-hca@linux.ibm.com>
References: <20241002160418.2424889-1-seiden@linux.ibm.com>
 <20241002160418.2424889-2-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002160418.2424889-2-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2m-uuezrKBnTJdfoGbrOz1mraajLhMNG
X-Proofpoint-GUID: 2m-uuezrKBnTJdfoGbrOz1mraajLhMNG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_12,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=474 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080092

On Wed, Oct 02, 2024 at 06:04:17PM +0200, Steffen Eiden wrote:
> Streamline the sysfs generation to make it more extensible.
> Add a function to create a sysfs entry in the uv-sysfs dir.
> Use this function for the query directory.
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/kernel/uv.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
...
> -static int __init uv_info_init(void)
> +static int __init uv_sysfs_dir_init(const struct attribute_group *grp,
> +				    struct kset **uv_dir_kset, const char *name)
> +{
> +	struct kset *kset;
> +	int rc = -ENOMEM;

rc is unnecessarily preinitialized, so you can wait for a cleanup
patch from some bot.

> +	kset = kset_create_and_add(name, NULL, uv_kobj);
> +	if (!kset)
> +		return -ENOMEM;
> +	*uv_dir_kset = kset;
> +
> +	rc = sysfs_create_group(&kset->kobj, grp);
> +	if (!rc)
> +		return 0;
> +
> +	kset_unregister(kset);
> +	return rc;

doing it like

	rc = sysfs_create_group(&kset->kobj, grp);
	if (rc)
		kset_unregister(kset);
	return rc;

is shorter ;)
