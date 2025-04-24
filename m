Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD6E1D5166
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745477148; cv=none; b=l/9omx6//zoseLQW+6IfWyFGiO7hUu2QVVBpF1ReCmjms/4sE3Sg0DOlIBK7kWRAKTphGoUnFy7zmli850svrQL/fCrfHJNL7oBt45rcpgR6PrRlRGVaqbbVv+LLUTCgepiw/C7TOCcS2pba+daQtSzP6k83Pmz4cJjUp2DGQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745477148; c=relaxed/simple;
	bh=lICdyoWCvZ1ObxtTAtc6zjTt8jdNkgQXAemKvVNXkr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rv+m/rcgTffL7EpnYILJirDNbqwHmTQyUXk37zZCwuJLvXUaOW3K5cN1IdYh/X97DbZmvqCoWEiYGgdh74fjw0oxF7q9gYmP36sT4c8l+k5amJjoFY+goROqV1vb+G7EYNSZcBZdufrVnrC3H3VVEttsPMgRx3JjuF4zBLsvojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qHRdg0mc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qHRdg0mc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O655d2010695;
	Thu, 24 Apr 2025 06:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=p873Yz3Hblu/QI9M7GV0LqB5aBIYQO
	TcsiGrjaknt6E=; b=qHRdg0mcUzqpdIgmMiYna9Yi+eiLNAiP29wP95wBAonhhk
	VJRfxXEfyqWRVUQ98fWYOrZF+dljsSAokCSpQwMi5C/MIl82VuEf0fXUgUdx9u0h
	BvTqeAKfMA7vX1UkGRlU+zyB3vRPfdfmC6KozPBfzG8Wvo5+7OvTKMYaB79ub3mT
	dNxsAyWOhhZS8Az/wlUBmow27D6jLLwtRiMBydugysDbbCdSF87wtYxXqf1kTeTg
	u/lZwd7XwS9WgHXvFo0sxPW6Kjqw0TpALLen3ROllNDB/g597t577UvqbgaJanRw
	aoZDfHT+/XLOr53QSxg5yirFPsNjkxK/o/XDZypQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466xns4spm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 06:45:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53O33Y2e008601;
	Thu, 24 Apr 2025 06:45:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxpx6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 06:45:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53O6jdqu58327342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 06:45:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F10E92004B;
	Thu, 24 Apr 2025 06:45:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABDA420040;
	Thu, 24 Apr 2025 06:45:38 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Apr 2025 06:45:38 +0000 (GMT)
Date: Thu, 24 Apr 2025 08:45:36 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v7 02/25] s390/ap/zcrypt: Rework AP message buffer
 allocation
Message-ID: <20250424064536.7083A9a-hca@linux.ibm.com>
References: <20250423101535.143137-1-freude@linux.ibm.com>
 <20250423101535.143137-3-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423101535.143137-3-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KplN2XWN c=1 sm=1 tr=0 ts=6809de17 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=JyunqWvMea0SjTLKC5IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAzOCBTYWx0ZWRfX4oHwra8rnS+j Wu4ijUHfoWfDhLmPyR7YlfRyW9mblEya3D/2+pWjzaa7LTQCP5iEXOkrHcGXmOpXDwIcymL/v1R RSNk9QxNLnR0wZqbCM27oQsiHxaN1Q+KzFeWzB+XBwpAIpRx87tY4c5XJYAIam/3V1IA6YPnhIx
 RQoyd5QSRqHSUbHooWAZqW9cRRb7TSghCmT2hyhEeBQeKFZd98fUm3pdfrCFrlGJdNmL0T+5Vo/ iWp9tmIr9tkD+TJxxpPKi3o/Yw2yn43e6cRlkzF3fEC1q4fWv5V8532mnMdigt0twcuOZYhquuf cnhNY1w2AyudjnSw/ZQjRupY6+q4tprrJwU89o8pr5VlXvW88UwnK2e51F4e7pG5wYTk3pWAxOH
 jbHNNS9YVW8iaqUMstF74qHeo/yRE4o6s4feJYjac2B9iUKiVNrEsjMVOiyK/F66IBaHMvbQ
X-Proofpoint-ORIG-GUID: 4N3rRDUTBvIpWpPmprayxg1gnI2aFpEd
X-Proofpoint-GUID: 4N3rRDUTBvIpWpPmprayxg1gnI2aFpEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_02,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240038

On Wed, Apr 23, 2025 at 12:15:11PM +0200, Harald Freudenberger wrote:
> Slight rework on the way how AP message buffers are allocated.
> Instead of having multiple places with kmalloc() calls all
> the AP message buffers are now allocated and freed on exactly
> one place: ap_init_apmsg() allocates the current AP bus max
> limit of ap_max_msg_size (defaults to 12KB). The AP message
> buffer is then freed in ap_release_apmsg().
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>  drivers/s390/crypto/ap_bus.c           | 26 ++++++++++++++
>  drivers/s390/crypto/ap_bus.h           | 21 ++---------
>  drivers/s390/crypto/zcrypt_api.c       | 49 +++++++++++++++-----------
>  drivers/s390/crypto/zcrypt_msgtype50.c | 20 ++++++-----
>  drivers/s390/crypto/zcrypt_msgtype6.c  | 35 +++++++++---------
>  5 files changed, 86 insertions(+), 65 deletions(-)

...

> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> index 5020696f1379..78df25da0b95 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -642,16 +642,17 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
>  	struct zcrypt_queue *zq, *pref_zq;
>  	struct ap_message ap_msg;
>  	unsigned int wgt = 0, pref_wgt = 0;
> -	unsigned int func_code;
> -	int cpen, qpen, qid = 0, rc = -ENODEV;
> +	unsigned int func_code = 0;
> +	int cpen, qpen, qid = 0, rc;
>  	struct module *mod;
>  
>  	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
>  
> -	ap_init_message(&ap_msg);
> +	rc = ap_init_apmsg(&ap_msg);
> +	if (rc)
> +		goto out;

clang says:

    CC [M]  drivers/s390/crypto/zcrypt_api.o
      drivers/s390/crypto/zcrypt_api.c:1223:6: warning: variable 'func_code' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
       1223 |         if (rc)
            |             ^~
      drivers/s390/crypto/zcrypt_api.c:1271:32: note: uninitialized use occurs here
       1271 |         trace_s390_zcrypt_rep(buffer, func_code, rc,
            |                                       ^~~~~~~~~
      drivers/s390/crypto/zcrypt_api.c:1223:2: note: remove the 'if' if its condition is always false
       1223 |         if (rc)
            |         ^~~~~~~
       1224 |                 goto out;
            |                 ~~~~~~~~
      drivers/s390/crypto/zcrypt_api.c:1214:24: note: initialize the variable 'func_code' to silence this warning
       1214 |         unsigned int func_code;
            |                               ^
            |                                = 0

Actually the problem that func_code may be used uninitialized existed before
your patch series, but now at least clang can prove it and complains.
