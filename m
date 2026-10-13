Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA511254AFF;
	Tue, 13 Oct 2026 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877857; cv=none; b=jHAn0cMWCjbLklL2ulM3KM+tDz/t1OoP9QtLM9VHxvRwvfJ0Hrjy3+k32Tzpmq7LEnSdZIgqFIjJ+D3uVlUyTp+yOknL6f3cCn6E+e2VOJyOTqPngt0x0KQV9XVdA0buyLHD81yaHf1s3k8p6myyIkSmUI/QBiA19J5e/jkrZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877857; c=relaxed/simple;
	bh=24/ZlOx+ZPKk/LHYC6cnoVGf2pxPAraBxhNLYYoSrqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXa9qGJlbRZPe909PJE4GcRJGD1+lFGA+tFQ+QdMU3BnYeUhGZRwxROPeIrWKvpcWIKgjnE3/BLisUaLU1ITEsczSqdUwoxIZim+jgzMbu6h3NXfaz+62Z8csBhy5a7XXAMUoKErntyD5dN/z37aYN41A6uRlTJb3Q6IypwkRZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MTJD1DH3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MTJD1DH3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2F4BD1933761;
	Tue, 13 Oct 2026 07:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Sjs5mgAwZ0u2tQzKKe+zpfzq8m52Sd
	rPDCcsqsEdmIg=; b=MTJD1DH3K509Y3CM40iggEGEh1FNGlOnHsHyS6xobIkPUB
	iWwogBwHl7a6rhTh4GGI1qsr7OdvVL+9SGl38P8RX6vTcPLSrGTajuxn4meC/jI7
	NqRS7BWskBB2BnN40kEHpoo924Ni9lJbq8+2vmWR/GtzgyDRGgkrbSprGP5QavNc
	K0YXAA0WKwRt3fp2u9tccOlvzqgOfVVDj3oGNUUH95qgEhS1iYnnOg3NMmyuUyZF
	z3xziv1e+hNrinpTP2b8bMqaMW8ZJXal2z9Fx5Uff7J2W1/btu+XjXA/rCbFY/9t
	2LBhpmYPYD8dmQJo8JescP2vRDCGbzY5REbo7oDQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w4cpe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 07:50:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69D7UVgH2297907;
	Tue, 13 Oct 2026 07:50:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cygfvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 07:50:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69D7oJ1A43123064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 07:50:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BABC2004D;
	Tue, 13 Oct 2026 07:50:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FAB420040;
	Tue, 13 Oct 2026 07:50:18 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Oct 2026 07:50:18 +0000 (GMT)
Date: Tue, 13 Oct 2026 09:50:17 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v9 02/24] KVM: Move architecture capability Kconfigs to
 header defines
Message-ID: <20261013075017.696560-A-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <20260930173441.66762-3-seiden@linux.ibm.com>
 <26b2c514-de23-4c70-81c8-875f8e8c094a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b2c514-de23-4c70-81c8-875f8e8c094a@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzMCBTYWx0ZWRfXyw5R7W3K3BrL
 LZS0Mygj1AmZeZcOQIxEbDCCTSV4YFnb+GKWecnNfkUmq8HHze6IZ3FC6JyEWjkgK/9ULemrzr4
 h1p8WEQGtHlHPTaqpAYsPkasUz9/rdU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzMCBTYWx0ZWRfX+r51WcVgennW
 1W5+Csfo13ax9IUXhhZDpqG3+qQTSbWxgs0E+z1KGhGCAwQl8QpaQjD5akVGj2QHYo5w9hgan+z
 0AKFKcE0yUv12a9dBfnmFMDshMhB38S3L8wWxivkvit2xvOmXqopiNZ/M5OsfZ12Rfn2cvF9Rik
 blDH9L6pdeQeE+k2gV7uSDaz8J7L5Qs/z/nJ+mp2K8eKDgfljuw0IO3PSWx/8vna76dJvxvl0kl
 5m7vjOtfXAI32BhTBhXxYHd0f6CV4L3oM/GK2Uvl9fU/tze9zgu8RRLxlkDYynI/ItlY92oKjml
 4L41SFPnBUqqgsnztOzmbL3BGTJKSS14uwZcj9W2gteqQ4DH5XmPc/ARTQxQGvAMNHpSlxtgUTY
 em45iQ68HXwQKpZB4m/Dusx6odXwsGkVwvBYBZd9fRRVtncyNDwSe7CO2f4UOovxo7YgouQaRHV
 YhAGaYl09ZrmTulXl5w==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acde2c1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=LolK8cCbLh9hbZZaMMsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: kRfiUjtPbLtTGxyBHkSxxPdk_XR8hKaj
X-Proofpoint-GUID: 8usMhobHWWRXOQdsRqavwz8LGCbzNUF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130030

On Mon, Oct 12, 2026 at 07:53:43PM +0200, Paolo Bonzini wrote:
> On 9/30/26 19:34, Steffen Eiden wrote:
> > Historically, KVM feature opt-ins and callbacks were configured globally
> > via Kconfig symbols (CONFIG_HAVE_KVM_* and CONFIG_KVM_*).
> 
> Not all of them - there are many __KVM_HAVE_* symbols already.  In
> particular now there's both KVM_MSI and __KVM_HAVE_MSI/__KVM_HAVE_MSIX (but
> the latter is dead, so I have sent a patch to remove it).
> 
> There are several remaining CONFIG_HAVE_KVM_ARCH_* Kconfig symbols as well.
> That's okay, but it should be noted in the changelog that not all symbols
> were fixed.
> 
> Can you at least quickly provide a v2, that changes all symbols to
> __KVM_HAVE_<function-name> (and when not applicable __KVM_*, for example
> __KVM_HAVE_READONLY_MEM)?  I have already changed KVM_NO_MMIO to
> __KVM_NO_MMIO in kvm/queue.
>

Yes, no problem.

Using this pattern would reintroduce __KVM_HAVE_MSI then, right?
I would create those symbols:

  - __KVM_HAVE_INVALID_WAKEUPS 		(formerly KVM_INVALID_WAKEUPS)
  - __KVM_HAVE_MSI			(formerly HAVE_KVM_MSI)
  - __KVM_HAVE_NO_POLL			(formerly HAVE_KVM_NO_POLL)
  - __KVM_HAVE_READONLY_MEM		(formerly HAVE_KVM_READONLY_MEM)
  - __KVM_HAVE_VCPU_RUN_PID_CHANGE	(formerly HAVE_KVM_VCPU_RUN_PID_CHANGE)

OK?

	Steffen
> Thanks,
> 
> Paolo
> 
> > Replace these global Kconfig options with architecture-specific opt-in
> > defines in <asm/kvm_host.h> and standardize their naming by dropping the
> > HAVE_ prefix:
> >    - KVM_INVALID_WAKEUPS
> >    - KVM_MSI			(formerly HAVE_KVM_MSI)
> >    - KVM_NO_POLL			(formerly HAVE_KVM_NO_POLL)
> >    - KVM_READONLY_MEM		(formerly HAVE_KVM_READONLY_MEM)
> >    - KVM_VCPU_RUN_PID_CHANGE	(formerly HAVE_KVM_VCPU_RUN_PID_CHANGE)
> > 
> > This allows each architecture and guest implementation to configure its
> > supported capabilities independently in its kvm_host header and eliminates
> > unnecessary fallback stubs across different KVM targets.
> > 
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

