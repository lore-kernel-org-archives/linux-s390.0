Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95C1CBE96;
	Tue,  1 Oct 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804545; cv=none; b=tk9Z6f4FdFX4Orht93XOsIgCZivWVUqBX9XPRpfs/ZL0ip83+5ABBMN/NbnL/o1ypTFs10BtCFxOgtMXFz4se6d9k+AFPyoy/BBge4LapUiJpAv+NKEg/zErVtxrX+HWamOJGk3Oa5lKUgitY1IsDoOuSvDimtEnhNarSs6Fxxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804545; c=relaxed/simple;
	bh=vctXxkLS+HH34UW9EYNVyXpSA8qwioVlPTmyir0WYdw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=SBdx28d7ivc0THoPDSYn+F6Ak72YyWHR6jGcO5L2/oD7/por+if0NRJA5l3zGSLtTWjrcGAR2rLvDIgVDKG0RIgqp68JQe+ajscX9T6lWPq8CFmIn3NujUpGFCnLFVnC5NdVEX3ykIm+IwEYDI9ewtbMRyc8RFGF6xu2cVKvrE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JZA+yKiH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JZA+yKiH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491GJd3u010581;
	Tue, 1 Oct 2024 17:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:from:cc:to:subject:references:in-reply-to; s=pp1;
	 bh=I7snKSV/pU1SnO1lQrZr0Df8fLkbV4uiwmbqJUqCKH8=; b=JZA+yKiHo2zo
	4VLc2BMMFhpfCYPkUWWs6/7R8eo0NJaQtxknyfWKXII0SQGA7NArAaK7i3qL+D3E
	RAt9i6g9dZ9fIjNE3opdKP5j6jzEHtoC2tUTUq+3iPQQyaSvwoLtkATzFeXFhY8B
	bmrAYPCTlIGH6W7fqtb57vjMOaEYtc8+F54rO90/sDci44yvcK1AIoVbTBX16XYB
	AsDpiwNclX4ERSXsBMf16OMYrcGtTblr9NGi9F48C/7L4hrZYoKNsOCTvkTmVPdn
	86vP8x/R+zlmSzh8gBlpO1Fs73/WaB6cT6dNw6FFcHPm4tFXtcv9LGvbk4MJ18Ik
	POl4UkZ66w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420m3brgkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 17:42:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491GbY80002767;
	Tue, 1 Oct 2024 17:42:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxu15g4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 17:42:20 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491HgGaH15204840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 17:42:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA33620043;
	Tue,  1 Oct 2024 17:42:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A93B920040;
	Tue,  1 Oct 2024 17:42:16 +0000 (GMT)
Received: from darkmoore (unknown [9.171.30.50])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 17:42:16 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Oct 2024 19:42:11 +0200
Message-Id: <D4KNL7YPNFYD.2FD1QX5DFT8H8@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Ingo Franzki" <ifranzki@linux.ibm.com>,
        "Harald Freudenberger"
 <freude@linux.ibm.com>,
        "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio
 Imbrenda" <imbrenda@linux.ibm.com>
To: "Steffen Eiden" <seiden@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v1 6/6] s390/uv: Retrieve UV secrets sysfs support
X-Mailer: aerc 0.18.2
References: <20240930131909.2079965-1-seiden@linux.ibm.com>
 <20240930131909.2079965-7-seiden@linux.ibm.com>
In-Reply-To: <20240930131909.2079965-7-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oQPISa71GeXMbjm-H9Fw8l2Lb1RfjNS1
X-Proofpoint-ORIG-GUID: oQPISa71GeXMbjm-H9Fw8l2Lb1RfjNS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_13,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 mlxlogscore=705 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010113

On Mon Sep 30, 2024 at 3:19 PM CEST, Steffen Eiden wrote:
> Reflect the updated content in the query information UVC to the sysfs at
> /sys/firmware/query
>
> * new UV-query sysfs entry for the maximum number of retrievable
>   secrets the UV can store for one secure guest.
> * new UV-query sysfs entry for the maximum number of association
>   secrets the UV can store for one secure guest.
> * max_secrets contains the sum of max association and max retrievable
>   secrets.
>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/boot/uv.c        |  3 ++-
>  arch/s390/include/asm/uv.h |  8 +++++---
>  arch/s390/kernel/uv.c      | 24 +++++++++++++++++++++++-
>  3 files changed, 30 insertions(+), 5 deletions(-)

[...]

> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 6838aa23e4e5..91631bea22d8 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -144,8 +144,9 @@ struct uv_cb_qui {
>  	u64 supp_add_secret_req_ver;		/* 0x00f8 */
>  	u64 supp_add_secret_pcf;		/* 0x0100 */
>  	u64 supp_secret_types;			/* 0x0180 */

This is not part of your patch, but maybe you can correct this with this
adjacent edit.
supp_secret_types is located at 0x0108.

> -	u16 max_secrets;			/* 0x0110 */
> -	u8 reserved112[0x120 - 0x112];		/* 0x0112 */
> +	u16 max_assoc_secrets;			/* 0x0110 */
> +	u16 max_retr_secrets;			/* 0x0112 */
> +	u8 reserved114[0x120 - 0x114];		/* 0x0114 */
>  } __packed __aligned(8);

[...]
