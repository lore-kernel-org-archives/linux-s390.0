Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46215F410;
	Mon, 12 Aug 2024 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444184; cv=none; b=hK8cMKR5OqWNBP/ObsIwIoVGjYhyRZi35iMqOdPizhnJIQRiy/XY3CHRNKHB+M/Pcc7/KDJZh49AXGiRWiJ5vMbvHrf4qUF4PXLavLLCjjQUdzyHQU/2ZReczgz7i63W2mOvRuSeNk9sLacpHt/UGGEezQSivrGDA2p1UsqJcY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444184; c=relaxed/simple;
	bh=HVMm0LRGbTcA7C2OT3F9o6ZG8lrp1l6Jf1CFDR86p+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLrXs7XqLF7KlTKMLXG3oyWJFiqXUi8nIIZvUqr9gyRTljA2porkCPEaS29zbHRmkhpWNf2Rh3K69pQlw0vWYMsRqhGGt8ZHuJ0aA6+VvpCDISSl5f3t4z/3SH1rPxWXhCWqT5fSQRgve3tDDjAhXXrzAx0U8mJM6F6NfYTLvKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jdtQXCfv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jdtQXCfv"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C4oDtn026486;
	Mon, 12 Aug 2024 06:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=e
	J2AwkxTY7H9tUucBRnELfKYFtQ4xduLEZZLsud8IY4=; b=jdtQXCfvwHXqcLwL4
	VDO4xaH6DbMhgCrFECoUvU8bPEGiD4rKjqaQWJmpiMzW03JSoO8LR2jGuR3cm7IT
	Yf2BBuOa/Oney1BmflDgWxxg22uGlJFjrZO8feytCmUXvs2VkhL3958JgQLvUyKL
	Lb59szx9eH5YyoTAZpdNfk/UivZjrWRZXsA/BEVU9VEpJWOCslzu9WcVZiVj8v6U
	JJsQBvs05f496+ZZEkZzLUa4e7zqBVgQVd/CcL7lh10/WuXWi9IaPDqEOxu/UKhF
	J8Er8E66Gw6noo1KVIW/Sj71Qt1DLietlg9k09KETt5EEZSCNSBSeS6AX8i31B27
	afyeQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wy7am3r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 06:29:37 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47C6TaSc027279;
	Mon, 12 Aug 2024 06:29:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wy7am3r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 06:29:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47C4H5kC020896;
	Mon, 12 Aug 2024 06:29:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xn82vru2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 06:29:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47C6TVHg42205514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 06:29:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3CD42015E;
	Mon, 12 Aug 2024 06:29:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E9AE2017A;
	Mon, 12 Aug 2024 06:29:28 +0000 (GMT)
Received: from [9.171.70.59] (unknown [9.171.70.59])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Aug 2024 06:29:27 +0000 (GMT)
Message-ID: <90da4cb0-a422-405d-b5f9-99eba490071f@linux.ibm.com>
Date: Mon, 12 Aug 2024 08:29:26 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net/smc: Use static_assert() to check struct sizes
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZrVBuiqFHAORpFxE@cute>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <ZrVBuiqFHAORpFxE@cute>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Do6X6uAXbeRBsCu70CzasC-89mr5k1_T
X-Proofpoint-ORIG-GUID: O30LSGKdDr_cmJY0FkCBAGQztESZf_fT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_25,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408120045



On 09/08/2024 00:07, Gustavo A. R. Silva wrote:
> Commit 9748dbc9f265 ("net/smc: Avoid -Wflex-array-member-not-at-end
> warnings") introduced tagged `struct smc_clc_v2_extension_fixed` and
> `struct smc_clc_smcd_v2_extension_fixed`. We want to ensure that when
> new members need to be added to the flexible structures, they are
> always included within these tagged structs.
> 
> So, we use `static_assert()` to ensure that the memory layout for
> both the flexible structure and the tagged struct is the same after
> any changes.

Read up what the macro does. I like it.
Compile tested on s390.

Reviewed-by: Jan Karcher <jaka@linux.ibm.com>

> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   net/smc/smc_clc.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 467effb50cd6..5625fda2960b 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -145,6 +145,8 @@ struct smc_clc_v2_extension {
>   	);
>   	u8 user_eids[][SMC_MAX_EID_LEN];
>   };
> +static_assert(offsetof(struct smc_clc_v2_extension, user_eids) == sizeof(struct smc_clc_v2_extension_fixed),
> +	      "struct member likely outside of struct_group_tagged()");
>   
>   struct smc_clc_msg_proposal_prefix {	/* prefix part of clc proposal message*/
>   	__be32 outgoing_subnet;	/* subnet mask */
> @@ -169,6 +171,8 @@ struct smc_clc_smcd_v2_extension {
>   	);
>   	struct smc_clc_smcd_gid_chid gidchid[];
>   };
> +static_assert(offsetof(struct smc_clc_smcd_v2_extension, gidchid) == sizeof(struct smc_clc_smcd_v2_extension_fixed),
> +	      "struct member likely outside of struct_group_tagged()");
>   
>   struct smc_clc_msg_proposal {	/* clc proposal message sent by Linux */
>   	struct smc_clc_msg_hdr hdr;
