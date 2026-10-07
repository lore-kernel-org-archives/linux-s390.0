Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B53D9043;
	Wed,  7 Oct 2026 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353078; cv=none; b=H3oYZA3Uoz7H5z+BKdGMqlRGihQyzBK3N0d3S4xswKf6r7FyJAowJLeuwS18dHTAviRomB+7oEASWvAsNFBnNgY3zuYEtVyrNqOip4hYP/R84LzQgZF+qsgxoYELGLY2+nct6q/4aTQ6Mk1Zi5u5xNJbQBl1kycM81Y1SSkwol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353078; c=relaxed/simple;
	bh=/t8TP1dCSIGnZBiigTCFs+h2I5ipbOac2mAqhEjT8N4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pegFArHQ+ov7AQUGwbsbnAtCurCaggZSIt0SWhYK2Tm1RBuVwfaYzmFofuqQ/X8DRARdC9/yYD3Ayxr4oJqhdINI/oE4CZTtlarTzwH1s6FDHw/rqP6BvnwHm2SGCfQZhKBvTDAX1I7uygHKirst4Z0IeeS/yf25zVDWiEJkyVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ov+vO6Lf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ov+vO6Lf"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6974alV41618712;
	Wed, 7 Oct 2026 06:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z0k3He
	zroMzvIvj5WTEo3kKoHszdINyM9gd4MS3C244=; b=Ov+vO6LfZzOoycb83d6H+Y
	TNcmPxy7bwpqkYveMANhgptjVRUWJ2LBUnsiVWBiLpCrFRCUttw8+NA0k7KbCQ5f
	VxJ3pM3t+OIreZJt4WE24hClggIVrA+6SemdjmtzC8KTKigJwlOJgqWiyoLrX73r
	LgLVLIPcyOC4oykv5gZKJ/ka5hEszYoAn7FkhNUN4MYrV6KC1zJjNzjvylHiVRVb
	FxIoy4woTjwR8fP7r6MatBZCdgFpMBYQIUOpkBCWBcMzYdTDUfo4HJQ841TvMqqE
	pRFBQOlweyyoqtc4ncw5pI+2sB13WaeayCjoMH3fT4zcxOW/+HkqQ5OVLoR4Ribg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74uyh6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 06:04:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6974lcgn1349200;
	Wed, 7 Oct 2026 06:04:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvwdke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 06:04:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69764V2u35586314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 06:04:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED77220043;
	Wed,  7 Oct 2026 06:04:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6310520040;
	Wed,  7 Oct 2026 06:04:30 +0000 (GMT)
Received: from localhost (unknown [9.111.168.1])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 06:04:30 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 08:04:30 +0200
Message-Id: <DLYDNZO7F3C0.2X767HD7G8PDZ@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik"
 <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Sven
 Schnelle" <svens@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] s390/pci: Add error cleanup in
 zpci_directed_irq_init
From: "Tobias Schumacher" <ts@linux.ibm.com>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Tobias Schumacher"
 <ts@linux.ibm.com>,
        "Gerd Bayer" <gbayer@linux.ibm.com>,
        "Julian Ruess"
 <julianr@linux.ibm.com>,
        "Farhan Ali" <alifm@linux.ibm.com>,
        "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
        "Halil Pasic"
 <pasic@linux.ibm.com>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>
X-Mailer: aerc HEAD-0d169b7
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
 <20261005-s390_irq_domain_fixes-v2-5-d45b824874c0@linux.ibm.com>
 <2321a5e161cc30281464302cc12810ae62c286ae.camel@linux.ibm.com>
In-Reply-To: <2321a5e161cc30281464302cc12810ae62c286ae.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hWOvYAegeihi5hyztozdxSftmZIOwo6M
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyMiBTYWx0ZWRfX5vmbFQKpR9HF
 eob8Q5R+NE0wwI6pS66ySyWFcLIZEGLKXksDqYPJXaYvWgYJPEn6MTzWzYYgtNH/gGogG9PqGuW
 qRP5Ke1cSrkjS92iUWYzJBZiW/rJpGM=
X-Proofpoint-GUID: hWOvYAegeihi5hyztozdxSftmZIOwo6M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyMiBTYWx0ZWRfX1KCIfn8NNw4D
 ngH2nUI7T/zlyZ4EXrNsu5Sd2DJSoMbcgjAoTZ97HNm8/1Q7nbnWIj/tker3Pj4P20aEgM4ioqJ
 TWPmPlpk1aBGrRv/3IvlH5pJ4lfDTrlXIZ35wDPZaIz8Kkgf5eEEJXyvgkrfMRzCCbAJOg0gSZI
 bxeUekZ6Rr9FTKy+v08GNvH3QWaL/TN9ZWdwIWu/o9gF4nAT7DpurppuryZvZ15i0251P73Abnh
 +hkdAhvoVMhqp/wAYNhHAM8a+VhEdT3lTPxjR2t/A4MzQa3gerNFpv+Lv0lG/DpOBVH9PW9Z69C
 MljfaTN6M4aK8ozWTifv7L1VUnXFuvjgpNvCeY0o3BoFh4ADiNG4Dlg4CA2sYO2uPCY63niVzbL
 axFhTzOYb2P6CdfSWKXhvQBQtb9KmhIFvLFln5/cyyxqDjP2PkrPre89ht/k1mspXdmeCD4Lofj
 EHv25EbNtR+gvTwSEzw==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac5e0f4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=ghh8Ew2c7-8p14jUzxUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070022

On Tue Oct 6, 2026 at 3:32 PM CEST, Niklas Schnelle wrote:
> On Mon, 2026-10-05 at 14:03 +0200, Tobias Schumacher wrote:
-- snip --

>> +
>> +out_free_dibv:
>> +	for_each_possible_cpu(cpu) {
>> +		if (zpci_dibv[cpu])
>> +			airq_iv_release(zpci_dibv[cpu]);
>> +	}
>> +	kfree(zpci_dibv);
>> +	zpci_dibv =3D NULL;
>> +out_free_sbv:
>> +	airq_iv_release(zpci_sbv);
>> +	zpci_sbv =3D NULL;
>> +	return -ENOMEM;
>
> As Sashiko notes this doesn't undo the
> zpci_set_irq_ctrl(SIC_IRQ_MODE_DIRECT, 0, &iib) and via the iib leaves
> the zpci_sbv->vector that gets freed here set in hardware. While
> Sashiko also notes this is an __init function and these allocations are
> extremely unlikely to fail I think the rollback is still just nice
> form. I think we could simply move the zpci_set_irq_ctrl() to after the
> allocations but before the cpu_enable_directed_irq(). It also seems
> more logical to set the interrupt mode only after memory has been set
> up.

Agreed, will change the order for v3.

Thanks,
Tobias
