Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666F23939CE;
	Fri, 25 Sep 2026 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328787; cv=none; b=nzKWjSmvqAwqMVCFHpM5Ja07YfE/gOjcejO6QYx/6GoaBEWzoBaVIqi5qTBracyONPI5xUmSzdfagyvyxg2dgaC7Wu6HG1K3ym3ta9HCeMGN3RdenllSBXvQ6fla4Q+UCu14CwILDRil9fVw5ld63hjDgngrWvmheuh3+ixYapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328787; c=relaxed/simple;
	bh=GvIIjNTIeccQXy3YNiaMU3xPYJxA4Mg1L0Vw/p2MX5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyqAKNvkpdPe6jHyb51Itx+8K2M4bQ/XKH5SnYOD9TZbU4fmTTV8LfBP0n6f1tzwvhlSzJm2aoybbpKP3GjLF0tZ+08fJKybrtoTueq2StR3UL7a3CqwUtQ6+9blqZubUStYE1DpSGgwDx67lnkEHeNvs9P0k6haEoruHGKuJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IbWsOFFr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IbWsOFFr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aOOh3083955;
	Fri, 25 Sep 2026 09:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+klEmu2O4UmRPdhpaMJUEI+VgaQI93
	BZLPpXP+wUiIE=; b=IbWsOFFrezpYzaMpgiVHBqKP6Yk6lcHY4+J3AdTCm/XYi0
	raDW98rmUjUZovpEHhoasFj3KgUSML6uQNgR83Kat1iw9gE0mLhzQCmSQHV1vo2D
	upU4ih6p3omktl7pnH2s0t0yiGn2P0+SHRm9VYSS32z9ZOwNI2YPfXQybg5aAm58
	llAe0Hkn/KXQ2LSKH5inRYJs+7ykkQMJ0WlRcfj5ILTtU0lXSAbK0e+LoxjN/3bF
	A6oLsgQO3ACXTx/iPZXJGgyBYuFTjn9tQqYQ0oxtdJ1WkgY9Lgu5y9Yl/GAxR+Kl
	fX5GDaFv+Vszql6yzBPcY1btre4Dc8Z8lJ1PwMkA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqw94u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 09:32:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lXjL3297003;
	Fri, 25 Sep 2026 09:32:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qsver-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 09:32:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P9Wdn417105268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 09:32:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CCAF20040;
	Fri, 25 Sep 2026 09:32:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59C3F20043;
	Fri, 25 Sep 2026 09:32:38 +0000 (GMT)
Received: from osiris (unknown [9.111.51.210])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Sep 2026 09:32:38 +0000 (GMT)
Date: Fri, 25 Sep 2026 11:32:37 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] KVM: x86: Use file_to_kvm_x86() in SEV
Message-ID: <20260925093237.47449-A-seiden@linux.ibm.com>
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
 <20260924-vfio-v3-3-4a294307797b@linux.ibm.com>
 <d8effe42-e212-4085-a302-250c60b2b5eb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8effe42-e212-4085-a302-250c60b2b5eb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab63fbc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=pG-L929pbL6aBdLXlOQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX1Kfrk+pKo458
 xOcAlBLV+mZ7VJn2an22QlljYHo8VZqfzfNR/8o0bPAKKni3JYRLc+JHJPGFtu83ayQfNJqL/+0
 tiQx6jfig46XPblFLMIm8+W2QBlXl9PNZa5l0uC4GpkCRaWL9Nci4OeidCWllyyUrNngzHUlpI4
 00AphRnwRWixrV4xPMcuFuf8gk2KaxYW+0xQ3dR/m+IrPtHcIw1GnbJBwAyGbk1CYkfXYuuv52c
 /RFi9DODh3EAGN2pgVB9RU75aKnU2qAhMX+0KoftbJiAhB0nYQnIlWxhXgYMqDC5iFBwx7QSyI4
 95Pu09KeuX/PUWsl80Dq159z/e8W0XFOpmqtlErQZxZAaUW9gTA/iN9iK9x6tRp7BAqqaawjNpQ
 SWNelzKlgBikQY3uQYjSSyOsBEF9EVI8ta291d+BZRn6wKgw7zrPeE5G1gIsG/kTYL6qag2Vhxc
 eOUV/lbGkH4TZAgm4lA==
X-Proofpoint-ORIG-GUID: MUBvbesm9W_mLrYEI1uTw7191Tis-wRx
X-Proofpoint-GUID: cJXuXxS3B20vFfxEIhTf7OmQALimnIzy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX+UmbfPJyOq3I
 QqGIwGVsGeVaFMcpxR97sGXmCl3mKJq+njreZ29VOs5QDrfzZ489N0YXb4BFix9H303HgiHc7Op
 IVBGMMHzqZI1kC5cQg/zVHvqa28H51M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250036

On Fri, Sep 25, 2026 at 10:35:55AM +0200, Christian Borntraeger wrote:
> 
> 
> Am 24.09.26 um 10:58 schrieb Steffen Eiden:
> > Use the new arch-namespaced helper  instead of open-coding the file
>                                     ^ double space> check and private_data cast separately.
> > 
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >   arch/x86/kvm/svm/sev.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 5705723f1f41..6b0eacde4f06 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -2145,10 +2145,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
> >   	if (fd_empty(f))
> >   		return -EBADF;
> > -	if (!file_is_kvm(fd_file(f)))
> > +	source_kvm = file_to_kvm_x86(fd_file(f));
> > +	if (!source_kvm)
> >   		return -EBADF;
> > -	source_kvm = fd_file(f)->private_data;
> >   	ret = sev_lock_two_vms(kvm, source_kvm);
> >   	if (ret)
> >   		return ret;
> > @@ -2866,10 +2866,10 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
> >   	if (fd_empty(f))
> >   		return -EBADF;
> > -	if (!file_is_kvm(fd_file(f)))
> > +	source_kvm = file_to_kvm_x86(fd_file(f));
> > +	if (!source_kvm)
> >   		return -EBADF;
> > -	source_kvm = fd_file(f)->private_data;
> >   	ret = sev_lock_two_vms(kvm, source_kvm);
> >   	if (ret)
> >   		return ret;
> > 
> 
> There are no remaining callers of file_is_kvm(), correct?
> 
> We could remove the declaration in include/linux/kvm_host.h and the
> definition plus EXPORT_SYMBOL_FOR_KVM_INTERNAL in virt/kvm/kvm_main.c
> here or in an add-on patch if we want.
> 
>
Make sense. I'll add a patch for that.

	Steffen
