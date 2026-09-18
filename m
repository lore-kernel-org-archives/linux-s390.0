Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D404C653B
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728298; cv=none; b=pEqUo78WfejSmjXQVr5gNO6ZPdScwqQ2LIe4j4flW6KirETavCcFIwYJ3cj8X7zmZZKKTtqnDA3rmcljGjXtHI+Ak/7kIOqubQUxrTlqgejOmv7OwxAMwd6/hQrGUeelTdaS4+m2MALjRIqVi4x4ovjut5K5Fsp4Hg86bL6/yqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728298; c=relaxed/simple;
	bh=BW43eyE24RbUsoaDqj1TBfggn7D+333u0Cf6t8S8eAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlkMUrMT783zM/kCg0jWKJWGDJm+3W6fYZZEFjr718IM+muIPrIp9g+iVU1fFYRhqTfFhsODXIUYXRZZVxQAzDhcTV7qFQCnJssBkmj0KPvrLzWK4HNoa9jxmieaOg7PlaJ8VNKb00giSCSt1lv8sAX19iaVKMJ760CoJIpJ3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UrMi429D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UrMi429D"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1SE2946075
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 10:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=W26Q4aOduVTDG0JKEFm3B6rDDWrqWy
	Lmi4QXuY1Vfg8=; b=UrMi429DBXSEp2AUBwSxRQkwE+uiEtTy5D/uWwh+72YzoZ
	vq70UH5Ro0UPd2vrNRzRohrz3XNW8/yEq2kNG9eDVlclUfXhm+BNaMfOzsWELryh
	204PXBWfzXAdzlxU+T3GCY+xWqr01tZ42iJJiyIN9dli9MLrzsdyMAwgiOgliOfx
	d7o2XLTMQia4Rp/UQFWy5150Y4opNnZhHEeN23MTk66uNOWCY+FEckGq6PXEsvio
	n21TshP1rvLluVH46KYgktTFBGo7nejHAaXyOM/kzv6T30jKujwEttp9MnGyib29
	rh251ozWKa6W9j5N/WjmtCWt8PK8rC4zlWsX7lTg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx847jpx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 10:44:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9o8u8466646
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 10:44:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa6u2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 10:44:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IAim5M28967500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 10:44:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AAC12004B;
	Fri, 18 Sep 2026 10:44:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F68320043;
	Fri, 18 Sep 2026 10:44:48 +0000 (GMT)
Received: from osiris (unknown [9.111.38.246])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 10:44:48 +0000 (GMT)
Date: Fri, 18 Sep 2026 12:44:46 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH v2] s390/debug: Fix NULL pointer dereference in
 debug_info_copy()
Message-ID: <20260918104446.20386Dd4-hca@linux.ibm.com>
References: <20260916160626.1988684-1-zaslonko@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916160626.1988684-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE0NyBTYWx0ZWRfXy0wVk+dg8DLe
 FQhgHZA71DetH39dLtT/aeYm7gVuYElMI3J/PWeVX8eqSG8S17uNCzUH4z3tHERCMNwusFu6nfD
 t+OPbgyjKqXIZAcsbuNJOchXwJKlJFa/abUnR6PahyXxRiIn2T87mOghCFsK9x6EjK4n96MOKIO
 hA2q49G11yHcFtsTxG8pdHPAPcQNN03HdIKOTJMA6i7fmimqq9W7mKwgJkyPkzSAmEXf1p2ESYW
 JuUJOQwr0PkXMDJEL1B0W8TcLk1eNzeFdJ88+m0TowuddFnBJ+2VTGz1171PTtqZMnGULDl+F9y
 s3VgYo5L3AsINP8robNA6PCeoNb3XxLYSkniThCJaQc0CtM2dIw7JqJt+u6MEjZmnBHJ2PsZnHA
 ElseKMkRiaTEVgNqO5qcVMSIzHKGRPn5XrdJ53jnRr1j93mcoosNdqNW1EOHkIKrfrFr9r+VaL5
 LiNz0fshtb+JwE7gLHQ==
X-Proofpoint-ORIG-GUID: jYrOOCRqOBDObLUdFsnztzqfpS7Hw-bt
X-Proofpoint-GUID: jYrOOCRqOBDObLUdFsnztzqfpS7Hw-bt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE0NyBTYWx0ZWRfX4v2JVefzjORc
 FlUacOZEp/dgDvCHL9MHH+AbM9SkfAXcNHp17IX0Sc33PApxj+DfFhg8PTkJnrcQG+f8xjvi4zs
 V7ZK2NLMbVZUDVJlvn4iJtRVQXpCqHY=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aad1625 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gheRGZjsO9QmUI7mxtoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180147

On Wed, Sep 16, 2026 at 06:06:26PM +0200, Mikhail Zaslonko wrote:
> When debug_register_static() fails, it clears areas, active_pages and
> active_entries but leaves the area bounds unchanged. Copying such an
> area, either by opening its view file or via debug_dump(), makes
> debug_info_copy() dereference the NULL pointers.
> 
> Skip the copy loop when the source has no areas.
> 
> Closes: https://lore.kernel.org/r/20260903132123.12F271F00A3F@smtp.kernel.org
> Fixes: d72541f94512 ("s390/debug: add early tracing support")
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> ---
> v2:
> - Different approach: check the areas pointer in debug_info_copy()
>   instead of zeroing nr_areas/pages_per_area in debug_register_static().
>   Zeroing nr_areas made debug_info_alloc() return ZERO_SIZE_PTR for
>   active_pages/active_entries, which debug_to_act_entry() dereferences
>   before debug_prev_entry() checks id->areas.
>   Checking the pointer also matches what all other readers in this file
>   already do.
> - v1: https://lore.kernel.org/all/20260910104525.3788362-1-zaslonko@linux.ibm.com/
> 
>  arch/s390/kernel/debug.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
> index b5bf8284dbfc..d611d0eed1f6 100644
> --- a/arch/s390/kernel/debug.c
> +++ b/arch/s390/kernel/debug.c
> @@ -434,7 +434,8 @@ static debug_info_t *debug_info_copy(debug_info_t *in, int mode)
>  		debug_info_free(rc);
>  	} while (1);
>  
> -	if (mode == NO_AREAS)
> +	/* debug_register_static() failure leaves areas NULL, bounds intact */
> +	if (mode == NO_AREAS || !in->areas)

This is just a more or less random indicator that debug_register_static()
failed. But this seems to be the easiest way forward. Alternatively an
explicit flag in debug_info_t would make this more obvious.

Anyway:
Acked-by: Heiko Carstens <hca@linux.ibm.com>

Waiting for Peter's reply.
