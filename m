Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18DC231C8E;
	Mon, 14 Oct 2024 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896094; cv=none; b=hkp5Z16Vm8IrhuCQrQydQHC4YT47c/TBbSAEeL2VMe8FTfLdwCs2gzHqzsqgslis+pID9vvwKk2558STZsjGjZMCDnjEfHrWzPtH5EimeVi4FlHvkv+TV4WmbbFqTPy4YXWN3HVNZzc9IMinHzqvh+S7h17mKnGUfZsZk4Oe6NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896094; c=relaxed/simple;
	bh=334/kP1ZS9qqdH61za7BkXxyez1dWPdwP5jxmw2QOgc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EqciLPWRe6j53FvXlpBbaQW2tB/EahaxhcC21hwAlASevQynblqJt/pe9JoN1p2drsvht2DK9dwJ6H2EB598xZzK1D4UDAwuJsEm6F3AM1XHx2Ha82/yL7kS2lE7SzDvxDp5hN+oWeM3T1CmnKjVmdZm89FGRPoxArlGJs36vrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YqiJ0JbC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YqiJ0JbC"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E8LkHf026351;
	Mon, 14 Oct 2024 08:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	g20+vSwQPCR+VxKd35Vza9wQi09ArdNbwM3n/b5/10w=; b=YqiJ0JbCyE8gGssW
	ZM8K3f7M+CZziAbwJuAVxqAnz95lBx4tZCAZjFb7PdMrbHEdbeH+5yHIVavgYeeC
	ZixJEqDToRA2ncV2qqjVBsRcmmIhRX4gMj7agqmq32O073cMcSXG9kQwgZHtaCtx
	AHGCNRqLJdDk+EvSa34lrw201IfD6Y742MIKVZe3id/xyy8mBmRD4qlL5PeIarKw
	NgQUKZ8s83jR81T0rCKa7DsiOOt0QKgdJcsmfxoxMdMaUKT8h7qqIX//gbzyATsm
	/m/AvPpkerYHQc9AeZ6kzN7erbqdtmBjBuKSPomBehsu8aAtbWmDhUVKmhw+OIwc
	9vM7kw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 428yq4046p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 08:54:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49E8QQse006843;
	Mon, 14 Oct 2024 08:54:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xjwdpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 08:54:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49E8sTBO23790106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 08:54:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5774920043;
	Mon, 14 Oct 2024 08:54:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AB3D2004B;
	Mon, 14 Oct 2024 08:54:29 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Oct 2024 08:54:28 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/2] s390: two bugfixes (for kunit)
In-Reply-To: <20241014-s390-kunit-v1-0-941defa765a6@linutronix.de> ("Thomas
	=?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Mon, 14 Oct 2024 07:50:05
 +0200")
References: <20241014-s390-kunit-v1-0-941defa765a6@linutronix.de>
Date: Mon, 14 Oct 2024 10:54:28 +0200
Message-ID: <yt9dmsj712uz.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IMkdp4OlovZoU_cFZnvrm2k4wYUXoIk-
X-Proofpoint-GUID: IMkdp4OlovZoU_cFZnvrm2k4wYUXoIk-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_07,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=548 priorityscore=1501 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140060

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:

> When trying to use kunit for s390 with
> ./tools/testing/kunit/kunit.py run --arch=3Ds390 --kunitconfig drivers/ba=
se/test --cross_compile=3D$CROSS_COMPILE
> I ran into some bugs.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> Thomas Wei=C3=9Fschuh (2):
>       s390/sclp: deactivate sclp after all its users
>       s390/sclp_vt220: convert newlines to CRLF instead of LFCR
>
>  drivers/s390/char/sclp.c       | 3 ++-
>  drivers/s390/char/sclp_vt220.c | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> ---
> base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
> change-id: 20241014-s390-kunit-47cbc26a99e6

Looks good to me. For both patches:

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>

Thanks!
Sven
