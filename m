Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38E3749FE;
	Wed, 12 Aug 2026 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540513; cv=none; b=d0d/yDAx+liY+upeLcUVRDYuPIXbZbTosQOKWyeYWrK8T6HxrdTTZjtsCouHatKbmxv07bEEdhWcd7bJv/t4S/3BCkFi24cxzVJiCT0459gNvr6jyi46AzpUbxdgAbhnh6+RHU/AbLJAIDBpbwU82scYrmNfyxGbThvEFCKF8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540513; c=relaxed/simple;
	bh=HJXO61D28QqnMm5cpqY3YaG2ueGXkXsg/aCu9QC3tCg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=TzNoUH5I1/kSgu+eZFp35edm6fxdFrseEx+Si9xfFEZc611Y57U0L0D1hnArY/aaHo2bD6YENtBxzzTTZajU6Ozft1zEV1LWGlJtk1uq70rBmsUfRKwFJNduKe/VFZce3nnqyM61Vs2zR/jRPUFrTEUhC+LJjD/rxbsyx0iQgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ts5aLa2Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ts5aLa2Q"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3wE03305139;
	Wed, 12 Aug 2026 13:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IiEahH
	MtqkSLZVhTef1Umy6Zb/pE1Uqd7BdbEpTmhhA=; b=Ts5aLa2QQQ1OKlN9yh01U9
	uu5AKc0dqctsVoZfDALMGUTvqhTydOADc1nOkz7M7L3+E04DjqjWB7xKQgr80KJf
	jaIZGST2O+NVrPQ2iYvMMjitE+PuIAP5KBmGWavNrSvItFmpdpMuOJ6NdqVSt1LB
	+9EiuJHIB/98GNM40IROHgsr8T3fdgLt3wVi/0RwbVIDylf8M8H01wdVSCjby95P
	4o9utc4fHoNuvqWzQuNkyY8B3KC29PRVS7IVIC3ixXCOfHXOHF0QBuuUfPeFGWYF
	yh8D3BsedAveSQPOLEQTI4aw0Jf/jGL1IfTK7MNhcaevxuxUpy0M5WUB8sIGc7GQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9tkau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:15:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CCuGxP030511;
	Wed, 12 Aug 2026 13:15:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjx3w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:15:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDF5Dq47513996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:15:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DC462005A;
	Wed, 12 Aug 2026 13:15:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDC6120043;
	Wed, 12 Aug 2026 13:15:04 +0000 (GMT)
Received: from darkmoore (unknown [9.224.78.25])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:15:04 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 15:14:59 +0200
Message-Id: <DKMZR3DM3NCU.3G8CTEU10KLJ0@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <david@kernel.org>,
        <seiden@linux.ibm.com>, <nrb@linux.ibm.com>,
        <schlameuss@linux.ibm.com>, <gra@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] KVM: s390: Fix potential tiny kernel stack leak
X-Mailer: aerc 0.22.0
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-9-imbrenda@linux.ibm.com>
In-Reply-To: <20260812104436.109741-9-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfX76GZdeplLsRi
 9DmPiDKCivcbbfTC7RRed9XMRFjCA2YTHSKPHfWGJyp7nrw+if4zW1tpj8yrvOVO7wBLbOoUdxb
 IAQQWpYnbUjwhsqTJrdUjsp27CstKUudDwNLXBUiJu7XI8HO8eRxV5f8Mjrkf2oLTo4qKGnYVN1
 e8Y+N6haS1jL477ltemhart+yFJlkzsLmGMP2Q8eCSjQCYF5iEdHLPfNablOqT0j7DG6fYA1133
 UmOXXGWWUa/Z1100R7VKR7p3rdZZJq03kekBzJ74PdeOteOfuFHmpjpHNHTPIDmIB2U8m6cUqzK
 6u7IOrM/4RE4naYBcCMYLf3xHImwSbnRnpFMGQklziMg/QHy87+BaH6IIbkjkpbZsHDs14SWk5B
 0itgWcvabTTR6qdhn0RiCqGYOZuVB2B/GHyno/ckbio1CL7EorF/WqePu6wgxUNcdaTzUHL59Nj
 1ilOVB40NdZe0dVDJZg==
X-Proofpoint-ORIG-GUID: 3K3fHUwfcibfUwnwfouZwKaJp6feIZa6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfX6nv78t4k7xsk
 QrZT3roZdPMaimuMS8/VHRmAdiLe8AnL9b5N1WduhpVIBk1IKNBWtcVV+ukz/7Jvauq+/7kVN2D
 hLTl9cE8qplRmrZ6ud0e8JdynVWgAVs=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c71de cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=uFAKcTYYjDz6xZQ_b9sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3K3fHUwfcibfUwnwfouZwKaJp6feIZa6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120106

On Wed Aug 12, 2026 at 12:44 PM CEST, Claudio Imbrenda wrote:
> In some circumstances, one bit of kernel stack could have been leaked
> from dat_cond_set_storage_key().
>
> Fix by clearing prev before use.
>
> Fixes: 8e03e8316eb2 ("KVM: s390: KVM page table management functions: sto=
rage keys")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/dat.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index f4dd6f783417..f2ea013cb33e 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -737,6 +737,7 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cach=
e *mmc, union asce asce, gf
>  	pgste.fp =3D skey.fp;
>  	pgste.gc =3D skey.c;
>  	pgste.gr =3D skey.r;
> +	prev.skey =3D 0;
> =20
>  	if (!ptep->h.i) {
>  		rc =3D page_cond_set_storage_key(pte_origin(*ptep), skey, &prev, nq, m=
r, mc);


