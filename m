Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791105;
	b=5V8GcgVrF9ZZ9B65Dq9RmKvl0WzZ1I6HAbcpXH8kw2gw934j0mx5HtbkL71o7WCWh67f
	 1E2k8nVhcnOq0F8U8P9ESSjO6lZSV/3GpJB0W2Q3/2r4cKftA27xTMrNcaXoIzGngOcTD
	 nZ/v29TvTKBrSylYYcSP/ka1rBE00r7DeGYihWAkf804RsiC1KsP8XqzL3R6J13C7egas
	 CufTLIzqUICejSVixEomQTeC4QSmkdV9/hKVYxmHRV7HwgwLJzqwtNx8Yaufm4bZ/zhqA
	 B9aOhhhJsN+zQxe7Gbxuroxg4CEvrx7V6SSOo1qzk60D7xwvF1AIClMRxAOemMA9FZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791105;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=JeBiRUxiLSmLiDQcpBLwTCe3hNTjIzn+WtvUlP0PG6U=;
	b=U828FDb+aw+3uJqqC1kZOFWVC9+JYkJh6ozSurp6is/460xKgY28DSZbYOBLJud5UG2j
	 ACLh4XnYkoHPQoa4qzBV6iTiN4aqbunnveJQDFLIOpqYMSCEN9Tv2w4VKth0wZJ1gphPB
	 PsbgOP/PxpTqZqYXWAZE2AP/zFax2anE1ZTfGGTaHL2ns1lr/cwS1uFi9/mS3jJ7e0Cqg
	 ONK8TG8i2DVouA0PehdS1tuYWllIx9UoHteyo9+d5qkB1P/01ohq3S9Q0ZBX2avLLdxbF
	 ANfFRL+E0PGHOH8st9Bgx7semRWF9jHHim3UTDWa020X+VCG3l1Tq3eJ+FFsAqbAeZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FFNCMwyw;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F739606A31B;
	Wed,  4 Nov 2026 11:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F739606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FFNCMwyw
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BEtOF399789;
	Wed, 4 Nov 2026 11:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JeBiRU
	xiLSmLiDQcpBLwTCe3hNTjIzn+WtvUlP0PG6U=; b=FFNCMwywEFF0SMheApDhZ5
	uIcRM7gzJ5xZuQyViWtyLbRjzu9obYB+X1IRB1AUmPt876uQJvztWdL6vkJYHSc7
	ShWeUYIlIV0wiAtG8rjVp0gwyp0z98VeEvvumwEB5zcYTa/+Ptv4ssqEbab9IC0G
	vK+cVnR1+wVKLIu2mKPjIX82PAfzop6D56bFw8KOrujm/ijEDHp4C5BMr2q41qKT
	N7I/DQPPXgwutrYfWqZlWKF7fJMMfZ3bzpy5XJxtdetm7aSjsQRb664RFjwG1QcP
	iJXkr/Z33tCmXBBhL7BO8mo5hi9VB7d4RuN8LYrsD+DrJWGW/FTNN30GB0bfYRfQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7ys32a5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 11:18:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4B5X7R4027038;
	Wed, 4 Nov 2026 11:18:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqbqke1hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 11:18:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A4BIFIJ17695030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 11:18:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C75220043;
	Wed,  4 Nov 2026 11:18:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AA4820040;
	Wed,  4 Nov 2026 11:18:15 +0000 (GMT)
Received: from p-imbrenda (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  4 Nov 2026 11:18:15 +0000 (GMT)
Date: Wed, 4 Nov 2026 12:18:11 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: Re: [PATCH v4 5/7] KVM: s390: vsie: Fix pinning using the wrong
 flag
Message-ID: <20261104121811.024f3097@p-imbrenda>
In-Reply-To: <8a182c71-6198-4d5d-9391-802d3ad67f8c@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
	<20261028185422.272146-6-imbrenda@linux.ibm.com>
	<8a182c71-6198-4d5d-9391-802d3ad67f8c@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6aeb147e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=2TDH5Pokhx7QKVwfa0AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA0NCBTYWx0ZWRfX5OMfhLRI0cns
 higBfY7sq04T3AOVQ6yZD7sW4MSTlpczJjGUfQRbuinTM/p97+A4zg0pfZ7CXteG6gYK3GHNbBX
 /TEYlz7i/9j2IqjKjXTupBxI0PIBGEU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA0NCBTYWx0ZWRfXztciftShxmU1
 LxMdQLzBGxeKpGs5cwljCknJC456Bm8OAw2hEmgwx9Odp71AJo0AV+ZQBmBe//Bv8XoIkRxWywo
 qvYtyqzMs4LMlTj09S7hiVqrObYxsT2bTr8G40QguNanbf9lY+mfgEBS01VrHMr/zqNyi6JFExG
 msL/QG8Oox0sruBg78odYzNSO/n0pbUUaYEh8Ff2TpoFM6uEnCF8+oEiXYOF8yZCt/SxjcVt08h
 lkHYevQ1zxWwuNNTOH6vBIHLmr1VIUwY4ob7/HVXyLdfxQL1pTQmM6w8XTNMl1OdIqIyCLyAbuX
 SaaWzO/4XqnY1KPg1p+fIlMCVUyU3HTREGj/WmX9dfTwESmNf0yaPNa3mkW9k3XWwuNM/sOhEkS
 x2XjPovthZtmVQWoEoEXLemleV6Q4ujfzySSTzYJz4E9cMrvgy2kIWgTRCryNBn2NTlJTbnC3mO
 GSqbf184eFARzApIVVg==
X-Proofpoint-GUID: JyGXIIrqOHJi_CaXDizG24YMdeOhmtx8
X-Proofpoint-ORIG-GUID: JyGXIIrqOHJi_CaXDizG24YMdeOhmtx8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_03,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040044

On Tue, 3 Nov 2026 16:31:50 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 10/28/26 7:54 PM, Claudio Imbrenda wrote:
> > When pinning guest memory using pin_blocks(), gfn_to_page() was used,
> > which under the hood uses FOLL_GET, which is the wrong type of flag for
> > memory that is accessed directly by hardware.
> > 
> > Fix by using kvm_vcpu_{,un}map(), which uses FOLL_PIN and is the
> > correct thing to do.
> > 
> > While technically a bugfix, the previous behaviour can only lead to
> > guest corruption in extremely convoluted test scenarios that cannot
> > happen in real/production systems.
> > 
> > Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > Cc: stable@vger.kernel.org #7.0+
> > ---
> >   arch/s390/kvm/s390/vsie.c | 135 ++++++++++++++------------------------
> >   1 file changed, 49 insertions(+), 86 deletions(-)
> > 
> > diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> > index 5926689fa226..6dd06ed52bb8 100644
> > --- a/arch/s390/kvm/s390/vsie.c
> > +++ b/arch/s390/kvm/s390/vsie.c
> > @@ -49,20 +49,21 @@ struct vsie_page {
> >   	/* address of the last reported fault to guest2 */
> >   	unsigned long fault_addr;		/* 0x0228 */
> >   	/* calculated guest addresses of satellite control blocks */
> > -	gpa_t sca_gpa;				/* 0x0230 */
> > -	gpa_t itdba_gpa;			/* 0x0238 */
> > -	gpa_t gvrd_gpa;				/* 0x0240 */
> > -	gpa_t riccbd_gpa;			/* 0x0248 */
> > -	gpa_t sdnx_gpa;				/* 0x0250 */
> > +	struct kvm_host_map sca_map;		/* 0x0230 */
> > +	struct kvm_host_map itdba_map;		/* 0x0260 */
> > +	struct kvm_host_map gvrd_map;		/* 0x0290 */
> > +	struct kvm_host_map riccbd_map;		/* 0x02c0 */
> > +	struct kvm_host_map sdnx_map;		/* 0x02f0 */
> > +	struct kvm_host_map scb_map;		/* 0x0320 */  
> 
> Not sure if it makes sense to add offset comments for structs that we 
> don't control ourselves.

tbh I agree, but I wanted to keep the existing structure

> 
> OT:
> Well, does it make sense to have them at all, this is not a HW struct 
> after all? We do have a 4k limit in place so we don't need to count 
> bytes to avoid crossing a page.

some things require special alignment (but I guess we can align them on
a case by case basis)

> 
> I won't hold back this patch for the comments, I just noticed that this 
> looks weird.
> 
> >   	/*
> >   	 * guest address of the original SCB. Remains set for free vsie
> >   	 * pages, so we can properly look them up in our addr_to_page
> >   	 * radix tree.
> >   	 */
> > -	gpa_t scb_gpa;				/* 0x0258 */
> > +	gpa_t scb_gpa;				/* 0x0350 */
> >   	/* the shadow gmap in use by the vsie_page */
> > -	struct gmap_cache gmap_cache;		/* 0x0260 */
> > -	__u8 reserved[0x06f8 - 0x0278];		/* 0x0278 */
> > +	struct gmap_cache gmap_cache;		/* 0x0358 */
> > +	__u8 reserved[0x06f8 - 0x0370];		/* 0x0370 */
> >   	struct kvm_s390_crypto_cb crycb;	/* 0x06f8 */
> >   	__u8 fac[8 + S390_ARCH_FAC_LIST_SIZE_BYTE];/* 0x07f8 */
> >   };
> > @@ -681,72 +682,45 @@ static int map_prefix(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struct
> >   }
> >     
> 
> [...]
> 
> > -/* Unpins a page previously pinned via pin_guest_page, marking it as dirty. */
> > -static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
> > -{
> > -	kvm_release_page_dirty(pfn_to_page(phys_to_pfn(hpa)));
> > -	/* mark the page always as dirty for migration */
> > -	mark_page_dirty(kvm, gpa_to_gfn(gpa));
> > +	if (kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), map))
> > +		return 0;
> > +	if (!kvm_vcpu_mapped(map))
> > +		return 0;  
> 
> That's a duplicated check, no?
> 
> kvm_vcpu_map() returns this:
> return map->hva ? 0 : -EFAULT;
> 
> And kvm_vcpu_mapped() returns:
> return !!map->hva;

I swear it made sense when I wrote it :D

I'll remove it

> 
> 
> > +	return (hpa_t)PFN_PHYS(map->pfn) + (gpa & ~PAGE_MASK);
> >   }
> >   
> >   /* unpin all blocks previously pinned by pin_blocks(), marking them dirty */
> >   static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
> >   {
> >   	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
> > -	hpa_t hpa;
> >   
> > -	hpa = (u64) scb_s->scaoh << 32 | scb_s->scaol;
> > -	if (hpa) {
> > -		unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
> > -		vsie_page->sca_gpa = 0;
> > -		scb_s->scaol = 0;
> > -		scb_s->scaoh = 0;
> > -	}
> > +	kvm_vcpu_unmap(vcpu, &vsie_page->sca_map);
> > +	scb_s->scaol = 0;
> > +	scb_s->scaoh = 0;  
> 
> This looks soooo much nicer.
> Thanks for cleaning this up.
> 
> The rest looks fine to me.
> 

