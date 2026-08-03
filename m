Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBDA40BCA7;
	Mon,  3 Aug 2026 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769410; cv=none; b=scsoRoV7UWhlK1fOfhNLWWbRDBrvTzfPDp8gyGGqrjFOMaf5Kap84nh2wUU8I4xGGgjcubsWPQDthBfAxaMJOpD0OJ8iAaGL/ZdYyxGhLDm/vRS+A//U3bJ6N73n9/3AzSCTE2h/tOtTq5s6wet/po5Cdgv/fRw0S+nk7mrFq1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769410; c=relaxed/simple;
	bh=PvkVr1SgPJ14lvpOe68PBhfEwunl/Wvt2IYZZN6Wk6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5g/TNJ8OuCTXHVTnmXp/LRy8VgQgIBdHawKiOGqSV0edl69cxTSsyCxqX7+VU+hqB2NzBOq0EDflqK7l8Aa1v/GrvWx65E/m4rlbETVWWcCPYSJgZ43EXlcE6Qu0dtLy4hiBDB0dkH/QX8HJzjP/1z8ZYiUqiP/zCj+I+qV1DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nj3QCB0a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nj3QCB0a"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHxhd2341751;
	Mon, 3 Aug 2026 15:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pkxgNw
	1PuQuxqL2ET6CnD7bjNjpCRxSD/yOBVYvDH+Q=; b=nj3QCB0al51aG+feu2hN9r
	LnD2XWkQoT3PdRhljA0AiEmhAEpgNtR9+FX9hdyYDXwIZ1ey8Zddktoysq+KRAIy
	E8Rmn/B08q2HJmJ1rbHO1ilUWPp84Ihj5bfKr3UHWLaa7kzp3+R97PFZBfQQLEdC
	qkKZ6uqOpXO/6TirnOH7n5GBmoaTl0vgEZq4CIH3WT/UkstCxK49h5N+VnxtNEWz
	9aHlLpyGfeBlgieNxrWQs4ng4r+F1QIwo22MQXwEipxK7Ao1pau2TV60DEMHAPDX
	aKykqPpsv28HUYu6TT9FRfK5DAh9NqGmKHxLf+pCIXkvfYtLnnXx420b1/Mhbx6w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euh2ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:03:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EuFi7014625;
	Mon, 3 Aug 2026 15:03:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg5pw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:03:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673F3HX131457550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 15:03:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C3EB20049;
	Mon,  3 Aug 2026 15:03:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9E212004B;
	Mon,  3 Aug 2026 15:03:16 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  3 Aug 2026 15:03:16 +0000 (GMT)
Date: Mon, 3 Aug 2026 17:03:14 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: Re: [PATCH v8 05/13] KVM: s390: ucontrol: Fix sca_clear_ext_call()
Message-ID: <20260803170314.1a1f49b8@p-imbrenda>
In-Reply-To: <8209fdba-9947-42e2-b124-81adf3419f15@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
	<20260803124040.126471-6-imbrenda@linux.ibm.com>
	<8209fdba-9947-42e2-b124-81adf3419f15@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: cqSBz1j3zYXxzwUCVvqmvhnPA6imF1BU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX/okmUd1kWBhs
 KtXsdzaXW5Zevc81aFRK5HMzo4LX1YjlgeicJj0Glfa6tF4+eKxUxYtcmy5FjwhYjkQhoWpfYc/
 CCGP3C6cn/V5tHO6vVSoNMB8wpGkLmE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX4cmM4Vfhu2Ig
 buQkAW89THzHWdEAeWB00rQtg7PGJMhj7MwVzKJRBLhGrp4V/qXEI5k7q2e5O9TG3utdTbfFasq
 lazt9lz6e1R3eOPTC02F58ZCXoEfBhfCIEIjQHjIbgx1O+wyLADEjsYV1AO/Don3fFoWESQbVWQ
 3IzPKn9s93aw7Gt4EnVjBUZN8Nz/FI1qdIFgOaAe8JGf3+wpZOqzVEKSvYFtm+BeIp4S21B9n0o
 yPBsKVTo2S+rKSu2eXFApFAcYAQdXANuPblzRH9nKk3klXV/cig4e/x+C+mqVbru2wfgWKaZkti
 ppA9E3NEh72LxJiaqcaWV03+EynuTaJaCANiSFtPe0/n6bjRChIHc/J7kk7eQrxSp7sZwjLJ0nQ
 oPAtcHsUkzPauIN8gMhEffoXVm2pQWNJ2VlsuKGA6tYYoCiz6Pz+rDfP7SE67H2vo8nv8NMX/ju
 EfNnLWNsyW0SQkR+hZw==
X-Proofpoint-GUID: cqSBz1j3zYXxzwUCVvqmvhnPA6imF1BU
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70adbb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=joHoxSTN3CKu4gl-UVAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030133

On Mon, 3 Aug 2026 16:50:30 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 8/3/26 14:40, Claudio Imbrenda wrote:
> > When cleaning up a UCONTROL VM, sca_clear_ext_call() will touch memory
> > outside of the allocated ESCA block, and UCONTROL VMs don't even use
> > ESCA.
> > 
> > Fix by not touching ESCA for UCONTROL VMs, and fence the
> > KVM_S390_INTERRUPT ioctl altogether. Add extra checks in
> > sca_ext_call_pending() and sca_inject_ext_call() to make sure UCONTROL
> > VMs won't touch ESCA.
> > 
> > Fencing does not cause regressions with userspace, since UCONTROL VMs
> > never used KVM_S390_INTERRUPT ioctls.
> > 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > Fixes: 7d43bafcff17 ("KVM: s390: Make provisions for ESCA utilization")


[...]


> > @@ -84,10 +90,13 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
> >   static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
> >   {
> >   	struct esca_block *sca = vcpu->kvm->arch.sca;
> > -	union esca_sigp_ctrl *sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
> > +	union esca_sigp_ctrl *sigp_ctrl;
> >   
> > -	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
> > +	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized || kvm_is_ucontrol(vcpu->kvm))
> >   		return;
> > +
> > +	/* Initialize after the above check, to prevent going out of bounds */
> > +	sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;  
> 
> Not sure why you only add this here and not at the other two occurences.

because the other two were added later and I forgot about the comment :)

> But I don't think we need these comments at all.
> 
> Dereferencing things before a check is not a great idea in most cases. 
> Especially if the check validates if the memory has been set up at all :)
> 
> >   	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
> >   
> >   	WRITE_ONCE(sigp_ctrl->value, 0);
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 5b2727d7dfd1..21574f57be72 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -2934,6 +2934,9 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> >   	case KVM_S390_INTERRUPT: {
> >   		struct kvm_s390_interrupt s390int;
> >   
> > +		r = -EINVAL;
> > +		if (kvm_is_ucontrol(kvm))
> > +			break;
> >   		r = -EFAULT;
> >   		if (copy_from_user(&s390int, argp, sizeof(s390int)))
> >   			break;
> > @@ -5456,6 +5459,8 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
> >   		struct kvm_s390_interrupt s390int;
> >   		struct kvm_s390_irq s390irq = {};
> >   
> > +		if (kvm_is_ucontrol(vcpu->kvm))
> > +			return -EINVAL;
> >   		if (copy_from_user(&s390int, argp, sizeof(s390int)))
> >   			return -EFAULT;
> >   		if (s390int_to_s390irq(&s390int, &s390irq))  
> 
> Do we need changes to the api documentation for this rc?

The existing documentation is already not describing which error codes
are possible and when.

