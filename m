Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CFB355055;
	Wed, 19 Aug 2026 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787140019; cv=none; b=dRf8KqZoliMq+R2EudnFbDiqAKCUpbc9s9s8ykaDs+X7n9Za2weZGbvX+6QXZbwOG7MB0obvbkBxiPHbS711+r3kzfWO17oyEdcENCY4tA8WKAIeLBnNiAi6msiPrc4T0NBpF1MVGVjaOR1ltnPp2eSXoh2z8RJ4gshXMXTkdtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787140019; c=relaxed/simple;
	bh=LKUFgZ//3AyxhWtNzenWbhseyKw58RqDy+y6jBhqSLo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=e6VczYcU/eRyZy9hVj64cvtjtCL00GCF1I3NpfnVHC5iin/LDh0VoXRZ2AqhpSb7GHe1a0hjXeNnfzdmmmYsul/IPyjuKmDemskPy1FKN3f4N0yxZxRzVgh9TOvoE1TTuKnNs8f5g+Vq/KSV8r+L3ZqUBkoG1Aec2rk9lcUZ2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IG40vREs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IG40vREs"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JAVte43191628;
	Wed, 19 Aug 2026 11:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=53Blfh
	rnwzDZpmteOKPxIbAjafcFPVlOAwteGAsA6Os=; b=IG40vREst8zHl8/BAREW/d
	5GG0Rimhi+wbet+OMoQRSTruz4bjqZ4DNfEDnc53dPFrUm6mp1Qe7G3LKX9jfmma
	lu9la8t/mw5ZnxxCkUaiDFIuvt0dptEirmgYzO3sum1l6SlMD12ovm/iZgYpwbZr
	nQKmoxDZKa15AMPUMZg6cNAemxiMTxuJBbBz1k3pzzL69uRTyVfj79PHr3AOS5b9
	FYKQWE4MuZ7TIo9wcnOHuaqnoI06td6LLvkIZMDC53srM1/rgJrbDEdkFrYqsbBj
	Xh7H8o1m5mmqlVlnXCKSgxx8uQdhzmeSMlvpdxD+98RZk7Ecy9D4Dd78rVtw5JMA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0bdf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 11:46:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JBfKG8025871;
	Wed, 19 Aug 2026 11:46:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw8swr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 11:46:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JBkmvH41746760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 11:46:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B88320049;
	Wed, 19 Aug 2026 11:46:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85F4C20040;
	Wed, 19 Aug 2026 11:46:48 +0000 (GMT)
Received: from darkmoore (unknown [9.224.78.25])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 11:46:48 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 13:46:43 +0200
Message-Id: <DKSW9BIX9YET.24AIJF05T655N@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <david@kernel.org>,
        <seiden@linux.ibm.com>, <nrb@linux.ibm.com>,
        <schlameuss@linux.ibm.com>, <gra@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] KVM: s390: Add missing srcu in
 kvm_s390_set_irq_state()
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.22.0
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
 <20260814163355.227191-6-imbrenda@linux.ibm.com>
In-Reply-To: <20260814163355.227191-6-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a8597ae cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=5NMBkYRrUetcHw1iU8IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VSkRrdDqIM7RtoTkcVjn9yM2Sxg0nE1-
X-Proofpoint-GUID: VSkRrdDqIM7RtoTkcVjn9yM2Sxg0nE1-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA4OSBTYWx0ZWRfX4glO0fQaLzRd
 qzRTvr7HJzSq+osP4ZkZlJ44l8WdVYDIF4SM15jEiXwwfNIr/E2Y8lbUKPCwNwLcbyBZFGtRd7c
 Idva5TsafzRf+Fd3AAecI8oyWTXOY0E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA4OSBTYWx0ZWRfXy+Iv5SzBSVKc
 tj6OTkGHyiiMc7pxRQWyqIWa1srFVOAy/7f4RHOOt6G3tyBSKWAG5aTMXVaa3azJd0/vkWEYsZO
 JVEM535l64aMZ2RYmHjDlh/SB2ooNyhlqiYe79V+jx5F7L0kE6J2EaoXqMxjlkM8N1Jk1BX/GF1
 lz8JXhuo7ODNibUfl2ca70+KoEci9Vxx2KnZ2KQSizG35U055tsBiblTjFczLKW/vrxCKXEaEu+
 LFmDqwFkVAlv+7WP0iHDY9tXO8yiCNAK9r9Sk+czu3/+Gq/0B2uU7DQbR/geYzunL+EdJ6sFkU4
 DZmkhGMwIzJvRT+pIs5ccrZM3WeWqxXmjcEPojs8LuW5DXx2pdL8L+WGMI8/6KqW5Q+SuEL2FOx
 QGPA5A17Dui1+2574EBto6+ZMLZorLHl2lw3245LgGZwd7T4LhyCMH1qKVKyabCAof08B90pqYq
 Ga7WSKkL0r7KXn4vomg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190089

On Fri Aug 14, 2026 at 6:33 PM CEST, Claudio Imbrenda wrote:
> Like kvm_s390_inject_vcpu(), kvm_s390_set_irq_state() also needs the
> kvm->srcu or the slots lock when performing the Store status operation.
>
> Fix by taking kvm->srcu in kvm_s390_set_irq_state().
>
> Fixes: ba5c1e9b6cee ("KVM: s390: interrupt subsystem, cpu timer, waitpsw"=
)
> Fixes: 062e44a9319f ("KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl=
()")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/interrupt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index fc4d1f8193d9..8a251f83d323 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -3230,9 +3230,9 @@ int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu, v=
oid __user *irqstate, int len
>  				break;
>  		}
>  	}
> -
>  	if (storestatus) {
> -		n =3D kvm_s390_store_status_unloaded(vcpu, KVM_S390_STORE_STATUS_NOADD=
R);
> +		scoped_guard(srcu, &vcpu->kvm->srcu)
> +			n =3D kvm_s390_store_status_unloaded(vcpu, KVM_S390_STORE_STATUS_NOAD=
DR);
>  		return r ? r : n;
>  	}
> =20


