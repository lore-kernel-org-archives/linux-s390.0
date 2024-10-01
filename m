Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49361CB339;
	Tue,  1 Oct 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799604; cv=none; b=ZgCHtCaldVp0/tIlmo6UExCB9E4X3t/FExRGnrbgCWtgHocIBhvNorv7bXbkRL5jGnM8ZaZxDlkEGrurh/Jefw/I852Oh3Gk3DK05XLF0eRLpeLmHG9eQejIQESuTPxVg32KcZ5vZpBfru7lLSDdiwK/z2+61n+YlrxwZz2l2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799604; c=relaxed/simple;
	bh=guDjXhdBFwrItrIxNPx2IN7uUqlKR5v/xqg2PEwLuT0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=uY4dKvwrBiMZx0eiZi7DQomc5sWjIOAwzndD+bYSkR098eHHFU5kKB6puTcwha5OKhP6CFjN+9+K5uAn+fxpFl562nd6rtOsUIUYfHZJ7mtMDJLiPaqnkqzrlr8mz7iuNuJItMl0pASGqcXXnu5858UH42c/vFst6ItMl94rCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HF9Uazie; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HF9Uazie"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491Et2mP008773;
	Tue, 1 Oct 2024 16:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:from:cc:to:subject:references:in-reply-to; s=pp1;
	 bh=S7xiCSmZ8Vlg0fk38XWweYgmP+1e29O0s5PXt7lVJdU=; b=HF9UazietIi8
	wEtauY8M3np4EgLNKn4VhHt15+QIVw6GowhMDZrtdKLijaHmMSRG3y4SQl5WhpPr
	zMaMVmYzXq5/BoMHLX6kjKKsnuBfE9mbih4kumgD6V1oPg5fLTBtRF1OSWLmLCNU
	qdk1iYyRI8cRMCOd1dvjPwCP6fBNHb19pSZ75fmR2GHNhBWbmzJdyyMz2jY9T5yi
	EBj8b+2Xvmll5LXnTgY+jCCISwz3j1nqKFDMTaG27Rt/xEBN9f/KcpexaHvT/vll
	khd1mX2dWvEXKMcDA9vh9t3J7FzucUw8c6ZitwajaokbjXlo3FWY8FsQFjkKz5Ah
	eUD8abCVTw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420k8s0f4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 16:20:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491EoUQL020424;
	Tue, 1 Oct 2024 16:19:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xv4s5nk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 16:19:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491GJud555509288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 16:19:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2111920043;
	Tue,  1 Oct 2024 16:19:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEBD820040;
	Tue,  1 Oct 2024 16:19:55 +0000 (GMT)
Received: from darkmoore (unknown [9.171.30.50])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 16:19:55 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Oct 2024 18:19:50 +0200
Message-Id: <D4KLU6A3D449.1P07EI9XL7IY2@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Ingo Franzki" <ifranzki@linux.ibm.com>,
        "Harald Freudenberger"
 <freude@linux.ibm.com>,
        "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio
 Imbrenda" <imbrenda@linux.ibm.com>
To: "Steffen Eiden" <seiden@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v1 5/6] s390/uvdevice: Add List Secrets Ext IOCTL
X-Mailer: aerc 0.18.2
References: <20240930131909.2079965-1-seiden@linux.ibm.com>
 <20240930131909.2079965-6-seiden@linux.ibm.com>
In-Reply-To: <20240930131909.2079965-6-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p2uBNTBPwJInNQl44cVCiXnrctEQCdAW
X-Proofpoint-ORIG-GUID: p2uBNTBPwJInNQl44cVCiXnrctEQCdAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_13,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 mlxlogscore=720 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010105

On Mon Sep 30, 2024 at 3:19 PM CEST, Steffen Eiden wrote:
> Add an extended List Secrets IOCTL. In contrast to the first list IOCTL
> this accepts an index as the first two bytes of the provided page as an
> input. This index is then taken as the index offset for the list UVC to
> receive later entries for the list.
>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

[...]

> +/* The actual list(_ext) IOCTL.
> + * If list_ext is true, the first two bytes of the user buffer set the s=
tarting index of the
> + * list-UVC
> + */
> +static int list_secrets(struct uvio_ioctl_cb *uv_ioctl, bool list_ext)
> +{
> +	void __user *user_buf_arg =3D (void __user *)uv_ioctl->argument_addr;
> +	u16 __user *user_index =3D (u16 __user *)uv_ioctl->argument_addr;
> +	u16 start_idx =3D 0;
> +	u8 *secrets =3D NULL;
> +	int ret;

nit: These can be reordered to reverse xmas tree.

> +
> +	if (uv_ioctl->argument_len !=3D UVIO_LIST_SECRETS_LEN)
> +		return -EINVAL;
> +
> +	BUILD_BUG_ON(UVIO_LIST_SECRETS_LEN !=3D PAGE_SIZE);
> +	secrets =3D (u8 *)get_zeroed_page(GFP_KERNEL);
> +	if (!secrets)
> +		return -ENOMEM;
> +
> +	// The extended call accepts an u16 index as input

Comments should use /* */

> +	ret =3D -EFAULT;
> +	if (list_ext) {
> +		if (get_user(start_idx, user_index))
> +			goto err;
> +	}
> +
> +	uv_list_secrets(secrets, start_idx, &uv_ioctl->uv_rc, &uv_ioctl->uv_rrc=
);
> +
> +	if (copy_to_user(user_buf_arg, secrets, UVIO_LIST_SECRETS_LEN))
> +		goto err;
> +	ret =3D 0;
> +
> +err:
> +	free_pages((unsigned long)secrets, 0);
> +	return ret;
> +}

[...]
