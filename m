Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53635203D
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745131; cv=none; b=dF15Zd6RYRlcrAvDtrKOBX6zz5pC800g79cxMb+lOyKaH/Rtlcj+ZFLhccRuwDSfIhFdXOYptsJqQiVMScWop1bKhYljIsG4/bqgZMNhWUq6x10T/cZeLJ7WINygwpqhzfmqPyiDxBRYTlz0AV4T1vvtq096lDr8wFuR838y4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745131; c=relaxed/simple;
	bh=z4kctMemWo64T/WR0K+7wL35h82Fdg91arz4iMo1FNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyX/fLR4s7EU+mdoRzM/xua/h+Dab59MTHKFDWe1F0+p4roy5Rk6TwonBCFhrn26ej9QyPMfdV3C17T/BGCaws3M9LJnCdyKA7YNYxQxRfCiJyT36FxZsChtznA9hnzYGXXxSNZRZF7YOUXLfmPv3jQI+EJ6PjFhiJcgp5XmmiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XWPUiB2i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XWPUiB2i"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MIBiNQ712846
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 18:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=uPMzUIPoEu0zitFqo8Rt6J/Qc4RBsP
	6MqCGnEiOiVjQ=; b=XWPUiB2iXMQ9vXOLUwbme13JQRGDDKFmMwXOfG6g85uJ1W
	NtvU0hILFuNpCwTOGXBS2B9N/2Q5Prd467+0U9Z9vgiwGCzgZiKdDzpPIbujJL1v
	lmynqcBSxM2cOlBsp/ryP4KDrMDYx9MkDd0vOuQgCk3lA8Q6rCCADiGb5cuMMGyt
	5squmDc3BuRqXxumKI/G9Rin5DpXb4hi6Jdz5SL7oJ+nNCGqW4E/j4DilfS5ultj
	Pu8omIlY0fwt1G2CcfEzyhZV2/R4kxVG5QVFDoD6a5NkZblOSYAbnF82o/+h8ov5
	gszINv6s6guev8QgHb0eBhBbhEO6pB3x0vPie9fA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahb8hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 18:32:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MIJixc020770
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 18:32:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah8kcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 18:32:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MIW4DJ60293452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 18:32:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 835DD200E1;
	Wed, 22 Jul 2026 18:32:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DBE1200DF;
	Wed, 22 Jul 2026 18:32:04 +0000 (GMT)
Received: from osiris (unknown [9.111.32.204])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Jul 2026 18:32:04 +0000 (GMT)
Date: Wed, 22 Jul 2026 20:32:03 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/1] s390/zcrypt: Close speculative mem read
 possibility
Message-ID: <20260722183203.13538Cee-hca@linux.ibm.com>
References: <20260722152025.119391-1-freude@linux.ibm.com>
 <20260722152025.119391-2-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722152025.119391-2-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ESvWMf9Ebp_BNFz6s3rVLWyLJUEFp8BE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE3OSBTYWx0ZWRfXzHgg1xIEaiNp
 5dUTDyYo1ZY/Wk18ITnfvMICbWz/wP6rbt1+ERxHB0VJ3Wk9OO00b4HUHZ9DL9UG6LGVdCeg+DK
 Yx3quQKebTjfsDnQ5RhBMDkLQCZc9wdemuChvWWo6D5LZM8L7SmL3c8RQudCPjYsuikOCbTSEhd
 mx/KXAlMkJfA7CX8nVkVJnaTSGfLd+Yl72wWC/L8XEoszX9cOpI1fFB3vdDVZs44oKYGCGWCkUX
 5p8rlJZDom2QKoHAXHXW9OW6B7u9Esfab/ADhl7IdMBisrUxppxaw3hD/ksIrYoNtG7xAQp/IM1
 /nKuMgWKESGBS08sFwlK2E9dpd/C6XGBUr79x5H2j0gClsGqXLBhQovySQt1oEHA8f8W2sGpC/i
 AaMItu2Zsy+36gmq0jKCCuxq7evngajD6ElkBuFKUjSD0B+GdL/7OyRkLnEHfpVNOx4GNsInEPN
 bEiRl0Ixx7gehY6t0hw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE3OSBTYWx0ZWRfX78VaNOUS+WFy
 Rq4Q7z+fJ4DXkEKJraIvGiJUpJWhvCSJwrRXXCtCEbZoFQsw+oz2Yl8kNF+vR8e+62FKDywzJCT
 eNRyS6WlaidkfOdppJkn7DR3TzxAJjE=
X-Proofpoint-GUID: ESvWMf9Ebp_BNFz6s3rVLWyLJUEFp8BE
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a610ca9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=IpLEZtQiE9cJNPtD5WgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220179

On Wed, Jul 22, 2026 at 05:20:25PM +0200, Harald Freudenberger wrote:
> The domain value is extracted from a given CCA or EP11 ioctl struct
> when a CPRB is about to be sent. Thus this is a user controlled value.
> Under some special conditions (custom device node used, administrative
> load) this value is used as an array index after bounds checking, but
> without speculation barrier.
> 
> Add the missing array_index_nospec() call to prevent speculative
> execution where this domain value is used.
> 
> Fixes: cfd68b33094e ("s390/zcrypt: Filter admin CPRBs on custom devices")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> Cc: stable@vger.kernel.org

...

> @@ -1079,6 +1080,7 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
>  
>  	if (perms != &ap_perms && domain < AUTOSEL_DOM) {
>  		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
> +			domain = array_index_nospec(domain, AP_DOMAINS);

This hunk doesn't make sense, and it depends on the other patch you sent:
"s390/zcrypt: Fix wrong domain value verification with EP11 CPRBs".
Please send them as a series of two.
