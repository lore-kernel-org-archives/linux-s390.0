Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94313A89B;
	Tue, 22 Oct 2024 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729599419; cv=none; b=fTPSFgR9h0ea6PEFtaKq//noQgHy7EUt7HN4HCJ8F5AXTd8EAIV5PjjXdD7OMls44xo/+8yixx+ZW33vHo86Hy9sS+P64504ZoUJg8ViTy5mTqrNBcF01B5xKYL95xwApBsisZW99O9Yihp+wNucpPHZY8UCK4BVqssGM28Skz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729599419; c=relaxed/simple;
	bh=ljkcEWFbWomKcrEA1bSvPlxkO+WDloeeKiVJF32nTUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/FShnBL8T/mCSiKUL4hLHiNQQ/OtUHkXqSl1wV+JMAszUKMdROs7iUxu1E72aW5cTApsBvi52O0GqRsJ/BDUyyNdE3e0bBj2yPOSvn7BVYB7e9fkxmrpKeGRNcvQQRemIog7Z3hnAjRQlmEZ9y6mLaMaWEpDlII6qcvrr3NiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G1iw3uS+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G1iw3uS+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M2HEbM005798;
	Tue, 22 Oct 2024 12:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q1Fzka
	tz3m4I/9MZsWuQNIY/B4h9f6L5HPkc0W6Pmsk=; b=G1iw3uS+IEs9Q8GeYt3fZQ
	TPNaqNoGG5UCCuIAFz3pJVROgbP1hyn+A+0Fzy/ZRvYeuxnd+94roITclE9Kp9XC
	NzSJzdItmYALI3Aer+PdV8ShXk8yIaTmjTRxbngSwG9J7ToO8wBgFsV14tNDFrXc
	WF1Taat0ITQuyC3ivf2qEs/LRsFnhgCCap9m7AwRBSrml4UI+cudFcd/tec/Jysx
	B4osSjqhzq86rWyMd+RMFA0IUZooZ2vx0XS/jk9T6CpBCp0X13PV0tsv1hO3279E
	2UdRyMAHX2Rm15jxMUcAQlOIBRTUUgO1y4gpSsk24CcIHFueY7GGYz3V/wqEoXNg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fcnrvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 12:16:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49MAbQso018655;
	Tue, 22 Oct 2024 12:16:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42csajavb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 12:16:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49MCGqgJ34210348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 12:16:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57BE52004B;
	Tue, 22 Oct 2024 12:16:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EACA920040;
	Tue, 22 Oct 2024 12:16:51 +0000 (GMT)
Received: from [9.171.95.16] (unknown [9.171.95.16])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Oct 2024 12:16:51 +0000 (GMT)
Message-ID: <76f80f85-0dbb-425d-8390-521d0a74d9ee@linux.ibm.com>
Date: Tue, 22 Oct 2024 14:16:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] s390/uv: Retrieve UV secrets support
To: Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20241018091516.2167885-1-seiden@linux.ibm.com>
 <20241018091516.2167885-3-seiden@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20241018091516.2167885-3-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3iWUyXM6ZnytXSUUDZ-HgjKj0UZCLu-b
X-Proofpoint-GUID: 3iWUyXM6ZnytXSUUDZ-HgjKj0UZCLu-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=623 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220077

On 10/18/24 11:15 AM, Steffen Eiden wrote:
> Provide a kernel API to retrieve secrets from the UV secret store.
> Add two new functions:
> * `uv_get_secret_metadata` - get metadata for a given secret identifier
> * `uv_retrieve_secret` - get the secret value for the secret index
> 
> With those two functions one can extract the secret for a given secret
> id, if the secret is retrievable.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---

[...]

> +/**
> + * uv_secret_list_item_hdr - UV secret metadata.
> + * @index: Index of the secret in the secret list.
> + * @type: Type of the secret. See `enum uv_secret_types`.
> + * @length: Length of the stored secret.
> + */
> +struct uv_secret_list_item_hdr {
> +	u16 index;
> +	u16 type;
> +	u32 length;
> +};
> +
> +#define UV_SECRET_ID_LEN 32
> +/**
> + * uv_secret_list_item - UV secret entry.
> + * @hdr: The metadata of this secret.
> + * @id: The ID of this secret, not the secret itself.
> + */
> +struct uv_secret_list_item {
> +	struct uv_secret_list_item_hdr hdr;
> +	u64 reserverd08;
> +	u8 id[UV_SECRET_ID_LEN];
> +};

Are you skipping the size asserts since the list is asserted?
It might still make sense to pack them, no?

>   static inline int __uv_call(unsigned long r1, unsigned long r2)
>   {
>   	int cc;
> @@ -383,6 +469,47 @@ static inline int uv_cmd_nodata(u64 handle, u16 cmd, u16 *rc, u16 *rrc)
>   	return cc ? -EINVAL : 0;
>   }
>   
> +/**
> + *  uv_list_secrets() - Do a List Secrets UVC.
> + *
> + *  @buf: Buffer to write list into; size of one page.
> + *  @start_idx: The smallest index that should be included in the list.
> + *		For the fist invocation use 0.
> + *  @rc: Pointer to store the return code or NULL.
> + *  @rrc: Pointer to store the return reason code or NULL.
> + *
> + *  This function calls the List Secrets UVC. The result is written into `buf`,
> + *  that needs to be at least one page of writable memory.
> + *  `buf` consists of:
> + *  * %struct uv_secret_list_hdr
> + *  * %struct uv_secret_list_item (multiple)
> + *
> + *  For `start_idx` use _0_ for the first call. If there are more secrets available
> + *  but could not fit into the page then `rc` is `UVC_RC_MORE_DATA`.
> + *  In this case use `uv_secret_list_hdr.next_secret_idx` for `start_idx`.
> + *
> + *  Context: might sleep.
> + *
> + *  Return: The UVC condition code.
> + */
> +static inline int uv_list_secrets(u8 *buf, u16 start_idx, u16 *rc, u16 *rrc)
>

Why is buf (u8 *) if you have it as (struct uv_secret_list *) in 
find_secret()?

You have a second caller in list_secrets() but that can also be (struct 
uv_secret_list *) since copy_to_user() shouldn't care and you need to 
cast it anyway for alloc_page().

If you'd be passing buf as u64 and not as a pointer it would make sense 
but you're casting it to u64 here

