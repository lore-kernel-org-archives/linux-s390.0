Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0466A376BE8;
	Thu, 20 Aug 2026 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787210987; cv=none; b=sCcXKpYn3kT+OzoE4SoAaLWmwqgq5CTR2/WpZ+jz92dVqtt1SB/yjEzZoBf25B32K+VZWPKZ8LvrdmacIoXrGZTY0Oz7Mt9P4bE1VxTbdi2wnKZiyp7P7EoSpobCS732yYOIr78N021zBRavy3v8I//biIolZsL2imH7KPYJMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787210987; c=relaxed/simple;
	bh=ABwnA1DnovY7/cSFF/R+WVZBKRWaV+aVHTBpiH4z1wE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=d9a2oiIoWJGXhKLuZ2q6erg032FQkGMxEmz14HFDkEQzdpv87Ig3l3+KGYQZ25RaCNZQ5NHiYfPJQGb6PL7Aj8Df8/4JeG+SsVle/q61uNSUW5Q8Dv0rf2mfYRnM59PUb4KHS0Gj/RcfAThXlyXY1eqbxzrNN1itfse9C7icljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mFEIEOpl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mFEIEOpl"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JLVlNu362217;
	Thu, 20 Aug 2026 07:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D+090Y
	K0R/TIgfIDoX6dOaYl0gyOWV+ZQbB2Uuo1M8Q=; b=mFEIEOpldnbGKcCODC76oX
	aNjVDRsY+nqt7UJsqfHCmr2CjL/7yS/IpQ5rt/oMkvHaDWX6mVMzF2qZxRO4fbxp
	LgoSJDs2VvKS3GpAqCxekwv/Qjx+TsF+9YRkooy0o95Fil4LTxMOYveo+43/eOR2
	7R7xdnpXlN2FUG6g4RZZwdk+ydqgoQI03csIhTTFTFVTMJdPCDfeATt3JCcCqAoA
	q6fY2tSRipjVb5TVTdcT4JeabGAq9G5dgAOjnP5g9n0FpkfkHPMpavLx0ytN3jSs
	/PC+b9gpJz/0r5Im7IZ1+pLIW4lX1a/t3nAlpTt+eoSmwwYxx9sSNnk+d/V6aSbA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu48kcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 07:29:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67K7QIYD001011;
	Thu, 20 Aug 2026 07:29:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ymwuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 07:29:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67K7Teho41484652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 07:29:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19D632004B;
	Thu, 20 Aug 2026 07:29:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B58F820043;
	Thu, 20 Aug 2026 07:29:39 +0000 (GMT)
Received: from localhost (unknown [9.111.13.52])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 07:29:39 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 09:29:39 +0200
Message-Id: <DKTLF1G2Y3IJ.1BFJVN2AVM17U@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev"
 <agordeev@linux.ibm.com>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 2/7] s390/pci: fix use-after-free race in zpci floating
 interrupt cleanup
From: "Tobias Schumacher" <ts@linux.ibm.com>
To: <sashiko-reviews@lists.linux.dev>, "Tobias Schumacher"
 <ts@linux.ibm.com>
X-Mailer: aerc 0.22.0
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
 <20260819-s390_irq_domain_fixes-v1-2-826ff27b6e97@linux.ibm.com>
 <20260819092018.9658A1F00A3A@smtp.kernel.org>
In-Reply-To: <20260819092018.9658A1F00A3A@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA0OSBTYWx0ZWRfX27eNeiZicUi/
 QOxvQvu5oQ6tWxThhvwIjMJRLHsQpUklLbOuc5LvSUQsXTGLzIZYJyKeok8MHb03rVVH31Pveq8
 BIebqyrbt+Zm9+9xXVCHLEZg1ZGXvFU=
X-Proofpoint-GUID: 2zYS7HINpzyVY580NI4K5aqrxR-U56Uq
X-Proofpoint-ORIG-GUID: 2zYS7HINpzyVY580NI4K5aqrxR-U56Uq
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a86ace8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=nseg9Ktxjk6rGLH3sdsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA0OSBTYWx0ZWRfX2d4rqDj7rT/J
 KqElOPWB6LIcIiQane3cMqMyS0D5dwP8zBIZUKINqrxXstxm52e+lspmPfD/pZlUDOvFaUQ4bhj
 rr90OZ+kE2m64f4dXgruY/AkY/ruBlGeblyagC7+nIv1TJj2OWNFQyDgxEidNuG4WE+0nfkjGqE
 /NYKpnkfoY2o+1lT2u4dZnq6WdVsOrXfN/UmxoD64IL2XnP5eLcoAvP5sHTYAbEKmyAQv6MVL1k
 Z4ndv/4e3f4ZKpHoL2lsAMiwmNRtQSgKx+Hk925i0pdqAqQxJv4QDheMvajq6icDme9NC0PYjju
 JLy9Onzcw+FVBkQiVAfn/Nx+qJrz6PVwh1cdrqOf1JAg2iuWEPYspe9yEMfQsA3AsgbbWIdcobM
 eoJhxtx5mJNAhDzOJ/ZZgeaF4i7zpTmaU2piB/BgCmiH4VpMgFMJzMhnqyJuTfSfTkfONWKyx+T
 NGxGZ8ayG+Cy3SSwKHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200049

On Wed Aug 19, 2026 at 11:20 AM CEST, sashiko-bot wrote:
-- snip --

>> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
>> index c9520a16ca753..94b03d16006ba 100644
>> --- a/arch/s390/pci/pci_irq.c
>> +++ b/arch/s390/pci/pci_irq.c
>> @@ -278,8 +278,14 @@ static void zpci_floating_irq_handler(struct airq_s=
truct *airq,
>>  			continue;
>>  		}
>>
>> +		rcu_read_lock();
>> +
>>  		/* Scan the adapter interrupt vector for this device. */
>> -		aibv =3D zpci_ibv[si];
>> +		aibv =3D rcu_dereference(zpci_ibv[si]);
>
> [Severity: Medium]
> I see that rcu_dereference() is used here to read from the array.
>
> Does the write side in __alloc_airq() also need to be updated to use
> rcu_assign_pointer()?
>
> arch/s390/pci/pci_irq.c:__alloc_airq() {
>     ...
> 		/* Wire up shortcut pointer */
> 		zpci_ibv[*bit] =3D zdev->aibv;
>     ...
> }
>
> Without rcu_assign_pointer(), the required memory release barrier is miss=
ing
> when the interrupt vector is published to the RCU-protected array.

Yes, will fix that.

>> +		if (!aibv) {
>> +			rcu_read_unlock();
>> +			continue;
>> +		}
>
> [ ... ]
>
>> @@ -346,9 +353,12 @@ static void zpci_msi_teardown_directed(struct zpci_=
dev *zdev)
>>
>>  static void zpci_msi_teardown_floating(struct zpci_dev *zdev)
>>  {
>> +	airq_iv_free_bit(zpci_sbv, zdev->aisb);
>> +	zpci_ibv[zdev->aisb] =3D NULL;
>> +	synchronize_rcu();
>
> [Severity: High]
> Does freeing the bit before clearing the array pointer create a race cond=
ition?
>
> If Thread A (teardown) frees the bit, Thread B (initializing a new device=
)
> could allocate the exact same bit from zpci_sbv. Thread B would then allo=
cate
> its vector and assign it to zpci_ibv[bit]. When Thread A continues, it cl=
ears
> zpci_ibv[zdev->aisb], overwriting Thread B's valid pointer with NULL.
>
> Could this overwrite lead to permanently lost interrupts and a memory lea=
k for
> the new device?

Looks like you're right, I'll investigate and fix it in a follow-up
series.

Tobias

