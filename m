Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A595C448CF4;
	Tue, 28 Jul 2026 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249806; cv=none; b=RdUeY5CW1RMj9nHELjzTjuvTIWCzPii/X2F4T1Uzq2BJnNyfjM9JI6aK4sp3VgKpdMxQvtXZywIHeujS3HM2LohUARUwqgSkbgM4hHJs0F7uriTTrOphyp9IbmRuXlg9mqkJ+V9fsnoTu1N1tH9W0l3+NU/ZAgOoZYYzYNh0X1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249806; c=relaxed/simple;
	bh=w7Zzhce0TWe/WabLsNQTEG8CbCIaUrKZfyu5lDhyQYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5i54VvGzp1558/hHt3GpUOOPAyA6Hg/mQvMQnu1MdYayt3SX3a+wVSynkWA3N92hXljYCQS1a9Z8meoyX3FDnvsDKnuPAvyLau3MUYRAttd/fxkdRR75/yUm99lbpJFtd2PH1kIMa/L8vqV1WrR22Prkf6FkKFkZT6ZSa/n9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bdWP6obn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bdWP6obn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SDlg7A1356676;
	Tue, 28 Jul 2026 14:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sqAdYE
	Ob4kLdAF/BUMX181y0iRXHew1ImpypI2TO3Gk=; b=bdWP6obnB68ADRxReLti4/
	U4CPipP7bHXAYMDk9k9ZYdHjpYHFe6ZEggtvHycALHdqmrpfyRurO9bX2TUQWua6
	/KEr4DvY2pCcgYCtd0S66Zdig4ZE+8WFAbdWZ4q2gPkrXdLHb/s/w6fVRHhRs4lD
	Jk9rB8pXAdGQI2oPfBys+lovgO/hgaaPeagEfLA1aolsR2phoL/NmXZgj+Xw661h
	dMEmgTVjP9JbD0su8imgxUREkdgPGxb9UvSugbXJnFRzSHHOlMNVXm2ilo3sJO9X
	wii2sIs1lWOQgtARHA3n63alztjP6RGw4M/UAdZbF/XKfIr8r84y+/1bsGMoz3uA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcw6q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 14:43:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SEffum024265;
	Tue, 28 Jul 2026 14:43:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y20t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 14:43:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SEhEi232375048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 14:43:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B57D02004E;
	Tue, 28 Jul 2026 14:43:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0A6C20043;
	Tue, 28 Jul 2026 14:43:13 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.73.241])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 14:43:13 +0000 (GMT)
Date: Tue, 28 Jul 2026 16:43:09 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: Re: [PATCH v3 10/10] KVM: s390: Fix cleanup in
 kvm_s390_pv_create_cpu()
Message-ID: <20260728164309.5a172dac@p-imbrenda>
In-Reply-To: <dd83d8ba-e8fc-48ec-b980-d9331d2e29c8@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
	<20260727150254.236021-11-imbrenda@linux.ibm.com>
	<dd83d8ba-e8fc-48ec-b980-d9331d2e29c8@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: oVCemLghfhs-1B_SSZHALIa6I1x1wRel
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEyNyBTYWx0ZWRfX1GFpBrQsVf8O
 opK1nK02PYAaeXVVoPagca8dTtFoEs7fuSoE8IC7gMM0TlNiCYcve3dzzLK/iCFh0kWswgi+wYz
 BRpTmnfsM2D7Wuz1Fn+pY8/kblZFZM4=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a68c009 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=-VSMeyrPRzZKpqsa-XEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEyNyBTYWx0ZWRfX9KPc0AKyo3Kb
 FfDwoL8WprlvfT+MhFmQiUf7IDRqhJAth6TDlwugo0dIW6kJ+nkcZF3ganp4TgAKCbA5ONsQlAo
 vaTb5v5fXhVqOUWeTcxKOlh+nVhTwUbR61n75TRHCqjO23C6gEhjkJU4tjLdNtomwy+ewVUKy3G
 PyocT8GXRXOcRdj7zhkENUi59ZCyNPgmJ/NtzqFfY4b7EywU4qeGVv9yJvmagWPDj1J1urK8DPz
 OYORMJwUGyfdLmT7QJC8I4k4a8XxiE9C/3iiMe8uXdqRsvwcPvh1/QS/RTTjZCQBNUR0xWSi/LR
 86YdAIKkgyVkmeRLOnP4eCJ+MFvIgGKFeOOqabhBw7EDL5PPgWazMAi2IzlWigWbOQtZE/IvTs9
 8JPHQMKzz1dWXNdx5QLu6K44RX9bsSwy3BcGewYwfjs0vpyp8QsXTtuLFiTTS8PhA3fRkX6HclL
 Z9hsCWLMx9D6vFF1xWA==
X-Proofpoint-GUID: oVCemLghfhs-1B_SSZHALIa6I1x1wRel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280127

On Tue, 28 Jul 2026 16:12:15 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 7/27/26 17:02, Claudio Imbrenda wrote:
> > If creating a protected vCPU in kvm_s390_pv_create_cpu() fails,
> > kvm_s390_pv_destroy_cpu() was called, which checks whether the vCPU has
> > a PV handle and exits doing nothing otherwise. At that point, due to
> > not having created the protected vCPU, the PV handle will not be set,
> > and kvm_s390_pv_destroy_cpu() will do nothing, thus leaking the
> > allocated memory.
> > 
> > Fix by factoring out the code to free and reset a PV vCPU; call it from
> > kvm_s390_pv_destroy_cpu() and kvm_s390_pv_create_cpu().
> > 
> > Fixes: d4074324b07a ("KVM: s390: pv: avoid double free of sida page")
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >   arch/s390/kvm/pv.c | 41 +++++++++++++++++++++--------------------
> >   1 file changed, 21 insertions(+), 20 deletions(-)
> > 
> > diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> > index dc204b521052..b02e0159d3cd 100644
> > --- a/arch/s390/kvm/pv.c
> > +++ b/arch/s390/kvm/pv.c
> > @@ -244,6 +244,24 @@ static void kvm_s390_clear_pv_state(struct kvm *kvm)
> >   	kvm->arch.pv.stor_var = NULL;
> >   }
> >   
> > +static void kvm_s390_pv_dispose_cpu(struct kvm_vcpu *vcpu, bool free_stor_base)
> > +{
> > +	if (free_stor_base)
> > +		free_pages(vcpu->arch.pv.stor_base, get_order(uv_info.guest_cpu_stor_len));
> > +	free_page((unsigned long)sida_addr(vcpu->arch.sie_block));
> > +	vcpu->arch.sie_block->pv_handle_cpu = 0;
> > +	vcpu->arch.sie_block->pv_handle_config = 0;
> > +	memset(&vcpu->arch.pv, 0, sizeof(vcpu->arch.pv));
> > +	vcpu->arch.sie_block->sdf = 0;
> > +	/*
> > +	 * The sidad field (for sdf == 2) is now the gbea field (for sdf == 0).
> > +	 * Use the reset value of gbea to avoid leaking the kernel pointer of
> > +	 * the just freed sida.
> > +	 */
> > +	vcpu->arch.sie_block->gbea = 1;
> > +	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
> > +}
> > +
> >   int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
> >   {
> >   	int cc;
> > @@ -258,24 +276,9 @@ int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
> >   	WARN_ONCE(cc, "protvirt destroy cpu failed rc %x rrc %x", *rc, *rrc);
> >   
> >   	/* Intended memory leak for something that should never happen. */  
> 
> That comment doesn't make a lot of sense anymore after your changes.

how so?
potentially calling the helper function with free_stor_base == false

