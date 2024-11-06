Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D551922EF;
	Wed,  6 Nov 2024 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883287; cv=none; b=cYi49QRVtYl3w7Z2aYzrsnT5FJG9UADdpe2hhYnPqDNTUCu765XGADWBNGU0mBWlqfG3sPeFd6yRhn251n6E2yRmpIFtQW1DSemBM6E0m79SJGJPZg+y3e359t2snWCc+lJbX2LF/wxUUQ9Cc8shvO7fLPQmzamHA/39tycRKoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883287; c=relaxed/simple;
	bh=sqSd93rmDbn8W6wxgo6v2bpwue+1Hnq4A9JjctkB24U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdnQuyQH601Y/6l8xFCHQvY1ddRCVtGYTzX5v6HBIyEySv9XA9fLvXHvEOdll5q+Yrng9twKtOjlXjHwfR20stDCtna4CuRN72Hwjr3tr7jiGxC7gE88R85zaYzjBdhX/oF7lIKbLJB2iLd+rFgs+i3KNhcLrkHV9CaWpM5etDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ojxsdQNk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ojxsdQNk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A68elQQ003692;
	Wed, 6 Nov 2024 08:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gjieog
	9CXQsydB5JwgTyVj+b7ANqha4EmKC/kzAqM/A=; b=ojxsdQNkL54QFvqG1CM7D/
	pUmGP4ndKK3rChLd+9V8NXpyVmSnuQOayAdatvJ6ByUo0v8atN0rMbjyLpSWheP5
	39O2MtfYLgnLI7muE/vkDm8H8J31xK+tj9ojfng7NLKjlUQ5T/jcPTMN9xlFLKnH
	PVhanTE9FT/tbLOEeYx+kNcG2akkwS5NB0f8qwv4/FfbUYvAZcoKbCuNi3M6RMoB
	Bz2Fofm259XGA9RezNzwEfm8TE6noeLnwUtto7H7mYTm3nK94ihuQ1UIyUegXy+A
	9t9NOPNhVjgieSx8pl7lkXgnc536F03QZ9jRwcacf6lpyvhc1We2pk/EWbcGzNYQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r55fg1mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 08:54:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A68Pirx024174;
	Wed, 6 Nov 2024 08:54:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsyhrrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 08:54:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A68sYJU56230232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 08:54:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48E7920043;
	Wed,  6 Nov 2024 08:54:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCD0E20040;
	Wed,  6 Nov 2024 08:54:33 +0000 (GMT)
Received: from [9.171.91.81] (unknown [9.171.91.81])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Nov 2024 08:54:33 +0000 (GMT)
Message-ID: <a74cfc12-f404-47ca-85a8-164da22bdbfc@linux.ibm.com>
Date: Wed, 6 Nov 2024 09:54:33 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] s390/uvdevice: Support longer secret lists
To: Heiko Carstens <hca@linux.ibm.com>, Steffen Eiden <seiden@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, borntraeger@linux.ibm.com
References: <20241104153609.1361388-1-seiden@linux.ibm.com>
 <20241106081004.16507-A-hca@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20241106081004.16507-A-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NjZUrZ1piqleZ00nw_oMzMh4kTQ0e-6t
X-Proofpoint-GUID: NjZUrZ1piqleZ00nw_oMzMh4kTQ0e-6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=769 adultscore=0
 mlxscore=0 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411060069

On 11/6/24 9:10 AM, Heiko Carstens wrote:
> On Mon, Nov 04, 2024 at 04:36:09PM +0100, Steffen Eiden wrote:
>> Enable the list IOCTL to provide lists longer than one page (85 entries).
>> The list IOCTL now accepts any argument length in page granularity.
>> It fills the argument up to this length with entries until the list
>> ends. User space unaware of this enhancement will still receive one page
>> of data and an uv_rc 0x0100.
>>
>> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
>> ---
>>   v3: remove upper boundary (8 pages) for arg len
> 
> ...
> 
>> +static int uvio_get_list(void *zpage, struct uvio_ioctl_cb *uv_ioctl)
>> +{
>> +	const size_t data_off = offsetof(struct uv_secret_list, secrets);
>> +	u8 __user *user_buf = (u8 __user *)uv_ioctl->argument_addr;
>> +	struct uv_secret_list *list = zpage;
>> +	u16 num_secrets_stored = 0;
>> +	size_t user_off = data_off;
>> +	size_t copy_len;
>> +
>> +	do {
>> +		uv_list_secrets(list, list->next_secret_idx, &uv_ioctl->uv_rc,
>> +				&uv_ioctl->uv_rrc);
>> +		if (uv_ioctl->uv_rc != UVC_RC_EXECUTED &&
>> +		    uv_ioctl->uv_rc != UVC_RC_MORE_DATA)
>> +			break;
>> +
>> +		copy_len = sizeof(list->secrets[0]) * list->num_secr_stored;
>> +		WARN_ON(copy_len > sizeof(list->secrets));
> 
> Is this really possible? Without checking the documentation I guess
> this is not possible and therefore the WARN_ON() should be removed.
> 

This happening requires a FW error, no?
list->num_secr_stored is reported by FW and would need to be >85.

We could clamp it down to 85 secrets / 4k - sizeof(header) with a 
WARN_ON_ONCE() to catch FW problems if that suits you more.
