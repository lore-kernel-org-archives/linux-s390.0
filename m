Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DEC44C65F;
	Wed, 15 Jul 2026 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118121; cv=none; b=b3y34WwjJTvfM6aEk0hWYlKIbuaMkwGrqlIngRSc9kKSAmZ2xvjpUjG7g4j3StttOxWL6Z3maQ6HAZA3nicKlkdQwmDlKk8p9f39G5Mu3YHnkd8SSfdvNcV/7drR/UR5tulLqCmd6dJpGtJ2F+RvSxjIM9j9K9WB42TDoSzZgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118121; c=relaxed/simple;
	bh=x/+Deqo72SEBIsarop1qZEWlqqsNvS9ulVXGIckFS0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApzCE1S1URskC6j4lVUxYv/ogJBt0EUzR2ltc3sY4EQKWIt8JBLKMwwm1gDr8sWk/lE1Iwt740t3U/AWamLY7fqBeriWPCnxmOQ7v2+kjl8fkX1JHXwChVSwN6hDCAdK4MZAI5bMygJvLOwZPPcBkFTdzmNyth2OSifAwzD2ETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U9JW+Sf1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U9JW+Sf1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBfYVM2370482;
	Wed, 15 Jul 2026 12:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nvXOTE
	192DT2O9k6oybYScSvBhqBDbOeX3gUaBQjxak=; b=U9JW+Sf1SsJWZ45G1bdkya
	Op42m4pX6osIEgFEUReqTzK9pCwqHF/ncKyD4uPXp/NtJdr2DPLjKXiVWHaQgGss
	MlfJMbRbyU2HHvmpA3FNzRHmxRlKX5T6ccLOCJnsj9G1WcvcF8TZ+O5QKJCLrcKG
	uDHbQET2jEdj2RgFyhnNqLei9KUr6E9kvgcQFfyIgdaGvak09ae/oLrlJF+9IS/a
	1EJpK9jzUDbvNaF3f7LIO+nmokhs3inA15+9WLEpWdYpCI4Rl0HEjbZz1Yl48DDg
	xDxVkxWnz0M+xzPr0TjS0Ke9swlr2z1Ee5kEdMZ8emDqSQcbf9V4vT4gAc6waqTA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33c15c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 12:21:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FCJbw4032513;
	Wed, 15 Jul 2026 12:21:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgfqyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 12:21:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FCLkhk49021280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 12:21:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59A8A2004D;
	Wed, 15 Jul 2026 12:21:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F022F20040;
	Wed, 15 Jul 2026 12:21:45 +0000 (GMT)
Received: from [9.111.23.116] (unknown [9.111.23.116])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jul 2026 12:21:45 +0000 (GMT)
Message-ID: <2b51de93-eb60-4ce0-87e0-6ff98c9cb5c0@linux.ibm.com>
Date: Wed, 15 Jul 2026 14:21:45 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/21] KVM: s390: vsie: Add struct vsie_sca with pin and
 unpin
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Eric Farman <farman@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-15-ea9f12066408@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260709-vsie-sigpi-v1-15-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEyMSBTYWx0ZWRfX7ppKYt6Q8ca4
 tQSMPIthLEulQT1lddkUJhHhOdpfmDBuNiStxQLZlIUQp0o4axAhgxcy08Im7TvwLZXN3GyiZ1m
 fSHFOoBoPUwtbny4pmnYW6+T8NaldS8=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a577b5f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=PGrXbKZJNvlhCRs6KjAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HK2RbLkZGteAS7Vx7YY3Yu-zZlWK9qFI
X-Proofpoint-ORIG-GUID: HK2RbLkZGteAS7Vx7YY3Yu-zZlWK9qFI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEyMSBTYWx0ZWRfXx34ccdGpUz0E
 iiOLlpCSYUSdxSjK9YC5yOpKVE0Qb/sj0hpdzMb57+YO8tMxotX+irNqki5a/Z079SxcVLZAAvP
 au2IQIIL7M4cOGlerfGzSZHYILu+UTsD3MFKaBM1piYTjevrXMD9N8jaRND9bDACl7J6soRILh5
 FR097y5tm0dLEzHG/fuo4MboDX7XPOTpSjhBXtUZDonM/1Ky83ST+C/+cLWYWP8AkOIXtg93rsK
 rGwCE+Ld4QToo4WYSeIfd9mo4B+jLp/Pp0XajpCtmQQMBf71unZcYIifdyL5486m0NGcJ7OIi7U
 +GmdRnjOUFt9vbMs7UzRA5jc5BkTxkor/E8RZ3XbaqtqfW2TF5u2T55nrOCMH6ikHYs293EH/Ex
 HdhaWYJINmZE/tmgvPIuBVMoYABgL4hk88ZQ8Rl5rIzMG18vVuGf1L8jommGs0mb9Z/NpXbvRaO
 g8znP51LxNixHK9iiYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150121

On 7/9/26 17:15, Christoph Schlameuss wrote:
> Introduce the struct vsie_sca to hold the SSCA and required management
> data along with alloc and free methods to use with the struct.
> On this basis we can also add methods {,un}pin_sca() to simplify the
> pinning SCAs in g1.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host_types.h |  1 +
>   arch/s390/kvm/vsie.c                   | 79 +++++++++++++++++++++++++++++++++-
>   2 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/asm/kvm_host_types.h
> index 6540146b4b00..d6025b34a66d 100644
> --- a/arch/s390/include/asm/kvm_host_types.h
> +++ b/arch/s390/include/asm/kvm_host_types.h
> @@ -7,6 +7,7 @@
>   #include <linux/types.h>
>   
>   #define KVM_S390_MAX_VSIE_VCPUS 256
> +#define KVM_S390_MAX_SCA_PAGES 5
>   
>   #define KVM_S390_BSCA_CPU_SLOTS 64
>   #define KVM_S390_ESCA_CPU_SLOTS 248
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 874ed2a55347..4b492af15542 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -29,6 +29,7 @@
>   
>   enum vsie_page_flags {
>   	VSIE_PAGE_IN_USE = 0,
> +	VSIE_PAGE_PINNED = 1,
>   };

This seems to belong to the next patch.
Also I'd adjust the name and incorporate scb into it so it's clear we're 
not pinning the vsie_page.

>   
>   struct vsie_page {
> @@ -64,7 +65,8 @@ struct vsie_page {
>   	gpa_t scb_gpa;				/* 0x0258 */
>   	/* the shadow gmap in use by the vsie_page */
>   	struct gmap_cache gmap_cache;		/* 0x0260 */
> -	__u8 reserved[0x06f8 - 0x0278];		/* 0x0278 */
> +	struct vsie_sca *vsie_sca;		/* 0x0278 */
> +	__u8 reserved[0x06f8 - 0x0280];		/* 0x0280 */
>   	struct kvm_s390_crypto_cb crycb;	/* 0x06f8 */
>   	__u8 fac[8 + S390_ARCH_FAC_LIST_SIZE_BYTE];/* 0x07f8 */
>   };
> @@ -76,6 +78,27 @@ struct kvm_address_pair {
>   	hpa_t hpa;
>   };
>   
> +enum vsie_sca_flags {
> +	VSIE_SCA_ESCA = 0,
> +	VSIE_SCA_PINNED = 1,
> +};
> +
> +struct vsie_sca {
> +	struct ssca_block	ssca;
> +	struct vsie_page	*pages[KVM_S390_MAX_VSIE_VCPUS];
> +	struct mutex		mutex;

You added a description about what the mutex is protecting to the next 
patch. Move it to this patch please.

> +	atomic_t		ref_count;
> +	gpa_t			sca_gpa;
> +	unsigned long		flags;
> +	u64			mcn[4];
> +	unsigned long		sca_o_nr_pages;

unsigned long might be a bit much for a handful of pages.

> +	struct kvm_address_pair	sca_o_pages[KVM_S390_MAX_SCA_PAGES];
> +};
> +
> +static_assert(!(offsetof(struct vsie_sca, ssca) & 0x3f));
> +static_assert((offsetof(struct vsie_sca, ssca) & ~PAGE_MASK) +
> +	      offsetof(struct ssca_block, cpu[0]) <= PAGE_SIZE);

If we force ssca to offset 0 will the second assert be unnecessary?
Where did you get the second check from anyway? Send me a DM.

Something like this could be a bit clearer:
/* SSCA needs to be 32-byte aligned. Let's be lazy and force it to 
offset 0. */
static_assert(!(offsetof(struct vsie_sca, ssca)));

> +
>   static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
>   {
>   	return (scb->ecb2 & ECB2_ESCA);
> @@ -831,6 +854,60 @@ static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
>   	return 0;
>   }
>   
> +/*
> + * Unpin g2 original sca in g1 memory.
> + *
> + * Called with vsie_sca_lock held.
> + */
> +static void unpin_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
> +{
> +	if (!test_bit(VSIE_SCA_PINNED, &vsie_sca->flags))
> +		return;
> +
> +	unpin_guest_pages(kvm, vsie_sca->sca_o_pages, vsie_sca->sca_o_nr_pages);
> +	vsie_sca->sca_o_nr_pages = 0;
> +
> +	__clear_bit(VSIE_SCA_PINNED, &vsie_sca->flags);
> +}
I think you moved out the wrong code.
Leave the structs and constants and move the functions into the next 
patch so it's less confusing for me and the LLM :)

You can consider splitting the scb pin functions from the next patch as 
well as get_vsie_page() (if possible, didn't fully check).
