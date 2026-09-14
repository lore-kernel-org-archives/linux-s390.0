Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74435C6B0;
	Mon, 14 Sep 2026 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411205; cv=none; b=IxeFxUif34/PbxzknpgCRyHB0UHxQBhyJQeu+6gXP4YJzpDy10vKo0qnOxeLsvF3yHNweh6TX9M8X5ZbzsvOhdZYdQ7D/eQVMSsgfQ3AE8MYa8KnV1DsMJ1cm58XuGV2UeBvVUanNAwkb4bzo+Xc5Jt5NcTvB/eWOj1tYhpSxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411205; c=relaxed/simple;
	bh=imwupTGtHvI+dKa/5+UpB083oKRxvJ3TOHk02nBolG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIVHXZvvVuSbq9GzLuHb1EMB/GpPJn+HmSdAJpZbO4+Un8XNtgcydUPQIRzqGL8ts5yVPfhhjNUX8Cr045jZieBwJ3R+udZTyvsNfNu8iz8ICwqxhP3tBL1KBL0BioB9JbpRAypGFcRVlJUgla9duXEiR8vOqa1Kfe5DV5q58Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rpm69m0g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rpm69m0g"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EFvkw72345157;
	Mon, 14 Sep 2026 18:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G/1lSD
	1AYh/vxHwjVYseqESHwU3wmnYWVJvr7m2J8M0=; b=Rpm69m0gzOCaUjLcBjemyJ
	prOaWGZ/G5bNtF3CFd1OroBwSVHQl9zxOz1pDdcNAzkrVc03VT67CMnsIe+YMhf+
	oPo74LB1WDrB1RV/SWqdvLsvyIUVhBwpWuXcnplyjXP5hvwNgzeYVQWgnlCGCiXE
	wUXtmfgs8Il7QYmwOFAvwJqV8y6DPE6G1oUl0o5nNYcFvNmSrg7yQpQbnMA5+wBN
	/5QV1Hrw81mvhYbNiERT/2KzthyvDFswyWo7rmOReiPTEuIgB6m05P8QzUgG2Hew
	6bJx8iPEbhzto2iNLMBSGPouxq9f2hiIFckE4r5o0BDMHfo5QOdSKCGm9pczG4lg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hke7m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 18:39:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68EGVNWG2359957;
	Mon, 14 Sep 2026 18:39:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnh2pysnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 18:39:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EIdmBP43254016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 18:39:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31F732004B;
	Mon, 14 Sep 2026 18:39:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B750C20040;
	Mon, 14 Sep 2026 18:39:47 +0000 (GMT)
Received: from [9.111.61.130] (unknown [9.111.61.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 18:39:47 +0000 (GMT)
Message-ID: <76c43631-5f87-48c2-bf36-5c323e35c9dd@linux.ibm.com>
Date: Mon, 14 Sep 2026 20:39:46 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] KVM: Serialize vCPU creation and revert vcpu_ids
 tracking
To: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Christophe Guillain <jean-christophe@guillain.net>,
        =?UTF-8?Q?Pawe=C5=82_S?= <spawel523@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
References: <20260914181223.289061-1-seanjc@google.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260914181223.289061-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI2MyBTYWx0ZWRfXwWHtlOyaJjv9
 p5nBdYbJg510ylSCZfuRh4Z7Hi4pvnIYgWAFV36i4TYzdumKQhrubw6Owj/rT2Fmc8ugOA3a7EN
 uzCVxorIDBqxiK8aNAfFOu1rCp2kNTEGQbVUeL7Yfo9bdL/ryLGdFDoIJJSVMkkgOt0jdtZ6kLO
 AUaYqvp0Hd5yfXl5lC5n88xCHs2UO8CS+9z57AnQDruf0QlUbXgLakx4vDZ1Uzvb0E8pORdXdaT
 x3lThrCUYwA8z97vOrTfQjgJxINofREt2MzmjybND2YZj9f7RBmm4ubh/V7jq/x+PHI+B2O4Upp
 dT+YoW1Li/ff3CEAKJFXvfT3QVYxp8EYqB4nUoiIyirpy/zvjUXhBWllpFc0cFn1u+h0yEVx5Ei
 1sHV1cxPXv0w1iu4t5baSeofMnwO55zKbwckBBki9s2X0eNPIGmGEgzHLq29WGuA4C/CGwGCJf7
 axsx5BXtA1OFv5XcaoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI2MyBTYWx0ZWRfX2DNsk+KlLhEV
 aY6RMTpXBdix3y8SgM/Q/0gE8phE6lW2pKHcFPriosKaoMSEnO6zX2Z7UDEB/7zFmkiCwWk8e6R
 Axd8AZGVBakOt0CBTo30CiMHDkAQ+lg=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aa83f79 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VdaaZELl3TLQH4z4TgIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2h3DLmQTaA0VehyNmnRrfsZ2RnEYwHGs
X-Proofpoint-GUID: sc5rWeNwQ9nh9YSYmQntx-0ZZs1c8o0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140263

Am 14.09.26 um 20:12 schrieb Sean Christopherson:
> Serialize vCPU creation by holding kvm->lock for the entirety of
> kvm_vm_ioctl_create_vcpu(), and then revert the now-redundant tracking adding
> by commit 97d65b544f48 ("KVM: Check for duplicate vcpu_id as early as
> possible").  I botched the math when justifying the vcpu_ids tracking; it's not
> an extra 256 bytes, it's an extra 2048 bytes.  Roughly doubling the size of
> "struct kvm" tripped x86's KVM_SANITY_CHECK_VM_STRUCT_SIZE, and obviously isn't
> something we want to do in general.
> 
> The TL;DR of why it's a-ok to serialize vCPU creation is that no VMM actually
> does parallel vCPU creation.  As with so many things, KVM's current behavior is
> the result of decades-old cruft, not intentional, deliberate design.
> 
> Patch 1 is a tangentially related bug fix; I included it here because holding
> kvm->lock for all of vCPU creation allows WARNing if KVM attempts to lock all
> vCPUs if vCPU creation is in-progress (the caller is must hold kvm->lock).
> 
> Sean Christopherson (5):
>    KVM: Reject attempts to lock all vCPUs if vCPU creation is in-progress
>    KVM: Protect all of kvm_vm_ioctl_create_vcpu() with kvm->lock


Interesting, that would allow to simplify several aspects in s390 kvm code as well. We might
also be able to move most things from postcreate into create.

Before that, the series as is needs some s390 fixups.
s390 takes the kvm->lock in
- kvm_s390_vcpu_setup() locks kvm->lock around kvm_s390_pv_create_cpu() at arch/s390/kvm/s390/s390.c:3760 (added with 29b40f105ec8)
- kvm_arch_vcpu_postcreate() locks kvm->lock around the epoch copy at arch/s390/kvm/s390/s390.c:3582. That dates back to the TOD attribute commit 72f250206f0f.
as far as I can tell.
