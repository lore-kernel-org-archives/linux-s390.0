Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B727B4F3
	for <linux-s390@vger.kernel.org>; Tue, 15 Apr 2025 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728788; cv=none; b=PIbY/Cgv9R6tw/0ZNvFCCWw/VSWldM0lOpAbCCFDywAkxD12BoJQjjGHOBxegv23B3bQ4nLnXbxz40aTq3l9Ut0OpOtqqIVMcNTcA6ms/2oEopzIj3V64VVvRSFOCqYnvJ1Hmm+COTbNj5NxinV59y4J2I+M5CtYUGj2cS7pl6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728788; c=relaxed/simple;
	bh=0UXuxEp+A3xhikjpBb0QdJV96H3B4PK1CjS7vs+rCyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUwhoJr7+r+gp2AMH7He0CKIO33Lj21VjG8GoqcKHNqm4x0A+SsbjE75/Bn3mG0hQbk+am11iqT8bRHwjFSQSUtjqrxHO8cavX2jISCyB/TGY0/5D6NppZUYIjVp313gSI/A7UQ0ZR50baQcfdrEs/0pjaUGHimsrcEdG5OKwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B+5CxMTj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B+5CxMTj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FAfNIu021892;
	Tue, 15 Apr 2025 14:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tVCjT+67eq6v7CddfFTC8lt3/2SPHI
	4lAVLCV6ODouU=; b=B+5CxMTjsXhz3OBCKR/L+2tIzHlne6zyZjPAe7Pl8qHpds
	cPilhzVS7xkfkjxgWO8qnb0lTBLtV2AldYI2BtU3abmzBtGapkZ4iLC2GU3e199p
	gViC0tZLeVEWdyqK2NlQE/EAHubTZ1U80yWA93U8anhmA+2jAAHunfJ4AymgI+Ul
	zu6JOCHPsoHdDuQiJQnxoLqGL205BaNFnxFB6IpYC4HWntB1OwvUArzFm9eAtVZ/
	x0f5PX4jh6r3t5Rlz0ruifKIf+w7aH/zf2raOlv+s0i7VMBOAQsG6I/2Pn7055NG
	ecEcFAzZV2mpuTXs5WXWK345fQ9H7JkpHqLShsvQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461nwq18ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:53:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FCocKV024892;
	Tue, 15 Apr 2025 14:53:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtbx6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:53:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FEqxMI50594274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 14:52:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BA842004E;
	Tue, 15 Apr 2025 14:52:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A37FE20043;
	Tue, 15 Apr 2025 14:52:58 +0000 (GMT)
Received: from osiris (unknown [9.179.9.172])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Apr 2025 14:52:58 +0000 (GMT)
Date: Tue, 15 Apr 2025 16:52:57 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH v5 22/25] s390/pkey: Use preallocated memory for retrieve
 of UV secret metadata
Message-ID: <20250415145257.12735Eca-hca@linux.ibm.com>
References: <20250415142438.118474-1-freude@linux.ibm.com>
 <20250415142438.118474-23-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415142438.118474-23-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iclkLll0qsbuLIlw9WEqDWOGfqaZVeZh
X-Proofpoint-GUID: iclkLll0qsbuLIlw9WEqDWOGfqaZVeZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150099

On Tue, Apr 15, 2025 at 04:24:35PM +0200, Harald Freudenberger wrote:
> The pkey uv functions may be called in a situation where memory
> allocations which trigger IO operations are not allowed. An example:
> decryption of the swap partition with protected key (PAES).
> 
> The pkey uv code takes care of this by holding one preallocated
> struct uv_secret_list to be used with the new UV function
> uv_find_secret(). The older function uv_get_secret_metadata()
> used before always allocates/frees an ephemeral memory buffer.
> The preallocated struct is concurrency protected by a mutex.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  drivers/s390/crypto/pkey_uv.c | 37 ++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)

...

> +static int get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
> +			       struct uv_secret_list_item_hdr *secret)
> +{
> +	int rc;
> +
> +	mutex_lock(&uv_list_mutex);
> +	rc = uv_find_secret(secret_id, uv_list, secret);
> +	mutex_unlock(&uv_list_mutex);
> +
> +	return rc;
> +}

This is a change to the previous code, and potentially is also a problem:
uvlist is not set to zero before it is used (unlike before). The condition
code of the uvc is partially ignored, and instead the return code of the
response is taken into account to tell if the uvc succeeded. This works since
memory was initialized, but now the contents of the previous invocation may be
used to tell if the uvc succeeded.

Or in other words: I think you need to add a memset() call to uv_find_secret()
before uv_list is used for the uvc.
