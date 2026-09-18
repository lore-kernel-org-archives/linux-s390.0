Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D880231C91;
	Fri, 18 Sep 2026 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739168; cv=none; b=T40Wocst4nijPdfvVqRtI9nR5mUd/6HzxdyJ9nG42xBSyu9e6Uw0j/f8IiRK1w5RAw4N+mxjE701/eucjtYjilc7byEGMh3TYzmao0DXRY3se68jGVqxl5nlydL/4rXJWeB2gFxZbHDvYE4/OJ7hiYPvUp5Q4QUS5fgKQTnyjsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739168; c=relaxed/simple;
	bh=7/yvXOEGZPsnRvj2oW/2xygx8Zby1GkJMEyn5hm4KN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWZMh5MGL0S48DXYHTPw2DIyjw+p3vhX9EnVk3CsV0nkyCFoFmJYJjcvJ1esmIIQ5HAsJn5jJPC/Z5vJYwwmaQEVOfQquw9T18pmtu7bqQ+YAR+S2RXyc7nJed3Qt3W2LNszYgqaruvXVQ6ViiH8NTyYwBBeL+nFEUfV671weiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IaIavFPF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IaIavFPF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVY5m1235759;
	Fri, 18 Sep 2026 13:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TGs03TXbw1l5y5oWCL3b9mZt26ZFoF
	RpJ4Hqo1ceQ1E=; b=IaIavFPFbbwV3z4cn0LqqOSqwE2KCh3hR0iZFJLJVVTBJS
	6CM107NIHDUJTdb1s2o22IKKVnf6IVEYhXg+sEI5FN97EhBI7txlTFlWl1/2SnwK
	zECzzm+qMT8phVmwboXiJ/nMMcdzXjjjp2hiD/wBDq69PIK6UW8Y6bIw8BXQoTmc
	S1kGtxGIVhPEpm63EolGc8yOFR+wMwXFpgUJn9gMe242Hg10SIbKdRC5+daiO4Sj
	zRtd16cXFW+Iobk/befD5r58C0N6sgC1c9jOtxtiCbvek7wRkfXCGNUXl/mjoQNx
	i928DWXBum9P/FiH4IWHSaBI75hwHFtRINhi+rQw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j83nx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:45:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDO5Fb777752;
	Fri, 18 Sep 2026 13:45:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yxnd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:45:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDjj7E31916656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:45:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B8C320043;
	Fri, 18 Sep 2026 13:45:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 867CF20040;
	Fri, 18 Sep 2026 13:45:44 +0000 (GMT)
Received: from osiris (unknown [9.111.4.88])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 13:45:44 +0000 (GMT)
Date: Fri, 18 Sep 2026 15:45:43 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Alex Williamson <alex@shazbot.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Halil Pasic <pasic@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2] vfio: Use file-based reference counting for KVM
Message-ID: <20260918134543.84754-B-seiden@linux.ibm.com>
References: <20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com>
 <apmsZ3j0mtZq4Lp9@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apmsZ3j0mtZq4Lp9@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE5MiBTYWx0ZWRfX2uEKFcDlt4fl
 4a6ksfohF3Oaed7ENIZK1zFT6wOG+q05tQBBO37nA3FeNVCW589EMvlEEkjymcT5NSdS9IqpvyD
 mos8ORkgXdq4oOGMrJTthJCTlv40MVyM7wGyMnMXDJqBgqjOREv5NpXr/a4UYveBBpw7xVxAuLV
 vA4LVwX+/2UciTw+SZUiYQZebEzKH/Ers11qDuv0JvoiAgoPCorwYiaBrjBnOPK+lkV+DBvYYGf
 N5KsAWxXl35cpXrirM9EJUWPVUmhy5RzQxRCcW5X08A3by5gjhd5bizKKfTHJg+UEA88fZUfr+j
 hgla+F7sxdnMImWAUG9ijmeM82iE8Ahnv/XvoBNEEm8eyyke9NyZnYUuSmLvS1Bw96a9fTw2vv3
 itM1ZqnDyx+86ruoGGgW4yvvayTbqbXZ/DuIKOM2xBsm1+fu3nxKadJFajpzRG4vFnrIipQN+zm
 UkB0lPXvqf9R8u72uvw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE5MiBTYWx0ZWRfXxIf8TTzYLoFh
 xUjQq2+BWw+B4IDDsBDOLJ9ENeapmTwuw/IQkPT896HCUkpI7EtwkDFRatpqcZTrMf3Bvj/2nM+
 yRYIQqse2cMxI3gUpn/98Tr1OvzqXCo=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aad408e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=FqYyJtKmiGreD6yfUUQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: LknL3Z2fHhttInKm5IG2dYYU--Aj0U_t
X-Proofpoint-GUID: PAWOw6IIPmRB8xRUokRpazTgK_3ysQ7E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180192

On Thu, Sep 03, 2026 at 10:20:39AM -0700, Sean Christopherson wrote:
> On Thu, Sep 03, 2026, Steffen Eiden wrote:
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 65eb26a0520d..34b4c43908b3 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -1314,7 +1314,7 @@ void kvm_get_kvm(struct kvm *kvm)
> >  {
> >  	refcount_inc(&kvm->users_count);
> >  }
> > -EXPORT_SYMBOL_GPL(kvm_get_kvm);
> > +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_kvm);
> >  
> >  /*
> >   * Make sure the vm is not during destruction, which is a safe version of
> > @@ -1324,14 +1324,14 @@ bool kvm_get_kvm_safe(struct kvm *kvm)
> >  {
> >  	return refcount_inc_not_zero(&kvm->users_count);
> >  }
> > -EXPORT_SYMBOL_GPL(kvm_get_kvm_safe);
> > +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_kvm_safe);
> >  
> >  void kvm_put_kvm(struct kvm *kvm)
> >  {
> >  	if (refcount_dec_and_test(&kvm->users_count))
> >  		kvm_destroy_vm(kvm);
> >  }
> > -EXPORT_SYMBOL_GPL(kvm_put_kvm);
> > +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_put_kvm);
> 
> Please isolate the export changes.  They don't *need* to happen at the same time
> as the VFIO changes, i.e. can be done on top.
> 
> >  /*
> >   * Used to put a reference that was taken on behalf of an object associated
> > @@ -1352,6 +1352,8 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
> >  
> >  	kvm_irqfd_release(kvm);
> >  
> > +	WRITE_ONCE(kvm->file, NULL);
> 
> Please move tracking the file in "struct kvm" to its own patch as well.
> 
> > +
> >  	kvm_put_kvm(kvm);
> >  	return 0;
> >  }
> > @@ -5496,6 +5498,15 @@ bool file_is_kvm(struct file *file)
> >  }
> >  EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
> >  
> > +struct kvm *file_to_kvm(struct file *file)
> > +{
> > +	if (!file_is_kvm(file))
> 
> file_is_kvm() should exist at the end of this series.  The only reason to ever
> use file_is_kvm() is in advance of getting at "struct kvm", i.e. this should be
> open coded in file_to_kvm().  Though as I suggested in the other subtread, it
> woudl be kvm_file_to_kvm_fn(), i.e. kvm_file_to_kvm_x86() or kvm_file_to_kvm_s390().
> 
> And those changes can and should be done as prep work, i.e. in separate patches,
> e.g. to end up with something like:
> 
>   1. Add kvm_file_to_kvm_fn() and use it on x86, i.e. replace the use of
>      file_is_kvm() in arch/x86/kvm/svm/sev.c.
>   2. Add kvm->file tracking.
>   3. Switch VFIO to tracking the file.
>   4. s/EXPORT_SYMBOL_GPL/EXPORT_SYMBOL_FOR_KVM_INTERNAL on the get/put APIs.
>   5. Enable kvm_file_to_kvm_fn() on s390 and use kvm_file_to_kvm_s390() in the
>      relevant code to prepare for s390+arm64.


I sent the changes incorporated in the main series[1] in 5 patches:

KVM: Introduce file_to_kvm_<arch>() infrastructure 	- adds the macros
KVM: Add file back-pointer to struct kvm		- adds the file field
KVM: x86: Use file_to_kvm_x86() in SEV
KVM/vfio: Use file-based reference counting for KVM	- the swotch in one go
KVM: Restrict kvm_get_kvm/kvm_put_kvm export to internal KVM modules

I needed to do the switch in one go (i.e. merge 5->3) otherwhise there would be conflicts.

Note, that in addition, I moved the symbol verification makefilestuff to
a shared loaction and reused it for s390 in separate patches in the
series.

	Steffen

[1] https://lore.kernel.org/all/20260918133107.1042730-1-seiden@linux.ibm.com
