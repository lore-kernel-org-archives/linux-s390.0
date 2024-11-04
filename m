Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB61B4F15;
	Mon,  4 Nov 2024 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722405; cv=none; b=NTntM5UmUJ6qzqCyO72twUuX+s8qAvrf8Lk36vCBpsNck4Ev1cmvDZOsbxUdEHEsojlW8bykw5W1zgnCDEjRo5hP/OH66Gm9p9IqP/H+iCqOc9sjCkJ20Rj6L9xETaCtVUrssMs3+15s7Usv75xk44DLG1xaE8WpbxoUZBTosUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722405; c=relaxed/simple;
	bh=c1+dZrjYSFCH7uQsyYckwZD/L6GG2H2kWKeJkEmFapA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nas7bqydaB/fvlrfaqhOBQIETwlQumr58iQjzy4IdA542x+4gZRNRionXlaADzEJPWvEEC59UXl3TGKFN0AJ9eRskfq+6JEuDTVjIMaXqgL54F9vYYYhygWF+zxTB+F7/uEP3pIEI/WorsohF0iHdvPeUOIryb5ETAL1HYna20E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kdalWzpO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kdalWzpO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BfskL012085;
	Mon, 4 Nov 2024 12:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xKXkot
	FI4sjSkLqsBcciFLFs+T5q9Lom7epCVHqTUf8=; b=kdalWzpOEqLRUzOP3ZDmGO
	7EFU7qnXjWKPwRnjq6h9QMfjtC4L9Tr9q2iiP85gUluE9qELZH+8Z+jsOWkezNF0
	YXrUMWiSojVFqsfBv8yN2nezjULjzM5/uEvKRW0q55525r6dNMO1FE8+6QHFgqNw
	kplX6wqkZ7t/Fkg0pJ3XpYtxhgXFXHeLPaJTl9wqOy/QyACeKtbnDRFZGv4cgD8N
	S43E7rDNeLU57cRG+baJsJ4JqsH0Ote+iad6dqJdsnRv80gBLBQXNNKrOi/smJhk
	omgdk0MDxV1XRF5hNJRVosGhuocvpLRxtGPAtuMMfcb5USVPI+/i382XsNN+oeiw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pwkg83vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 12:13:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BD7aI012237;
	Mon, 4 Nov 2024 12:13:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p140sxw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 12:13:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A4CDHfj30671578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 12:13:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3482120063;
	Mon,  4 Nov 2024 12:13:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9D8520043;
	Mon,  4 Nov 2024 12:13:16 +0000 (GMT)
Received: from [9.171.49.1] (unknown [9.171.49.1])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 12:13:16 +0000 (GMT)
Message-ID: <5bd1d878-69d0-4d27-9129-6fb8126ccb31@linux.ibm.com>
Date: Mon, 4 Nov 2024 13:13:16 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/uvdevice: Support longer secret lists
To: Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, borntraeger@linux.ibm.com
References: <20241031093541.1641849-1-seiden@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20241031093541.1641849-1-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Fl6xkvTP2rwac-ftxcpgEA9kmfHyQdOw
X-Proofpoint-GUID: Fl6xkvTP2rwac-ftxcpgEA9kmfHyQdOw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040106

On 10/31/24 10:35 AM, Steffen Eiden wrote:
> Enable the list IOCTL to provide lists longer than on page (85 entries).

s/on/one/

> The list IOCTL accepts argument length up to 8 pages in page granularity
> and will fill the argument up to this length with entries until the list
> ends. User space unaware of this enhancement will still receive one page
> of data and an uv_rc 0x0100.

Once the length check is fixed I'll be happy with this patch.

> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
> Reworked the whole list-creation loop. Hardened+simplified the implementation.
> Now, only the actual data filled by the CP is copied to userspace.
> 
>   arch/s390/include/uapi/asm/uvdevice.h |  1 +
>   drivers/s390/char/uvdevice.c          | 72 ++++++++++++++++++++-------
>   2 files changed, 54 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/s390/include/uapi/asm/uvdevice.h b/arch/s390/include/uapi/asm/uvdevice.h
> index 4947f26ad9fb..c584250d4a35 100644
> --- a/arch/s390/include/uapi/asm/uvdevice.h
> +++ b/arch/s390/include/uapi/asm/uvdevice.h
> @@ -71,6 +71,7 @@ struct uvio_uvdev_info {
>   #define UVIO_ATT_ADDITIONAL_MAX_LEN	0x8000
>   #define UVIO_ADD_SECRET_MAX_LEN		0x100000
>   #define UVIO_LIST_SECRETS_LEN		0x1000
> +#define UVIO_LIST_SECRETS_MAX_LEN	0x8000

Since we're only ever allocating a page in the kernel it doesn't really 
make sense to arbitrarily limit this IMHO.

A check for 0 and page alignment should be enough.

>   #define UVIO_RETR_SECRET_MAX_LEN	0x2000
>   
>   #define UVIO_DEVICE_NAME "uv"
> diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
> index 1f90976293e8..667d573e54b0 100644
> --- a/drivers/s390/char/uvdevice.c
> +++ b/drivers/s390/char/uvdevice.c
> @@ -297,6 +297,43 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
>   	return ret;
>   }
>   
> +/*
> + * Do the actual secret list creation. Calls the list-UVC until there is no more

list secrets UVC

> + * space in the user buffer, or the list ends.
> + */
> +static int uvio_get_list(void *zpage, struct uvio_ioctl_cb *uv_ioctl)
> +{
> +	const size_t data_off = offsetof(struct uv_secret_list, secrets);
> +	u8 __user *user_buf = (u8 __user *)uv_ioctl->argument_addr;
> +	struct uv_secret_list *list = zpage;
> +	u16 num_secrets_stored = 0;
> +	size_t user_off = data_off;
> +	size_t copy_len;
> +
> +	do {
> +		uv_list_secrets(list, list->next_secret_idx, &uv_ioctl->uv_rc,
> +				&uv_ioctl->uv_rrc);
> +		if (uv_ioctl->uv_rc != UVC_RC_EXECUTED &&
> +		    uv_ioctl->uv_rc != UVC_RC_MORE_DATA)
> +			break;
> +
> +		copy_len = sizeof(list->secrets[0]) * list->num_secr_stored;
> +		WARN_ON(copy_len > sizeof(list->secrets));
> +
> +		if (copy_to_user(user_buf + user_off, list->secrets, copy_len))
> +			return -EFAULT;
> +
> +		user_off += copy_len;
> +		num_secrets_stored += list->num_secr_stored;
> +	} while (uv_ioctl->uv_rc == UVC_RC_MORE_DATA &&
> +		 user_off + sizeof(*list) <= uv_ioctl->argument_len);
> +
> +	list->num_secr_stored = num_secrets_stored;
> +	if (copy_to_user(user_buf, list, data_off))
> +		return -EFAULT;
> +	return 0;
> +}
> +
>   /** uvio_list_secrets() - perform a List Secret UVC
>    * @uv_ioctl: ioctl control block
>    *
> @@ -308,6 +345,12 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
>    *
>    * The argument specifies the location for the result of the UV-Call.
>    *
> + * Argument len must be a multiple of a page; 1-8 pages allowed.

Fix comment when adjusting len check.

> + * The list secrets IOCTL will call the list UVC multiple times and fill
> + * the provided user-buffer with list elements until either the list ends or
> + * the buffer is full. The list header is merged over all list header from the
> + * individual UVCs.
> + *


