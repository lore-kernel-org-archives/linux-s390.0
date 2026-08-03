Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F931F995;
	Mon,  3 Aug 2026 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768899; cv=none; b=FszXQlhxzqHADTejreGf/c9Pbl9Gl70BYk4oC1OmWePYd7QkMLe57efjnV6A1R7qYpjpB/zhGt16SiZqEqT8YhqxE+Wuzlh363y0W8sBFBxavkzWl7f2hObFfcAisaRMQNHRCglV2jNjfxeUtLVYDSSuuhT6BkPhHLQ78/twtUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768899; c=relaxed/simple;
	bh=odSNU+3v+WRHjeiwtRpTXdpaH9Q4at8RJZDW8jBNzwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3829iIMn/hJA1pOOPHc5pfyOoSly4toQ2sw/FH87+BIp3mIB1SQBAN7GS4HxRFXu3CMfbDbxe8AvYfPxAxVqeDm73vuR5SFKBlYmu0TmilMFbTWc5d1MBKmwEV+uTAe4617Yqn9RIKSNfJjT3tYmWpaIVPbJWXdZDiujxm+QPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HI5I43zC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HI5I43zC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHdNC2282639;
	Mon, 3 Aug 2026 14:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G8xI9V
	A0XsmIMAd8gOqOIrzejpg5Zu11pyi3nap8ghw=; b=HI5I43zCHiLbT+EUwIWIr4
	HZ72v7eq5UGg/1Ym09ogOJ8oUtYBoc8n9sKwunqCA+711DuRcmkyRcGwfrpa0Zfo
	up/q07Nr07ioyTKJPUQ+dsqmCgrmq7aNNzawlRGhW8LQ1StcoGoh61TuOMponpHx
	CkzjvLKt/uDsYgnTIpN34s72PAJeJMNYFvymFKqHkFHdjkvNHeXiEEDoJyiUTwpP
	XhDC5fNBD3AonezueeKmSX84V3KEbiZ6PDz8sNjsrskQaZ/1nKglhOPvkZTCN/Rc
	BMHCZ55ZtZz/U/+2FwQjdcuOOmtII6zpGdaKqqsdS8D7Qinb7VmyRLgBvAo+7AlA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4scut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:54:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EfFmA030482;
	Mon, 3 Aug 2026 14:54:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtydmc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:54:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673Esn7s17433060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 14:54:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 485982004D;
	Mon,  3 Aug 2026 14:54:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1686820043;
	Mon,  3 Aug 2026 14:54:49 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  3 Aug 2026 14:54:49 +0000 (GMT)
Date: Mon, 3 Aug 2026 16:54:46 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: Re: [PATCH v8 03/13] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
Message-ID: <20260803165446.6d053a29@p-imbrenda>
In-Reply-To: <b36684f2-0844-4695-8d9f-cac74ad88af9@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
	<20260803124040.126471-4-imbrenda@linux.ibm.com>
	<b36684f2-0844-4695-8d9f-cac74ad88af9@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX/7Q8rzQhwopC
 u3fJ8dGcpes37jRPeLSaS8LtbYtrhlZAbfBS67cXG6RLHTh79Sg5QT3iwcuIXJYf7kDmiK2V4/C
 K7ckIQR3VV1LLESEHKLIb00260C18SA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX9OLWD0TDxPVm
 g6NjSJWuOr8+xI534wy7iq55wFtdRqvl1vcFaFQ447KrbBZ9hfCAglpEMx1LFvq6wgYmxCYZD3n
 3XHnI1yz5wAC6UyihUscRj9yjK0kVqCRCiKhe7TX0YlxsNBfPUmwtknP/CVN4TonYW8QMNo1PCY
 S4F7HUCka0DQGhNFivzvMZuIpQO/D1h/C71vsAjv3nwnsZvb5fx576ciLIAcEFXrbA89aiIi7oO
 2IkujylwD96SEid9HUxFDZotbwAL/qBGPhxhmpXuJMefZRVVl6YtOqi0dyqpCZeYm1pJ5044MQ9
 Fcz3k3IxZye/Ms01G5fpyp6okIZxBhA+wtnmC0kNpRt2CFXMyO7fCvmcmEH1COzrtr1ZPDqYiJh
 wyekJIp68NTHMbCplTJ84jyUlL9/bYnUFTXzhvmMxe0ug+djtt3HoSTkNnFAIBKYSgB567kYVbR
 PTyzc9628c1ClYA8Wog==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a70abc0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Q5H-Lj453KBsm_83YB8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: krgsRFP6w2mNBLg35ftbpDRZegFlTGm5
X-Proofpoint-GUID: krgsRFP6w2mNBLg35ftbpDRZegFlTGm5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030133

On Mon, 3 Aug 2026 16:30:21 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 8/3/26 14:40, Claudio Imbrenda wrote:
> > In some cases kvm_s390_vcpu_unsetup_cmma() can be called with a 0
> > cbrlo; in such cases, if running with V != R, free_page() will attempt
> > to free physical page 0.  
> 
> Secure guests without cmma in the unsecure guest?

normal guests when the vCPU gets destroyed before it's fully
initialized (i.e. something went wrong when creating the vCPU)

> 
> > 
> > Fix by freeing cbrlo only if it's non-zero.
> > 
> > Fixes: b31605c12f4e ("KVM: s390: make cmma usage conditionally")
> > Fixes: 29b40f105ec8 ("KVM: s390: protvirt: Add initial vm and cpu lifecycle handling")
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >   arch/s390/kvm/kvm-s390.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 1b3290a5ad1a..9be27db0a21e 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -3678,7 +3678,8 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
> >   
> >   void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
> >   {
> > -	free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
> > +	if (vcpu->arch.sie_block->cbrlo)
> > +		free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
> >   	vcpu->arch.sie_block->cbrlo = 0;
> >   }
> >     
> 
> This is fenced for destroy cpu, but not for the transition into secure 
> mode. Can we check "use_cmma" instead of cbrlo and then remove the 
> fencing in the cpu destroy path?
> 
> If cmma is not set-up in vcpu_create, then we exit vcpu creation.
> Maybe sprinkle in a warn on for !cbrlo

