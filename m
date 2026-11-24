Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544769;
	b=ENqwKx+b7er6H5lJ7MjXcoEPylRAcdGVq7k4AlRAK92xCnXAF/3l03mzX/qXuM6c0ROo
	 FDDuS3EWrZL5oBcPcfFR5S1CTgz3K4Yx2yYlyB7voNkn4jalSwfavOkfAudSuWkyNmOmf
	 K4SZTPJwsBi9MINDgUmQV8Mt2FIoAMm94YKDAwPcRY4W6b2XrrUduqZHHG392OHe+XuSH
	 Ebwj9ByCNenQfL0Iuac7E55rm14NpmNIDeyouuAueFInWuE7EGjtt3p4Cjw5RTAdVe9vx
	 mEcZfybkJlNZjVkXVkmZD490kc47JdJSBW7VT0r5aQE3kS/+6Uoo9/mq4ofxzvK80Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544769;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ra3jsCKFlcyeQDzEHh5eXFmT0/Lsiag2Ank3S7B2Ljk=;
	b=tW5pLfJwRiRhchxHrmzX+vcQgbE+d3POBIZfws4Man6ooqXPf93WGzo42LfA+kmE5TrO
	 RszSjtjHd+hb2dwukf5rJ4C7x0UI/fmPMO+F3RaiZIVLzYPqEZ2Lrnh4dB7Nouyhe2Bf4
	 qaVuLiDtzv7q47up15J2hY7g+bcyAl/kgO4MbpjiMJmsCkJbC6CT61l+T9PzvriUI2pp3
	 nbTqR5XZ0P5iIvHwcoCiNTb3hrSgNKCVadQn7vjJ5+AQ55ju5qCGKZQUcXAEgDVk3ya/T
	 e0khQIb9QvsnHkz1nHT2ynG7p6CoE2Bc8oD15zYhj4b4IYo2JtKRDzlg7D0yUPtxw/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oOnZvmhF;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA7F606A330;
	Tue, 24 Nov 2026 18:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EA7F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oOnZvmhF
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFa3Fr1235397;
	Tue, 24 Nov 2026 18:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ra3jsC
	KFlcyeQDzEHh5eXFmT0/Lsiag2Ank3S7B2Ljk=; b=oOnZvmhFVNG5Kr8XsfcFc4
	5NIcvm4VfWZqI/AVSBiPZECeE8oY0iOTNcWveDWF0UkcikXu6fnz06Bdrc7W3dxO
	NoGlyqXgKRFHe57HciR3lFKsO0IcO7+88dtRrScNjIq2YAe5Op4+FU8wqHeG7O3E
	ixl+NcSx96vzOL71pWpVYdUmR9DvOqFhbt7iNt5/Kjd5X9x4lw0yU+r3f7Mdyax3
	5GddgGFKr3eIQ5/hk+b96jECQf+uLAy4gf2e+3stWsewwe9i5MMiJxOBXzRqEbGj
	1W+6/xUF4+oEiBYeMZtYkhNv5TjOTQ4RO0aYzmI2FA858YUOnuyaafjHExiZJyIQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3948h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 18:25:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFJbNd3536144;
	Tue, 24 Nov 2026 18:25:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axks24c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 18:25:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOIPhDw52494668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 18:25:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D7A92004B;
	Tue, 24 Nov 2026 18:25:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F26520040;
	Tue, 24 Nov 2026 18:25:41 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.42.244])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 24 Nov 2026 18:25:41 +0000 (GMT)
Date: Tue, 24 Nov 2026 19:24:24 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Carlos =?UTF-8?B?TMOzcGV6?= <clopez@suse.de>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
        seanjc@google.com, pbonzini@redhat.com, akpm@linux-foundation.org,
        david@kernel.org, peterx@redhat.com, ljs@kernel.org,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        Steffen Eiden
 <seiden@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Marc Zyngier
 <maz@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven
 Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 9/9] KVM: s390: don't unmap the gmap on permission
 upgrade
Message-ID: <20261124192424.157a46a3@p-imbrenda>
In-Reply-To: <20261112142039.907090-11-clopez@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
	<20261112142039.907090-11-clopez@suse.de>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b05d6ac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=AIa7Fw-m9XHv1_55a70A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3MSBTYWx0ZWRfX6p5dAHjNm+tJ
 qQNhTSDIlZnGYtXWPLXPqs5WlzEtXy+hx65yydYPUl/PGfIM7uVi9ErV5Q32g+TgTNi6JdF3m7P
 5r7jOiAPI82eUkSec2zsoD31ScW/wJ0=
X-Proofpoint-ORIG-GUID: _bOIgOxr_71bpzoMoIN84JN7KDxL3hkY
X-Proofpoint-GUID: dlWeO2vv-EDCUQu4fy26Fmp8c1EHzeHa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3MSBTYWx0ZWRfX+h8EAijKXqe5
 V6b1bS4c+YLh7vvhyQUKQ/smtKmFgYHCj6DxqojRQ4HVbE+AZ3JaN0DC2GvWKwfecsm5KM3q1tF
 HZJ1a8qM9WJxDWcUORAvrBEZXPaj2GF4tPsnQpbamBQi50GGUxdJTeBrWikcgR75u5jvyUr9AUj
 bMaPF2BWeCmR7hpNSNT0ucBQu8LOI8fZnu+ph9PXZscXA/9oYeTXxMxcdNYhGzbQwyvyxdrzXKr
 6+9hMmtZmT3Ha1CPL3DR1B99bmCpVaaTlKctbRkfy3RgEcXmrDon/5/Tz3Yt+k2IMsKlxlmNv1i
 qsB3cvUFV0Uu3hpBeMLU3bLOXLdlE5JWmAIXj08XCOwXpq6YcVdCgr/W+w/yrXpCKf0PvhrESBt
 O13rYkkaud/WnF6pBfqx78gZks+Bs2OIuTYpcwrxMskeBMk45d1lJ3Q/S1FnFyR2I1EmIv6yPiR
 Uz31equXc3fVclY/ACQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240071

On Thu, 12 Nov 2026 15:20:38 +0100
Carlos L=C3=B3pez <clopez@suse.de> wrote:

> When an mmu_notifier invalidation only upgrades permissions
> (MMU_NOTIFIER_RANGE_PERM_UPGRADE), keep the existing gmap entries
> instead of unmapping them. The PFN is unchanged and no access is
> revoked, so an existing entry is no more permissive than the new host
> PTE.
>=20
> A write to an entry that is still read-only causes a protection
> exception, which kvm_s390_faultin_gfn() handles as a write fault. This
> applies to both s390 and arm64 guests.
>=20
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
> ---
>  arch/s390/kvm/arm64/arm.c | 7 +++++++
>  arch/s390/kvm/s390/s390.c | 7 +++++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> index bd9d85235f43..5aee1817aad8 100644
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c
> @@ -678,6 +678,13 @@ void kvm_arch_commit_memory_region(struct kvm *kvm, =
struct kvm_memory_slot *old,
> =20
>  bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
> +	/*
> +	 * Do not bother unmapping if this is only a protection upgrade.
> +	 * Permissions will be faulted-in on demand.
> +	 */
> +	if (range->flags & MMU_NOTIFIER_RANGE_PERM_UPGRADE)
> +		return false;

this works for now, but in general the meaning of the flags bits depends
on the value of range->event; it wouldn't hurt to add a check like this:
	range->event =3D=3D MMU_NOTIFY_PROTECTION_VMA

> +
>  	return gmap_unmap_gfn_range(kvm->arch.gmap, range->slot, range->start, =
range->end);
>  }
> =20
> diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
> index 18fb200f854a..954bf6b64683 100644
> --- a/arch/s390/kvm/s390/s390.c
> +++ b/arch/s390/kvm/s390/s390.c
> @@ -5871,6 +5871,13 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_r=
ange *range)
>   */
>  bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
> +	/*
> +	 * Do not bother unmapping if this is only a protection upgrade.
> +	 * Permissions will be faulted-in on demand.
> +	 */
> +	if (range->flags & MMU_NOTIFIER_RANGE_PERM_UPGRADE)
> +		return false;
> +
>  	return gmap_unmap_gfn_range(kvm->arch.gmap, range->slot, range->start, =
range->end);
>  }
> =20

