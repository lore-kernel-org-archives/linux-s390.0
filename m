Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6514FC8FD;
	Mon,  7 Sep 2026 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794720; cv=none; b=YetoV46kXjsrKC6LTiISygk45ezUOeEqfQKbQBbAeyYroKVd2xlOJPiTVqXsGHsVCNmqA1RMgbk9JM5j5yERWqcfu+o3xWOZbEklu6o3qafg2iqtdMHqgMK8ibHjz92SWO0DbjxsQ7GGxQ9L8325jfiT3N9nnKYXDAHAJsgVLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794720; c=relaxed/simple;
	bh=eKzDr8/wCeQCg2/90BjHTxPETEeWJwmcwT2sGZGhowc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JeWwyO6S9RG9ZlPuPgSj5EevEsOAH8PqB8lTUfGJ1omZ+a4wLcPCZqGxn29CHWGX6ODZhMQUfd8qsQGy9TtK2n7ndSjU29fpJnHA7oATjWCqFlYjUlZfikUhh3CRWwYwgSECkqg4ib0D2tu2B7OwVCP2iSJgLmA/iiIACgRQ1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aQHS8/MQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aQHS8/MQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687E1Xmh2191807;
	Mon, 7 Sep 2026 15:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gSJtfM
	shSfXkqFoQ/Va92ywCE30Yrb2WoQsAi6r9XaQ=; b=aQHS8/MQTStBeL30OG+qAO
	j9XZWRNK/97Bt3ZPSeMxuOf0vILlOhRMfaRAoI9oIXSjdmeaqmRxh4wO/YxpWBqh
	4d2Erz3ZAXcElilKPD1lpR/ixa42HuaYvhR+SFrwEE9QluPi8WgqshViuuqgZB5+
	efHq7p3Ev7gSRevlTEY2KuADQfubpx30qJBndELRR48A5f/ZELqsjXVsPQ7EJINW
	j6igc4SCGWIgh6YC93aUQjozNjRpcA9vZUXYExg0+no7Y6W/IDIyfwKR+4XyCUll
	XH6Cb/KZE5YQeBRfCmjL2MvVEUAb0RdjpLbSbaUHgtO1FtiZlpBfC3JhiJdxhsjg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhesc11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 15:25:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 687FBG3E017847;
	Mon, 7 Sep 2026 15:25:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymg6fej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 15:25:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 687FP5v643450774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 15:25:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3899620043;
	Mon,  7 Sep 2026 15:25:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A567320040;
	Mon,  7 Sep 2026 15:25:04 +0000 (GMT)
Received: from [9.87.150.24] (unknown [9.87.150.24])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 15:25:04 +0000 (GMT)
Message-ID: <98f11271b6574aa945755f073a3bcec8f69a02e9.camel@linux.ibm.com>
Subject: Re: [PATCH] arch/s390/pci: fix fixup_user_fault() calls with NULL
 unlocked parameter
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Liu Dalin <liudalin@kylinsec.com.cn>,
        Niklas Schnelle	
 <schnelle@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik
	 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Matthew
 Rosato	 <mjrosato@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle	
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Deng Yingchao
 <dengyingchao@kylinsec.com.cn>,
        Qin Yungao <qinyungao@kylinsec.com.cn>,
        Luo
 Qiu	 <luoqiu@kylinsec.com.cn>
Date: Mon, 07 Sep 2026 17:25:04 +0200
In-Reply-To: <0726CF177011E0E2+20260826064228.3255764-1-liudalin@kylinsec.com.cn>
References:
	 	<0726CF177011E0E2+20260826064228.3255764-1-liudalin@kylinsec.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nJa_E25ZscRu5YZVdGbVbWd_q596R95w
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6a9ed755 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=C4lfG5toAAAA:8
 a=HXg_6OqaGmJXRC9Fbd8A:9 a=QEXdDO2ut3YA:10 a=iqleXTDqv_QQetf3OR0u:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE2NyBTYWx0ZWRfX9i6Q2Mx4fDsi
 mmL3C1S7DEqvh84mmsRbB2Hwjb1CuHGoRZy/TzndoBywhzqqQtuZyxJWyB3NG9h3iROZtcMjLVR
 TiLYSZ9YD4fMBMkK8JZy/Tdf/aRUut8=
X-Proofpoint-ORIG-GUID: nJa_E25ZscRu5YZVdGbVbWd_q596R95w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE2NyBTYWx0ZWRfX0Ga9Lozmhsv7
 lY9yjR7oUM8IlTNqcK2LnsvlJV52sdeYqXxlUkfRabg5GlMFsKpQAnAOF+7a39WKqNb2TQyaP5t
 XrHJkhRIGRaqiKtkSbGdZUoIlllzNkDzuuilGWcBtoWnH8RZA1koKljWRpAqBlsAVAo4TbH5N4w
 Nzw/kSnP0yUBa+N1B2+UDv99Bm+Ay5ZqQrwN/++rQ4TT9mS5YMiGHajVJC3G+cj8IJ27R4IXZVG
 7g+z1gxsv/uKNSeNlzxRned3CmB8zeNOcHBhFtg3GCLkJLOTAYfymRC3byaqNwR35Vt6koV9gru
 /MnkhP2QdWKEaSfxQHXrkiDd4e4mjBg031W3eaZeeiJCHDoYX3QBTmW/Rs72/tmuqgDh6DgtZL5
 ptDPkJMlhWbm4ce9bPlKHhZKQHkOXoQrt5ZuTQ2BNPlDobGs5VN5T6i2eZCArzzkmYzATuvnPyR
 c0ZRKOImVkpG+2i5J1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070167

On Wed, 2026-08-26 at 14:42 +0800, Liu Dalin wrote:
> The s390 PCI MMIO functions call fixup_user_fault() with the 'unlocked'
> parameter set to NULL. This means when handle_mm_fault() returns
> VM_FAULT_COMPLETED or VM_FAULT_RETRY, the function re-acquires the
> mmap_lock but cannot notify the caller about this state change.

Hi Liu,

I'm far from being a mm-expert, but from reading the function
description of fixup_user_fault() in mm/gup.c I believe that mmap_lock
is unlocked *only* if retries are allowed by way of setting the
FAULT_FLAG_ALLOW_RETRY. Otherwise, the unlocked parameter is allowed to
be NULL.

Since s390_pci_mmio_write()/_read() calls fixup_user_fault() without
the FAULT_FLAG_ALLOW_RETRY flag, I thought your patch is not needed.

But then I got concerned about the comment in the handling of the
VM_FAULT_COMPLETED return from handle_mm_fault() - which got introduced
with commit d92725256b4f ("mm: avoid unnecessary page fault retires on
shared memory types") without changing the documentation of the
unlocked parameter of fixup_user_fault().

I'm under the impression, that so far we saw
s390_pci_mmio_write()/_read() only in use on VMAs that ended in EFAULT?
But that's a question to @Matt and/or @Niklas...

> This is problematic because the caller subsequently calls
> mmap_read_unlock() at the end of the function. If the lock was
> re-acquired inside fixup_user_fault(), the unlock happens correctly.
> But passing NULL makes the code fragile and hard to reason about.

For a full solution, this would have to make the call to
mmap_read_lock() dependent on unlocked being true at the end of both
sys-calls.

>=20
> Fix this by providing a proper 'unlocked' variable to fixup_user_fault()
> so the lock state is properly tracked.
>=20
> This is a follow-up to the defensive NULL check added in fixup_user_fault=
()
> by the previous patch in this series.
>=20
> Fixes: 41a0926e82f4 ("s390/pci: Fix s390_mmio_read/write syscall page fau=
lt handling")
> Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>
> ---
>  arch/s390/pci/pci_mmio.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
> index f3f79ba78410..5ef2d6436d4b 100644
> --- a/arch/s390/pci/pci_mmio.c
> +++ b/arch/s390/pci/pci_mmio.c
> @@ -182,7 +182,9 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, m=
mio_addr,
>  	args.vma =3D vma;
>  	ret =3D follow_pfnmap_start(&args);
>  	if (ret) {
> -		fixup_user_fault(current->mm, mmio_addr, FAULT_FLAG_WRITE, NULL);
> +		bool unlocked =3D false;
> +
> +		fixup_user_fault(current->mm, mmio_addr, FAULT_FLAG_WRITE, &unlocked);
>  		ret =3D follow_pfnmap_start(&args);
>  		if (ret)
>  			goto out_unlock_mmap;
> @@ -335,7 +337,9 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mm=
io_addr,
>  	args.address =3D mmio_addr;
>  	ret =3D follow_pfnmap_start(&args);
>  	if (ret) {
> -		fixup_user_fault(current->mm, mmio_addr, 0, NULL);
> +		bool unlocked =3D false;
> +
> +		fixup_user_fault(current->mm, mmio_addr, 0, &unlocked);
>  		ret =3D follow_pfnmap_start(&args);
>  		if (ret)
>  			goto out_unlock_mmap;

Thank you,
Gerd
