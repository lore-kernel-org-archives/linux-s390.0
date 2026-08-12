Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A87832B13B;
	Wed, 12 Aug 2026 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533089; cv=none; b=N9IunDoC1gutW+q/VyYgwWYkYoVIZT3Fyo79/VZFADaSR/LcaySZkON/5X1M2mQlRmj27HpsjcEAHeKT/6JG+grRsHZ4htc0ko3CIQdD4ESlY3MeM/qQUGT8fu6DuXjkRB72rPEnuoJv74SIDqhMyByrBm8Hk8sVfAd1keYVax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533089; c=relaxed/simple;
	bh=txJFGU7J62L113n31e1G08aGE1X/fMjeuYreZn3fav0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=XyV3u3PUc0oxQf/FJHuZt7K04QNt5KS2qw1o4lDHkyI20sz8bCWtWscKhUk4s4+Mlcn4eqdJ+0gWJ1V1/pw2KLp9gMu30j3uolBssrmhixVkYMlexEZhAsSukhc03e9XIZ5/2vKN5M1OC/NXA5o1iehscEH/IYj+Kk6FRdJVGa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Brj9CIPN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Brj9CIPN"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3MZN3303955;
	Wed, 12 Aug 2026 11:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OYIBwu
	rYlLQ1J9On8VqCNHGE0iXLscA34FwDPpJgszg=; b=Brj9CIPN6a+J3+az2+TW9o
	0rKc6Coho0JyDkLb1sXyiBN8VxRrq3u9oR/lPt6j6k7fdcZEOsxRumAn+SOhLO0H
	pQ1aTz0d8Y0ROzgfe3LECLGjtAbey2ZSH1Xg3OONIFdEcVw5QXhU9hr4k3XIWx+A
	RGG1jhlMy1HO7kTAMAzU36lY3PBAxUCC1VOY1q0PTYDUhKKRYfWmxMe5DEqW9vSE
	Tm7I5MqYrJrDHkGqTvPWhIeZVJJYS0IMsbqBITlnhGcvCapkWr2g0+zaoWXuK8/x
	hDmkCHZ0sD2BKSaRy8LUq9X9zqAp9ZBCZbkKPwUSqeR4brOC/Oo234grphuDb4tw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9t49r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:11:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CAuJNj009600;
	Wed, 12 Aug 2026 11:11:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h5mnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:11:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBBLRB35979604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:11:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC6CF2004B;
	Wed, 12 Aug 2026 11:11:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6D6520043;
	Wed, 12 Aug 2026 11:11:21 +0000 (GMT)
Received: from darkmoore (unknown [9.224.78.25])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 11:11:21 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 13:11:16 +0200
Message-Id: <DKMX4D8DCKOD.O92YNFWFMTGQ@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <david@kernel.org>,
        <seiden@linux.ibm.com>, <nrb@linux.ibm.com>,
        <schlameuss@linux.ibm.com>, <gra@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/9] KVM: s390: Fix pgste_get_trylock_multiple()
X-Mailer: aerc 0.22.0
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-6-imbrenda@linux.ibm.com>
In-Reply-To: <20260812104436.109741-6-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4OSBTYWx0ZWRfX85IUhb/+ugK/
 pKECE903e76qSne0z0khWrAcqTzkR2D8QDaKmo7dQVRtp2CohbS6uUYrMurXeHw2MYRjrRyT1oU
 AwbksvYktahbJNQcN4v7AXmATtCHwNZvLg0Gg5m2EPDvgZMYjWkLNApnT/ygOEALRO0Qz3IoV6B
 pQQuHnf4LYlYU2DhVsOLFa5fQ5nV7oUiYgwBJxgebeum9Wmvb2yyY+tIxyRcISoYFQiZbUrDOtr
 TpJfUfX1L+l0rzaOzc3zRwo0qqaqxK6hEf7yraFIRpTNhFZo1RTGKgkXQjWnu/QZQtmwIhoPeyx
 VYplKpq9ItHz1PXiM6E7hqij40R6Z0vPr4TMl5Qi8NCMiykvs2F3C7cM/dBL/gZ59nfVOmwWglx
 qDqLBCH1LOBcLAFxFAEQVMKSb9SvVq7gaA2xyQPx2Fo8Z4+MClP2qAiTfsZqHbU7Sc7WPT0HI5W
 xRBbuAIgW7bN6YvSd9A==
X-Proofpoint-ORIG-GUID: gI7QksIn-XFEcY8rG_7tLUqEtnReMomA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4OSBTYWx0ZWRfX8fWS0TREhQ2W
 dJizEWx2i9fV5O7/HqGn1fwgSCOYR6iIevP1MuGvSNyNNBhlAlLJ/PhNeEFwcI7r02JWRvHmCP+
 7MOzxYlHdxUPPuNfXAnkwwgja7dZ5Zc=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c54de cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=0R0jmd_GHOanYFiHbnAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gI7QksIn-XFEcY8rG_7tLUqEtnReMomA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120089

On Wed Aug 12, 2026 at 12:44 PM CEST, Claudio Imbrenda wrote:
> In case of failure, pgste_get_trylock_multiple() will attempt to unlock
> the locked PGSTEs based on whether the PCL is set. In some
> circumstances this can lead to unlocking PGSTEs that were locked by
> other threads.
>
> Fix by unlocking the amount of PGSTEs that were actually locked,
> ignoring the PCL bit in the array.
>
> Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lif=
ecycle management")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/dat.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 165c704fcf29..f4dd6f783417 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -923,11 +923,8 @@ static void pgste_set_unlock_multiple(union pte *fir=
st, int n, union pgste *pgst
>  {
>  	int i;
> =20
> -	for (i =3D 0; i < n; i++) {
> -		if (!pgstes[i].pcl)
> -			break;
> +	for (i =3D 0; i < n; i++)
>  		pgste_set_unlock(first + i, pgstes[i]);
> -	}
>  }
> =20
>  static bool pgste_get_trylock_multiple(union pte *first, int n, union pg=
ste *pgstes)
> @@ -940,7 +937,7 @@ static bool pgste_get_trylock_multiple(union pte *fir=
st, int n, union pgste *pgs
>  	}
>  	if (i =3D=3D n)
>  		return true;
> -	pgste_set_unlock_multiple(first, n, pgstes);
> +	pgste_set_unlock_multiple(first, i, pgstes);
>  	return false;
>  }
> =20


