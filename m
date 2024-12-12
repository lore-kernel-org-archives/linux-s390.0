Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122E216E3B;
	Thu, 12 Dec 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015806; cv=none; b=gdd8WcpZioWI/xDEU4I5pWDGgoPkQc8kcnZ5/WpYfDNzsevCTDjDptYK0Y8MYOsFTRtRQpI1LRmf551AcvH7Wf10LOnPpYcPBkycRz916fR217/foNTQ6cbnIUF1fdRyfnJ7e36wKG1iG2IKsoBt+W0UYUXhD2b1O6FrcW75WQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015806; c=relaxed/simple;
	bh=gL2akLtYlAt8MZafJL6RY7IcgOt+9heDw+QwznQ33OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQddc8jNMQoW4A8WhHmKusSV6iXUW5axM+W/4/M3ItB8vRx9tVVInMpOgrMpI6VILN1Up5D9phcTG1LJeGen5s6wYHMQZkDq7gVNeG2vFdKD0+ilwYWpXT+8QvfmPzAE0mMFm2wmxrznZZrdV3qqK+thZ4HQhAIeyul5ho4jqw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r/MG7nvO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r/MG7nvO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCEx9Rc000648;
	Thu, 12 Dec 2024 15:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5KBxrQ
	sQNxKrZaAQZznW2uf3kpOeca1+VRigPr1qED8=; b=r/MG7nvOcsqTYSeBFitSYj
	D1ncey0pji9m2zuZ49JGVrcVO44XFDANoa7sgqYAev+J6DNI2HU4DnNfZrXR5jUO
	fNzBoM4lA9O2jd6WobaBF7mbutxprjTZDEPcBQglELE+9hktxiUKQL1A1pY3A1r+
	KqpJaoHadLX+pskBGc1QAhPjzT7MGu0/LlSTzKKrkyDOZrxu26ZJmp0SLKR7Uhpd
	VkJ47JpFk4TWOQAwmBI/SP5R8LdZxBKl5W0z9XIqMN+Zo5JyDtDB93yiT5cLxl7v
	yGrKRCQmEYX6e3B66NAoGmD3+PApdnL1HFHPRxmGNrprIGx21iEks7NlmjYZwNqQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ft6d2sxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 15:03:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCEIn5M018595;
	Thu, 12 Dec 2024 15:03:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26krybt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 15:03:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCF3Iu352494768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 15:03:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB2B220043;
	Thu, 12 Dec 2024 15:03:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D66720040;
	Thu, 12 Dec 2024 15:03:18 +0000 (GMT)
Received: from [9.179.9.164] (unknown [9.179.9.164])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Dec 2024 15:03:18 +0000 (GMT)
Message-ID: <2295c2a4-7d7f-4932-99df-fa9d4b6186ae@linux.ibm.com>
Date: Thu, 12 Dec 2024 16:03:18 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] s390/pkey: Constify 'struct bin_attribute'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
 <20241211-sysfs-const-bin_attr-s390-v1-5-be01f66bfcf7@weissschuh.net>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20241211-sysfs-const-bin_attr-s390-v1-5-be01f66bfcf7@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mZQSjWXdccMDUIAlc1JPJUI28tgiVnsS
X-Proofpoint-ORIG-GUID: mZQSjWXdccMDUIAlc1JPJUI28tgiVnsS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxlogscore=971 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120108

On 11/12/2024 18:54, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks for your contribution.

Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/pkey_sysfs.c | 128 +++++++++++++++++++--------------------
>  1 file changed, 64 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/s390/crypto/pkey_sysfs.c b/drivers/s390/crypto/pkey_sysfs.c
> index a4eb45803f5e6d6b17dec709e6068448973399f6..57edc97bafd29483eedc405d47eabe3d7f6c28fc 100644
> --- a/drivers/s390/crypto/pkey_sysfs.c
> +++ b/drivers/s390/crypto/pkey_sysfs.c
[...]
> @@ -295,9 +295,9 @@ static struct bin_attribute *protkey_attrs[] = {
>  	NULL
>  };
>  
> -static struct attribute_group protkey_attr_group = {
> -	.name	   = "protkey",
> -	.bin_attrs = protkey_attrs,
> +static const struct attribute_group protkey_attr_group = {
> +	.name	       = "protkey",
> +	.bin_attrs_new = protkey_attrs,

This is more a comment to 906c508afdca (\"sysfs: attribute_group: allow registration of const bin_attribute\") than to this patch:
Why have you named the pointer `bin_attrs_new` and not something meaningful e.g. `bin_attrs_const`? I know, it is already in the kernel, but I would highly recommend to rename the pointer in another patch.

[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

