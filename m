Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F18259C84
	for <linux-s390@vger.kernel.org>; Mon, 14 Apr 2025 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744618119; cv=none; b=iTd6UAEhqnSkO686G4Z5MUAM1VreiWXxdeDnJ3A48Q9iGMJW3khMwJWEi1pSiQNIor6qr2GkA7G7g0riHcyX6nt+gbKmglxd0WVR5NxBz2v3aFtMosyAa2bDRi40snAdsODhttFw7StpWU/nUl4mgYpLdlugFQKVhIo5JQlqECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744618119; c=relaxed/simple;
	bh=NYUMf+7UAkCuaxeFegsUiy77GGxQxVtlEGjyt8X0/A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6zEe1TXTz0ehBVW4LkGFH2laYsGPAjeIHCTr31GRWmFkDPz5EuxpOk6kcPkA5gjuVGTa19qP2t2BcSOjpE764tAjfVce5LQotFFcOyXWPe3RPdhXwDekFuc36DZoLjIB1Q/vBVTpfOKuqo9WZRIjMiIbQTB1Li/cagd78EHiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iHSSyCgB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iHSSyCgB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DLhWwV004925;
	Mon, 14 Apr 2025 08:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MfMf5C7L2smqxVGTmNdbd39+5UpD5X
	bwzgWd2brDpM0=; b=iHSSyCgBLypQUEYyXtPw/Rk83lwC/IV6OdZLwmVvjIHk46
	7fU0JYS+/wlBUKrMecGNLwwy8MXANg/a5p6A79Iw8ImcPlwcpP/H8VljHBmXlBWw
	+O+Tpv6MurD/6OemiPyOjJUjhk6wYOG0rfZShQlW0sw048iYPqbFJKjK/GUBXk95
	gL8sFHQLgCJFRjsKzunEZ8faphsqxP2k3sLZMjsJb0ZVtxrM9ueWZts7xVXjLAKQ
	IF/zQ8kWKhSoCzg0mRk0cULDfTovudHSZOcB59vkHnfkmKaU1C+1ovt18gCvwOxn
	zcyM66XS5duMz49+ys3xZHl7J2+BnbWhMi+l/RJw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460b6ektq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 08:08:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53E7oRXp030919;
	Mon, 14 Apr 2025 08:08:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gndauj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 08:08:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53E88RgM40239516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 08:08:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FDAB20043;
	Mon, 14 Apr 2025 08:08:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA3B720040;
	Mon, 14 Apr 2025 08:08:26 +0000 (GMT)
Received: from osiris (unknown [9.155.199.163])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Apr 2025 08:08:26 +0000 (GMT)
Date: Mon, 14 Apr 2025 10:08:25 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v4 21/24] s390/uv: Rename find_secret() to
 uv_find_secret() and publish
Message-ID: <20250414080825.19379-B-seiden@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-22-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409140305.58900-22-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 143CJ7oZBxytXZHE73MmorMPNZsPMNw2
X-Proofpoint-GUID: 143CJ7oZBxytXZHE73MmorMPNZsPMNw2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=799
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140057

On Wed, Apr 09, 2025 at 04:03:02PM +0200, Harald Freudenberger wrote:
> Rename the internal UV function find_secret() to uv_find_secret()
> and publish it as new UV API in-kernel function.
> 
> The pkey uv handler may be called in a do-not-allocate memory
> situation where sleeping is allowed but allocating memory which
> may cause IO operations is not. For example when an encrypted
> swap file is used and the encryption is done via UV retrievable
> secrets with protected keys.
> 
> The UV API function uv_get_secret_metadata() allocates memory
> and then calls the find_secret() function. By exposing the
> find_secret() function as a new UV API function uv_find_secret()
> it is possible to retrieve UV secret meta data without any
> memory allocations from the UV when the caller offers space
> for one struct uv_secret_list.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

With the documentation improved:

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

> ---
>  arch/s390/include/asm/uv.h |  3 +++
>  arch/s390/kernel/uv.c      | 12 ++++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index b11f5b6d0bd1..8d7e00fa2bf0 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -616,6 +616,9 @@ static inline int uv_remove_shared(unsigned long addr)
>  	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
>  }
>  
> +int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
> +		   struct uv_secret_list *list,
> +		   struct uv_secret_list_item_hdr *secret);
>  int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
>  			   struct uv_secret_list_item_hdr *secret);
>  int uv_retrieve_secret(u16 secret_idx, u8 *buf, size_t buf_size);
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index 9f05df2da2f7..4acbbdff568f 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -681,12 +681,15 @@ static int find_secret_in_page(const u8 secret_id[UV_SECRET_ID_LEN],
>  
>  /*
This documentation string does not make sense for an exported function. Let's
add documentation from the get_metadata function.

>   * Do the actual search for `uv_get_secret_metadata`.
Change this to something like:

Locate a secret in the list by its id.

> + * @secret_id: search pattern.
> + * @list: ephemeral buffer space
> + * @secret: output data, containing the secret's metadata.
>   *
Add:
    * Search for a secret with the given secret_id in the Ultravisor secret store.

>   * Context: might sleep.
>   */
> -static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
> -		       struct uv_secret_list *list,
> -		       struct uv_secret_list_item_hdr *secret)
> +int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
> +		   struct uv_secret_list *list,
> +		   struct uv_secret_list_item_hdr *secret)

...
