Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E833D3486;
	Fri, 12 Jun 2026 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270261; cv=none; b=FMguGEXX72RsOrhQ1Eyphc6XgRa/IcfGB2nWrRrLtbEzst/T5U0F8MITR7xZLW62oO0AU6uvV8LwWYVyWSq6BRy0Cx13026w3HXrcxXNvP8pfTm7JqnqB3ZP/4+i7EYMrkCZHPG5B/Hd5sDsTzH94oJWJoZ28iX8VVenzOF5EyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270261; c=relaxed/simple;
	bh=QtBSWv7v3obdqvm+4G47JdQrCjmuz9fDrNm0dNd3yv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKOFMnot1uLMa/T6o4EgDtjwKn1kqYm8M5UKwtUPRW4D55hm4/QmKzSrod2IOLhJ15DjX3wTLnfdrc3evLLWBGvQhjvcaVExYMoRFovQiAzCxFTLEOweVM08Xy+EAcSieUVQMp+f5pRcB8eBBhE6yBNyyBQAVl5iyyV6KIKTEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PS5sQ/TJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PS5sQ/TJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C1U5SB1742020;
	Fri, 12 Jun 2026 13:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2NP3OE
	UfBE964IvcWvH0OHIkn3qdZ8GRT1b1vgShFZY=; b=PS5sQ/TJarERx/R6hKQ7bL
	2Oc/HR0jPc9RTwC8WomnxhvZmmMig8s+Gyd/9Hbnpb8CyS172BasXud5qaSrVKit
	p+3J+f01KdHwUiTAPASBiRJ8fdLQd6o88/xRGQVPlJF6cMWEEoJ6hrltpYEF9r7i
	UudrtyBgR0BphTXkVaom2HJnjkdiGLOcUcfQxssY+yp0kKl0aD2bPp/vv6IM+AU7
	bLgn2YXySTm/d21rHDOQzepKrE/KH1VMHwbCdvhNhg4Klig5CLGAkI4HgleBJWSz
	WYvMgMjmXL/oCzqBPv3FptXZq8YhyBAioDC6kORyytHL36DHGCM9239Ubs5BdYUg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8brr3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 13:17:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CD4cld010292;
	Fri, 12 Jun 2026 13:17:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09yyd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 13:17:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CDHYcd40370556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 13:17:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 356C220043;
	Fri, 12 Jun 2026 13:17:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03F9020040;
	Fri, 12 Jun 2026 13:17:34 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 12 Jun 2026 13:17:33 +0000 (GMT)
Date: Fri, 12 Jun 2026 15:17:27 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nina Schoetterl-Glausch
 <nsg@linux.ibm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] KVM: s390: vsie: Implement ASTFLEIE facility 2
Message-ID: <20260612151727.6371d634@p-imbrenda>
In-Reply-To: <20260612-vsie-alter-stfle-fac-v4-4-74f0e1559929@linux.ibm.com>
References: <20260612-vsie-alter-stfle-fac-v4-0-74f0e1559929@linux.ibm.com>
	<20260612-vsie-alter-stfle-fac-v4-4-74f0e1559929@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Xfa5Co55 c=1 sm=1 tr=0 ts=6a2c06f2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=YyXg9xsmcDl62_M5rxQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMCBTYWx0ZWRfXzL+I4cIlNrV5
 3TzTg2k9WWMOVDQ4ruhlekT3WMvv2apIa2Ae0qTvOBJO2N8NFyP4yWKg4E9R8i7n/+c3xsYW4Ie
 vdPGFM1COWUftNQLtVNBa+cCOpoFXRNbchLpnTTaM/UsOmWzwKMaI60SfEvaldOgRFQHUyGgGim
 8zwbpslyOIvmHIQ7BsYJOsUHDNeVlYeCX3X1ALjf3FO1KGIERr4NAby6FNSjrz8/mQutgoN//My
 /Iuaemi6gqgaoew/sZR5m4TB23b9n1d1+tNbvi6uuEwXSnsWMndTcrarLC5T6IgLtNrJvX1WCKE
 ZxVr7ka43q66kPgWOsVdc+pHqsoFC1BTwBqsUqbanmUZD83djPBzH3KpAz7Q0bnCAmEunufMLez
 /SoxkMZwUjUQ4n4FXsGxmMZ8xNzthA3nm1/PEKrYOWVDPb9+7zTAvTqLNJsNMpwBsCJ79ZZKMgo
 u3phUHXU1/9faJbMwtQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMCBTYWx0ZWRfX2oZQU+iT7cqA
 jI6v7y25fDy1kEknVTGxpb0bjPPsTxuMSL5xCs6R8Wf1txJiGo2VzdQrQDJLQapjVeaF1CCM5z8
 D/asio6U1jaBXxmnxcePE9mvcexZPK4=
X-Proofpoint-ORIG-GUID: v_tr-oNiB7m7meaCMtAvwvbojO_CANhC
X-Proofpoint-GUID: v_tr-oNiB7m7meaCMtAvwvbojO_CANhC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120120

On Fri, 12 Jun 2026 14:23:04 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> 
> Implement shadowing of format-2 facility list when running in VSIE.
> 
> ASTFLEIE2 is available since IBM z16.
> To function G1 has to run this KVM code and G1 and G2 have to run QEMU
> with ASTFLEIE2 support.
> 
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 12 ++++++++++++
>  arch/s390/kvm/kvm-s390.c         |  2 ++
>  arch/s390/kvm/vsie.c             | 34 ++++++++++++++++++++++++++++++----
>  3 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 8a4f4a39f7a2..aa4c4685f95c 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -504,6 +504,18 @@ struct kvm_s390_cpu_model {
>  	struct kvm_s390_vm_cpu_uv_feat uv_feat_guest;
>  };
>  
> +#define S390_ARCH_FAC_FORMAT_2 2
> +struct kvm_s390_flcb2 {
> +	union {
> +		struct {
> +			u8 reserved0[7];
> +			u8 length;
> +		};
> +		u64 header_val;
> +	};
> +	u64 facilities[S390_ARCH_FAC_LIST_SIZE_U64];
> +};
> +
>  typedef int (*crypto_hook)(struct kvm_vcpu *vcpu);
>  
>  struct kvm_s390_crypto {
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 2a57ea095b48..cb623fc41127 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -460,6 +460,8 @@ static void __init kvm_s390_cpu_feat_init(void)
>  		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_IBS);
>  	if (sclp.has_kss)
>  		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_KSS);
> +	if (sclp.has_astfleie2)
> +		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ASTFLEIE2);
>  	/*
>  	 * KVM_S390_VM_CPU_FEAT_SKEY: Wrong shadow of PTE.I bits will make
>  	 * all skey handling functions read/set the skey from the PGSTE
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index c7dcdd460dd1..9abc2c657d69 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -65,9 +65,9 @@ struct vsie_page {
>  	gpa_t scb_gpa;				/* 0x0258 */
>  	/* the shadow gmap in use by the vsie_page */
>  	struct gmap_cache gmap_cache;		/* 0x0260 */
> -	__u8 reserved[0x0700 - 0x0278];		/* 0x0278 */
> -	struct kvm_s390_crypto_cb crycb;	/* 0x0700 */
> -	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
> +	__u8 reserved[0x06f8 - 0x0278];		/* 0x0278 */
> +	struct kvm_s390_crypto_cb crycb;	/* 0x06f8 */
> +	__u8 fac[8 + S390_ARCH_FAC_LIST_SIZE_BYTE];/* 0x0800 */

this should be 0x07f8, I will fix it when picking

[...]
