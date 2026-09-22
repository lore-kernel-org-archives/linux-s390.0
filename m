Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD26418A33;
	Tue, 22 Sep 2026 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064057; cv=none; b=QOrgsCVoi3XU9Ygj8MWhvfvsJD8wRBb0c2jvMSQ9abnp2AWqH2EvHD3kkkLot6lX1zCWfrNxXMaKSJ+LUVfoZPoxBTDmFAZzWueZHW3oNW80hYnkkLQyKtODqvBFJ2wKWaUt9WXjCn0APEfxGmh2k8llQjlRwgx+fl744lJ8ZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064057; c=relaxed/simple;
	bh=KjXRAKBgA8kr840ceo2LLAxRSSi3+MTJxaR9wGSm1cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cggYE0nKU2yb98R7AoYm9Exd7o5B1C9QfCoeLvQWMa9x/UhwFaWDxDTp0Vy/aZvY/Yn2rXS6yT+eA5zk4Bp/ASGyFstZFmZ7hO2OhqfdA8EmfDQE+DOQxrPo3PSUMk4dr9ZEEIiyUvzoJd+RHJSA6LUVRMwLkw4QtRLW5S6W9aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ukvu0I1+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ukvu0I1+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05PHT2948356;
	Tue, 22 Sep 2026 08:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=K41nxNHDZw9WuqUB9kOBGLojLVfZ1z
	UsuTyHMCvuj0Q=; b=Ukvu0I1+4IpPCQ1IIWZcPbdM3hjJSGwEYPdjWOQKHbuMul
	AAp1/n7hr9N6f37CwRHa5UexxICbKz458q5rLTbKNR7szwnPKOJpwdgydzbcthO4
	u5pdr+jNe58Buf4ASH7VdLY2hs7GsiKn66BhuAleaQKJgVpOkYWEeB00OgEscsBW
	K9YNC8LVzwz+ScURXVrilx/vWnIxiWLZd9cKXff+zggXtsgOq4JXjJwGp4iEA0vI
	xul+Jqj8nZ8TQ7W9NbhJUIOzxn2KaDYjQZVC7BhZZlFMqaX3DCQn5qfKqriT0SdU
	r6iJFwSDwK/GxQyjpZ9VO0IFTMbYEhhKyo5w059Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs4mar-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 08:00:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M5Xnd82025383;
	Tue, 22 Sep 2026 08:00:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vh0dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 08:00:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M80Iqn43581786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 08:00:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD3A82004B;
	Tue, 22 Sep 2026 08:00:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8944120040;
	Tue, 22 Sep 2026 08:00:18 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Sep 2026 08:00:18 +0000 (GMT)
Date: Tue, 22 Sep 2026 10:01:55 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        x86@kernel.org, Alex Williamson <alex@shazbot.org>,
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
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] vfio: Use file-based reference counting for KVM
Message-ID: <20260922080155.316969-A-seiden@linux.ibm.com>
References: <20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com>
 <apmsZ3j0mtZq4Lp9@google.com>
 <20260918134543.84754-B-seiden@linux.ibm.com>
 <20260918153811.GE11599@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918153811.GE11599@ziepe.ca>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab23598 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=zNZwmuGfLEkv831Cx38A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: wkStHpHJPnFxFDq3vGQdjHpelJ3jvpIT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEwOCBTYWx0ZWRfX+LXjD/rTXbF4
 3dtr+aXQFhUYsWIxHAqR0yNPszLm6pWiC2h/OPT335CL2Yjq8SSMnJTRubITE8pH4QmViAP1hm2
 ahfpzT/9PS3tBvQUmEDCWNDh0Zd9c/IAQqKMVuWkGedfhZ9PqOQxA+eVmTCkhKEGOkJ6OMiGKgz
 IEvq0ojVzF1ipqgHsB6Oxvrvl8MtozX9qP1NqVU5ZyyhwuEaaAAk6PzECYqnsj1JcLUtXfiKi+o
 RH4Gam48cJj4lQjtADYE+9xafhsedWL15DozXrQ5crvtDINGh0LTQMAb0XuLvDiTegLCQkND4CS
 exaTSFszX5a8Dp41W0eVl2DEBaqWT9uaM1aTwIegPL6530aewd0fD34HtLi1F+VkPZn+DBBbd0f
 oWQk8ZFfFA5Uh6Tb40KQg+jiRX1pikyCYVS6rr+xy/SycFm//zaEuHkpc/JK1ydqW40W6/cLwev
 itSW9deSvJqINcbG9VA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEwOCBTYWx0ZWRfXyu66dnDBWEXz
 ZitOd8Rl5tTEyQ7lQVFqC0ZGVtiAwu1+xBkP86OcZjnnQotpxspm+d/orUIBMXZzCZQbhCIqfdB
 ve21yvr0woxFjb/v9xf6O8EP0jNwjwc=
X-Proofpoint-GUID: GR8sdXhledxhSurGln-LEM4Uj_4aCpjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220108

On Fri, Sep 18, 2026 at 12:38:11PM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 18, 2026 at 03:45:43PM +0200, Steffen Eiden wrote:
> > I sent the changes incorporated in the main series[1] in 5 patches:
> > 
> > KVM: Introduce file_to_kvm_<arch>() infrastructure 	- adds the macros
> > KVM: Add file back-pointer to struct kvm		- adds the file field
> > KVM: x86: Use file_to_kvm_x86() in SEV
> > KVM/vfio: Use file-based reference counting for KVM	- the swotch in one go
> > KVM: Restrict kvm_get_kvm/kvm_put_kvm export to internal KVM modules
> > 
> > I needed to do the switch in one go (i.e. merge 5->3) otherwhise
> > there would be conflicts.
> 
> It seems to me many people want this vfio conversion, can it try to go
> this cycle? IDK if it can meet that linked to the s390 stuff?
> 
> Jason

yes, I will send a v3 later this week to this spin-off. Sory for not
making this clear in the original message.

I  wanted to get some review input (from Sashiko) with the patches in
the main series before sending another round here potentially triggering
the same report twice.

	Steffen
