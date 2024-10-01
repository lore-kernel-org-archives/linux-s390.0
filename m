Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969C19AD48;
	Tue,  1 Oct 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782926; cv=none; b=a9uVZodtVLSFFzOGzlSRgv6WEm2psPyzxbYY5N+6+Ep5ZTJ8s+cCTIMHBX/vBty8fd0qUxRrlPcDNrzKfKBK9VKeCLEk+tNtusmv/BjqreriLncKCHSfAiLXu9tS0m7ORuyqevwQMTl9ULT0kv9+7Eo6KlZXsHeLrS2Okxbzxq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782926; c=relaxed/simple;
	bh=Ux2SzW/jQn0Bzn5R53YOjyR8iBe1jmYDlyqkumWxsoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jU6F/K0ZKOd/5+81P54OBq5uYUFgoF03Y6J78sHc6NUnMBus/TkMryq1fgwLnj5d9sTEsvlCIzs56TTRW9jtUQC0thznH4fExElQTNvqWauk2+eL+cIHzxiKDMYGVnWNJ1MD7300nXFyf/FS4C0bauZrZ9wCXhR2njp9+XsA7HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nF3vu4aM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nF3vu4aM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491AMktF018051;
	Tue, 1 Oct 2024 11:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=m
	ZNDUMKJkR1zjZlo4YSLBwFYMfwd8lhLM1eVfp3IqYo=; b=nF3vu4aMrP0+06RoQ
	sEaCe+9KTdMgrmvCUweJHp92eRf9kFfaxD4GE0fMK3lxasOA2WS3ZKOsg0zwlY0u
	E0a1Lsap2pghEYB5UE3taN1tE4phok8Oape6/5JHrx3snX9febkA43D3Wgfff8p+
	Oeseaur3oE1WM55mF7pu4RLlvg3Tpb47ZJ8uxehAMxMba2BRYEfCUtRzv3r+Xr5C
	WFQ7+6fy4PMra3HC35tfRN/N6wNFE/XBl1IcjWyBpS4LMduu4pIAHim1bTCEOdSI
	eVniHWO9iAW8aBeFrwVrpRvqU+fgjX6PxbX9fQV9qrVjaaOr8lbt95osYLMat+VT
	YevsQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420f90rcgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 11:42:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4918plJJ007947;
	Tue, 1 Oct 2024 11:42:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgxv6j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 11:42:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491Bfwl312517642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 11:41:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4ECE20040;
	Tue,  1 Oct 2024 11:41:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55F4C2004B;
	Tue,  1 Oct 2024 11:41:58 +0000 (GMT)
Received: from [9.179.3.12] (unknown [9.179.3.12])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 11:41:58 +0000 (GMT)
Message-ID: <344b4019-0c7c-4e08-ab50-f03b1d51277c@linux.ibm.com>
Date: Tue, 1 Oct 2024 13:41:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] s390/uv: Provide host-key hashes in sysfs
To: Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20240930132042.2081982-1-seiden@linux.ibm.com>
 <20240930132042.2081982-3-seiden@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20240930132042.2081982-3-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FXWzjHzGbMT8e4q5TfUnL4yzK71bD1dU
X-Proofpoint-GUID: FXWzjHzGbMT8e4q5TfUnL4yzK71bD1dU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010075

On 9/30/24 3:20 PM, Steffen Eiden wrote:
> Utilize the new Query Ultravisor Keys to give user space the information
> which host-keys are installed on the system.
> 
> Create a new sysfs directory 'firmware/uv/keys' that contains the hash
> of the host-key and the backup host-key of that system. Additionally,
> the file 'all' contains the response from the UVC possibly containing
> more key-hashes than currently known.
> 
> Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   arch/s390/include/asm/uv.h | 16 ++++++++
>   arch/s390/kernel/uv.c      | 75 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 91 insertions(+)
> 
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 153d93468b77..7eda73073cdd 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -31,6 +31,7 @@
>   #define UVC_RC_NEED_DESTROY	0x8000
>   
>   #define UVC_CMD_QUI			0x0001
> +#define UVC_CMD_QUK			0x0002

Should've used the long form here as well.

>   #define UVC_CMD_INIT_UV			0x000f
>   #define UVC_CMD_CREATE_SEC_CONF		0x0100
>   #define UVC_CMD_DESTROY_SEC_CONF	0x0101
> @@ -94,6 +95,7 @@ enum uv_cmds_inst {
>   	BIT_UVC_CMD_ADD_SECRET = 29,
>   	BIT_UVC_CMD_LIST_SECRETS = 30,
>   	BIT_UVC_CMD_LOCK_SECRETS = 31,
> +	BIT_UVC_CMD_QUERY_KEYS = 34,
>   };
>   

[...]

>   static int __init uv_sysfs_dir_init(const struct attribute_group *grp,
> @@ -789,6 +859,11 @@ static int __init uv_sysfs_init(void)
>   	rc = uv_sysfs_dir_init(&uv_query_attr_group, &uv_query_kset, "query");
>   	if (rc)
>   		goto out_ind_files;
> +
> +	// Get installed key hashes if available, ignore any errors

Please use:
/* */

> +	if (test_bit_inv(BIT_UVC_CMD_QUERY_KEYS, uv_info.inst_calls_list))
> +		uv_sysfs_dir_init(&uv_keys_attr_group, &uv_keys_kset, "keys");
> +
>   	return 0;
>   
>   out_ind_files:

