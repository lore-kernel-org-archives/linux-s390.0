Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629091;
	b=pFsbmSTFFay601t1zQsC35heoxlERDN82wFUd/26Lvo/N8zKu3igSYs72QI838bupNH+
	 ihDQZOXIJW7m1LuMloR1OVbbwUZhwvaIm0LkFRZKmQGw/rpEhf8fEJuqPZeLdNsf7+4Vp
	 SWeF6gQ3oP24//HNYEsh8CkO1AmCtoa20100k+RLuRrw3VzpVAPUf/K8LwHgRAEAH2wTW
	 RJryYSiZySVT7CiQAYsXB8CcxOVQefWQyys702z8Ob7u+zvfyUCgNyJUKCWs1hT0X6kZQ
	 y6uX8NC+KQ/zckgwNcjCd91/4uyABZTCO6J9kEbu1aEQ7bKlTnjADMY103iwbzinZjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629091;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8eW9phS8sj7+2ncq+kortnmMQd52WyTjCVvQHyuNmaw=;
	b=t7R/PnlyZa1IABg5PfXwJY5nNOox5Je5tVAOLle8bk6Z7N9brO0r/0RROmweuu7VkoyZ
	 +/+XMEWZXydxV0643IcdpG+gUixKQsezzSVETJ+elwpDWTF7HkA4AUaUURLVQHBTC7KbG
	 zqcSZuq5LHMmuT2gVrXZdBBfVpVUKAA9WZLyW950dusTARlZdNza78me+i/SAmfgtSV1Z
	 LnnNX9i4TFxjF+gGFHd1zJAdDOTO3/8LfSB9X0WP58Uhcy4Wxed0GCl30s8R4cTuR3E4m
	 pi6cUOVixKK0VT/sshqr0yV3Pb1xjdyU7h12o3dj/I/N+2QiPbyNR7/kHKgtaLo1Eqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="O/GI6FrS";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B181606B5D7;
	Mon,  2 Nov 2026 14:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B181606B5D7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O/GI6FrS
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EEjkE3114971;
	Mon, 2 Nov 2026 14:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8eW9ph
	S8sj7+2ncq+kortnmMQd52WyTjCVvQHyuNmaw=; b=O/GI6FrSwQXVaTh1n3KCRl
	H/lVHGWwnWoYjjg0Dj6BGodZaPMdTnkzOww+9pV6/oRbxgvmDDdA3SiHU8AMvpEY
	styBxBShDCYFGjeNNPrF/k51U0nXvL3AlbbK7NFd8gdVA7kjNyW9u2i+OIjfGRCs
	oJsgCo2NYKnfhtRuekD1BaAtp2DEzcqYUjJdxY6oAUnG2INEujVLdtAvtb+33bPN
	kwgccw6f6lYzoNzfGQa1S3SPiKGTWvl/kYeBjuub7XYicmBfgK9pYUsZuJU1iYLX
	qr7aSUqMYswoqSDXw8hac917H96XwQ8Eaco03MXAPDP7Gn1mYdGclsyJR7yZFwlg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7yrrtsk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 14:18:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpOPv4016040;
	Mon, 2 Nov 2026 14:18:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnvvfp149-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 14:18:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2EI04x43909490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 14:18:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F4DF20043;
	Mon,  2 Nov 2026 14:18:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 335ED20040;
	Mon,  2 Nov 2026 14:17:59 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.14.46])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  2 Nov 2026 14:17:59 +0000 (GMT)
Date: Mon, 2 Nov 2026 15:17:56 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: Re: [PATCH v4 1/7] KVM: s390: Fix UCONTROL inconsistencies
Message-ID: <20261102151756.0625f117@p-imbrenda>
In-Reply-To: <73347a6b-1224-415d-905a-aec1a62dd13a@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
	<20261028185422.272146-2-imbrenda@linux.ibm.com>
	<73347a6b-1224-415d-905a-aec1a62dd13a@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6ae89b9e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=KJou_Y6U8xQNuixg6DQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NiBTYWx0ZWRfX7dDK15ZLh4VN
 PjFR30I3cCKE6frw0BGYf1Yjz4mWbNsUTRc2ZZ/oELTzEg2B5uwLFE/X9AbOrRRxlBvAZ1YxCfa
 ska49DYxoSX0KV1mT78B5VU52vd63K0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NiBTYWx0ZWRfXyc567bhszyCD
 h1mMvi1ahvBR+EpQ0PihPG+oujvbFlCwoHMaA2sbzYvxa96xUFPeT3A/qGoabbQuWFzmnwiOPhZ
 e3La6aJtOrvF58ZQeyEqTKG1jsaqcx68j60lNE/A2a53XgmiAGJOrorOD6Y4ZTa0PISBH93F/qH
 p+6yJfISWHDvVq+8CjyN1TWNzQa+SM1i0+KsyZZsff7xuvsMu6EsMT+vHW5UaC90VGCpXr420Jd
 BRZtvPxgtWNQZt3AwdLyWQeXABJkkPX954Y4ooNJovMDzn+vZXZa5aso6q74+6jtCNFrNgzEHvD
 ENXAAFvrOhGmrRVyTXGkXgzzhk7HoGRClQz1MV3fnbukjhVGDG+R+ODAkOb81/L3H/XyJNcTS4X
 nn69B+hN1nEeCNkBHbVYVI6jZ0Rq2ruxwm2RIHMJwC3aRC/53u22NTJphofv8Ozr30TxQyOa3ke
 1BmlmvVyIAHCXlWg10Q==
X-Proofpoint-GUID: RTdD8L1UkI4V_M4hYAzPRTaNqgbPFz9O
X-Proofpoint-ORIG-GUID: RTdD8L1UkI4V_M4hYAzPRTaNqgbPFz9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020056

On Mon, 2 Nov 2026 14:45:48 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 10/28/26 7:54 PM, Claudio Imbrenda wrote:
> > For UCONTROL VMs, when a vCPU segment entry is mapped but unallocated,
> > the tl field was set to 1. This collides with the present bit, which
> > means that other parts of gmap would mistake the entry for a present
> > one.
> > 
> > Refactor the code to use a different combination of flags to indicate a
> > mapped but unallocated segment.
> > 
> > The new flags combination will result in several functions returning
> > -EFAULT when used on UCONTROL guests. This is fine, since those
> > interfaces should not be used for UCONTROL guests to begin with.
> > 
> > Proper fencing of the interfaces that are not allowed for UCONTROL
> > guests is outside the scope of this patch.
> > 
> > Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > Cc: stable@vger.kernel.org # 7.0+
> > ---
> >   arch/s390/kvm/gmap/dat.h  | 16 +++++++++++-
> >   arch/s390/kvm/gmap/gmap.c | 54 +++++++++++++++++++--------------------
> >   2 files changed, 41 insertions(+), 29 deletions(-)
> > 
> > diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
> > index 90389d47ba4e..4665c1112bb9 100644
> > --- a/arch/s390/kvm/gmap/dat.h
> > +++ b/arch/s390/kvm/gmap/dat.h
> > @@ -109,6 +109,8 @@ union pte {
> >   #define _REGION3_FR_MASK	(_REGION3_MASK >> PAGE_SHIFT)
> >   #define _PAGES_PER_SEGMENT	_PAGE_ENTRIES
> >   #define _PAGES_PER_REGION3	(_PAGES_PER_SEGMENT * _CRST_ENTRIES)
> > +#define _UCAS_ENTRY_LENGTH	0
> > +#define _UCAS_ENTRY_OFFSET	3  
> 
> Both of these together in combination with tt=segment are essentially a 
> flag for a ucontrol mapping that's mapped but not allocated?

correct

> 
> >   
> >   /* Soft dirty, needed as macro for atomic operations on ptes */
> >   #define _PAGE_SD 0x002
> > @@ -421,6 +423,17 @@ static inline union crste _crste_fc0(kvm_pfn_t pfn, int tt)
> >   	return res;
> >   }
> >   
> > +static inline union crste _crste_ucas(kvm_pfn_t pfn)
> > +{
> > +	union crste res = { .val = PFN_PHYS(pfn) };
> > +
> > +	res.h.i = 1;
> > +	res.h.tt = TABLE_TYPE_SEGMENT;
> > +	res.h.fc0.tl = _UCAS_ENTRY_LENGTH;
> > +	res.h.fc0.tf = _UCAS_ENTRY_OFFSET;  
> 
> You're missusing this field in order to get to bits 57 and 58 which 
> aren't actually the tf field for a segment, right?

yes

> If so, then this might be easier on the eyes since you don't use a 
> bitmask but it's horrible for the brains of anyone other than yourself. 

you're assuming that I don't find it horrible just because I wrote it ;D

> Especially since there's no comment explaining the shenanigans.

comments will be added

> 
> > +	return res;
> > +}
> > +
> >   /**
> >    * _crste() - Useful constructor for union crste with FC=1
> >    * @pfn: the pfn this pte should point to.
> > @@ -985,7 +998,8 @@ static inline int dat_create_slot(struct kvm_s390_mmu_cache *mc, union asce asce
> >   
> >   static inline bool crste_is_ucas(union crste crste)
> >   {
> > -	return is_pmd(crste) && crste.h.i && crste.h.fc0.tl == 1 && crste.h.fc == 0;
> > +	return is_pmd(crste) && crste.h.i && !crste.h.fc &&
> > +	       crste.h.fc0.tl == _UCAS_ENTRY_LENGTH && crste.h.fc0.tf == _UCAS_ENTRY_OFFSET;
> >   }
> >     

