Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4F23C8B2
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432963; cv=none; b=BzhEs5OXNJPqo75KQOdYSz4TKkEPku6wE5Zio5BYmzxG0yZwK4UbBfJelFLJUo4NRFhF0Kq81eT5ia6y4y2ngsrrTNsAvpuFMBFsqJVn1xkSsNoH+qRl6u+V77deba/VrTyEnCmdw4GQ2SQLIstG0pWw+awqIK6y0v1cQ/qan1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432963; c=relaxed/simple;
	bh=oOOU+IxGSNjpZ72Yma7e0c5SfBhk90/gJD/LtmK6GAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtnJEM+dbB/s2quP+ScnYgOcxmnES1LAKaH/OjJNEEjqhGpr9l2jSCsXm3jLKgD7SW4z6EdqBK6ogPGihwXe6STH/fPXax+jNPkEr7Z+XoxY3PMPx3lQTIeR5ZfpTAWT30IztCeDdWu5VUGatyCszsvsmJBEbLMJAHn5ZeA4eVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cgf/+2Tm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cgf/+2Tm"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VDXTs3020195
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 14:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nWQvo8FlpOnudzkMwilkLdB4hDHek7
	3t8MNdbOIX2NM=; b=Cgf/+2TmMo5ZDyWqcTmUaGxJU6gX41dXMTEA2zkiOjK71a
	Ptiacos5SezJtynzuqM4eyuigNN74M8O9dDeiNp/KNRAi+VEkvzfgnNy5vH3Jk/z
	v57xSeVoLKsAlxUlegckk7wgOXw1No61UhG7yvVzxc4gm3XlTtVYani5Di2RXcvK
	Iol4p+5yHXe8aUK+r3qRW26BmHZMHoZYyRb2s7YSL2p8GZp3D2iBU2idNg+YfdyX
	wixTNf6LDuYg9suEGyUnBQ/wNmbiVRUh3Drbq1J6wuzq5AyYdiGgvJMhJSBYJhcQ
	r3IPN9rnRr1pUS2gV4xMdiTgtugxXeTdYNpF+I1A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qke9jmxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 14:56:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52VD0bG9019422
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 14:55:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pu6sxf17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 14:55:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VEtuc833751600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 14:55:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EDBF20043;
	Mon, 31 Mar 2025 14:55:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B610620040;
	Mon, 31 Mar 2025 14:55:55 +0000 (GMT)
Received: from osiris (unknown [9.179.29.62])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 31 Mar 2025 14:55:55 +0000 (GMT)
Date: Mon, 31 Mar 2025 16:55:54 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/1] s390/uv: New param workpage for the
 uv_get_secret_metadata() function
Message-ID: <20250331145554.25223Gce-hca@linux.ibm.com>
References: <20250331103505.15210-1-freude@linux.ibm.com>
 <20250331103505.15210-2-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331103505.15210-2-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1BlZoHRTCajEo_AC9rkLDlyD8ZbjUpvC
X-Proofpoint-ORIG-GUID: 1BlZoHRTCajEo_AC9rkLDlyD8ZbjUpvC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=703 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310103

On Mon, Mar 31, 2025 at 12:35:05PM +0200, Harald Freudenberger wrote:
> The pkey uv handler may be called in a do-not-allocate memory
> situation. For example when an encrypted swap file is used and the
> encryption is done via UV retrievable secrets with protected keys.

This doesn't answer the question if the context is process, bottom halve,
or interrupt context. If it is process context, is it sleepable?

> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index 9f05df2da2f7..0a8a6bc19c49 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -713,6 +713,9 @@ static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
>   * uv_get_secret_metadata() - get secret metadata for a given secret id.
>   * @secret_id: search pattern.
>   * @secret: output data, containing the secret's metadata.
> + * @workpage: ephemeral working page. Caller may give a ptr to one page
> + *            here as ephemeral working buffer. If NULL, kmalloc is used
> + *            to alloc a working buffer.
>   *
>   * Search for a secret with the given secret_id in the Ultravisor secret store.
>   *
> @@ -725,16 +728,19 @@ static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
>   * * %EIO:	- Other unexpected UV error.
>   */
>  int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
> -			   struct uv_secret_list_item_hdr *secret)
> +			   struct uv_secret_list_item_hdr *secret,
> +			   u8 *workpage)
>  {
>  	struct uv_secret_list *buf;
>  	int rc;
>  
> -	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> +	buf = workpage ? (struct uv_secret_list *)workpage :
> +		kzalloc(sizeof(*buf), GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
>  	rc = find_secret(secret_id, buf, secret);
> -	kfree(buf);
> +	if (!workpage)
> +		kfree(buf);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(uv_get_secret_metadata);

Please don't do this ugly workpage interface. Just rename find_secret() to
e.g. uv_find_secret() and make it globally visable. Then you have the
unchanged uv_get_secret_metadata() + find_secret() interfaces, and in addition
can call find_secret() / uv_find_secret() with a custom buffer.

Given that pkey_uv.c is the only user of this interface: how would the changes
to pkey_uv.c look like?  Or in other words: wouldn't it make more sense to get
rid of uv_get_secret_metadata(), and just keep uv_find_secret() and push the
allocation to the pkey code?
