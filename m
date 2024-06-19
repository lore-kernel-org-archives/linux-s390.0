Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167297710F;
	Wed, 19 Jun 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837079; cv=none; b=gdNsZGusgOmksCTWvfgOTjNDWpl4uUVcb4DnJusa45n99p4vXVo7LPhS0imNrOCOpa1DEiMWzP+Vf7jpNgfBSK+YuGIoB8np7fsBH6WvRLqX7aiZiDZAU4HuWPgKXnTjHkJU95BBiCb51hfJJfSb7yFdLSCZuW1sC22hYm3bMlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837079; c=relaxed/simple;
	bh=CsDRSrmUZP+0eO7bsoP2Z3JCZ3evSl0DmXDRy+IGP50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llyUT8mFq1r2xO84EJGtd1TlTxStaM0orx2cXdQp3DiAoPug2pFjMZ65tvt7si4RulQNtGJIrMEk1FepzjWsrV0ZjpramWCgtoZ0t8ga3w6iERbq4vCf5o/ySMsJjx/AS5t14i90jJqMKYXYY+/7HYHr5rhRsH+Fh2c/LG1clwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MRQxx2g9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MRQxx2g9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JLKdV1024684;
	Wed, 19 Jun 2024 22:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=2fnecpl8ETZ8acT8Sd3wdlPMERN
	Bcsx2ZpcQs43w9Ec=; b=MRQxx2g9wWcnmL7e14sPkXUsbie+MAidUY2ym6OALzv
	jbokEk1Nv6iW8khBc6jUMF2SBToZxqm521kpj/1FYyppsjXU6B+GBJQKZUmMUCR+
	NQDXL47aVYnBR3J+vUema5lmMV0NCyeOZ9vvIXWjAoq1t3xDDs9YN9O3xpLamygT
	Eb5nqWIomlKsemvmU0L60fz/5sheqzXQbSTT58+pDX4k33KGtI35WpsQ4CiCJb0Z
	DvRdy+2/eJMAyMzNgcVLQGeIWy/7BJwElxNAHVx0XH9lr7RL17rbccCn2ZJGkSyY
	AITlm327E97rpsg/DTNAmYq20YMigwMxuGeP51ASSIA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv6df07hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:44:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JKK3Od013477;
	Wed, 19 Jun 2024 22:44:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysr040bg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:44:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JMiTdU57082206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 22:44:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2511120040;
	Wed, 19 Jun 2024 22:44:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4AAF20043;
	Wed, 19 Jun 2024 22:44:28 +0000 (GMT)
Received: from localhost (unknown [9.171.70.82])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Jun 2024 22:44:28 +0000 (GMT)
Date: Thu, 20 Jun 2024 00:44:27 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] s390/lib: add missing MODULE_DESCRIPTION() macros
Message-ID: <your-ad-here.call-01718837067-ext-4050@work.hours>
References: <20240615-md-s390-arch-s390-lib-v1-1-d7424b943973@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240615-md-s390-arch-s390-lib-v1-1-d7424b943973@quicinc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6SSkeXdvNQ3WUtDI54aM2b-2yKIEwdNX
X-Proofpoint-ORIG-GUID: 6SSkeXdvNQ3WUtDI54aM2b-2yKIEwdNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 mlxlogscore=599 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190169

On Sat, Jun 15, 2024 at 05:47:26PM -0700, Jeff Johnson wrote:
> With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/s390/lib/test_kprobes_s390.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/s390/lib/test_unwind.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/s390/lib/test_modules.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  arch/s390/lib/test_kprobes.c | 1 +
>  arch/s390/lib/test_modules.c | 1 +
>  arch/s390/lib/test_unwind.c  | 1 +
>  3 files changed, 3 insertions(+)

Applied, thanks!
