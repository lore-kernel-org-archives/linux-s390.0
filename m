Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2528A2E974D;
	Tue, 11 Aug 2026 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786471289; cv=none; b=hPWjsMe8+ZF/Ib3FyvKSA80vYepnklqPKxXj1HhZ2oGHHk/qDqw5za0/eAzRBKFaTp1DARspz4mgiUgqGZWKnrdO+4vwSx1oY+QC8EUskxDQojIHKV+Atw60uZTcOh53GAA4G2obtqDeDmiUqyZueWycFZo7L+9xb2zr0LV/25E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786471289; c=relaxed/simple;
	bh=wemf/ZvAzuGDy6YWvKI0TKDvuIsZ6iQMIvWCBAuxh+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWXyvhNrz+/7FZpH/7w86S0KbXre5G5E4Z6ckYWmxIktmt7lZNrrxF1itmz1GicWBGELdME8Mj67prCPxBBoWOTgyqVuXhOEJkar4Eb1BSU0aHC0De2eduzZwtUPa5DGWt7Q/MNKP20ImcVmpT1wzQ3aW3Fkm3UXBhaT86saLpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tr4IVS0W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tr4IVS0W"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVQYO3260512;
	Tue, 11 Aug 2026 18:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MdTCB5
	sh1BcIYpph/yTDQ6atCQCFBVdWvaEmsujhmnQ=; b=Tr4IVS0WOPRhRxD+29QTKC
	SU6okdNEetTTWfG9fEsTyA2ZEvdza/D+WEagckQ9keO89oaH8zZl2CvjMpZZNlm5
	ogJFgCDDdhxpA69dMoJGQLsVO8nc7OsKyz1IKf1ljPSh398wBP/CeEJBxYhU81t7
	t0IHVBVr+aeiHrT8zJ9Xkk1D4KznwpB3j13LwQJKAPO/V7dPW4WpySvhsaiHjwdU
	xwijzKWU5UZ/y6Nfj3ziV039aNK7bO4pnV4qiNWX9GYS/S21xKnBaZ6oIZtH0Oui
	4oG2M3/QZWX50Mb8O3Dm5BVwEJZVmke/fcJ+Q+u8NRzyuBiVw9Qp3kpIqYQqAXyQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyxae9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:01:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BHuEsJ016505;
	Tue, 11 Aug 2026 18:01:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjt3yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:01:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BI1IX349021222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:01:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B9AB2004B;
	Tue, 11 Aug 2026 18:01:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21E4820049;
	Tue, 11 Aug 2026 18:01:18 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 11 Aug 2026 18:01:18 +0000 (GMT)
Date: Tue, 11 Aug 2026 20:01:15 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: Re: [PATCH v1 02/11] KVM: s390: Use srcu in
 kvm_arch_vcpu_unlocked_ioctl()
Message-ID: <20260811200115.03b66ee0@p-imbrenda>
In-Reply-To: <c1816927-d455-4164-8ae1-d0ccbac5aa9a@de.ibm.com>
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
	<20260811155641.219777-3-imbrenda@linux.ibm.com>
	<c1816927-d455-4164-8ae1-d0ccbac5aa9a@de.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1MSBTYWx0ZWRfXydz77Ab9RTQV
 j7WzFK2/hLSR0/G40PgYnfT4d47kzWw7qy/QopmV27/gOd8PuyXtLQZjBI8woshgjocj8MKDmvM
 8BAkoX0z/XvqZmOUyXJF7ps+eV71uwfWD71Fp9079jsHASFmzsRzswJ/E63e7c2soSALyp4gzhz
 rMl7hILeZKWwD6uL70MhfNDfBlx8LgzE+Zqg8UHuVWlQD/ceE1LO3VZ0tXXHWBE2/zbOWrIXgkD
 8Tk8EA4vhYPjP9NOHH4eWMnluD++DKf3jB3868liJIyM8edFBH5qliDRnLzMCUW24+JgvfQ0R+F
 zEq9T7fO1UBjvOpdF+xCwhIRTqPEgjuLTQnaMd1Xvx3B2QVl9KbCtPKO3nfruoq6Qg4jD0bp3eF
 EBSFDLsHDz4pQN/Jylts2ImB9rCMSejoJa6qd0fmEQI+rUc154glVSa6sglOVvpRYyUVhEaAi/m
 6w4TArPMXj90lOlPeTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1MSBTYWx0ZWRfX0Goxw5hdqR2x
 9ktJ1az2BWyoXysEBUPH+dIU6d7+01eobL3UlzKwNjqNBhAFGgQrjF2dEZYBlohNsFu869mgPAl
 SVOmu9AKj42V6Qv4YgNdbHVeJmQPmlo=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b6376 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=9C0cF1Sc3kSFM2HxLBEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: DMHlLco21i1wiKRkhQhzeiwAMOUL6U3S
X-Proofpoint-ORIG-GUID: DMHlLco21i1wiKRkhQhzeiwAMOUL6U3S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110151

On Tue, 11 Aug 2026 19:26:42 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Am 11.08.26 um 17:56 schrieb Claudio Imbrenda:
> > kvm_arch_vcpu_unlocked_ioctl() is called without further locks held, but
> > kvm_s390_inject_vcpu(), which is called from there, needs either the
> > kvm->srcu or the slots lock.
> > 
> > Fix by taking the kvm->srcu in kvm_arch_vcpu_unlocked_ioctl().
> > 
> > Fixes: ba5c1e9b6cee ("KVM: s390: interrupt subsystem, cpu timer, waitpsw")
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >   arch/s390/kvm/kvm-s390.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 518a69c55e85..02c5428ba239 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -5444,6 +5444,8 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
> >   	void __user *argp = (void __user *)arg;
> >   	int rc;
> >   
> > +	guard(srcu)(&vcpu->kvm->srcu);
> > +  
> 
> not a bug, but just having srcu around both inject would avoid having holding srcu on the
> argument usercopy. This is not forbidden but might just take a while when paging.
> 
>   scoped_guard(srcu)(&vcpu->kvm->srcu)
>                        rc = kvm_s390_inject_vcpu(vcpu, &s390irq);
> 
> in any way, no objection to your variant and a real fix.
> 
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

I had not considered the user copy; I will definitely respin with the
scoped_guard()

> 
> 
> >   	switch (ioctl) {
> >   	case KVM_S390_IRQ: {
> >   		struct kvm_s390_irq s390irq;  
> 

