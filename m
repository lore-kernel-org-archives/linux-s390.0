Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956343385B2;
	Wed, 20 May 2026 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294020; cv=none; b=BCMMPaxN/uhRPxKr5nbxknHYZMH0URS+wlyZ+OAgewZjLR+KIHlAZRIgeUz6qYs7WTTKjCS9qSx3jDta+5efX3Kme4PQmAC2ie+slY+wIKIaonmqFFGEU0HFZd7GgozmTqYdLJDob5DfPh4ZswCT+vHWzTUOBRg6sY0M0t++pOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294020; c=relaxed/simple;
	bh=bvpQZxLlvESVgRx5DsRdBcGxpbxx7htU+Nbqdlz9Qqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJ7oEPuztQaqxRxyi5xuur3xJ7J6K4qwg3sXRyHEjbTWl1QdGeJ/S7Sk8CzvGLb9DcVZlQYumpnlBZqNxm+f4BIltnIfBVq9gzz8Qq7WzW+q5gCUPoYmIAvHQxT7rzyBLfzBUNJiGCMlc5GBsbAWvHKyRkvoYDcSziyW9mA+Ulg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k2l8lV2v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k2l8lV2v"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K6mYp91522114;
	Wed, 20 May 2026 16:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OjNWer
	M7KdyccfB86OenGSDqiENrepQBwwkiOuCBlFk=; b=k2l8lV2vurvYcy2jZkOt/i
	FrSbab16fGVhFtOkpwKx8QfG6TRMiUbwFuulH6ApAN+GdIEd2oQhaPnB9owmIDvv
	75q/rU0EKtxcmDHBn0oP9kiJ0w3Rhd+dDCxdYM3qVgFOZnjYaQP5qBNNsJXuIrJn
	8XqBS7gkzSw1ArHibpCVn3On9QpV7tSmmA5DRjj2h+ojBzaCKoBFmC/gSkzkyUA+
	q4pjUZ0EBxLrXUemornBL+kREqqHV3olpuC7iTyPCEnI4RoCvhF2JwR9Ywy9g07U
	OO6+k3A+kjg/AHZoNvia2C76CK4q6/6fsFIfck6jI/Z3Uw2auNQpsbYuFnXQumXA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y31ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 16:20:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFsE2g015474;
	Wed, 20 May 2026 16:20:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk84p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 16:20:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KGK6Tc60490170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 16:20:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E79082004B;
	Wed, 20 May 2026 16:20:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A43DE20049;
	Wed, 20 May 2026 16:20:05 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 20 May 2026 16:20:05 +0000 (GMT)
Date: Wed, 20 May 2026 18:20:03 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, yan.y.zhao@intel.com, isaku.yamahata@intel.com
Subject: Re: [PATCH v1 3/4] KVM: selftests: Fix pre_fault_memory_test to run
 on s390
Message-ID: <20260520182003.7b170445@p-imbrenda>
In-Reply-To: <ag3S3MjXHW4AeW_6@google.com>
References: <20260520151710.231788-1-imbrenda@linux.ibm.com>
	<20260520151710.231788-4-imbrenda@linux.ibm.com>
	<ag3S3MjXHW4AeW_6@google.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfX0+w+yKPcFFR+
 RFtDLen9F7QLJSDtM3gOx1+q/zasx1WkdD9HTe0TVmiWkR9u9ouSJapq8FnDgG5n/mIkNYWRPrE
 JT2jKL3N6VJkAy5Ts5hOJg/L9PH+uWJQXBv+mvA6kirQMr1gMjscFeGk2DfLLmXnTo4AX6Q2Wnz
 MzX3FhJj48memqcgCcpSO4v/9LlTgUuJnubzbbm06cLVquuX3+57MgycIfcg5NaPvTVxGBUGq/t
 vvccozSL/nnorlv16+SbUVg5xirI4M9aUdhwMVV16/3zGADru3D9OXwUrIvh1i08z83fjTZY938
 fZE3pMQz+nTmrN64rQtI2KX2DUbcVtfjdnxvuWivUf3UvqyUgriGS9CckQVtvO1bKd1hk9tEN46
 pLIgbniMbI6pDD28PelSRVazhSk4V+JsDDMcyDDxEdh7ZxQlsD7Xrg7IHe4C+s/hf7YnyqxMRvc
 5Wh2zBLBS7pwzzhR0fg==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0ddf3d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=6aIEw9uYXiUzMIZbHnsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Jgxl_FsFFR2lJ2ZbPil12KZWlBeVWtEd
X-Proofpoint-GUID: aNj4-9CiqoVIF8cQmFqHHXZgMnSI678Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200156

On Wed, 20 May 2026 08:27:24 -0700
Sean Christopherson <seanjc@google.com> wrote:

> On Wed, May 20, 2026, Claudio Imbrenda wrote:
> > Add a missing #include <ucall_common.h> which is needed and otherwise
> > not included on s390.
> > 
> > Fence the assertion  vcpu->run->exit_reason == KVM_EXIT_IO  so that it
> > is only checked on x86. On s390 the UCALL will return with a different
> > code.
> > 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >  tools/testing/selftests/kvm/pre_fault_memory_test.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
> > index fcb57fd034e6..42794892e902 100644
> > --- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
> > +++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
> > @@ -11,6 +11,7 @@
> >  #include <kvm_util.h>
> >  #include <processor.h>
> >  #include <pthread.h>
> > +#include <ucall_common.h>
> >  
> >  /* Arbitrarily chosen values */
> >  #define TEST_SIZE		(SZ_2M + PAGE_SIZE)
> > @@ -167,7 +168,6 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
> >  		.type = vm_type,
> >  	};
> >  	struct kvm_vcpu *vcpu;
> > -	struct kvm_run *run;
> >  	struct kvm_vm *vm;
> >  	struct ucall uc;
> >  
> > @@ -193,10 +193,11 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
> >  	vcpu_args_set(vcpu, 1, gva);
> >  	vcpu_run(vcpu);
> >  
> > -	run = vcpu->run;
> > -	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
> > +#ifdef __x86_64__  
> 
> I'd say just delete this assertion entirely.  It's an extra layer of paranoia to
> guard against stale ucall data, but x86's ucall_arch_get_ucall() already has
> sufficient guards.

will do, thanks!

> 
> > +	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_IO,
> >  		    "Wanted KVM_EXIT_IO, got exit reason: %u (%s)",
> >  		    run->exit_reason, exit_reason_str(run->exit_reason));
> > +#endif
> >  
> >  	switch (get_ucall(vcpu, &uc)) {
> >  	case UCALL_ABORT:
> > -- 
> > 2.54.0
> >   

