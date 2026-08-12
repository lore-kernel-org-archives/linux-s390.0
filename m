Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8073546D2;
	Wed, 12 Aug 2026 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540298; cv=none; b=B1Fymgt3T9pfsH2M8T56ydEGw98RZOtKdx1WgyPNVdjwk4WCcJtb5LIDQCo9prixpsJyatIGEvkcxJ1lS87uf6Fi8bomnmLIRSCRMjJMtStjW3SkW1UseMgP9pX+lBhp0v0YfCsvHObtjcPteuyCVyMqtQnn19mq0J8CzaEcHoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540298; c=relaxed/simple;
	bh=GzE7R5Vn4vw7HqtJWlpEFCgUpPJpIvzCSDUk4k8D+ss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4jGcWDnm1p+SJYwRqI2U3SxIO03aUjN3RZnBQ4SEN2TFhGgd1PHzjrpvKZmWxoz7Y5EebR/IKFSEWItp2fK5LG/JRi+P7uJcRHvFRAGKoAxmTX6Cez0E0TUXRBDGQX8iohgh57/p6ONZSMySTNWAIvmj7xlMXFsmxgQ3nu1N14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BQQz5GJZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BQQz5GJZ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3dXu3334307;
	Wed, 12 Aug 2026 13:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fWy1Qw
	FO1/Qe8frRAEND9i1w8Td0Q2XyzbDKgBgmOqI=; b=BQQz5GJZ3Tu1dQdl+ZeY2S
	VQKS77ogjljZZwDXrkau6ZuL0mgpX+beRGv/VfcAn0H8MM3qhjrv1VY3qUiixAFm
	71eQOPEDJF5e3Myl4kqWWOR93oSgym8bAunU06Sm54HkFXhgarFxp2Ul7uERBYqK
	wvDkDapmxubxQFuU5TK2/x8r7gFic47LtSuBkxfnuqE1KXEgLAlhDJs4lWLnK9Og
	t02Ct5f2yCYCApsJaFKD+8bxfAB4g9FeXHdKTA7X+iOXoAxKgkr5tpxTFPa+Vb8u
	3zjDSgF2nJG0gZKolsJWgVK6K+Hn2G+stqX9xCSRk1A3Bg77mdKGLhS0KwLGsXhg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw9qps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:11:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDBHFf017901;
	Wed, 12 Aug 2026 13:11:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gdycm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:11:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDBRNn30867730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:11:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7715920043;
	Wed, 12 Aug 2026 13:11:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FA0720040;
	Wed, 12 Aug 2026 13:11:27 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 12 Aug 2026 13:11:27 +0000 (GMT)
Date: Wed, 12 Aug 2026 15:11:25 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, <borntraeger@de.ibm.com>,
        <frankja@linux.ibm.com>, <david@kernel.org>, <seiden@linux.ibm.com>,
        <nrb@linux.ibm.com>, <gra@linux.ibm.com>
Subject: Re: [PATCH v2 6/9] KVM: s390: Fix IRQ injection with SIGP Stop and
 Store Status
Message-ID: <20260812151125.029af983@p-imbrenda>
In-Reply-To: <DKMZFBBD13PQ.1588PLS4LJS74@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
	<20260812104436.109741-7-imbrenda@linux.ibm.com>
	<DKMZFBBD13PQ.1588PLS4LJS74@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c7106 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=iBEcVuJVuu-1Z3s23EIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: aXm1a0DywSpobL8TH7RoEogCkZ1dZ_JA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfXxfZxj1D4/6kL
 R7ldw0ooN9xCtGO6zUCPi8K3O6GD8HmfsOKZMZkRnoQDTIo9a92TziGrGuaPrfjMwip40W0QbQl
 +8kKOhPsoDo+4Tn3jjRDUIGBsJlhDrFUSRo6tKF4YFIRnWqX49jmYXWULvKNSjkysDrZvlX4kOO
 TcqrOyA37LGOm3em6t7bELcW7NJigkglv74gTBVrwZ0Ml4ZHgEolhQHx6wOLHn/otFesnXQujxy
 Rw4ikOZO8CjFpHMwhmUoaxxPFJEKXNqWBDj8hAfrEPvOaLRIUvY8LkLhKYtIighQ8DaJ6HncyVH
 lGM7BWG7mNII54J9a0o96p1JoiTuhKf6hQ/2fwvQbaWrXZ4mv8IEjmIUgvV562o/mYAF+VWXqqQ
 6NlzgfGte6DgSpKPN+6BDF03p+qdBYMjlFtH+PtW2AQSko/UQ/BjIu1mUo6C4ibahNsdL22Oyk0
 yWbrFXyzKTDQfGPH7cw==
X-Proofpoint-ORIG-GUID: aXm1a0DywSpobL8TH7RoEogCkZ1dZ_JA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfXzNuXH2Bbn771
 J+o+STUXh/IZT1qBK+WMR43wrv+H9z6ZisZg1nRdwi0FmpicjnAIrwqbIkg0ONEyt5FJewjxw6u
 89kVw0+6S5JnVc43PRwgKTIcmiMkQ5o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120106

On Wed, 12 Aug 2026 14:59:36 +0200
"Christoph Schlameuss" <schlameuss@linux.ibm.com> wrote:

> On Wed Aug 12, 2026 at 12:44 PM CEST, Claudio Imbrenda wrote:
> > When __inject_sigp_stop() is called for a Stop and Store Status
> > operation, if the vCPU is running, the interrupt is marked as pending
> > and the status is stored by the thread performing the KVM_RUN IOCTL.
> >
> > If the vCPU is already stopped, the status is stored immediately.
> >
> > Storing the status means writing into userspace, which might fault, and
> > __inject_sigp_stop() is called from do_inject_vcpu() which in turn is
> > always called holding a spinlock, which is obviously an issue.
> >
> > Fix this by returning -EWOULDBLOCK from __inject_sigp_stop(), and
> > adding a bool flag to indicate whether a store status is needed. The
> > callers of do_inject_vcpu() are modified to pass the pointer to the
> > bool flag; whenever a Store Status operation is needed, the callers can
> > now perform it outside the spinlock.
> >
> > Opportunistically refactor kvm_s390_set_irq_state() to use
> > scoped_guard() and __free().
> >
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >  arch/s390/kvm/interrupt.c | 70 +++++++++++++++++++++------------------
> >  1 file changed, 38 insertions(+), 32 deletions(-)
> >
> > diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> > index 8e4b88bce31f..6940f4d354e5 100644  
> 
> [...]
> 
> > @@ -3188,31 +3192,33 @@ int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu, void __user *irqstate, int len
> >  	if (!buf)
> >  		return -ENOMEM;
> >  
> > -	if (copy_from_user((void *) buf, irqstate, len)) {
> > -		r = -EFAULT;
> > -		goto out_free;
> > -	}
> > +	if (copy_from_user((void *)buf, irqstate, len))
> > +		return -EFAULT;
> >  
> > -	/*
> > -	 * Don't allow setting the interrupt state
> > -	 * when there are already interrupts pending
> > -	 */
> > -	spin_lock(&li->lock);
> > -	if (li->pending_irqs) {
> > -		r = -EBUSY;
> > -		goto out_unlock;
> > -	}
> > +	scoped_guard(spinlock, &li->lock) {
> > +		/*
> > +		 * Don't allow setting the interrupt state
> > +		 * when there are already interrupts pending
> > +		 */
> > +		if (li->pending_irqs)
> > +			return -EBUSY;
> >  
> > -	for (n = 0; n < len / sizeof(*buf); n++) {
> > -		r = do_inject_vcpu(vcpu, &buf[n]);
> > -		if (r)
> > -			break;
> > +		for (n = 0; n < len / sizeof(*buf); n++) {
> > +			tmp = false;
> > +			r = do_inject_vcpu(vcpu, &buf[n], &tmp);
> > +			if (r == -EWOULDBLOCK && tmp) {
> > +				storestatus = true;
> > +				r = 0;
> > +			}
> > +			if (r)
> > +				break;
> > +		}
> >  	}
> >  
> > -out_unlock:
> > -	spin_unlock(&li->lock);
> > -out_free:
> > -	vfree(buf);
> > +	if (storestatus) {
> > +		n = kvm_s390_store_status_unloaded(vcpu, KVM_S390_STORE_STATUS_NOADDR);  
> 
> I assume we do not care about loosing n = -EFAULT when we are already on the
> error path here with r != 0. But are there cases in which we would not want to
> call kvm_s390_store_status_unloaded() at all here when one of the later
> do_inject_vcpu() calls failed with a specific error?

no, because the store status should have happened before the failed
interrupt injections.

The only tricky part is if store status fails, but the other injections
don't. In that case we should have aborted without injecting the other
interupts. On the other hand, when the caller receives a -EFAULT it
will probably just give up on the whole VM.

> 
> > +		return r ? r : n;
> > +	}
> >  
> >  	return r;
> >  }  
> 
> 

