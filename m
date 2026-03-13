Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BD9382F2A
	for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2026 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390766; cv=none; b=h7y9sVlkyfrCSdiD8Ez+5eF2fj/PeANldLEs6bLHMtpKgVsU9n44n30nBVUlbgCP+f6oOlFMhPbnaGJ3z0ug7E4Uy0ojoP/IWHh12LoRVD48NUn7IFwoFc4SWlLlne7byBd7WJteYA9t/VNw3SWNC5Io5e9IuNXAeL8SAiMk+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390766; c=relaxed/simple;
	bh=nRjSdtzuR8EzFUAEprezTG4wXZPkuhmUsQwDdc4XIfA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CMB/VC1pM7f3WlfM8j/5WNBluzNvChY/qx/GhEf636343JSGgRzkrHH9ApcOUOQ2LOdW3WboYeTaTRdbzc4Hj0e8o9PMWEuXAsunjAPNm9TlUgAsK/GWYHazka++tCxUjMFM++lyVonGFmphmXrRWWYr5gDp92z2kQGEy3QZfJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KJDbv0Pt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KJDbv0Pt"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D7XGFQ2279216;
	Fri, 13 Mar 2026 08:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=+mH/RIoZRkMlj/nCFh30B7aho4243Ix/FSTAEXYdE00=; b=KJDbv0PtkAwG
	Cl3i+ImDtt2jiVp98d7u86WaJK+/zFupeB61xWkz/WC51FlCdch97sSFXo3anoou
	3ot4pBlxo9gjksdc/F4d26tMV4hyLkez94jBB8vNj3f9PC3UxbH8PgxM2Hj2QJnH
	WhRgyrz4r/ryHKyN5j5ras/Ka+qz3ax9ZTzczAqSqS65prlPPYJuujvN0Y2gYIhv
	H4qtsk6H3EeZsCZUErRON4EzlOULsT1UBfImvkQtPE+RpecBEOniVigFFg0F5L8d
	zBHkst6BJogBHTIVlM0vhCl4lfaCtEJOsbKRD4LatPAEsWFNpjgfRsb3P6l3MqLZ
	+YxkB7xFkQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91pu8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 08:32:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D5FQoW014631;
	Fri, 13 Mar 2026 08:32:41 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha8dvgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 08:32:41 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62D8WeCf13173500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 08:32:40 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76B965805A;
	Fri, 13 Mar 2026 08:32:40 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF9CF5805C;
	Fri, 13 Mar 2026 08:32:39 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 08:32:39 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Mar 2026 09:32:39 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: lirongqing <lirongqing@baidu.com>
Cc: Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/pkey: Remove synchronize_rcu from
 pkey_handler_register
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260313052312.2389-1-lirongqing@baidu.com>
References: <20260313052312.2389-1-lirongqing@baidu.com>
Message-ID: <058c161c4e82d2d78ddb9c52cfc8ee50@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NbikojqJ0zWpLvjKPymhLbikpdNBnKU0
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b3cbaa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=zuLzuavZAAAA:8
 a=VnNF1IyMAAAA:8 a=lFT4GuY0HqRxgGrVVpkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2NSBTYWx0ZWRfX3eGf6MohNInO
 Hs4n8qj2JiYXKrUkZM643NghMg6bmFztdncq/1pNEIe1mxoOSjlaZEA5wZt7kR5jDiBIkz5br9c
 aCijDu3G/BuNNvOecAX89lDoZbDSK3fFLvdPHSkSeUaXa/rrexW2tQJwTD5rMZOFDQNhHcq+hxO
 fc1Jir96IIN/SnW78pp07aojUZ9GFCF/VfIkr6qRjZirQT9bY4W3mcN8lYSfUHk6Zai7KYqDFED
 REpYYbYEiVj1nGk6ylYf9H46ToiGx3LWMHwQpsEId3K5O55n+U7Rtp53/uCTvTwhBocXAFk+UOY
 +KTqPsXBcNNs+QBKj4KWnQF5NyxAh3tcyA7a+5KJbmXD6TIDJpdVPeNZfXNJycSTjDnsmBEoBwt
 U/tZcITTJ0Nn9uLFXy1D+YxdGiX6K1raj/Kuyg8LuVt6sFsjPh/OImls/IClt/HkwYDgeYoiPLX
 8FpzrzlD4oI8J01G5eg==
X-Proofpoint-ORIG-GUID: NbikojqJ0zWpLvjKPymhLbikpdNBnKU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130065

On 2026-03-13 06:23, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The synchronize_rcu() call after adding a handler to the handler_list
> is redundant because RCU readers will either see the old list or the
> new list. Removing this synchronization point reduces the blocking
> time during handler registration.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/s390/crypto/pkey_base.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/pkey_base.c 
> b/drivers/s390/crypto/pkey_base.c
> index d60cd98..c2e29d6 100644
> --- a/drivers/s390/crypto/pkey_base.c
> +++ b/drivers/s390/crypto/pkey_base.c
> @@ -60,7 +60,6 @@ int pkey_handler_register(struct pkey_handler 
> *handler)
> 
>  	list_add_rcu(&handler->list, &handler_list);
>  	spin_unlock(&handler_list_write_lock);
> -	synchronize_rcu();
> 
>  	module_put(handler->module);

Thanks Li RongQing

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>

@Heiko/@Vasily/@Alexander will you pick this?
