Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2713A3AE1B8;
	Mon, 23 Mar 2026 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273448; cv=none; b=geVKa6LIj8ClK6to7Qpyh3Is3rMa1zLnWdcg3ipGRTiA5omulWUBTiogzYv5nsK60xi4U58uvSehW0A8Rf1odgupxRBiykGNISsmUJU8FAqH062XkACdDVVKLA+PUWrLGYMW3Ua5vNp8e0PV809ANiYXObAq8MQAymx+Jl3QAbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273448; c=relaxed/simple;
	bh=AKu1YaPhPPZaOaFw+r4TZS3TahnM2+GdXaXeiNaCJA8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:Cc:To:
	 References:In-Reply-To; b=Mep/dsu/ryDz+TV5Oo/S5xto+ZvrxzBTq3pHKH731rDeCBOe8ScW677uhSm2ZwKC0wyN/mZhZpx4rXu58CGF4k6CtYeG1EvDfo+NBF3OxlhWXlv0nFN7kgRbMtQ4jkdL2fOdSR2ufFsvxh69JeosL+YJcE96UyKkuO0X0QetUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EFtTJj/m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EFtTJj/m"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MLt6hu488451;
	Mon, 23 Mar 2026 13:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=E9UIHq
	w4xgdh6LZZONwad+M5bnFdSEcA68tjkCouitc=; b=EFtTJj/mdUHwoKg6/BPiFz
	xJY1b4zG8x12xCXfcu/w3JeMJMEt4MUjsJ4l3CmJjadkFdlaGSf2mm86cymTZWiL
	DVhtPTaoGnVNBGIEyteB+hBm6YQijvLQWdgjCeKhXwDKckncGX4uPDpBrFbth01N
	pLQ0eynxPkNxPkjD7/eo2wOHs8akTZNOwFEssTum8ymmHUcO7IyHe0rtRQIyDDjf
	quSNx1ZRVhxWPjl79kFp6+31ysdsg8NtD2l8aPxHyCSkR3AWX9SSFHuESqLZGuE0
	if0or2A5qjH4mFjozWZLUI70rrujWSTflUnovSY8WAkZKiSl9AKDTF0aNdgmwgMg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumet08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 13:44:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NC0PAX005976;
	Mon, 23 Mar 2026 13:44:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ydnj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 13:44:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NDhxfK29885000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 13:43:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4A5920040;
	Mon, 23 Mar 2026 13:43:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE0F92004B;
	Mon, 23 Mar 2026 13:43:58 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 13:43:58 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 14:43:53 +0100
Message-Id: <DHA7FUZXVHSE.2CFXV16WE8PDA@linux.ibm.com>
Subject: Re: [PATCH v2 1/8] KVM: s390: vsie: Fix dat_split_ste()
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <nrb@linux.ibm.com>,
        <seiden@linux.ibm.com>, <gra@linux.ibm.com>,
        <schlameuss@linux.ibm.com>, <hca@linux.ibm.com>, <david@kernel.org>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, <kvm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
 <20260320161542.202913-2-imbrenda@linux.ibm.com>
In-Reply-To: <20260320161542.202913-2-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0e-Su-VIdUAIXevdtnsTfrklmrCjZ8HJ
X-Proofpoint-ORIG-GUID: 0e-Su-VIdUAIXevdtnsTfrklmrCjZ8HJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfXxJeAOu/QUS5R
 HAUzMQLsehdnIaXMXV673v0BxjMcQv/4TPZ3nQ9SguRJHREVD/KFquQsOOhBwD6ZZQ8vYqJAFLG
 Fuy1JN81iTHgFaGcsLj85bSzrCPnP2mXVBMzflL+h5emjAorLrmIQvKt1iCVj+emRV9bXMKqPJi
 jgEjis/JjOHSPs+QQwpyJ1Kb+HzPocYBLbXtkYee4MFGCeSml7cscuCb9GIpoJomZV2EUEfIz7d
 9qa/WQ37OOVCcfoNnRw5Y+D9PQgO8otlnxQZax06LLN5em4PdEXqPpNP/eL/Uz6kYscmJYl42x3
 D/jFimfz0Pp0biMGv0U8Md+iONEmmw9nbFui/Cum744dS91amaIaqZ1xbJPkACwPTp98cAf88O0
 FZDKIjRkawWRydjZyGvBa6uC/IIo0IhF20c6CeqmfMnMQCIz2+BIM9gKYez1tHtDo7q0CKkvLPp
 0vAZ3snPx/qypVibXMA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c143a3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=buXqh26OFB9ADXD7E0MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230103

On Fri Mar 20, 2026 at 5:15 PM CET, Claudio Imbrenda wrote:
> If the guest misbehaves and puts the page tables for its nested guest
> inside the memory of the nested guest itself, the shadow mapping will
> lose synchronization with the actual mapping.
>
> Propagate the vsie_notif bit from shadowed large pages to smaller pages
> when splitting a large page.
>
> Fixes: 2db149a0a6c5 ("KVM: s390: KVM page table management functions: wal=
ks")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/dat.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 670404d4fa44..48b5f2bcf172 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -292,6 +292,7 @@ static int dat_split_ste(struct kvm_s390_mmu_cache *m=
c, union pmd *pmdp, gfn_t g
>  				pt->ptes[i].val =3D init.val | i * PAGE_SIZE;
>  			/* No need to take locks as the page table is not installed yet. */
>  			pgste_init.prefix_notif =3D old.s.fc1.prefix_notif;
> +			pgste_init.vsie_notif =3D old.s.fc1.vsie_notif;
>  			pgste_init.pcl =3D uses_skeys && init.h.i;
>  			dat_init_pgstes(pt, pgste_init.val);
>  		} else {

