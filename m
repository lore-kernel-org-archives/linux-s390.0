Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83680442FD4;
	Wed, 12 Aug 2026 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543633; cv=none; b=Zk5yQqOzEjMWKGzqtgU4qpvp5RbIdymJcVxEG2cufIijtv2wBpaM3OiJwNHDKoQ97en/X6PxrDd2cYVVbgCOwRm2TBss9zOaCZ406Na2kPVMN81nbtTSv0vPyu1xUJ3jSeCJK7z3JEjX7lq8+4tYAoUzXmVJNodRzQDaFA35RAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543633; c=relaxed/simple;
	bh=SA7yL5at3gzR9GtoTBsGiIoN5CWQa05YjIj/wz0wQp0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:Cc:
	 References:In-Reply-To; b=OadF0w/3yNbnLNt4bi3z2dh1gbLbvFFFXrnnmMrG/fpUIqKd2uoSnuIxMV6eM2e+U5kicX6cvW30I85ZCtDGs3/OQeDzVuLqTZ2MNgsJhw3AHRSWtOmYe+W5VkHYBiMRmphgR9I1v6rDhwWMW0opfXr6Hm9tMBmUdoABOi2My8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ka80DPB3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ka80DPB3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1h322585817;
	Wed, 12 Aug 2026 14:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ttr3fk
	DTML7EFfBiVt3tBUW3/5nz3PeIpPH6e2g+K4A=; b=ka80DPB3g/WJDSgBb7QLvw
	izC17WksbjGUKdMcJkgk/tQhaa0XaGqzlasN7P9+j4TDsW2/MVA8knDKjQ/7WDkS
	AryGMO/NCzs4BFUkCbaRgPRpAl0njXRzuAWiSPogw2iIXAButJ6enjnkFY6jpJU0
	lmuvW10SW42tWWt4Xn/c7RcNFJqNqaGqDqpARXkSJELpmRpOiNxMjpiRXrG7QRmQ
	TIqmCBv4gkbDNBvDQlXyLW05yrklLN2ne2u2og92x4nz0N5GLEk3YRqd1Pd5DP1t
	bJ8Fb/UpqIm2FHhhPpEhp7AClj9ajHuMiA8NTwSRTXAJa3tzBIsMAaYxlMGD+hiw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23ubds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 14:07:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDuOd8008922;
	Wed, 12 Aug 2026 14:07:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjxasp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 14:07:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CE72lO50135402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 14:07:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E201C2004B;
	Wed, 12 Aug 2026 14:07:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD5C620043;
	Wed, 12 Aug 2026 14:07:02 +0000 (GMT)
Received: from darkmoore (unknown [9.224.78.25])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 14:07:02 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 16:06:57 +0200
Message-Id: <DKN0UVPSXBF6.74VFJ754QGP4@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/9] KVM: s390: Fix get_all_floating_irqs()
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <david@kernel.org>,
        <seiden@linux.ibm.com>, <nrb@linux.ibm.com>,
        <schlameuss@linux.ibm.com>, <gra@linux.ibm.com>
X-Mailer: aerc 0.22.0
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-4-imbrenda@linux.ibm.com>
In-Reply-To: <20260812104436.109741-4-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c7e0b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=qrknQNrlDZ0fREQFVdQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExNCBTYWx0ZWRfXyxANBY12GYK5
 FGQfHg3oAiURdtNr6qBY2ErjLy/oiStEcCX5dHT7JmyYLXOwpjtIlxeTtqDHDpKn1oCzEK6YDro
 hzvtHSzjhHfQuCpL5qHRKejQ66BELNOQ7cAa5DppFUc/l+SIhQqfhVPmU2beesSZM7jJ78FsadC
 ghnggGnlqWsH/eJJErO0txAcdouFcV6MkBkqhZrqEM6EmZ5sWH7tBkLMZ9/aS/YOIJAPy7Ls07f
 3oTWyzhjbncCOfb8qGgQpnBsyxKt3Gb99c9IFV75ihcITmU3dI7AjGdBeJUjyB385O0zcbMofi/
 FTnGWffDZ08uuIm4JVN8P9uXsBusGdxLYTEtFojiTNel5JwOBz09ZwbJjkO4s+uxGjTVqdVcGjx
 9+vyBeo7hNiaqS5ziJPAWSTiBv5vFEO0wP2QT9iajMIiwPJAHu6zi/h1LF5tp13vOTZ8p653oI1
 C+K0Xgw9TLStH+6NoZQ==
X-Proofpoint-ORIG-GUID: 3S0tXm2zKg0y5fP5KS-7vM-UzWetJZ4w
X-Proofpoint-GUID: 3S0tXm2zKg0y5fP5KS-7vM-UzWetJZ4w
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExNCBTYWx0ZWRfXxaMH+XMt/UnX
 H2voYTC8o9BoPsnhct/8GgQHkAkVBZVjutoci+kcdluxdoNn85uye/vke2sCHItHKpnlnh8BhCc
 Lh5DskuDcl9z9xYRG/78PWHzH11yuSU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120114

On Wed Aug 12, 2026 at 12:44 PM CEST, Claudio Imbrenda wrote:
> When attempting to report all pending floating interrupt to userspace,
> the GISA IPM bits are atomically tested and cleared, and the
> corresponding interrupt description is written in the output buffer. If
> the output buffer is too small, an error is returned to userspace, but
> the GISA IPM bits are now lost.
>
> Moreover, the contract of KVM_DEV_FLIC_GET_ALL_IRQS, which is the only
> path to get_all_floating_irqs(), states that:
>
>> All interrupts remain pending, i.e. are not deleted from the list of
>> currently pending interrupts.
>
> Fix by non-destructively testing for the GISA IPM bits.
>
> Fixes: 24160af6cb28 ("KVM: s390: add GISA interrupts to FLIC ioctl interf=
ace")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/interrupt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 6b3f97a7513b..61e75d10110e 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -273,6 +273,11 @@ static inline int gisa_tac_ipm_gisc(struct kvm_s390_=
gisa *gisa, u32 gisc)
>  	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) =
gisa);
>  }
> =20
> +static inline int gisa_test_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gis=
c)
> +{
> +	return test_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *)gisa);
> +}
> +
>  static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long pending =3D vcpu->kvm->arch.float_int.pending_irqs |
> @@ -2242,7 +2247,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u=
8 __user *usrbuf, u64 len)
>  				ret =3D -ENOMEM;
>  				goto out_nolock;
>  			}
> -			if (gisa_tac_ipm_gisc(gi->origin, i)) {
> +			if (gisa_test_ipm_gisc(gi->origin, i)) {
>  				irq =3D (struct kvm_s390_irq *) &buf[n];
>  				irq->type =3D KVM_S390_INT_IO(1, 0, 0, 0);
>  				irq->u.io.io_int_word =3D isc_to_int_word(i);


