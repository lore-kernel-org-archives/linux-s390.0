Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFA738E8A4;
	Tue,  2 Jun 2026 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392745; cv=none; b=YACxlfr8JGi8QvIKzu2//8r/zn5+HMG/Gdoj/EgSxImuGLOhxE1Ym3bg0715KYhHdEq6YxM8jRgaUkcrIR2ja0Aaug5tyOM5CUTP4rV51jZqOlir89Bk/0cUWikKHvAj34O/b4LmkzkGpPFxQOdDmjoKAp9xmZRXVOUTF8wHQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392745; c=relaxed/simple;
	bh=TIXCMYnAz3nRbCiUwoctdyQBtytJ2XAwCJkfxKTlymA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM+9WMt1JopqDjUi0B0Frdj6qaij459RQfe8iC5mHf2V6JvkhgYqbus3aogbFqPB4agqrLacwSeZhp90uEvRkd6nMgDQR17v9yY6F0D1rhtdZC5YEKirFtQ53pOgd61ia8q8oHGNhJklJXjFJHl5ygk/FbOJZ382QLloU2xg9BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l+xomWIK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l+xomWIK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6527V5c63295133;
	Tue, 2 Jun 2026 09:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WJm6ApGKzkKEwcgHKyf0jD9MBtlkYj
	Ex4H0AHzDW9eE=; b=l+xomWIK0Wq/E3Qmh5M/Qa5Hg9vz3Dby5OZC/T+ea4kynl
	gAbetBvgebQYozhB3j84HFl+y1JnIDw14XV39nhN+TQvXrdYDCFROXHwvSciRsy/
	sEMEHUdG5ha4E52FiYkjg6XUb2dYUisuut/zO/cKNLkWvjRLufioCofWY6YwJc04
	4naPjx7U2I5YP6q2v1iUPdskZBZnfV1HbQfd9AXJZQz1pUEdag0v8K5vk5lUPeuV
	BgIcV51neP/HPcS9wOMmoL5U37wf+cpf6LL3K0VDpdGrBmJhk0WmAqxrxvm6VFb5
	XGhnuTkpZZTVva4a7ni2k8KGKOvgtIyerx9RgACA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahmyt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 09:31:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6529O5pD006737;
	Tue, 2 Jun 2026 09:31:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k2j23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 09:31:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6529VXP530933318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 09:31:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2A872004B;
	Tue,  2 Jun 2026 09:31:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 863C220043;
	Tue,  2 Jun 2026 09:31:33 +0000 (GMT)
Received: from localhost (unknown [9.111.42.7])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 09:31:33 +0000 (GMT)
Date: Tue, 2 Jun 2026 11:31:33 +0200
From: Andreas Grapentin <gra@linux.ibm.com>
To: Oliver Upton <oupton@kernel.org>
Cc: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v1 10/26] KVM: arm64: Fix set_oslsr_el1 to write to
 OSLAR_EL1
Message-ID: <ah6fmaSnsM_o8NcR@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
 <20260529155601.2927240-11-seiden@linux.ibm.com>
 <ah4F7dAEA7LFz5fN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah4F7dAEA7LFz5fN@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NSBTYWx0ZWRfX181A+AGJbeaJ
 8ee4QN6Pl/iBbMATYkWypcyDwv6rUrkLP5JzfF7elSisdcNiLdyb/GH/XLGmsEIojCMBlMmZl1W
 J5f0tMDzUXrw/APH/4C+ne3LmOeaPgyRU7G9Wr/QMZW1gyo6mXjXgH308urEAZDt8Ozc+ngigPJ
 wwKCBu88QTWK3bM2kyMRCWnLNHbxsjdIiNXAiYhxOghTJ9GKhKyoj55EdC0bd5PXpRZ4VGVMrrp
 8yWeSy1L5jVDOSrPQxyUYnpiTYgEK3xbqUQSywWCN7bZz7Po0xmLBFFLaPeLP7s9H+DGf4UfNvC
 mSHoVMJTnRPUl5UGdOk2+pgPv+T7kMmUnfqYVab5j9f4BprRxQmEc8l1blBRvstLGNAW2XcAWrx
 ELKmit3Op2fgvb349mJAFb1CUe3kjfAZwLwJKq9r4nOF1dqb/0fnnVG5E+g+EVOhLMFqifarP02
 c1g4o1q97OFnAvS2ZlQ==
X-Proofpoint-ORIG-GUID: UcBU39xqv_22mUun1G5fgwQbsPs36BwG
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1ea2fd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=EMFgzdqWpYFkXg4I9EcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: UcBU39xqv_22mUun1G5fgwQbsPs36BwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020085

On Jun 01 26, Oliver Upton wrote:
> The current behavior of KVM is correct. KVM treats OSLSR_EL1 as the
> stateful representation of the OS lock and is RO from the guest POV.
> 
> We keep the UAPI straightforward by making this register RW from
> userspace, such that the VMM can directly write back the value returned
> from KVM_GET_ONE_REG.
> 
> Do you have another reason for using OSLAR_EL1 as the canonical
> representation?

Ah, thanks for pointing that out!

this change must have bled into the shared KVM code by mistake, it was
supposed to live in the s390 specific code because it deals with an s390
specific quirk. It was not intended for this change to have any impact
on the native arm64 KVM implementation.

on s390, we need to map the userspace writes of OSLSR_EL1 to OSLAR_EL1,
because OSLSR_EL1 is write-only for the facilities that are available to
us to write system registers. But that detail should be confined to an
s390-specific implementation of set_oslsr_el1.

We'll amend this for v2.

Best,
Andreas
