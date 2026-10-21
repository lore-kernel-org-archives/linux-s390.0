Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591311;
	b=Spi4eyXjof18pIg+fhuKxnF1v5ChH0+H9eOZ0BUScYDM7zfS9hazCsJcUChd5erjIOjl
	 4HujuHHtAQrgsqlVkTrTRwcGAfg3la+yj+SMV7RrDzRJ7BXUd63eOqYi6CVBNhzIH5MF7
	 He9ZdBoS+nPpjBQ0EzGKHzP/O0aiDNvuV6nRfIVdgaWr8bLIbb6oPM6mSfpWduiD6XPAB
	 WJe9CTH4T+UGn7wKDQYOp66JmPnUXB482Q5hkG5PShMhyznblxARXxYqYIKL1GaY1rdGR
	 a8GHLphvxxF1cVOTw8wN2gp+rELp9pVJR6uO/6zdZxS5wzvj8UAw0uhKzsoq5qP2kwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591311;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Sender:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Vus+ES+bDW2bgHuxZtQdwHa8Fj67IwfkQ6QwvXBIocc=;
	b=tsFqow5CKAp5U7Nf51Y2TDDf0dPhjvTIMnAahqXBkmDyNXbTYt1T6Z/Q4N2lk+ZWYTav
	 O4sw6ZaeEy6Vi6/H97dLxBiqYiFyJi9l7bCx88YmTRP1S4+sUn1InENVGa+t36qidLvsN
	 E34Ji8zHzHXSv66Fw+qzAVNH78EBXeLwwiCMQp8PXYFWg2hB7wHmVOXOttcb1JnqokSfT
	 czup/Llb+18Rh+TI3G80kYBcRL+RdYVUrd6MFXPNUu/rj9d8Gc3xmuB78R1oefGf0fp+N
	 m/jft+xQfkIu0yEjabSXv9MLMeI6/U81LOSv941I7WGwD7SwM97IpuV+jY3W5TJIH1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jdQQynPQ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF9606A31B
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 14:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BDF9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jdQQynPQ
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBi6hE1082502
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 14:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=Vus+ES+bDW2bgHuxZtQdwHa
	8Fj67IwfkQ6QwvXBIocc=; b=jdQQynPQlqRv6sxetF51/Ac2C8pli27YiIHMaA5
	ue0J3v56ttt4H3pBybzXsYfNqITxodMcglxn202T+Aqxu/1bC77czg416NtBjvih
	bCX/fs153aKqRv2aF+5h9LYCy+65dfNJPdoxVSSIU6KmtMTZ1RHuwGQLgyIk9Mqa
	Zl+L794wycSd7OGRfEK0XP7L+NbL3ftn95e/h1s9C4/LhMiWHpo1aEqZ97pisczO
	njWiXTrEHYTxFb/kKO0Qm0MluGNjOxqaeI7wcYl5ySBapxUN2zW2AuGD2beznLiv
	Q0ZXdkKElU5WSx7QIewud9Ic/CKF2b86974H5ayDCkE3QMg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a9em2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 14:01:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69LC4sc43038599
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 14:01:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hekdgahus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 14:01:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69LE1fY451446078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 14:01:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFAE22004F;
	Wed, 21 Oct 2026 14:01:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEABD20040;
	Wed, 21 Oct 2026 14:01:40 +0000 (GMT)
Received: from vela (unknown [9.224.91.188])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 21 Oct 2026 14:01:40 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.100.1)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1xJWsu-000000024X1-2PFV;
	Wed, 21 Oct 2026 16:01:40 +0200
Date: Wed, 21 Oct 2026 16:01:40 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/3] s390/diag: Add diag204 IOCTL to diag misc device
Message-ID: <atjFxOoK4GbbfZmh@linux.ibm.com>
References: <20261021-diag204ioctl-v1-0-25645b97bf4e@linux.ibm.com>
 <20261021-diag204ioctl-v1-3-25645b97bf4e@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021-diag204ioctl-v1-3-25645b97bf4e@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NCBTYWx0ZWRfXwjhCzo9RM+On
 p+rE8rcgF9wyepje6or+13b2r4OI3BnQauDKLvtTBZaKEY0sS6ZCWpjHpHwx73sXUfuWQotVHmK
 BIbblwDxJwWMRtXHhwSz5W6aCeJIlh4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NCBTYWx0ZWRfXwcoWUb2q1ECN
 1NXYAbOcOYPU6tQ9TpF5+hcwBHDVU8cT39YubQDa48Y/ws4in1qLyWvz4HbT9yfadZxwjIBjD9j
 FMzekdBRBc/gvGi+jRkEVyN2HNbf/Te4XTrcKP+wwuNL29AnM3oNcK58TDKlhk22BNtnFYnSgui
 A/+Rc7sYKwks3oHN2fkX2AfR6smVrtosGntpEHEDpcNcbZWv39EolngDF49MhUKSfY3Vie/W5Gi
 pkt6WPV0AB7LgHTdZYjHW59t/2VguQB0NrmA4N/9Mwg88832iAyzj25lp5zmv9TdaHQ2XNlmYHH
 kIXkhfsFqY4IOsJHwUTKyeJDNlD8jE8dSzL0nM6zotJutanCe9dNv/mG0gv3No/RYQdw3LDM7yU
 Mg9KBniDZHJWvIRxlReIYV4AcD4F4w==
X-Proofpoint-GUID: IvuFW0QlnGSzanQkfDFDFnvWWYeEiS0w
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6ad8c5cb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=8Sqf8kbqV5CRYtRxJLIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: IvuFW0QlnGSzanQkfDFDFnvWWYeEiS0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210054

On Wed, Oct 21, 2026 at 12:28:10PM +0200, Mete Durlu wrote:
> Add IOCTL implementation necessary to fetch diag204 data from the new
> diag misc device under /dev.
> 
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
>  arch/s390/include/uapi/asm/diag.h  |  8 +++++++
>  arch/s390/kernel/diag/diag204.c    | 43 ++++++++++++++++++++++++++++++++++++++
>  arch/s390/kernel/diag/diag_ioctl.h |  3 +++
>  arch/s390/kernel/diag/diag_misc.c  | 10 +++++++++
>  4 files changed, 64 insertions(+)

[...]

> index efffe02ea02e..ac263baf8d08 100644
> --- a/arch/s390/kernel/diag/diag_misc.c
> +++ b/arch/s390/kernel/diag/diag_misc.c
> @@ -35,6 +35,16 @@ static long diag_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	case DIAG310_GET_MEMTOPBUF:
>  		rc = diag310_memtop_buf(arg);
>  		break;
> +	case DIAG204_GET_LEN:
> +		rc = -EPERM;
> +		if (capable(CAP_SYS_ADMIN))
> +			rc = diag204_len(arg);
> +		break;
> +	case DIAG204_GET_BUF:
> +		rc = -EPERM;
> +		if (capable(CAP_SYS_ADMIN))

Why do you restrict this to sys_admin cap? I think that access control could
be better managed through mode and ownership of the /dev/diag device.

Assuming that I like to run a service collecting information from diag204
would require to run with sys_admin capability (almost root authority).

On a /dev/diag, allowing root and group to access the device would allow
a service to run with regular and respective group privileges to access it
(w/o cap sys admin).

We should revisit the device .mode = 0444 setting and prefer using
0440 to prohibit other users and restricting access to root/group ownership
only.


> +			rc = diag204_buf(arg);
> +		break;
>  	default:
>  		rc = -ENOIOCTLCMD;
>  		break;
