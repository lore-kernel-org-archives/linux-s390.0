Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7A48EBC5;
	Thu,  1 Oct 2026 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855524; cv=none; b=fJU8bmR6W5Gb6a6QQn5Gj/at55uNQAhlcreBzcb9jxxOxB33pq+JtrMfpZzCS+TYCjUnSvHojKkalduHru9E5Opepq8nK0VEdVXT4FtF3+yIsqXvQIi2j8tRSVI9QOGvAWM6ABJ0K/aloutWNxZMgvgay0AHU6fEEBKRFI0E1iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855524; c=relaxed/simple;
	bh=z78nDGdYDVWnzc+4/ea1AG8Cu9XBfrk3LDfsV2jvVe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8AY4Azw5kIggW7en2E56Xd09GfAX2FFTvVoeUSojxJYe5iXR2NVSygBCHj8jbGQ/yrD3RZM17jf6onyRIuydhodOXFcS34b4lWAlhf1M0to+RFKsIGSVRAJAxV69xRy/qduQvOEZp5b4Fqr1VwNtdYi/Iv/uJacyKM6S4Bs4lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RCoiuOjs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RCoiuOjs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175eK83446334;
	Thu, 1 Oct 2026 11:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yRfTKQrht+cYC8rwBPASXMz6cM83Gt
	C4awV0qzGv6rs=; b=RCoiuOjsmYUBMrPVs0iyHxTRURS16JBJUwAaKlsO/2ctS7
	GpNfetemMjBI7Yea4Kp8wT3vcQO6R95BS0NXHVgNE4SiVMik1eayxMfyF33OTGZH
	gxCsDW4JRY3oSBk8PDeNv2aE/Rj073miOBsB14R10HGEsS8kbtAJnvDTi+2uG2m8
	NCI7Qbj5xQwrQ7aAqN0WveuicrljKsgNsxYytvP4k8KPIB998g3NP18mQC8U3Pvz
	bqPa5wGeCGRjx7/1wzVLhUjRexxhnKur3FKOaKeVthixDEiIBVm4PPmVAB7fnmyX
	HgeyGwHAOaoAQxa2XBSb78M1Apdz9f1nSO5FD/iw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrjwsk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:51:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 691BJvkQ557925;
	Thu, 1 Oct 2026 11:51:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23rceh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:51:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691BpbtB41943484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 11:51:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 717A720043;
	Thu,  1 Oct 2026 11:51:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B63F20040;
	Thu,  1 Oct 2026 11:51:37 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Oct 2026 11:51:37 +0000 (GMT)
Date: Thu, 1 Oct 2026 13:51:35 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
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
Subject: Re: [PATCH v3 2/5] KVM: Add file back-pointer to struct kvm
Message-ID: <20261001115135.240730-A-seiden@linux.ibm.com>
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
 <20260924-vfio-v3-2-4a294307797b@linux.ibm.com>
 <yq5afqyruvsf.fsf@kernel.org>
 <yq5acxtvuryx.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5acxtvuryx.fsf@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0NiBTYWx0ZWRfX+vgSw2cslaxg
 0gSq6THOW2uyZk1RwRf0vPZvL4EsxG4Be2PFhQPdzRy08blBb4FcISvTk1kmI9tVOascJlLEUfW
 jalhv8dxwbTRggHOnuh9pGYXDoZQ2TTy4vfuW5wIWh1UH/emVlSGAxCdn0+DfutwRDkgEMjq9YG
 QpMURUY7+/vZHvM/neySA53N9ChNgSD0YLKPy1YeivXs0dE/FeqSNS/VShN0m6vSLK0jX8k1kuZ
 t9W7cdua+s07BGUSKuc7pgCQLpoFAMLm8MsqWPnxsC6JDXgcOdtckSjeegcNtklpu4LlU8jZPki
 Cl43tyffMmbABJZBufikKXixmwaQBkTtgeZgX9kIfQHKXnG2Z2r7cBwRmkBsjFtNMAyt2VH8iM3
 be5rBgAGHONqUFsKGjS01JJwyI3+944u1QuzwBR7Ok/3e5bdh+wGf3HAHX72XO/tPAQKN3xKwfl
 d17aJ/SRnSC9tMeYyoA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abe494e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=OOaDrGxNcRb0xd6qBlcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Xs30qpxtMEZonjlXN_rB9Y0jhusf66JD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0NiBTYWx0ZWRfX/RlSXALzEVZz
 lXyJd+FnGIU174/84WJ5/79cwJCP6G8wfZu2KColv0pdO8FoAaWf0mxZlhzC2acOVo3E8XMLzhh
 iGVRWke+a02xBrPanwr5pkeRW56ZzmU=
X-Proofpoint-GUID: 6ZhCgEdubetrE1VHGvYN1ul43k0Eb01W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010046

On Wed, Sep 30, 2026 at 12:49:02PM +0530, Aneesh Kumar K.V wrote:
> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
> 
> > Steffen Eiden <seiden@linux.ibm.com> writes:
> >
> >> Add kvm->file as a no-reference back-pointer to the VM file in struct
> >> kvm. The pointer is set at VM creation time and cleared under
> >> WRITE_ONCE() in kvm_vm_release() before the file is freed.
> >> Callers storing the file must take their own reference.
> >>
> >
> > I have a series that does something similar and also updates VFIO:
> >
> > https://lore.kernel.org/all/20260917140159.1163281-2-aneesh.kumar@kernel.org
> >
> > Any suggestions on how we can combine the two efforts? This series has
> > received more feedback from maintainers.
> >
> 
> I compared the full series and will rebase my work on v4 of this series.
> 
> -aneesh

It looks like that the first patch oy your series is more or less
containend in my. So rebasing seems the right approach to me.

FYI: v4 is out there: 
https://lore.kernel.org/all/20260928-vfio-v4-0-e32e226d5932@linux.ibm.com/

	Steffen

