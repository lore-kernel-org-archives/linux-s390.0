Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9AD757EE;
	Wed, 19 Jun 2024 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837129; cv=none; b=eZTy1KoTRYzVFHLXKxlhdMDRTKjs8XxFvU+oe4wVAysWUZe2V2zDgdv+XO+MjebO3RxI5e56nDLJhPwGL9clmZwyjpUmkb2kMumGPshBJdMxOxS+auWwTnMcCzBuzqA9GKIemuax7BnHWyHJtWU/J3xUpH/3KyK6+k7tYDNKTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837129; c=relaxed/simple;
	bh=WuAERy+/8zxmixKWoQC0OnXGlcxPzZRiqldRXOTuqGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrCTpPn5rkrXjovgLJHVrm6jo983v2cHflTxuKp20MePjMqp+0+V08vzdnNGtWV2JxWlKP5Gr93i3l3bp+FJX2024OQ2qUwBNuGkcC6glTDl9vDPP3K8mHdNo4RrzaIGvlx3wSOIbMMlTRzVahSOW9UMZcIEFhK/dA0hSw10ARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aaLrx8L3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aaLrx8L3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JMTefa030507;
	Wed, 19 Jun 2024 22:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=RENt8jh04NEcUbAUD+vObAL5vQd
	Qo/kTbVZK+0UNgFg=; b=aaLrx8L3wkgsgQeTMXMM1VZQlYLSeUUvV090f9XVgEK
	wNppUV3rwGK6HrOkxHsSyND7FKLsgxcnUA54fx0mRvJO1SeCyDpiYRl8t8UTHpzd
	9d0vMuUVR221vy+L3qRBwqioDjfSv6j305AiHHWJXkv/oC0VeHt9/5HINfqDwf0U
	nkEt2C+ADZ+0nviQ8Q3nVqD88VuPrg5ubpY4PJJ+F1c+IgbTu+g1GU99lGVrASul
	9JKBS6kRqaqzdypdFmRS9DB6kgiCgecMElnm9mPrVJgER7yfyfkvb3Hl5N0K3EXh
	5H1Ug+5YNTs75pMV/PIBwCxf3jx9jx9mkGzZiFtWtRA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv85cg1au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:45:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JL81SA013397;
	Wed, 19 Jun 2024 22:45:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysr040bn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:45:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JMjJTX47186360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 22:45:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 367972004B;
	Wed, 19 Jun 2024 22:45:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E40D20049;
	Wed, 19 Jun 2024 22:45:18 +0000 (GMT)
Received: from localhost (unknown [9.171.70.82])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Jun 2024 22:45:18 +0000 (GMT)
Date: Thu, 20 Jun 2024 00:45:17 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] s390/dcssblk: add missing MODULE_DESCRIPTION() macro
Message-ID: <your-ad-here.call-01718837117-ext-1988@work.hours>
References: <20240615-md-s390-drivers-s390-block-dcssblk-v1-1-d9d19703abcb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240615-md-s390-drivers-s390-block-dcssblk-v1-1-d9d19703abcb@quicinc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bpsCvdTInmVTygH2K96skQBhOX8ZjrCz
X-Proofpoint-GUID: bpsCvdTInmVTygH2K96skQBhOX8ZjrCz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=763 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190169

On Sat, Jun 15, 2024 at 07:34:50PM -0700, Jeff Johnson wrote:
> With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dcssblk.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/s390/block/dcssblk.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks!
