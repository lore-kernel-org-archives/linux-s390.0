Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960C17DFFA;
	Thu,  1 Oct 2026 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863330; cv=none; b=Wp2ddrb4aQUTrTEGP7/ipXkLJQB+qRKkxwKVYcLMAxZrSTAS6LIWDdDsgsFSRhP2apzDQ4wtdXwHpMDQtEIaZp/eqHqCq9CrwiCD+Ept1Wf9P3f88HQQRxA8M7L6BQ7sgZHNFW/UVVbPP6zcd+VnsN48KmGxe2MoHzUqWMEWL4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863330; c=relaxed/simple;
	bh=NuBbFoZn0niIXRTRmUoG8XEUzNHZKWhfO7cXJXLACCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVD0uyTZ7NIIozUIcKmIOXeVLUGk3VSze7GhqlI90l1lyoI3nXhyGjvf1WE2q3MMIswuocLoZmOVX3pntWKhegaolNS1hHRg0DS3Shhnaq+r3ayCqfdVXopen4De9I8IV32kr50IBsftPhwZaZixyPy0AzgGO+ESeXFLTKFCY8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=df7l44gt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="df7l44gt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DasrX1923898;
	Thu, 1 Oct 2026 14:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4CWBB36TayNRMlA0bYNDKSWCDqNVZq
	WzsPrGOYHuOQ4=; b=df7l44gtpkxoE90eEdn6vdqzXK9KmnullnWmh/qNI5vm4t
	HjNdH1gf9IIgbKGYHsnIV6vc0WxHvxk+aQvk1sGSmEyGhJnfmlxQa1tNoFx9TWK/
	c9gttjp7+bzuQ2cPSFZx/Khug4f3XFPlpgW4wpgvbj0VHXW0ENUZ5x4Ct6reXvWF
	FLINnHhCcvNg1kF1Cx0QAPfqcP2vyUg1rGY/OkeQVX1lI5DeUI4n0IzdobethxXw
	wyVHtXpSzG0poavjZDXjH7c7L4RqLRvAqCVDZEmm3U5oapB0WnsSG7pDZSxz/Uph
	pwj6gFj8QguqwGxamJ4AXyThoJSuXayea6gNQV0g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5krem-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 14:01:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 691BUcSJ545523;
	Thu, 1 Oct 2026 14:01:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcse8np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 14:01:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691E1V8k56295810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 14:01:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 902FE20043;
	Thu,  1 Oct 2026 14:01:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C1072004B;
	Thu,  1 Oct 2026 14:01:31 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Oct 2026 14:01:31 +0000 (GMT)
Date: Thu, 1 Oct 2026 16:03:36 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "David Hildenbrand (Red Hat)" <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, Lorenzo Stoakes <ljs@kernel.org>
Subject: Re: [PATCH v9 23/24] KVM: s390: arm64: Implement basic page fault
 handler
Message-ID: <20261001140336.314717-A-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <20260930173441.66762-24-seiden@linux.ibm.com>
 <e2742ccb-6b91-463c-a148-30b7e2f41e9a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2742ccb-6b91-463c-a148-30b7e2f41e9a@app.fastmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1NCBTYWx0ZWRfX2/tDWrsC+4h/
 J7JgixmCTZUbMByuQTn9ggSNDC97iF9uIgF/eSUgQYdCgNrh5VoxSCEFw/U00e1t9jWUtLTU0QC
 mF8gQMk0R25Zix5+3zTVeWkwno+Qva8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1NCBTYWx0ZWRfX9AmvIZDQZYkR
 LSCt2Lur8c5mkYJZSAvSMEpkS+pKcPMMklBuQfat/VsOjT+KpzybElYTTXpob6/diF/oaDmZeg+
 vuDfBIod0nLx6Jy+M2TYAol8PbVQbFQh1LhZODAka4SaoyxTdDOuvR7AXyBx0LTdSeRP1gO1Zth
 sS6G2xL91nEvMP2+ftByK6YbZk6XXBrsln14+XQnuudeFVMngKXmBaDZiZYW7HWiN3FrBXaYs32
 //sd0lTDNknbdZ7OZCXdoGml7ho/cGjg1vkGGL7f2ZIG3hM3WPTwl9W4I6GyL/uXqfN4okCc+Dq
 paDngM+ufFboslaTBPu9a7lWD/i69h3Q8Us9elQbPJWXrud/lMW+E55x5h7e4YleFJtsvQ4PXyV
 7maDfiqqm9HtZjnYAGNEVwtiW3YOhJYYsr9xwGhGbtJt8W3umAmMsiFb3DvKZXF0UYMM5bIPpR/
 bbk9udyIKdkJzNmaOHA==
X-Proofpoint-GUID: L_0ONLFFmcIrsHb4kqzw1Ll-e-2wJL2z
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abe67c1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=OP9nytA2sT3uWfd1H84A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: q5AY-1AMfiv7u9Rp9EXk8TVRJP4lXiON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010054

On Thu, Oct 01, 2026 at 02:10:06PM +0200, Arnd Bergmann wrote:
> 
> > +		/*
> > +		 * Check for a cache maintenance operation. Assume the guest is
> > +		 * cautious and skip instruction
> > +		 */
> > +		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
> > +			kvm_incr_pc(vcpu);
> > +			ret = 1;
> > +			goto out_unlock;
> 
> Hi Steffen,
> 
> [Adding Lorenzo Stoakes to Cc]
> 
> I see this function fails to build on top of linux-next, as the 
> kvm_vcpu_dabt_is_cm() function was removed by commit 18b94675b1fb
> ("KVM: arm64: Use ESR helpers in guest abort handling").
> 
> I used this patch to make it build, but I'm not sure if this is
> the correct fix:
>
yes, it is the functional correct fix.


> diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
> index 3c1c8a2def73..7ee157c61d70 100644
> --- a/arch/s390/kvm/arm64/mmu.c
> +++ b/arch/s390/kvm/arm64/mmu.c
> @@ -119,6 +119,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>  	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
>  	write_fault = kvm_s390_cur_gmap_fault_is_write(vcpu);
>  	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
> +		unsigned long esr = kvm_vcpu_get_esr(vcpu);
move this on top of the function. I need the esr in the function for the
full pfault handling later anyways.


>  		ret = -ENOEXEC;
>  		/*
>  		 * The guest has put either its instructions or its page-tables
> @@ -143,7 +144,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>  		 * Check for a cache maintenance operation. Assume the guest is
>  		 * cautious and skip instruction
>  		 */
> -		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
> +		if (kvm_is_error_hva(hva) && esr_dabt_is_cm(esr)) {
>  			kvm_incr_pc(vcpu);
>  			ret = 1;
>  			goto out_unlock;
> 

	Steffen
