Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912401DE3AE;
	Tue,  8 Oct 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398918; cv=none; b=rF6BODsSMHp89H0riljjHUSj2x8oMou018Luk0+rjLkdETSXW2ruNvh3e32YU0nuuhqy+ALyfHHrqK3MlalQcvioUWVVQz7MJy7ZKLDDjtM9xTSC0sAmHWPPQRebeYgDQKJfcwzO7EvE8KNQ7YxONbQleEY4tkS/Gq+yvDyx9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398918; c=relaxed/simple;
	bh=gGZ6Vb61qjdJyh4oVLCrujuvkdwo6WX8w8jrKPNwQes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukkWiqlKC2K5i/RLUibZ71DyT0oRkwvls4WXJM+C0mtu8KcQe1Jtt8Rx48uXGGEXDDXdFev2QAYR6ag83or3smi74nx4iWr6o/oZEntgM2YHOkpGZYqbOCMi6TccuquZAQMpSoB8pVMeE6ZSlaMfxIU86SUxjLO1rqaWj852edQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=onF5MiW7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="onF5MiW7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Dqjwa015046;
	Tue, 8 Oct 2024 14:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=AHl+fOLyKmYjQuOAG3UEVwrg0kq
	YhPu35IKeKKI6WxE=; b=onF5MiW72okBcAW+ngG6ZOzb1eDRTe0dwE7UTa5PKCY
	rI/ed0ZhIxMpOaQQ/y/U/ENNjRrs8ZsRXKliGhkO1AlJhZ6Ji5OHuhI4MMYZRybd
	dGARYSjSvewzvOhjzV78G32Qff9DgvTXI7GTtaptwW3G2QCZxKChQv6amop9Utjx
	pagymBGVBZDCt0kW5icc0Rc0AegIgrX5r2KN488vNDpEziFwkUFLAZ2HyRpnkU2l
	T6y9tcZsc84YIm5SEfCXP4DUNPOzXqgp0FdX8oJh6chEV9MNPcqD7RMl+HuGksrx
	q7wgwEzm0dwJ4pwABjMDJIMYWyN51+DytRlWKoDeKHw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4255yvrat6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 14:48:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498DK4Gk022671;
	Tue, 8 Oct 2024 14:48:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423h9jvrgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 14:48:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 498EmSDu22479258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 14:48:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 203432004D;
	Tue,  8 Oct 2024 14:48:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEA0B20043;
	Tue,  8 Oct 2024 14:48:27 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Oct 2024 14:48:27 +0000 (GMT)
Date: Tue, 8 Oct 2024 16:48:26 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2 5/6] s390/uvdevice: Add List Secrets Ext IOCTL
Message-ID: <20241008144826.27223-D-hca@linux.ibm.com>
References: <20241002160532.2425734-1-seiden@linux.ibm.com>
 <20241002160532.2425734-6-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002160532.2425734-6-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q9tpJWYyVjniKic_mByzII9qB-ppF7X_
X-Proofpoint-ORIG-GUID: Q9tpJWYyVjniKic_mByzII9qB-ppF7X_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_12,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=498 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080092

On Wed, Oct 02, 2024 at 06:05:31PM +0200, Steffen Eiden wrote:
> Add an extended List Secrets IOCTL. In contrast to the first list IOCTL
> this accepts an index as the first two bytes of the provided page as an
> input. This index is then taken as the index offset for the list UVC to
> receive later entries for the list.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/include/uapi/asm/uvdevice.h |  4 ++
>  drivers/s390/char/uvdevice.c          | 96 ++++++++++++++++++++-------
>  2 files changed, 75 insertions(+), 25 deletions(-)

...

> +/* The actual list(_ext) IOCTL.
> + * If list_ext is true, the first two bytes of the user buffer set the starting index of the
> + * list-UVC
> + */

This is not standard kernel comment style; there is no need for a line
with more than >80 characters here; and in this case it would be nice
to add a "." at the end of the sentence :)

> +static int list_secrets(struct uvio_ioctl_cb *uv_ioctl, bool list_ext)
> +{
> +	void __user *user_buf_arg = (void __user *)uv_ioctl->argument_addr;
> +	u16 __user *user_index = (u16 __user *)uv_ioctl->argument_addr;
> +	u8 *secrets = NULL;

No need to preinitialize.

> +	u16 start_idx = 0;
> +	int ret;
> +
> +	if (uv_ioctl->argument_len != UVIO_LIST_SECRETS_LEN)
> +		return -EINVAL;
> +
> +	BUILD_BUG_ON(UVIO_LIST_SECRETS_LEN != PAGE_SIZE);
> +	secrets = (u8 *)get_zeroed_page(GFP_KERNEL);
> +	if (!secrets)
> +		return -ENOMEM;
> +
> +	/* The extended call accepts an u16 index as input */
> +	ret = -EFAULT;
> +	if (list_ext) {
> +		if (get_user(start_idx, user_index))
> +			goto err;
> +	}
> +
> +	uv_list_secrets(secrets, start_idx, &uv_ioctl->uv_rc, &uv_ioctl->uv_rrc);
> +
> +	if (copy_to_user(user_buf_arg, secrets, UVIO_LIST_SECRETS_LEN))
> +		goto err;
> +	ret = 0;
> +
> +err:
> +	free_pages((unsigned long)secrets, 0);
> +	return ret;
> +}

If you would change the order of the code a bit, it would be possible
to write this shorter:

	int ret = 0;
	...
	if (list_ext && get_user(start_idx, user_index))
		return -EFAULT;
	secrets = (u8 *)get_zeroed_page(GFP_KERNEL);
	if (!secrets)
		return -ENOMEM;
	uv_list_secrets(secrets, start_idx, &uv_ioctl->uv_rc, &uv_ioctl->uv_rrc);
	if (copy_to_user(user_buf_arg, secrets, UVIO_LIST_SECRETS_LEN))
		ret = -EFAULT;
	free_page((unsigned long)secrets);
	return ret;

> +/** uvio_list_secrets_ext() - perform a List Secret UVC with a starting index
> + * @uv_ioctl: ioctl control block

This is not kernel doc style.

Anyway, just my 0.02.
