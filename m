Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED158275102
	for <linux-s390@vger.kernel.org>; Mon, 14 Apr 2025 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643743; cv=none; b=ZxXkhdotIQlWNths6bX9N9Q0YHHtxU7hv764lxkSYCQHu5+9LdzR74s3Rh3NswW2/3jwdoakHoZ2h1PZ1Yr34NIeESqAqNQ67O8KWrVLop6MP5GwAvDqRpLM59inHrw3Wb+9dNElUimorMNH/DPnJ88dP6AlnFk4Hnx2ppb/NN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643743; c=relaxed/simple;
	bh=sZDwFzqD8jzoZTpt6iu7ABH8gyVwFauha1A+Fzor2TY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LBEXs5NyJPmnQ3wKIbJodNCy9zvMSanesmsjhgzxEa/W2OKPH3dptcEkOzXLDqlfJCZUJ+Chx1Zp1yTvShkrZz+ixvbN0gkV2zTvbbkfzmDtaDrA404UChkRW8XPAAFjeTAyBGfKIjF7vBIrRuyzZXdWthRD8nJPslE1PpYFkSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cbYPQuuV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cbYPQuuV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ECZJgp016576;
	Mon, 14 Apr 2025 15:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=OVwGdsfgN4pcgqKh+oTO2pjzd3kkV+iKy2R9+UYbmEo=; b=cbYPQuuVIsEe
	ENFaIXe9jwnO9isTgJ5dNsp8A2I8ie9ctHnLG8QRPjS4vBIna599/c3Rk6lcZuZP
	KxlyTLH3l+v2+1rjjX8oy6KU+/DTLe4AjWNY2DT2v6qn71b1dNwuJrApXYgxygQD
	L3emoWsP3jVZy2+BjGnF4wFwrH/uKf7zLGB5MipZHxcZ4loogNuAAiv9Zu/iSD/C
	IXlEOJz1LSEA1xm7lDfHi6M2qBVW8uYH97tOyQo9vwKjOuZcrVroGNVmjUwWjh8e
	Bxq0usn5Qv+3AR03uH9txeUhqbnhn+4vw2fkIl+56qmxh6Hf3+hfATlGp4JNvDMU
	fNF2eVSsHw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460q7x3kre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 15:15:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53ECBGD0031061;
	Mon, 14 Apr 2025 15:15:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gneteg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 15:15:37 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53EFFax632637568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 15:15:36 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7583B5805A;
	Mon, 14 Apr 2025 15:15:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9C9B58054;
	Mon, 14 Apr 2025 15:15:35 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Apr 2025 15:15:35 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Apr 2025 17:15:35 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v4 21/24] s390/uv: Rename find_secret() to
 uv_find_secret() and publish
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20250414080825.19379-B-seiden@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-22-freude@linux.ibm.com>
 <20250414080825.19379-B-seiden@linux.ibm.com>
Message-ID: <34a5faeee685e97e80a53e00ec846af5@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tKEYVExV3NGGS3_WNtzR-xtSdFMnds6Y
X-Proofpoint-GUID: tKEYVExV3NGGS3_WNtzR-xtSdFMnds6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=769 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504140109

On 2025-04-14 10:08, Steffen Eiden wrote:
> On Wed, Apr 09, 2025 at 04:03:02PM +0200, Harald Freudenberger wrote:
>> Rename the internal UV function find_secret() to uv_find_secret()
>> and publish it as new UV API in-kernel function.
>> 
>> The pkey uv handler may be called in a do-not-allocate memory
>> situation where sleeping is allowed but allocating memory which
>> may cause IO operations is not. For example when an encrypted
>> swap file is used and the encryption is done via UV retrievable
>> secrets with protected keys.
>> 
>> The UV API function uv_get_secret_metadata() allocates memory
>> and then calls the find_secret() function. By exposing the
>> find_secret() function as a new UV API function uv_find_secret()
>> it is possible to retrieve UV secret meta data without any
>> memory allocations from the UV when the caller offers space
>> for one struct uv_secret_list.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> With the documentation improved:
> 
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> 
>> ---
>>  arch/s390/include/asm/uv.h |  3 +++
>>  arch/s390/kernel/uv.c      | 12 ++++++++----
>>  2 files changed, 11 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
>> index b11f5b6d0bd1..8d7e00fa2bf0 100644
>> --- a/arch/s390/include/asm/uv.h
>> +++ b/arch/s390/include/asm/uv.h
>> @@ -616,6 +616,9 @@ static inline int uv_remove_shared(unsigned long 
>> addr)
>>  	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
>>  }
>> 
>> +int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
>> +		   struct uv_secret_list *list,
>> +		   struct uv_secret_list_item_hdr *secret);
>>  int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
>>  			   struct uv_secret_list_item_hdr *secret);
>>  int uv_retrieve_secret(u16 secret_idx, u8 *buf, size_t buf_size);
>> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
>> index 9f05df2da2f7..4acbbdff568f 100644
>> --- a/arch/s390/kernel/uv.c
>> +++ b/arch/s390/kernel/uv.c
>> @@ -681,12 +681,15 @@ static int find_secret_in_page(const u8 
>> secret_id[UV_SECRET_ID_LEN],
>> 
>>  /*
> This documentation string does not make sense for an exported function. 
> Let's
> add documentation from the get_metadata function.
> 
>>   * Do the actual search for `uv_get_secret_metadata`.
> Change this to something like:
> 
> Locate a secret in the list by its id.
> 
>> + * @secret_id: search pattern.
>> + * @list: ephemeral buffer space
>> + * @secret: output data, containing the secret's metadata.
>>   *
> Add:
>     * Search for a secret with the given secret_id in the Ultravisor
> secret store.
> 
>>   * Context: might sleep.
>>   */
>> -static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
>> -		       struct uv_secret_list *list,
>> -		       struct uv_secret_list_item_hdr *secret)
>> +int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
>> +		   struct uv_secret_list *list,
>> +		   struct uv_secret_list_item_hdr *secret)
> 
> ...

Done as you suggested.
Thanks
