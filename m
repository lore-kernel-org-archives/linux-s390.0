Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F019F422;
	Mon, 14 Oct 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906400; cv=none; b=UqWNfMJ8qTCWaDCJANu9OebtbVhKd1QuT2R++DHXCGPGBLVNcSgvB9Cam6DeQD35OLjchuDDNw9Ktye3eH+nVDuX1Q8Cahk+J1YtevzUdNowaI3i6DGmepXJx8pU+vo5YNqRIDDJk5vnYsxP/+y25OJH9TGTzrhNXhZonctAYsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906400; c=relaxed/simple;
	bh=nTB1qOgsvVknB33T9r8+Bbv1xBHou1dnMPWpaOoUv5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/OSo8AHjcOc5JugUvs2hVoY44JsqQI/7t/sjeQKvqi0Vnrdz2nbXQYV+zmeaOqJsSmYuDy06QFIu7D6SuUcy1XeiApOJcrQvHzeltwQm+mCXeNculjnBt3xIYzAwBSZYg5/6O5U0llNsCpOlMMsuzlccV0Q+IIfBiCNwufjcao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XjfDzzMA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XjfDzzMA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAKn05018859;
	Mon, 14 Oct 2024 11:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=F
	VlyaQ+gYkGeMLGjxM2G2pW6ZmjtXH1UNeMo2MSk11c=; b=XjfDzzMAhryv0gt02
	8cD+pPVzC8kLNbhixCzB5pgpw7ScU0u43nKUQXngXG3wjiY/lOFlt8zr5GScCOXw
	Y8lx43lnbu9mnf/KN4KfvcOIoooWkx4cdtS9MrHBiwzdjp2uMkGCNeKVkteTnK1w
	1UOinO3ee14gz/h0PTGa8PyPHr7e8Yudk7WXB7dkLDKJNzZ0gmfUPqMIHeSLKNpK
	j4o7rdd2/sHT7Ri/AWS6M7V2AZ8Ce3OgCdivaH8UoiZpmOmDvJ/JaXTucKn/wrc1
	8w+3PrxyS2ZU0PkPCJpd1xS9wWaqwXdVUaKZNzlLK69uX1CEhG9cpsGZAYvjEJ7G
	iTiGw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4291f88bwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 11:46:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49EB3fsh002408;
	Mon, 14 Oct 2024 11:46:36 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284eme96g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 11:46:36 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49EBkZlb26542622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 11:46:35 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DA3B58043;
	Mon, 14 Oct 2024 11:46:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 828B358059;
	Mon, 14 Oct 2024 11:46:33 +0000 (GMT)
Received: from [9.179.1.71] (unknown [9.179.1.71])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Oct 2024 11:46:33 +0000 (GMT)
Message-ID: <3463a84c-1f68-4d60-b705-3079491f0176@linux.ibm.com>
Date: Mon, 14 Oct 2024 13:46:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] s390/uv: Retrieve UV secrets support
To: Janosch Frank <frankja@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20241002160532.2425734-1-seiden@linux.ibm.com>
 <20241002160532.2425734-3-seiden@linux.ibm.com>
 <6ea3cfb4-47ab-478e-b5f0-0a02ec28b37d@linux.ibm.com>
Content-Language: en-US
From: Steffen Eiden <seiden@linux.ibm.com>
In-Reply-To: <6ea3cfb4-47ab-478e-b5f0-0a02ec28b37d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FqPOUGdPH1lZcXz-12-1m45TxTYAlIij
X-Proofpoint-ORIG-GUID: FqPOUGdPH1lZcXz-12-1m45TxTYAlIij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=742 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140083

Thanks for your comments Janosch.

On 10/7/24 2:31 PM, Janosch Frank wrote:
> On 10/2/24 6:05 PM, Steffen Eiden wrote:
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
>>   arch/s390/include/asm/uv.h | 131 ++++++++++++++++++++++++++++++++++++-
>>   arch/s390/kernel/uv.c      | 127 ++++++++++++++++++++++++++++++++++-
>>   2 files changed, 256 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
>> index 94ff58336e8e..aef333aaaef4 100644
>> --- a/arch/s390/include/asm/uv.h
>> +++ b/arch/s390/include/asm/uv.h
>> @@ -62,6 +62,7 @@
>>   #define UVC_CMD_ADD_SECRET        0x1031
>>   #define UVC_CMD_LIST_SECRETS        0x1033
>>   #define UVC_CMD_LOCK_SECRETS        0x1034
>> +#define UVC_CMD_RETR_SECRET        0x1035
>>   /* Bits in installed uv calls */
>>   enum uv_cmds_inst {
>> @@ -95,6 +96,7 @@ enum uv_cmds_inst {
>>       BIT_UVC_CMD_ADD_SECRET = 29,
>>       BIT_UVC_CMD_LIST_SECRETS = 30,
>>       BIT_UVC_CMD_LOCK_SECRETS = 31,
>> +    BIT_UVC_CMD_RETR_SECRETS = 33,
> 
> One is SECRET and the other is SECRET_S_.
> I know that you coded this according to spec, but sometimes we need to fix the spec. I've contacted the spec authors to fix it on their end if possible.
Yes we should fix the specs.
I will use singular forms on both constants.

> 
> [...]
> 

>> + * Do the actual search for `uv_get_secret_metadata`
>> + *
>> + * Context: might sleep
>> + */
>> +static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
>> +               struct uv_secret_list *list,
>> +               struct uv_secret_list_item_hdr *secret)
>> +{
>> +    u16 start_idx = 0;
>> +    u16 list_rc;
>> +    int ret;
>> +
>> +    do {
>> +        uv_list_secrets((u8 *)list, start_idx, &list_rc, NULL);
>> +        if (!(list_rc == UVC_RC_EXECUTED || list_rc == UVC_RC_MORE_DATA)) {
> 
> Inverting this conditional would get rid of 3 characters.
> Did you chose to implement it like this on purpose?
> 
No special purpose behind that. In fact, I prefer your shorter variant.
Thanks, I'll change that.

>> +            if (list_rc == UVC_RC_INV_CMD)
>> +                return -ENODEV;
>> +            else
>> +                return -EIO;
>> +        }
>> +        ret = find_secret_in_page(secret_id, list, secret);
>> +        if (ret == 0)
>> +            return ret;
>> +        start_idx = list->next_secret_idx;
>> +    } while (list_rc == UVC_RC_MORE_DATA && start_idx < list->next_secret_idx);
>> +
>> +    return -ENOENT;
> 
> 

Steffen
