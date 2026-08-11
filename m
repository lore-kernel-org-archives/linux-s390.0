Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9AB3B2FC0;
	Tue, 11 Aug 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462507; cv=none; b=atvaQygrEOMz0JUFkyQ5D4AYnH1o7GxADv8nKzPFrXLN0pbiPKe2UTdFePmHUW6MWJKpB0eoiP9JzYHtp6dF1HEJSh8ks1qecSncuYkC/tlFeV2vF1jbRWSCeOiEjqzGxJa6FgDan/dHU0Y785Lw/Fw1i9GIvamrB+mIvQ4ktJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462507; c=relaxed/simple;
	bh=DCUebQ9V8fMRtn82MnZZb0OI61yCyd7PjBW+TId1XWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBxvHkQ5fW1ICCyp82fofMkq0L804doW95flwTlp74dDXrZ8BuPd333G2dGAwIfnEnI3y69QtmHTp7Kh1/RJMIzMC+81XaiEOJ0XTuF9m0feRxJv/hpBYS9XJdANvqHpkSQWCbuuswHqWLV6Q/qZzj81ETMCA/b1ARSABj+fUok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MsFNzkzk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MsFNzkzk"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWQo0492235;
	Tue, 11 Aug 2026 15:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o97Gzo
	SRughNKsR92ufPLc22buJITxxFjzRxBh5LLmA=; b=MsFNzkzk/1SbhTIGcoICWu
	lLV/Slq9ajsYWhq6ZxMn8eKbyjq22jdT6jcfEGyRsPoTgeHQ6+TRlA60hZz9RrGL
	30RxXiuCGJYtOb7s1RQ9TI0HgibzqNBgTy5iM19Lr6cq70lx+Q0Kg5I0c0yAceDe
	4XUyXC3Swfi9NJyXrnf28EYRqrBPvg4gnpKgIKUjatWlYHyeam5hcUk2DXg9NYcx
	0bU2UkDd+QApY4ReJIvMc50U1yCPoDoTt3OZ2ga80PU72+VRCiivR7vMk5dh7OA8
	wtYRh5Y1NYSo9JIJGOPFBu30NEfZqHttwfQE025KoBLExI0H2nMXmGVnc13dD74A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9dp4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:35:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFQFR9025179;
	Tue, 11 Aug 2026 15:35:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq1pbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:35:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFYwa039322034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:34:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4FE920043;
	Tue, 11 Aug 2026 15:34:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85C4220040;
	Tue, 11 Aug 2026 15:34:58 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 11 Aug 2026 15:34:58 +0000 (GMT)
Date: Tue, 11 Aug 2026 17:34:57 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Harald Freudenberger
 <freude@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: uv: Fix loop condition in uv_find_secrets
Message-ID: <20260811173457.6fb3b438@p-imbrenda>
In-Reply-To: <20260811-uv_secrets_fix-v1-1-940a421a9292@linux.ibm.com>
References: <20260811-uv_secrets_fix-v1-1-940a421a9292@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NMX-5RtiBklXOiSihNBFr9d1SopeoF7p
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b4127 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=q3jhUv3Av2XTsyYR1iQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfXyu57bu3p+zrQ
 l6Y2WG25mfhZvgoxXo2SieqDwDrM5SK/+Msqs34M1+DIdnFGJhoL4p55wHK5tz7Qht9I7u3FIA0
 iQVShMLLkYTsSoiaRCBHDzAGro4Y2RF5MpPpYMG3e7Vu2i51ApNaXmOZxexOoIBZAcS3X0kj99M
 BZcMF+YUB5sdqPhfZvoR1S/3HEb151GoYoSGiFHZdMGvHT0Nk+CPizwXoN7XISGlXswcYgLSBuy
 WyYQfkifCE4q9O7I/cllRwp0ps/5vEPdc83HP3TPlzUr66JLHuFMQFWQv8PQQylEqDz9LUBrwte
 m1AQKH1YiijfsyGm10iB5M4cnYrtFRxiNRVx/mpP0x9exaNGvpmoK4jbEhjw/mKhDvivBQaDIHb
 CSuRbaa6p9tk4VQM6jQZcTe+Mi6enDGNZhXGI+LdGP/CtdpAJRw/2WpvlrvxRfZYg6kErWhOx2j
 6nG7qMrNdEKUYxV+vbA==
X-Proofpoint-ORIG-GUID: NMX-5RtiBklXOiSihNBFr9d1SopeoF7p
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX3UYfJQy3UUU8
 RfZqW5tH0X/ZxWXwrJ0WVmMgslAIYVuNNeIwupkDWeE6HeG/FP46vldYi7RxAiKPgL2/9Oym/vJ
 ZCJmr1GyWTKfbZ8sUP1ob3+T2deHk64=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110130

On Tue, 11 Aug 2026 10:43:52 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:

> Nothing modified `start_idx` between the assignment and the comparison,
> so the=C2=A0condition was always false and the do/while ran exactly once
> even when the UV returned UVC_RC_MORE_DATA.=C2=A0Systems with more than
> 85 UV secrets got -ENOENT for any secret past the first page.
>=20
> Fix this by setting the start index at the beginning of the loop not at
> the end. First test if there are more secrets left by comparing
> start_idx with list->next_secret_idx, and then set the start index to the
> next secret index.
>=20
> Fixes: 7c9137af2042 ("s390/uv: Retrieve UV secrets support")
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kernel/uv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index a284f98d9716..d970b15ef126 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -781,11 +781,14 @@ int uv_find_secret(const u8 secret_id[UV_SECRET_ID_=
LEN],
>  		   struct uv_secret_list *list,
>  		   struct uv_secret_list_item_hdr *secret)
>  {
> -	u16 start_idx =3D 0;
> +	u16 start_idx;
>  	u16 list_rc;
>  	int ret;
> =20
> +	list->next_secret_idx =3D 0;
> +
>  	do {
> +		start_idx =3D list->next_secret_idx;
>  		uv_list_secrets(list, start_idx, &list_rc, NULL);
>  		if (list_rc !=3D UVC_RC_EXECUTED && list_rc !=3D UVC_RC_MORE_DATA) {
>  			if (list_rc =3D=3D UVC_RC_INV_CMD)
> @@ -796,7 +799,6 @@ int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LE=
N],
>  		ret =3D find_secret_in_page(secret_id, list, secret);
>  		if (ret =3D=3D 0)
>  			return ret;
> -		start_idx =3D list->next_secret_idx;
>  	} while (list_rc =3D=3D UVC_RC_MORE_DATA && start_idx < list->next_secr=
et_idx);
> =20
>  	return -ENOENT;
>=20
> ---
> base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
> change-id: 20260811-uv_secrets_fix-58a63b4a4ec4
>=20
> Best regards,

