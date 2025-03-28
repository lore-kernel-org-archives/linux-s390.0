Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46B4A35
	for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158083; cv=none; b=PcaZrsQwlsBtrfl4o9qqUrFdO+w4BZrsJ6FRNW1d1MOeTiujOqKerCNb1en4dsoAui7K/9amSq/PNrzCH1m7vlv32oq/Yq+6kztjh37K/LXePJDMckuD2zGME8V6vd+estIQA4y32+ZOxy8sFTg62dhxsvUgAyJv762jipCjzyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158083; c=relaxed/simple;
	bh=IzwuCKm+AX1qNpJCw6mK7jxUAzAQnwXKzZjkvlARd5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glZTXSL5UhThfIOaXYMxViS+udFo9LYfNXyFGnWDvm7wU8Ie5rg+TcJAAfx58SbqOYrR8a80PcfGo/QXI8A0Nj1TQDtbTV8T0WiIE1Kl0z5qrytv5S9QbUNnxWJEESH4jIrXFusZ3DVYpCSGoIGOH0Jd4Tu530AfHTQv2t/IM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PacV/Vhz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PacV/Vhz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S0PL6w008015
	for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 10:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dKAOICO5zqxlLzmUoPt2mc4PkFRHDO
	suV5UleW8qj0U=; b=PacV/Vhz8Udqd7UpXIDqAAPPtgne7k0hyJycWvv8wviqGi
	285/d8G1zV+0w7jM+rZpoPiaMMR20G1NsoCovutBgrmpJ1NMXXTNUK/f9wkpk6Yr
	MjMQz/VywfY8ZyaJIXJHPFJ+nySO02eXeLuhBKhVP6Kc9SsZusbGRdkw/LBl3eOA
	gR2+aQBWH5+OI6dFF7uVwSjmGTKcZu9AeVi+Hzs9ogYJfAibOV1rFf5h+79Z2TGy
	VXm3uJgFC/GN+nBCNFFNkft9MrHJqCOI8Pef+8mCEwnJ/S8HGznZrs8G2YFrXto+
	FwFgOjbHwdeKfAvp0ayf9dJiKemFp7AgPi1RAryA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45n83pdhpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 10:34:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52S99r01009718
	for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 10:34:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rm1qpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 10:34:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52SAYaem42139978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 10:34:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5BB420063;
	Fri, 28 Mar 2025 10:34:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BF4C2006A;
	Fri, 28 Mar 2025 10:34:36 +0000 (GMT)
Received: from osiris (unknown [9.171.48.48])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Mar 2025 10:34:36 +0000 (GMT)
Date: Fri, 28 Mar 2025 11:34:34 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: seiden@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH v1 1/1] s390/uv: Prealloc and use one work page
Message-ID: <20250328103434.11717A53-hca@linux.ibm.com>
References: <20250327153824.61600-1-freude@linux.ibm.com>
 <20250327153824.61600-2-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327153824.61600-2-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M6YH5gw_Z9q6l3-YB2QceaEy5UHmdfJ-
X-Proofpoint-ORIG-GUID: M6YH5gw_Z9q6l3-YB2QceaEy5UHmdfJ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=970 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503280071

On Thu, Mar 27, 2025 at 04:38:24PM +0100, Harald Freudenberger wrote:
> The pkey handler is calling the uv in some circumstances
> where no memory allocation is acceptable. As of now only
> the uv_get_secret_metadata() function allocates memory.
> As this is exactly one page, lets introduce a pre-allocated
> work page and protect the concurrent use with a mutex to
> remove dynamic memory allocation and free. This page may be
> also used with future extension to the uv code.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  arch/s390/kernel/uv.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

[adding maintainers, according to get_maintainer.pl]

 
>  static int __init uv_init(phys_addr_t stor_base, unsigned long stor_len)
>  {
>  	struct uv_cb_init uvcb = {
> @@ -61,6 +68,12 @@ void __init setup_uv(void)
>  	if (!is_prot_virt_host())
>  		return;
>  
> +	work_page = (u8 *)__get_free_page(GFP_KERNEL);
> +	if (!work_page) {
> +		pr_warn("Failed to alloc a working memory page\n");
> +		return;
> +	}
> +
>  	uv_stor_base = memblock_alloc_try_nid(

Did you test this? I think this cannot work. When setup_uv() is called
the buddy allocator is not yet initialized.
Please use memblock_alloc_or_panic() instead.

> -	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> +	mutex_lock(&work_page_lock);
> +	buf = (struct uv_secret_list *)work_page;
>  	rc = find_secret(secret_id, buf, secret);
> -	kfree(buf);
> +	mutex_unlock(&work_page_lock);

The commit message does not explain why memory allocation is not
acceptable. Usually this translates to non-sleepable context. If that
is the case, then using a mutex would be wrong. This needs to be
clarified.

> +
>  	return rc;

Unrelated whitespace change.

It is up to the kvm folks to decide if the whole approach is ok.
