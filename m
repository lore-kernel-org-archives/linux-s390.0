Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F62EA15C
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468502; cv=none; b=Eyyip7SYXTC+mWx+nahX1jaDPD2HQW0CUf2VaSqoOZ6HTZKV8bz/iMIMgTBhVKRKc9e+cKHy2HWNOzOUDaE/2IcMbFiddDFHnrBZtoLyOkJisw++REdg1ROcCtfS5Tz9PCGCPQ5GJ945QPULhTGotZhEoZBy6kr158Si0jxOTSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468502; c=relaxed/simple;
	bh=hiDqtBuqVzEQAsiqdJH8GnrTUNhWjAwUwyRI9hdx5QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAFg5s5IFzbRk6cxaP1jkpyBskb+Cr1p7WrZiKO+9k9KZVF2WmeoYE3xqXIjfJJNpbfQG8zXwWkv9Yg6m1+av9M02vrwUjJiu34glYVFuQe8FN9TTuBLl/4dZxSjS1B0YEU/2hPDViYD9ezbT1KqkUwGJBnIUjpfL9v5EyDe2D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PCKmhvOc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PCKmhvOc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698BZabt3611636
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 14:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zCwEyW
	ncpVuGP/3Ku0xF3c37WiFRN7dEDT3lJAxbaVc=; b=PCKmhvOcaFNWBf2CzuiwKW
	hxd2OoeUo3jRIBicdJM2PPVft+f/xXsL6lEsLqrCUiYOGnPAF9em/DVHr7ni0sZu
	UcWCJGw8RI+SGqBIgy7u/P5gfMkDyOn4q/MwIrKCLDgF8PR18MApPdlbbN7gb2Qo
	apoXfbVGwtmrm1CY9PbhOwVFoZDDWWuu2Ga2ek3kegydGBL3MBAObQt5XjXtUVYh
	XxwfntHt7UzZk+CKq5xECxBlkkasVvqgHdCurNkToXccu7EF7UD+Cswx/4EqRn49
	hPdR0gujDS40Kzg/38x5hnB8rBylsag/HcpmuxI+zQLewADymjKkM4o6d7XW5Beg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw47pw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 14:08:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698BHwRo2135019
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 14:08:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3txgt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 14:08:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698E8GA544302722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 14:08:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37E5E20043;
	Thu,  8 Oct 2026 14:08:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E924E20040;
	Thu,  8 Oct 2026 14:08:15 +0000 (GMT)
Received: from [9.111.89.16] (unknown [9.111.89.16])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 14:08:15 +0000 (GMT)
Message-ID: <89744dbd-e019-419d-9d44-2cf0e2fcd9b4@linux.ibm.com>
Date: Thu, 8 Oct 2026 16:08:15 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] s390/zcrypt: Guard domain index uses against
 speculative bypass
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20261006154603.9699-1-freude@linux.ibm.com>
 <20261006154603.9699-2-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20261006154603.9699-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cVm5kZHqQuFajj5yKuIsOamW3X59kCwv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1NiBTYWx0ZWRfX44/bQaF1QVWr
 edqy6Wz7jDB4DMWbQ8/2pULO+1FPDzxYdlrHMR7vwXPaNVGbx7tQBWZAIASTYgXjh3Qo8PSZS12
 XEZ10hLs0RyPasyYhRAabetFAnXK/JpahJiWkjRwK9upmoHb6LoS4Ea9bMSbmDcmgv1dZWkq+PS
 FKKWrWpREhDf9wItWl7I6rAUi3BVVDdZBv3ASwwyN0qFzoLoj87a924NPI9ruIMiktbGqA9nUxF
 uSC8xR9vEqj5keoGn0Fi6WvqdTdQ1nI8f4rh47beEVrFpaRr1mYEGWN+P4xS8AlFrVNK5MzPaTN
 6/dNT9f4R7tSNCBcaVP7ZoWkLRWiw1VkuUCJbX4FkgO2mGhPSTEU2oNlKEEGm1RcUGdjWPzhgcq
 ZpwF79nhSmg1W/iWkIMqoRyULahwg6wEZ7q1hLgXBLLuN7jQCHtFJHA8o4QV4rbK95d0NTRasKA
 Y7KCpPllF2ao/Rbj2iA==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac7a3d4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=jD9WW-peAJN3IKa1l5wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1NiBTYWx0ZWRfX/aQdeDnHODB6
 sigcV6FYCqYk2ph4xNtxtW5VgVlnvcphv1qtED+dD61VGHO9e77jPhBK20NtM9oYM64cTAxjxqN
 ngV90nbBXD0wvyK13qxifROhaMYtOXM=
X-Proofpoint-ORIG-GUID: cVm5kZHqQuFajj5yKuIsOamW3X59kCwv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080056

On 10/6/26 17:46, Harald Freudenberger wrote:
> The previous array_index_nospec() placement only covered the admin
> permission check, leaving ap_test_config_usage_domain() and
> ap_test_config_ctrl_domain() in the CCA path exposed to speculative
> execution.
> 
> Move the sanitization to before all permission and config checks in
> both the CCA and EP11 paths. Hold the sanitized domain value in
> another variable so that the later use can choose to use either the
> original value (subject to speculative execution) or the sanitized
> value (which may in case of AUTOSEL_DOM reflect the wrong
> value). Before that, check the domain value to be either AUTOSEL_DOM
> or in range 0...AP_DOMAIN-1 and return with -EINVAL in case this check
> does not pass.
> 
> Fixes: e935cd525af4 ("s390/zcrypt: Close speculative mem read possibility")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/zcrypt_api.c | 35 +++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> index ec6a4c2f9f04..625578b3fabe 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
[...]> @@ -877,10 +877,17 @@ static long _zcrypt_send_cprb(u32 xflags,
struct ap_perms *perms,
>  	print_hex_dump_debug("ccareq: ", DUMP_PREFIX_ADDRESS, 16, 1,
>  			     ap_msg.msg, ap_msg.len, false);
>  
> +	/* Check domain for either AUTOSEL_DOM or in range 0...AP_DOMAIN-1 */

typo in comment: AP_DOMAIN-1 --> AP_DOMAINS-1 (missing S)

[...]
> @@ -1078,10 +1086,17 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
>  	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
>  			     ap_msg.msg, ap_msg.len, false);
>  
> +	/* Check domain for either AUTOSEL_DOM or in range 0...AP_DOMAIN-1 */

Same here.
typo: AP_DOMAIN-1 --> AP_DOMAINS-1 (missing S)

[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

