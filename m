Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5B3CE494;
	Wed, 18 Mar 2026 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844168; cv=none; b=NboYCwG0Pr2S+yKRqlYeCX79Fd+ZC5T0JfHkRgcoW3i+NtDFBbbc0w4r1Gu01ORQtcyYJdFbAJTt38ickhFXG5mEMM31+7709RslNGUErAwpW63e7tBonsMuEuCEzNEU1CqNhXWfCIjanZvukSF1Gesk9S2Vl7coYikJp31vfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844168; c=relaxed/simple;
	bh=pkOWRcIRtEOpYUTb8nMg66OkPFOLlPmOV6W1TLeQTRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAkyXMCdnDF3fNe1q6rn3se742abT1mTo81Pdref35pyzOfCO/APvEf62PGIBa4p3dNPAbmMG4NjorDTWjGv/DHE3u44J/yid6Ypfa/vnS4WvqKjvvjJ5nDoqjCPgKnwPWLVvWINdxgxrM+aOLGsTYJK0uo+O8zPL5mPDwbQA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L+sKwSW+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L+sKwSW+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IC2FQd924584;
	Wed, 18 Mar 2026 14:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qZtOl5
	qa1PVqu9S9AwPIbLQEBN1u92LHtlnKxRb8Y1M=; b=L+sKwSW+gEqWeQ7iEKeYFA
	G+QWEKmh4sdWwQFCNKdRF/BvFx5Ir3htU+jIRsr+RDMabDeLnSOfzauV5FPNs8PS
	mrLHCcpi+6NZCVwEUtLlw4uY5xgvVzeVwjZQda29Z0J0jxa2keXSjRmmaw8doVJQ
	7/1RW+HZ+6VT7o6HdT8FTKhNWlh6tGyNTYSFwgxsciQtd4ORbdwSiKN35Ykc3vZe
	mYhHdGDrQVg1AppZE0/P2DM3CMstRbJ9+sbB/4HHrx+w31hpN2DZbwxQzJioSNT4
	g+J5zTVvZyk9tKeL0tF1GVOnY8y5GPSC75Qnte9gn+Wki+yuteqbvM4LeRU72s3A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3j1x2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:29:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IDQ9hD014024;
	Wed, 18 Mar 2026 14:29:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy6e8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:29:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IETK1M25821618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 14:29:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D30A2004D;
	Wed, 18 Mar 2026 14:29:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65AE02004B;
	Wed, 18 Mar 2026 14:29:20 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 18 Mar 2026 14:29:20 +0000 (GMT)
Date: Wed, 18 Mar 2026 15:29:18 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        akrowiak@linux.ibm.com
Subject: Re: [RFC 04/10] KVM: s390: kvm_s390_real_to_abs() should return
 gpa_t
Message-ID: <20260318152918.5231a61c@p-imbrenda>
In-Reply-To: <20260316180310.17765-5-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
	<20260316180310.17765-5-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rQJGjdnIy-uX-JEJlDt0gP2gLM9zTJKL
X-Proofpoint-ORIG-GUID: rQJGjdnIy-uX-JEJlDt0gP2gLM9zTJKL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEyMSBTYWx0ZWRfX9Hg0CY3k/bhE
 VI25Cg57J27eVYdkrMonGY3yxcYnT8+efVVJIZzwF+7E2y+4uwrzuPGceZe2+w/3vl77frETtb1
 u6yXZBwgX+Pv+GP49NCK4iuCld3E16CgaYQ4VU27kzWz3wnFYFQquYx4CK1To9XF5bSKf/Q23YD
 WMv4w53vrDJwJrdVFkIAbAfUPcwNTdnWmpb6kvT+jq7j5HvnDNpB2GsXl7SILFk6p7QGGPmYG5h
 3YdVarUxGe4Yz0WOQRUrj/Jg/OW7hsvWoLxkket4dut2h8/6ytJWg6UtV0Qlg3jqM/GfttAInAl
 TuHvhs0/qxypt4dUNKi5KZi4bRorbGYBBGAcv1rW+fm1gB1j4eREuQ6OIBnBIy5ly2JcRdDDTz/
 dujYmTIouzIqRMKEhwOwo9AIFWaRNvwowtVSLyfou/Xg3xVixtyGS0t0MvNItBrbGP+waX21GrU
 0dOjrneTe/ktMNxdO/g==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69bab6c5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=5VlVqv3a4dB1-NjogH0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180121

On Mon, 16 Mar 2026 16:23:51 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> An absolute address is definitely guest physical.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/gaccess.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> index b5385cec60f4..ee346b607a07 100644
> --- a/arch/s390/kvm/gaccess.h
> +++ b/arch/s390/kvm/gaccess.h
> @@ -24,7 +24,7 @@
>   * Returns the guest absolute address that corresponds to the passed guest real
>   * address @gra of by applying the given prefix.
>   */
> -static inline unsigned long _kvm_s390_real_to_abs(u32 prefix, unsigned long gra)
> +static inline gpa_t _kvm_s390_real_to_abs(u32 prefix, unsigned long gra)
>  {
>  	if (gra < 2 * PAGE_SIZE)
>  		gra += prefix;
> @@ -41,8 +41,8 @@ static inline unsigned long _kvm_s390_real_to_abs(u32 prefix, unsigned long gra)
>   * Returns the guest absolute address that corresponds to the passed guest real
>   * address @gra of a virtual guest cpu by applying its prefix.
>   */
> -static inline unsigned long kvm_s390_real_to_abs(struct kvm_vcpu *vcpu,
> -						 unsigned long gra)
> +static inline gpa_t kvm_s390_real_to_abs(struct kvm_vcpu *vcpu,
> +					 unsigned long gra)

as Christoph suggested, please put it on one line; with that fixed:

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

>  {
>  	return _kvm_s390_real_to_abs(kvm_s390_get_prefix(vcpu), gra);
>  }

