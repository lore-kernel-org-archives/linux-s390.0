Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB615746E;
	Wed, 23 Oct 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671289; cv=none; b=q290hS3SlWQP2OSb3NJ9oGBVEr5+CYmgIy5WdeLfyMoTxDDAxr0+dM4lb5ojXp4Ml0kMrxoseytVHP7F3SwT4eLUgYM74On29wx/IntlZgsZ/vISMxgs41n6hEk2WSdzuxCvOUZ4FLrxC69KGjcto/VEBfIm8sJyVtMd3M29gbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671289; c=relaxed/simple;
	bh=Ba25mhOo6jd/ZI+SaaOySxVohJpT5UvUE6YhVVla5PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aY+2p8IJZalH6bCwuuHu6IOAJwDaXqiuBekebpdNh2wChiVEt0/FC/1hg73NzbRACeIIHOkNXJaFVKzHE6AgZ2ThN6+ybP7pP9y15yAOFnXqSNsrUmkvtSuK2io3wS3N8dA8bFi/D15XocT5xiXNHd8d7R460l+wd9UPEicmDBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nRizuHn3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nRizuHn3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N0NqDm016293;
	Wed, 23 Oct 2024 08:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7w24KY
	OWzjPxITJ6KqdVH4uPRl0bd1bMa5hbVvttiZc=; b=nRizuHn3YW5enJPISBWb8/
	MBEy6FXCTUvYHJtCseRkq01+irYkR24KD8gf0EBqoj6gSoB8uesEpJKyupPnOVRO
	hBUzKNAgzXB5DD08uzUH7FWJ6sW15wH4ASJqQbp+s/cgG9Ofx0su0TWqMiRD2xB3
	q9l/fz0SGw7g3LozbfdG9qEX5+J4VlpTiRnRmKBi2FncqQ5qS40NNnmkWDH25deb
	wIfYb17oF5/JQCuZoPekBN5v7fBxkm6BEaF69yJa3BOKmvZWVxkfdEfHpDLMnBkN
	1pEIf5v+YGvKBLVLCib9TUY1Ir6T+ipVJifV91VSwP4H4VXOJowl7aKBFinRF2gA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emadt1qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 08:14:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49N7YnjH001521;
	Wed, 23 Oct 2024 08:14:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emk99ww5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 08:14:39 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49N8Ec4R26542822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 08:14:38 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3415258053;
	Wed, 23 Oct 2024 08:14:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94EDB58043;
	Wed, 23 Oct 2024 08:14:36 +0000 (GMT)
Received: from [9.155.199.163] (unknown [9.155.199.163])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 08:14:36 +0000 (GMT)
Message-ID: <7a33afb9-89da-4493-9d54-7a65fffe05d9@linux.ibm.com>
Date: Wed, 23 Oct 2024 10:14:35 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] s390/uv: Retrieve UV secrets support
To: Janosch Frank <frankja@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20241018091516.2167885-1-seiden@linux.ibm.com>
 <20241018091516.2167885-3-seiden@linux.ibm.com>
 <76f80f85-0dbb-425d-8390-521d0a74d9ee@linux.ibm.com>
Content-Language: en-US
From: Steffen Eiden <seiden@linux.ibm.com>
In-Reply-To: <76f80f85-0dbb-425d-8390-521d0a74d9ee@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zcEDe96udDRwOZqLgChC8ES6MzPrVdcx
X-Proofpoint-GUID: zcEDe96udDRwOZqLgChC8ES6MzPrVdcx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=777 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230049



On 10/22/24 2:16 PM, Janosch Frank wrote:
> On 10/18/24 11:15 AM, Steffen Eiden wrote:
>> Provide a kernel API to retrieve secrets from the UV secret store.
>> Add two new functions:
>> * `uv_get_secret_metadata` - get metadata for a given secret identifier
>> * `uv_retrieve_secret` - get the secret value for the secret index
>>
>> With those two functions one can extract the secret for a given secret
>> id, if the secret is retrievable.
>>
>> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
>> ---
> 
> [...]
> 
>> +/**
>> + * uv_secret_list_item_hdr - UV secret metadata.
>> + * @index: Index of the secret in the secret list.
>> + * @type: Type of the secret. See `enum uv_secret_types`.
>> + * @length: Length of the stored secret.
>> + */
>> +struct uv_secret_list_item_hdr {
>> +    u16 index;
>> +    u16 type;
>> +    u32 length;
>> +};
>> +
>> +#define UV_SECRET_ID_LEN 32
>> +/**
>> + * uv_secret_list_item - UV secret entry.
>> + * @hdr: The metadata of this secret.
>> + * @id: The ID of this secret, not the secret itself.
>> + */
>> +struct uv_secret_list_item {
>> +    struct uv_secret_list_item_hdr hdr;
>> +    u64 reserverd08;
>> +    u8 id[UV_SECRET_ID_LEN];
>> +};
> 
> Are you skipping the size asserts since the list is asserted?
yes.
> It might still make sense to pack them, no?
It is unnecessary to pack the struct as it is naturally aligned (at least on s390).
While, processing your comment I noticed I unnecessarily packed uv_secret_list as well.
Probably because nearly every struct in that header is (IMO unnecessarily) packed.
IIRC packing may restrict optimizations done by the compiler.

However, to stay consistent with the rest of that file I will pack this struct as well
(+ uv_secret_list_item_hdr). Those are not hot paths anyways.


> 
>>   static inline int __uv_call(unsigned long r1, unsigned long r2)
>>   {
>>       int cc;
>> @@ -383,6 +469,47 @@ static inline int uv_cmd_nodata(u64 handle, u16 cmd, u16 *rc, u16 *rrc)
>>       return cc ? -EINVAL : 0;
>>   }
>> +/**
>> + *  uv_list_secrets() - Do a List Secrets UVC.
>> + *
>> + *  @buf: Buffer to write list into; size of one page.
>> + *  @start_idx: The smallest index that should be included in the list.
>> + *        For the fist invocation use 0.
>> + *  @rc: Pointer to store the return code or NULL.
>> + *  @rrc: Pointer to store the return reason code or NULL.
>> + *
>> + *  This function calls the List Secrets UVC. The result is written into `buf`,
>> + *  that needs to be at least one page of writable memory.
>> + *  `buf` consists of:
>> + *  * %struct uv_secret_list_hdr
>> + *  * %struct uv_secret_list_item (multiple)
>> + *
>> + *  For `start_idx` use _0_ for the first call. If there are more secrets available
>> + *  but could not fit into the page then `rc` is `UVC_RC_MORE_DATA`.
>> + *  In this case use `uv_secret_list_hdr.next_secret_idx` for `start_idx`.
>> + *
>> + *  Context: might sleep.
>> + *
>> + *  Return: The UVC condition code.
>> + */
>> +static inline int uv_list_secrets(u8 *buf, u16 start_idx, u16 *rc, u16 *rrc)
>>
> 
> Why is buf (u8 *) if you have it as (struct uv_secret_list *) in find_secret()?
> 
> You have a second caller in list_secrets() but that can also be (struct uv_secret_list *) since copy_to_user() shouldn't care and you need to cast it anyway for alloc_page().
>
Yes, that makes sense. I'll change that to struct uv_secret_list *


> If you'd be passing buf as u64 and not as a pointer it would make sense but you're casting it to u64 here
> 
Thanks for the feedback.

Steffen

