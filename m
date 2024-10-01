Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19C1C7B77;
	Tue,  1 Oct 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798816; cv=none; b=nNuAJvzaQ6KcSk8qnI/BGxat7Urnnnhej1UDWwvSXtq75zFBeRkBJGB/Epw63ybsQQ8dwt9hnMQgtTlv+S8/MsW/+yC6mnE7h+DmPp/176mnSVa0WROmYylSHXFUDImT6NxHgP+HURAbYB20iWdHm9o/rxsjuBSDfHUaE6fOjww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798816; c=relaxed/simple;
	bh=Owb2st34qU30uEYqBBvmUSTgERBwNvNTZdQ89+R7C6I=;
	h=Content-Type:Date:Message-Id:From:Cc:To:Subject:Mime-Version:
	 References:In-Reply-To; b=Dn/5ogwX/g4+PctEaaRv4VuOzIHfgjLQmx20sLqCy0fSqf7Sp2tK69F7eb51JznfIBzdEVMycHD51IjCDd0yON6GQJjAu9bEg9K6Y4ZoCKPbIfsuh40S55DG8WD7TBU5UQCZip/Hv0i5mK+b4RC2Wfj/fLVtUlDl3KNlxG8dZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bguBwbfm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bguBwbfm"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491Fq6I4019604;
	Tue, 1 Oct 2024 16:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:message-id:from:cc:to:subject:mime-version
	:content-transfer-encoding:references:in-reply-to; s=pp1; bh=+yy
	rFsfQzmRiRkarFD2u2BJTy3A7gGzoX6HKLLiQHQw=; b=bguBwbfmuo1slrrNWoY
	IDNUQlgEHmexAPgmlRF1DYyTjNk6uMNDheOg88/CRzqf80o7V5xSbR9m6Vc/5hIa
	Jiq/lbJW1sy7pjT9OUPJOlkTsQVSL2HF6rHmGD5fdZm30i2a0e6KiouXOn1MQSfm
	R525thW++UTme5wcovl1dWPxdatqIcKVxDZrrlMd0fVvQsyYKMZOLx0OUQNNSCh4
	w4dh31z/SY+cPd3zMVwI8lD4xl4HWd0pC9gxuy1qnIDRckIANiQ7Nx6PCNV3CZrM
	THmjpFBXhO5Vho1rWQDQsnj1ImOSS6terZjuwBFfAtqcuq3mGaQ+nkS7ZX4YPBVj
	+SA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420m3br202-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 16:06:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491FXQln017905;
	Tue, 1 Oct 2024 16:06:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mwd3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 16:06:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491G6keT51970318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 16:06:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F8882004B;
	Tue,  1 Oct 2024 16:06:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E17620040;
	Tue,  1 Oct 2024 16:06:46 +0000 (GMT)
Received: from darkmoore (unknown [9.171.30.50])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 16:06:46 +0000 (GMT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Oct 2024 18:06:40 +0200
Message-Id: <D4KLK3E4C9HH.3W2N6GXGMR4OY@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Ingo Franzki" <ifranzki@linux.ibm.com>,
        "Harald Freudenberger"
 <freude@linux.ibm.com>,
        "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio
 Imbrenda" <imbrenda@linux.ibm.com>
To: "Steffen Eiden" <seiden@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v1 2/6] s390/uv: Retrieve UV secrets support
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.18.2
References: <20240930131909.2079965-1-seiden@linux.ibm.com>
 <20240930131909.2079965-3-seiden@linux.ibm.com>
In-Reply-To: <20240930131909.2079965-3-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S_05ZgEsqdXCOnfQZ56uRGnUOFQaef69
X-Proofpoint-ORIG-GUID: S_05ZgEsqdXCOnfQZ56uRGnUOFQaef69
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1011
 phishscore=0 adultscore=0 mlxlogscore=890 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010103

On Mon Sep 30, 2024 at 3:19 PM CEST, Steffen Eiden wrote:
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
>  arch/s390/include/asm/uv.h | 131 ++++++++++++++++++++++++++++++++++++-
>  arch/s390/kernel/uv.c      | 124 +++++++++++++++++++++++++++++++++++
>  2 files changed, 254 insertions(+), 1 deletion(-)

[...]

>  /* Bits in installed uv calls */
>  enum uv_cmds_inst {
> @@ -95,6 +96,7 @@ enum uv_cmds_inst {
>  	BIT_UVC_CMD_ADD_SECRET =3D 29,
>  	BIT_UVC_CMD_LIST_SECRETS =3D 30,
>  	BIT_UVC_CMD_LOCK_SECRETS =3D 31,

Is 32 skipped intentionally? Should there be a comment here that it is rese=
rved?

> +	BIT_UVC_CMD_RETR_SECRETS =3D 33,
>  };

[...]

> +/**
> + * uv_secret_list - UV secret-metadata list
> + * @num_secr_stored: Number of secrets stored in this list
> + * @total_num_secrets: Number of secrets stored in the UV for this guest
> + * @next_valid_idx: positive number if there are more secrets available =
or zero

s/next_valid_idx/next_secret_idx/

> + * @secrets: Up to 85 UV-secret metadata entries.
> + */
> +struct uv_secret_list {
> +	u16 num_secr_stored;
> +	u16 total_num_secrets;
> +	u16 next_secret_idx;
> +	u16 reserved_06;
> +	u64 reserved_08;
> +	struct uv_secret_list_item secrets[85];
> +} __packed __aligned(8);
> +static_assert(sizeof(struct uv_secret_list) =3D=3D PAGE_SIZE);
> +
>  static inline int __uv_call(unsigned long r1, unsigned long r2)
>  {
>  	int cc;
> @@ -383,6 +469,45 @@ static inline int uv_cmd_nodata(u64 handle, u16 cmd,=
 u16 *rc, u16 *rrc)
>  	return cc ? -EINVAL : 0;
>  }
> =20
> +/** uv_list_secrets() - Do a List Secrets UVC
> + *  @buf: Buffer to write list into; size of one page
> + *  @start_idx: The smallest index that should be included in the list.
> + *		For the fist invocation use 0.
> + *  @rc: Pointer to store the return code or NULL.
> + *  @rrc: Pointer to store the return reason code or NULL.
> + *
> + *  This function calls the List Secrets UVC. The result is written into=
 `buf`,
> + *  that needs to be at least one page of writable memory.
> + *  `buf` consists of:
> + *  * %struct uv_secret_list_hdr
> + *  * %struct uv_secret_list_item (multiple)
> + *
> + *  For `start_idx` use _0_ for the first call. If there are more secret=
s available
> + *  but could not fit into the page then `rc` is `UVC_RC_MORE_DATA`.
> + *  In this case use `uv_secret_list_hdr.next_valid_idx` for `start_idx`=
.

s/next_valid_idx/next_secret_idx/

> + *
> + *  Context: might sleep
> + *
> + *  Return: The UVC condition code
> + */
> +static inline int uv_list_secrets(u8 *buf, u16 start_idx, u16 *rc, u16 *=
rrc)
> +{
> +	struct uv_cb_list_secrets uvcb =3D {
> +		.header.len =3D sizeof(uvcb),
> +		.header.cmd =3D UVC_CMD_LIST_SECRETS,
> +		.start_idx =3D start_idx,
> +		.list_addr =3D (u64)buf,
> +	};
> +	int cc =3D uv_call_sched(0, (u64)&uvcb);
> +
> +	if (rc)
> +		*rc =3D uvcb.header.rc;
> +	if (rrc)
> +		*rrc =3D uvcb.header.rrc;
> +
> +	return cc;
> +}
> +
>  struct uv_info {
>  	unsigned long inst_calls_list[4];
>  	unsigned long uv_base_stor_len;
> @@ -469,6 +594,10 @@ static inline int uv_remove_shared(unsigned long add=
r)
>  	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
>  }
> =20
> +int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
> +			   struct uv_secret_list_item_hdr *secret);
> +int uv_retrieve_secret(u16 secret_idx, u8 *buf, size_t buf_size);
> +
>  extern int prot_virt_host;
> =20
>  static inline int is_prot_virt_host(void)
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index 36db065c7cf7..090246efc1fa 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -786,3 +786,127 @@ static int __init uv_info_init(void)
>  	return rc;
>  }
>  device_initcall(uv_info_init);
> +
> +/*
> + * Find the secret with the secret_id in the provided list.
> + *
> + * Context: might sleep
> + */

The method comment formatting is in general a bit inconsistent. Sometimes w=
ith,
sometimes without newlines / dots.

> +static int find_secret_in_page(const u8 secret_id[UV_SECRET_ID_LEN],
> +			       const struct uv_secret_list *list,
> +			       struct uv_secret_list_item_hdr *secret)
> +{
> +	u16 i;
> +
> +	for (i =3D 0; i < list->total_num_secrets; i++) {
> +		if (memcmp(secret_id, list->secrets[i].id, UV_SECRET_ID_LEN) =3D=3D 0)=
 {
> +			*secret =3D list->secrets[i].hdr;
> +			return 0;
> +		}
> +	}
> +	return -ENOENT;
> +}

[...]

> +/**
> + * uv_get_secret_metadata() - get secret metadata for a given secret id
> + * @secret_id: search pattern
> + * @secret: output data, containing the secret's metadata
> + *
> + * Search for a secret with the given secret_id in the Ultravisor secret=
 store.
> + *
> + * Context: might sleep
> + *
> + * Return:
> + * * %0:	- Found entry; secret_idx and secret type are valid

You mean secret->index and secret->type?

> + * * %ENOENT	- No entry found
> + * * %ENODEV:	- Not supported: UV not available or command not available
> + * * %EIO:	- Other unexpected UV error
> + */
> +int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
> +			   struct uv_secret_list_item_hdr *secret)
> +{
> +	struct uv_secret_list *buf;
> +	int rc;
> +
> +	buf =3D kzalloc(sizeof(*buf), GFP_KERNEL);
> +	rc =3D find_secret(secret_id, buf, secret);
> +	kfree(buf);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(uv_get_secret_metadata);

[...]
