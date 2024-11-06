Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E947919148A;
	Wed,  6 Nov 2024 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880613; cv=none; b=qio0pvkAbXdsxbJxjWFszaJoWVmywKlBG3VUbMOJE0BzpCebsmGJf/MSltbYY6yBoz08Tlkg1KmLZMuKl9XrvljGAiG/HxATZqoWW/l+B6IGO7OaaQuB6KWbMmqEFLKHNDQSwCZh8dl2VwvrowZxZ+HU2JkJNIC/ZWX70vDrFKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880613; c=relaxed/simple;
	bh=sXgglb6RJyFZT6poiRwu0692++EFfo0EZU7SsQpBdJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzlmDJ6KyQklPqFadgmK4RS1kLpVXLnIjVhMX4Xy0nCRsZLDDWtgMwrayxTBAuQu5E6BW5GGiIo1C12+Kvowe01S/5E/ecSEsW7AbJuRIIMy3G6e1N1+gOCh/siODhAvOo03g5bX2TV4hBGUBhzIBE8PGY5qsPTz0XXpzn+QkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dVblc/Ss; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dVblc/Ss"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A66eZBE028055;
	Wed, 6 Nov 2024 08:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vnyKGLlOrMBKv5a70pXeBruA9QrK89
	THd5y5r0X5kqQ=; b=dVblc/Ssb1RyhbcTY/pEi7FNM24+SiFyf++5bKy7qVZ6k6
	JSxb3/qmORQ7lH7mbsgTXLM1JDPqXgxe/XJSGnqlCXVt6qYBfp8Xz5WRDuEniS2V
	7T6+7T/HdqBLb/QiL0CC75GU6Tbn4GeXAsmASa5cgULDVtBfFLH28ufTaBVTRpxh
	Q1u7mUUbgfVA/RRrJijALb+Ee3UW0yh2z+RRpf9t/neamYAbelCwlne0Zup2vTBK
	5UzHr9jPvXtEnQkam4lhu975Zxkhvrdwc37ac7nk1SSZNvRpkXeINAnOhNCUgun6
	8FG96/g9w/n1VfH8UuuG+jf++OiChBcHNAyVi6gw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r3d2re9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 08:10:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A65vAob019096;
	Wed, 6 Nov 2024 08:10:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj5p9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 08:10:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A68A6PK39649538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 08:10:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C84B2004B;
	Wed,  6 Nov 2024 08:10:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A6ED20043;
	Wed,  6 Nov 2024 08:10:05 +0000 (GMT)
Received: from osiris (unknown [9.171.89.178])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Nov 2024 08:10:05 +0000 (GMT)
Date: Wed, 6 Nov 2024 09:10:04 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, borntraeger@linux.ibm.com
Subject: Re: [PATCH v3] s390/uvdevice: Support longer secret lists
Message-ID: <20241106081004.16507-A-hca@linux.ibm.com>
References: <20241104153609.1361388-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104153609.1361388-1-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QH-RRJU5xP0YMUELHZLowN6Pc13qQZtt
X-Proofpoint-ORIG-GUID: QH-RRJU5xP0YMUELHZLowN6Pc13qQZtt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=431 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060065

On Mon, Nov 04, 2024 at 04:36:09PM +0100, Steffen Eiden wrote:
> Enable the list IOCTL to provide lists longer than one page (85 entries).
> The list IOCTL now accepts any argument length in page granularity.
> It fills the argument up to this length with entries until the list
> ends. User space unaware of this enhancement will still receive one page
> of data and an uv_rc 0x0100.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  v3: remove upper boundary (8 pages) for arg len

...

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

Is this really possible? Without checking the documentation I guess
this is not possible and therefore the WARN_ON() should be removed.

If however this can be possible then this should be turned into a
WARN_ON_ONCE().

> +		if (copy_to_user(user_buf + user_off, list->secrets, copy_len))
> +			return -EFAULT;

...and in addition, if the above would be possible this _could_ copy
random kernel data to user space. Not good.
