Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544747;
	b=G1xbJD2B0mToodR4iTsyvWeKegvZrDvmhsVmTUZBb7/dXUj1ae4c604KSAGSfsEmeZeq
	 o0CKMdaBrC3kSpAozlKOVZcNTiotieCyIWJRH1MMGl6A4eJSu+hArVQcwnfzRIjxW+Eku
	 STZF8S6FT8LMBJikRyApI2IMIBXp9s/opv7OyfxaKzAodTN0tlRk1Fv0eKjw/Wbe3Rmwu
	 lCj3XfkoBCrGMWmcotdYRZlFtefilxq+C6rE8huuGowDW4VfU7g5MKyNZXuVGlR73bjBW
	 yVRk9CiOKdApq8zoEssxu28eWjXBrdSr5h2/LMmlAnIiXa3QHBuL1l17DmpwlJSlgDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544747;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FK7TF6nx2QGJoGLIPvxemsgkQEfTOokIWX/H1B1mYyY=;
	b=u0I63JwrgZn6Fgg2S06ibclAScq0Ge9SHCttcBaErQWZeYMD4Z62L8nK+9GrkmE/+xSM
	 A+2erq1cLolCMm8ca8yxfeYDERaVeNxaRl9Yo0UUECJjFnpfklU44b6wC7+5ifkVBOjxA
	 jkNNzkAcufYlQ2BOyj/0E6NNigzbEYD3BtMDsVpejD+iDazhBIlSc8ewuGrpoVlIoMb8F
	 NZ8ZNECrYZtghDXsAd/q9GzrMYZdZWNNrCYssm/i0iA8M/sS5hCi08d2iXISidLLJVtNc
	 e0VAchMPlnKprMryxaHA3cEBQ2MN+WJ/CHIMOQUYViL9HwV0NpBbhBfYfwp4nzn0HdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bUSrjmZO;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4CC606A336;
	Tue, 24 Nov 2026 18:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD4CC606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bUSrjmZO
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFa2bQ1235269;
	Tue, 24 Nov 2026 18:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FK7TF6
	nx2QGJoGLIPvxemsgkQEfTOokIWX/H1B1mYyY=; b=bUSrjmZOTCRqeBVQaTx7uL
	IYyIPI89Wk/p+bINEx1u6w9afTKnUHT4rOsdehl6zrv6lXBtpapY101ocZ6DBoWc
	1YEAPP7jS7GufE+9Uf0XPhkgeA0dUKnMAv5bZvo6Q/ckwxPePA2qxU89y211K8tj
	85HKQ2h2eVRMAHyrPVSiUHNYH3X9GaJsM72L4f1rY9ZhSbHfA0RQUOvLrp4JdfZU
	pAWZuieb7ouTV+6Um6Ksf6vwcmCytE9K9o0+zLt8bKAvLxDiHF+RbXt50r3fv4nT
	nAiX0U3f3CxI8jyMGLTyadlkA4ApfY6dKoDADcKBd2TyEbzOiAlw425713wFnJgw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3947x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 18:25:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFJZBY2883662;
	Tue, 24 Nov 2026 18:25:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vks67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 18:25:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOIPcSx17629610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 18:25:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4F6C2004B;
	Tue, 24 Nov 2026 18:25:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4E7420043;
	Tue, 24 Nov 2026 18:25:37 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.42.244])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 24 Nov 2026 18:25:37 +0000 (GMT)
Date: Tue, 24 Nov 2026 18:00:30 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] s390/mm: Deduplicate machine_has_tlb_guest() usage
Message-ID: <20261124180030.35caca96@p-imbrenda>
In-Reply-To: <20261124135948.1295745-1-hca@linux.ibm.com>
References: <20261124135948.1295745-1-hca@linux.ibm.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b05d6a7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=AFcVWVyc7PIXRdJLRLYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3MSBTYWx0ZWRfXwZINeO7443JA
 0xGG1PfSn2V0xGqliKde7IINiLTajJhS4l/VuzzQCIVeKXCCyeNqSqsL9dQT8aGPUU+71hHfObw
 YNfxPo/0Sdj68464xOlFKf44MSiocPo=
X-Proofpoint-ORIG-GUID: pp6-d4SXmXIrjJvrj7IxW8mtxWVftiPX
X-Proofpoint-GUID: pp6-d4SXmXIrjJvrj7IxW8mtxWVftiPX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3MSBTYWx0ZWRfX4Y0MnG1hgbua
 Q6LyH41aPZFXBhrrdkjQOxUK0cRcr8+OZAhVWMdWPfv2OFzwcoxGDUV+WHxf9HBoIKdZibNiRLT
 Vc5gZCOSKj86qesGJCfHv92NzU9Y/aHMS+JnyHHBbgzT+690xydYv86cGfPBCFu7L5OkqvpfaSU
 bAM5NXsDLxkBNJWuRAUisOV68zkb/Tl90sETHJvIm67Lz8uFl+cSWDWLk28IzLUsEuBa6hI45l2
 Ke58NRQQmOWa7z5lNxAhZU84mQJarmhla+tFLzmOIKmdMOjtopwm74/4bxFm2xRxRTwwfP4MGVV
 dY2E5fLBAZ/CPIYB1TnsxQFPPnyy1oq12FygKQNqBGt9V+KpOo5iGbx6QNpGF9I5ZTSn9AqW0Gp
 dUynZNRXisjberEqZgh9wqzcEN49gqEYkKEYWypsAC1zz7e7NSZuTE2Xu8FNcyn1KoL/GhL6fFe
 YIEah8i2oUbvC9OLWYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240071

On Tue, 24 Nov 2026 14:59:43 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> While working on something different there was the need to add yet
> another machine_has_tlb_guest() check. The machine_has_tlb_guest() check
> pattern is duplicated all over the place. It seems to make sense to add
> common helpers instead of duplicating the code again.
> 
> This also revealed that the gmap_asce member in mm_context_t is always
> zero since Claudio's gmap rework. Removing it allows to simplify quite a
> bit of code.
> 
> Code applies on top of linux-next 20261123.

Moving the checks inside the helper is the cleanest way. I was already
working to do this for KVM too.


Whole series:

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> 
> Thanks,
> Heiko
> 
> Heiko Carstens (5):
>   s390/mm: Remove gmap_asce from mm_context_t
>   s390/mm: Remove unused nodat parameter from ptep flush helpers
>   s390/mm: Add ptep_ipte() helper
>   s390/mm: Add pmdp_idte() helper
>   s390/mm: Add pudp_idte() helper
> 
>  arch/s390/include/asm/mmu.h         |  1 -
>  arch/s390/include/asm/mmu_context.h |  1 -
>  arch/s390/include/asm/pgtable.h     | 31 ++++++++++
>  arch/s390/include/asm/tlbflush.h    | 12 +---
>  arch/s390/kvm/gmap/dat.c            |  5 +-
>  arch/s390/mm/pgtable.c              | 94 ++++++-----------------------
>  6 files changed, 53 insertions(+), 91 deletions(-)
> 
> 
> base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5

