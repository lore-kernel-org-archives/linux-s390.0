Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88295187323;
	Mon, 17 Jun 2024 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608354; cv=none; b=K/cQaX1UCR1+mCxqhXKBo/hsSjX1ciq2XlQIgc9MonRTo0fDcuFCosEhmEwSv98k/OOGZYY5jW4gE9aBAT7c/ewX8GpKrJMADUqQBZTjHmAnofluNsF6AbdCYb3I1b9hIp93j9zj1xQZx6e3takZHaM5zNj7ZojOp2iEUU9mxhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608354; c=relaxed/simple;
	bh=1Pdnnsv+4H1+xRQ2MXTH98SvbrTizrijzJdjQnW5Ky0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N81fB3onPMNaXcBuHadph7haYUHNxd6PKxNF1xPLTo41v2hapknrhnuCNVcTNl8TlS8qFsC0a2lpO5Yaw/xBHA56rUJ6LEZkJUezSu7KT0TTwvBYZJlGaoM/WHtEEJwoAz6wM+q7mQgP4w55IBtwJghMT5jUggVzZfMZxno4kD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nn8GgdUg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nn8GgdUg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H4tQ2l007779;
	Mon, 17 Jun 2024 07:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	UCRJ3eftxXrLEbwyiW6PUEFcv4Vib2NF/RTrMnRowWY=; b=Nn8GgdUgOPVmYJ7v
	l2GAKMWjc3E0MmZ2Q3GchDxxuEmW8v0PZ3wf1O9g/aZY5zNy0JPi7lKcEVRwjqQX
	C/H+J6MPpE2T7VMRE5Hz3D0QPah8v3gcbW/aG/zT7944b45qMagzOgs8XYlQsaoZ
	3QlIzy8mRtwuYlG8Ratlgp8BkTlzITZ/h5D2EpubLKXVW9ZXrsluIDVIiptLjq/h
	+wtKpHSftQBIupdU7Djz3OXCQWtBock4tpM2bXG8046URepJRIhzPb3gHc9nuOBv
	X7k1sdK8zztNdzYhnsmwJ5ZZciPRa0Y1mgUjcQG0RdtbW/Vyzo4R9iPct5q8iNH+
	/41mhg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytcu6rdur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 07:12:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45H6o8Hx006227;
	Mon, 17 Jun 2024 07:12:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysn9u821c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 07:12:27 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45H7CM4Y42533318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 07:12:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23D3720043;
	Mon, 17 Jun 2024 07:12:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A97C52004B;
	Mon, 17 Jun 2024 07:12:21 +0000 (GMT)
Received: from [9.171.86.232] (unknown [9.171.86.232])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Jun 2024 07:12:21 +0000 (GMT)
Message-ID: <8357ad99-4627-4084-a000-9208f7c6c18a@linux.ibm.com>
Date: Mon, 17 Jun 2024 09:12:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/lcs: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20240615-md-s390-drivers-s390-net-v1-1-968cb735f70d@quicinc.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240615-md-s390-drivers-s390-net-v1-1-968cb735f70d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ylpOOhBGHplOXCPclnYNNJcvPyT5juaV
X-Proofpoint-GUID: ylpOOhBGHplOXCPclnYNNJcvPyT5juaV
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_06,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1011 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170051



On 16.06.24 06:23, Jeff Johnson wrote:
> With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/net/lcs.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/s390/net/lcs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
> index 25d4e6376591..83807ce823e9 100644
> --- a/drivers/s390/net/lcs.c
> +++ b/drivers/s390/net/lcs.c
> @@ -2380,5 +2380,6 @@ module_init(lcs_init_module);
>  module_exit(lcs_cleanup_module);
>  
>  MODULE_AUTHOR("Frank Pavlic <fpavlic@de.ibm.com>");
> +MODULE_DESCRIPTION("S/390 Lan Channel Station Network Driver");
>  MODULE_LICENSE("GPL");
>  
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240615-md-s390-drivers-s390-net-78a9068f1004
> 
> 


Thank you very much Jeff for noticing this and sending a patch.

I propose to describe the module as
"LAN channel station device driver"
as this is the term and spelling used in the documentation, e.g. here:
https://www.ibm.com/docs/en/linux-on-systems?topic=n-lcs-device-driver-4

Please send a v2
