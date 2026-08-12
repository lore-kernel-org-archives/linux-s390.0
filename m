Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E205E434E47;
	Wed, 12 Aug 2026 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534227; cv=none; b=M+ICxaqKLEpRaVFNlDK1icU2FJ63r2I19tsLSAGYCCKXBfD340kbwxzjLpsuEMen64r0cKrnHJ6kpwUyzUJ5Xg4W3qShhygV5tfVCjSU1916q12Kd3L+A6LuHCFC93z1/KQQ7n5dmvab5vOCOgN5S5mgD+wfFlBkyAfOEfoHNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534227; c=relaxed/simple;
	bh=KqdYhP4ESbtttsruGK7kuEHcSsVmfotbRNgdrtvBP7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xr6NuiHYlAeNlaVcd3/SYk67VtwD+K6iieGdMtTysZifwMnjGHM0QNe9znkSQy3QShz8wRwv3+bHt3JQPIxlj93plfN8ltm95YHLp/iHXnwIehnSu0l7z1BOonpn09mg4VV3Ir6Yb9YW+F0oDODAGDp243npnZI1q3bfbechKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=au6BFcg9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="au6BFcg9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3oIP3214510;
	Wed, 12 Aug 2026 11:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rpQJ9F
	wIXXfjiwAiQfy378FFbNixaxjIoBH1HoHd4/A=; b=au6BFcg9iteovGbjc9Scj9
	x2brOkeXSrBidsyxzPpWU8ZBhLDQH6KdRqExFVESAm6mlcoO/2VwL5SRAkFpHKSO
	VVzaaYUwBCPZ786ZvaFblpX8iM+oo54nKF5FJjZ+WwHoIJma82+oC0xwPXEseOBZ
	Lx5EGbWcJwfayPtR2961evkPHDkLkwwnfd4gUU1Jyi1oP5KMCea+i8cL2Z5u6Iaw
	bK6wwqWCzmcBH4HVHSoHKXxoAw5LjB2onvPnLJgLX1JoIh+U9vl+BL7xZbtmk3BL
	lPOD8A/2vVURtAUBX8StFag0pWvqdXc7ou91NiIVnLlYIZUaZ0YqDDxjmGA2EZvg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp31c5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:30:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBQJQI021640;
	Wed, 12 Aug 2026 11:30:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy5j2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:30:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBUIU930605628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:30:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94DE720043;
	Wed, 12 Aug 2026 11:30:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7251120040;
	Wed, 12 Aug 2026 11:30:18 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 12 Aug 2026 11:30:18 +0000 (GMT)
Date: Wed, 12 Aug 2026 13:18:56 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, KVM <kvm@vger.kernel.org>,
        David
 Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>
Subject: Re: [PATCH 2/4] KVM: s390: vsie: zero stale crypto bits
Message-ID: <20260812131856.35aea6b8@p-imbrenda>
In-Reply-To: <20260811153738.206885-3-borntraeger@linux.ibm.com>
References: <20260811153738.206885-1-borntraeger@linux.ibm.com>
	<20260811153738.206885-3-borntraeger@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c594f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Ms-7nd-jqOneT1YA4oIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: lD0VEuuWCGHw20kE_3vo3Tnp37Oqjrks
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4OSBTYWx0ZWRfX1C2uTaA9EK5O
 c7fZRbcUM27M3EZ0HF+kKuP298/UL7NKCx6/g0MFKp44l9drmd922qNQeRjEEk7gTv7VIl6Bt4k
 +1MNuTZ34YbiFZMNiFyl7VQJ/z13N8AEm0WzIhPtsFTGuBHzz5GBkER4OvUDUSpd8/aP4QSxjbp
 4z3UG4bYTLYbU/gCGrgFn8ztdFIjNi7qOa7gidgwfAry2hvR883BPV74k/eAWOX4ht/T1K/FG73
 Uztc8lyUwIuKxdILvLNaHQwlpXL1DCr5K78HFQQz8/EnGcPf1qEeDBYnG+ERd+Hq1TRx7IkpAKF
 yuG9fuCxAeUtmlkpJeeD+LRjfX2jFwygRuGzGBhTiwJEfWiDCA4WGM3IFYjzZEqQTllpeJ16Pqg
 EAzpV3eBF41TVb2USLYy2xYkcF5y9jLzoM1nQEQKIAogMB2hTFwHgyG4FAq+viLHfH9wsrgRyS6
 v0suHi+Ha736uLPdltg==
X-Proofpoint-ORIG-GUID: lD0VEuuWCGHw20kE_3vo3Tnp37Oqjrks
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4OSBTYWx0ZWRfXyCsVR0n1VSVs
 ni/L5pUh87GGGMklAFf4r9Fn/5ohKUyCa3+rf9N2Gmmk+Ma1vESJZKGnmln9TAZAduVTyw3Uaaj
 DTw8khmvY465KuN6uf18PhizsDwz/Qw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120089

On Tue, 11 Aug 2026 17:37:36 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> When shadowing crypto access bits from a format0 apcb (crycb 0 or 1),
> the bits 64..255 are unchanged from whatever is in the vsie page in the
> crycb and thus in the apcb. This gives a nested guest potential access
> to a device no longer available. Zero out the remaining bits.
> 
> Fixes: 6b79de4b056e ("KVM: s390: vsie: allow guest FORMAT-1 CRYCB on host FORMAT-2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kvm/vsie.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index f546239d8ff8..7971947d2fe5 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -172,6 +172,7 @@ static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
>  			    sizeof(struct kvm_s390_apcb0)))
>  		return -EFAULT;
>  
> +	memset(apcb_s, 0, sizeof(*apcb_s));
>  	apcb_s->apm[0] = apcb_h->apm[0] & tmp.apm[0];
>  	apcb_s->aqm[0] = apcb_h->aqm[0] & tmp.aqm[0] & 0xffff000000000000UL;
>  	apcb_s->adm[0] = apcb_h->adm[0] & tmp.adm[0] & 0xffff000000000000UL;

