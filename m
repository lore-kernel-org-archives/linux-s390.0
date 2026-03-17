Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417CB3A5450;
	Tue, 17 Mar 2026 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741704; cv=none; b=HhDbVHc37cpwLt3nKsDhTJWG6pRuHv7bTCldAB/C5QjBgQrYDmTg3w04hUHD7VU9Rxwk9+QEJe1oao++irecv4V5BCMWiq31v205sG1MwIB0bMZy70tU7WulCD43wVZV8IDIqpDOLgfFjNAQ7mdImFgYAHgTyLacO+SbbpDy+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741704; c=relaxed/simple;
	bh=hm8Ln8Nc4yaWiI1OnzDKfFx6vYsqc+wqhWJsnRjOTt0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=kdK+W0SZ+3Q2WGngNbdjwaMQCr2TfqK1xJvaXOx9BDL0bLWTZgFWqGneO2e+N9NHQxQI5w105ntKY5QRH8xAslIi0IsmTHC75DGLYRquCEvKbx5/ZCMtt8V0R/23gYnHBNtBdKpElpoTimT4Fj4W5jZueqNYW4jO+MG3dl163b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ckSkf+qG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ckSkf+qG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H6cAdn651426;
	Tue, 17 Mar 2026 10:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ih/EPn
	QuPMH6GBpvqz4s2EQyqs6EAj1y4pOizniWkoY=; b=ckSkf+qGhyxBrozF2mCryR
	bPcOblmkyYSyy6trK4z7r+UlZ1r6MRktEItB09g1AIXG7ZTkSmWWV6k+kb4eFyD5
	KgXjmb2lgh6djVYSB/4D7CmVceJySF6r1V/K78OUuu6jHu2Ddxh/PfWc0GXBg9Jz
	bTxOticfOBXbV8R18aRznsjo9bobWe9LlqZDgf7ULwq21oHx611ZQ8IroPweepL2
	VfiIl4MyGS0QWrn7c1ACUUe6CsPStiR0n6oC970+0cw2Q+RJUz9bXbnkjD9R/37C
	GK2UZfDHvgkXUtzMnjLIk84AYw69jxNRZ8F9eE2kI+rHP1u0nAXrb2hgGktA6ZrA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cun78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 10:01:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H8CeE7028455;
	Tue, 17 Mar 2026 10:01:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq18bp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 10:01:37 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HA1XnV52691328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 10:01:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1B4F20067;
	Tue, 17 Mar 2026 10:01:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7807A20065;
	Tue, 17 Mar 2026 10:01:33 +0000 (GMT)
Received: from darkmoore (unknown [9.87.132.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 10:01:33 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 11:01:28 +0100
Message-Id: <DH4YYAGNRJWN.31F7DA634KSPA@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <akrowiak@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC 01/10] KVM: s390: diag258: Pass absolute address to
 kvm_is_gpa_in_memslot()
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-2-frankja@linux.ibm.com>
In-Reply-To: <20260316180310.17765-2-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b92682 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=hmbiDVwH1lKaQpimJPgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA4NSBTYWx0ZWRfX8aWf0crwaKQ3
 xY+lokRdIQ/GDUbjiLem8qwXwwDFbSdDRgwm28TTd0g1NkLvZAFrenRy+u9eUOZOqF9Zt40qRrD
 FVTYr9IMc/g1bQxR/lQQ/cSD9x8146F3JsYUj39lxNIxGobHIO/ISqyjQVz4+MC4avzDN9a/r1B
 4e3AxlWCOvD2OQ0LnFYx8R6dMdCNhouFXtj97UdduJty6rjbiR1op4/8Z9LHNCBC0xet6bWKlHW
 kqjKu4gyil59W0LLo7lfHmuUnEN40Ln7GBlxIrvZpMBAGQvDD0WeM++ovd7GCI/+/3c5DK8wiiW
 M438kRdTTAA4IraOUA8zAwOgGarxq/CzkKHfOBW8VybjzDuiNlc36WjI3N0catNxgQJV2+OTVz2
 +l2DOTOFVmZaK8VZmI+vVkCv8cHp59HG5sIC+pHG701oX1vLP7QmAR6zx+Yo3GOrhcAp9f+W0IA
 sXvTeM2HjaOOOJRjnRA==
X-Proofpoint-GUID: MskDmt1F45ODaLWeN3m1uzEiYvTCBYdk
X-Proofpoint-ORIG-GUID: MskDmt1F45ODaLWeN3m1uzEiYvTCBYdk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170085

On Mon Mar 16, 2026 at 5:23 PM CET, Janosch Frank wrote:
> The token address is a real address and as such we need to translate
> it before it's a true gpa.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Fixes: 3c038e6be0e29 ("KVM: async_pf: Async page fault support on s390")

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/diag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index d89d1c381522..51ba4dcc3905 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -122,7 +122,7 @@ static int __diag_page_ref_service(struct kvm_vcpu *v=
cpu)
>  		    parm.token_addr & 7 || parm.zarch !=3D 0x8000000000000000ULL)
>  			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> =20
> -		if (!kvm_is_gpa_in_memslot(vcpu->kvm, parm.token_addr))
> +		if (!kvm_is_gpa_in_memslot(vcpu->kvm, kvm_s390_real_to_abs(vcpu, parm.=
token_addr)))
>  			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
> =20
>  		vcpu->arch.pfault_token =3D parm.token_addr;

