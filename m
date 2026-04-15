Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041AE34B693;
	Wed, 15 Apr 2026 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776254000; cv=none; b=WGqq0wdewM4FiGZxw+QNUh2qfJtHuoy7nb0OFWNOU+FLE8FIV5a3LBM9xFw7k76HiIAbF1UJpmDT6xS8OAh3Z+L+JLz0WTB//PHPDlskwJzLHs+wYflSAKEjapXHwzim/F0jGWr5VOWhXjSohmtxLFgNVRIxCuai2HCH/+6tGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776254000; c=relaxed/simple;
	bh=MM98JvxHrVnVBMzMzATPsJakIk07yyd2NVi/OWhI6KY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ObEjNVxF2cdYmviC2oPWwzVlWFJI8cYM2yLI9xoHXEqRqEWyYHreliLMzE1D9cPO0guf5NIKvL3bPZbMzcJYZBYAb+kJkXB0GwnjmD2UlDxZ1DyAfWIRO/+ka866Eb+rGxrfYn63VFNCCINEQZ60CIoJnP8eJOoMjJlfsm1AVvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d4t1kdLK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d4t1kdLK"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F35ZBi1833259;
	Wed, 15 Apr 2026 11:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ziuFyb
	7AjNla4nepnNpxbO940KjIiGWtyWy1oQa9sKA=; b=d4t1kdLKgAt1REyTl7de2N
	Nkm9GrlupLNyVJ9sAq32s5SkwZXQVjqVxMI9Lt1FCRVjbycORHZ5RLM/sIrKTawj
	8OslG1NQMdL+6COqFAq8WVtd3r85Q4GMZ3XtHFp8oLcLjOswyROVxhCRxbmNfVzo
	4nNzKMXEzMYsb4LdXSjCqk2hY0/KH33T3JWpvXWjYChrpDiGzyCMInoP8QGFPrBi
	wWNTGtL7p7TE42IC8kqCUlCxPm7G34mkQv3JYy+JkfWxRGEvCldyb2meRwR2QSI/
	bG0yxMsiAhuGHhfcslxXVLxIDSfKKv9Lgr3pYIRmp8wslDM4jGMzhTouTQfBNg8A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rfvar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 11:53:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F7v8Bo030721;
	Wed, 15 Apr 2026 11:53:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10ye6nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 11:53:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FBrD2t47448516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 11:53:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CD7820043;
	Wed, 15 Apr 2026 11:53:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2970920040;
	Wed, 15 Apr 2026 11:53:13 +0000 (GMT)
Received: from t14-nrb (unknown [9.111.91.157])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 11:53:13 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 13:53:12 +0200
Message-Id: <DHTPHNBLDSL0.1T802QN87CWQC@linux.ibm.com>
Subject: Re: [kvm-unit-tests 1/5] lib: s390x: Add function to get page root
From: "Nico Boehr" <nrb@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <nrb@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260415085145.91197-1-frankja@linux.ibm.com>
 <20260415085145.91197-2-frankja@linux.ibm.com>
In-Reply-To: <20260415085145.91197-2-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEwOSBTYWx0ZWRfX+LSMq8UyiYx7
 3aBDIfQ9UHvns2P7mSvr2aivMiyzirROrjDdvAEgcGcEG+Twy9VnjJ92RP8JGkyaoJkH/JN3Dkn
 2iXYdUenVlnxa/Bc4ucNR2EJgMdKcBYur7Uug0Enl4W1uaYqVrVg90I5S4izHqsJXvHYtNd/Nnp
 X1r+EnJflPogo1TpVFmDkHKHZ9vhNlu/p3DF/qmKWLufCWrrpKOdJY4U3I9RpUhpvmYCKkoBskD
 MFSbdmcdJWQayztqYqoeBGXNTKsMmvbSFvz2tnbKG/wjK/F7QZ5Lr0NTTEECM4yvBSgVe2DQijc
 2XvBJAlNVnp6uM2ZewUIWvgxyJDP7BQ9vj9Jn4FCmXLdF4hHb/dL++URsFFO4IgDVSrh4y3KQfr
 vOOX3gl1j4RnZv1M27xtlriHpMrSQDJn3VtOd2A+JiCGr7SklYaCNuwRmOioeDrJl/ULH6716Td
 pBTGCz/+nxkDw2z8gcQ==
X-Proofpoint-ORIG-GUID: eg1Bztj_uUQKYJywiegztJU9cFmPh_3C
X-Proofpoint-GUID: eg1Bztj_uUQKYJywiegztJU9cFmPh_3C
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69df7c2e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=ilMZofm7wjk4FRapem4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150109

On Wed Apr 15, 2026 at 10:45 AM CEST, Janosch Frank wrote:
[...]
> diff --git a/lib/s390x/mmu.h b/lib/s390x/mmu.h
> index dadc2e60..6ba19d28 100644
> --- a/lib/s390x/mmu.h
> +++ b/lib/s390x/mmu.h
> @@ -10,6 +10,8 @@
>  #ifndef _S390X_MMU_H_
>  #define _S390X_MMU_H_
> =20
> +#include <asm/arch_def.h>
> +
>  enum pgt_level {
>  	pgtable_level_pgd =3D 1,
>  	pgtable_level_p4d,
> @@ -95,4 +97,9 @@ static inline void unprotect_page(void *vaddr, unsigned=
 long prot)
> =20
>  void *get_dat_entry(pgd_t *pgtable, void *vaddr, enum pgt_level level);
> =20
> +static inline pgd_t *get_page_root(void)

Only nit I have: naming is hard... do you think it makes sense to reflect t=
hat
we're talking about the primary-space root here?

get_primary_page_root()?

It's not like we're using the other spaces much in kut, but maybe we will i=
n the
future.
