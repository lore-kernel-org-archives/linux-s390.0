Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD431A555;
	Wed, 12 Aug 2026 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539591; cv=none; b=mVLuM+d2LalBFArVU70gKLsjtAQLkoj+vkHcJI3JxnyAxOdaozzAYcKfZHX9PF1tJuXAsmwp9SMnkCB4tsHj/oPu1A6/k4SSTaUAwWlR/1n74FloAq1h+K81S0+pkOp+d9qz3OK+gLT8lrSBSjmagltLQJCyMmIE+RiEWPhXEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539591; c=relaxed/simple;
	bh=eMgx2avTIERWFpGJgijDRzZ+oniAt9zaBAZC0LKe2tQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=Msyxc2ZVBH82R7xyIKCEhCzLYlNRnNWrGYYg0fXE8e8v6OLh8BidcO9DhetfLRoZsBx0SAAUx8Eo7zDJK13wqcLgOroVRqf03Jpjh/TjWLTlF2KjtH48ee0ueTCmvFC/MyQJ3Q2tGDP7mnvE49kJGbH0mcR6Ae6xHh0sJRhVtXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qQgakyTx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qQgakyTx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB54AQ2207895;
	Wed, 12 Aug 2026 12:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+WFKY4
	ufw8fUGrg7pVuIRGv0fEfofwEM15wbpLHmkbE=; b=qQgakyTxU2330D3NvPFFcf
	f9IG5gA94eysZLyQZE98uDfpF/by1dtWnAr4+DS3EdPD8Oq1gxxTdLf8HcaJcUAA
	KE1lOAPmUdHZRZaZZwKI86ie5uE+etT3Hzbd3VMpDP/Tw5Teq67sVaoee2QIpicV
	5cLNVTWhfxIHacGd6olhsiU5uhjX7gktgR5binn50odG6eAKvNBR0Ij1GCQ4L2rP
	EkGZ0A+FrBMZ6QPHuRaLfcCDI29s4S5Z4KoUJ2LhVrSRshP2Q44SdTsVzFdhnYGW
	wXBWG+M2djj47s3uoI0NQfyP8AU8Omxsb/70hPz2wPZJP/ln6IdriD9+pjNruTDQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23u1j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 12:59:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CCuGru030511;
	Wed, 12 Aug 2026 12:59:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjx1b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 12:59:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CCxgN239780640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 12:59:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC3F520049;
	Wed, 12 Aug 2026 12:59:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6A7E20040;
	Wed, 12 Aug 2026 12:59:41 +0000 (GMT)
Received: from darkmoore (unknown [9.224.78.25])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 12:59:41 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 14:59:36 +0200
Message-Id: <DKMZFBBD13PQ.1588PLS4LJS74@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <david@kernel.org>,
        <seiden@linux.ibm.com>, <nrb@linux.ibm.com>,
        <schlameuss@linux.ibm.com>, <gra@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/9] KVM: s390: Fix IRQ injection with SIGP Stop and
 Store Status
X-Mailer: aerc 0.22.0
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-7-imbrenda@linux.ibm.com>
In-Reply-To: <20260812104436.109741-7-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c6e42 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=wj_1A0y2YC5ubAPmoGIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMiBTYWx0ZWRfX/M1ejYf9LjE+
 D/+icbR5067bH5BQKUVbhXj0FGaitOiWp8jTwzZ0S2bzBqIc2Vi+pkwzeSJkqDg4eLK5CtuIDpv
 mh+cjJcOSVd06kUWcjDunnPxUKHpFEFPi8gnW/chP66Ycum8oPNLKrPuKqNqvmmUBB60PqxnuOw
 XGYQVGQpq5pyWawBPH3kxM3AEK3uOMMElLLZDXuzZlloA/Yot+l+H0+wObXeU3lgihPtmmAZvQ7
 l0mcSxFeRKlpMEqvdY73JdzSVxMInEpxS7vRSjyMnOm5gjr+KyAaR67DTvlujocwvi3DVLvvk9t
 T29/2TLmmygGtoJnEhkTuT8bGtuRw+fNp7dHGCZLdP103lF4Ocv7KcrVKvzByCGNtEp3Tu9RtTn
 HLddVqIQnSz7mADv05UgiSxlWrgHwtINtG6gTtjsQr83+KltE9ScvtXnxAItk6ux2RgJHMK1lrV
 ywF24fXrYnr1QEHJCyg==
X-Proofpoint-ORIG-GUID: tC2mWcq06aj-_vM6pmEVq41R8Od3BIlF
X-Proofpoint-GUID: tC2mWcq06aj-_vM6pmEVq41R8Od3BIlF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMiBTYWx0ZWRfXyeZboPsW7RbJ
 UQbqhdzkmYIA43nR4vfBFjX3uuaZF9LqMHm3f6K9Nl/gzpId/mrRcjelrq1AsYcgTr1+PxfnbDq
 Z6YcYjfJdCjfjmm5QUe3YMRodPRmH1s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120102

On Wed Aug 12, 2026 at 12:44 PM CEST, Claudio Imbrenda wrote:
> When __inject_sigp_stop() is called for a Stop and Store Status
> operation, if the vCPU is running, the interrupt is marked as pending
> and the status is stored by the thread performing the KVM_RUN IOCTL.
>
> If the vCPU is already stopped, the status is stored immediately.
>
> Storing the status means writing into userspace, which might fault, and
> __inject_sigp_stop() is called from do_inject_vcpu() which in turn is
> always called holding a spinlock, which is obviously an issue.
>
> Fix this by returning -EWOULDBLOCK from __inject_sigp_stop(), and
> adding a bool flag to indicate whether a store status is needed. The
> callers of do_inject_vcpu() are modified to pass the pointer to the
> bool flag; whenever a Store Status operation is needed, the callers can
> now perform it outside the spinlock.
>
> Opportunistically refactor kvm_s390_set_irq_state() to use
> scoped_guard() and __free().
>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 70 +++++++++++++++++++++------------------
>  1 file changed, 38 insertions(+), 32 deletions(-)
>
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 8e4b88bce31f..6940f4d354e5 100644

[...]

> @@ -3188,31 +3192,33 @@ int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu,=
 void __user *irqstate, int len
>  	if (!buf)
>  		return -ENOMEM;
> =20
> -	if (copy_from_user((void *) buf, irqstate, len)) {
> -		r =3D -EFAULT;
> -		goto out_free;
> -	}
> +	if (copy_from_user((void *)buf, irqstate, len))
> +		return -EFAULT;
> =20
> -	/*
> -	 * Don't allow setting the interrupt state
> -	 * when there are already interrupts pending
> -	 */
> -	spin_lock(&li->lock);
> -	if (li->pending_irqs) {
> -		r =3D -EBUSY;
> -		goto out_unlock;
> -	}
> +	scoped_guard(spinlock, &li->lock) {
> +		/*
> +		 * Don't allow setting the interrupt state
> +		 * when there are already interrupts pending
> +		 */
> +		if (li->pending_irqs)
> +			return -EBUSY;
> =20
> -	for (n =3D 0; n < len / sizeof(*buf); n++) {
> -		r =3D do_inject_vcpu(vcpu, &buf[n]);
> -		if (r)
> -			break;
> +		for (n =3D 0; n < len / sizeof(*buf); n++) {
> +			tmp =3D false;
> +			r =3D do_inject_vcpu(vcpu, &buf[n], &tmp);
> +			if (r =3D=3D -EWOULDBLOCK && tmp) {
> +				storestatus =3D true;
> +				r =3D 0;
> +			}
> +			if (r)
> +				break;
> +		}
>  	}
> =20
> -out_unlock:
> -	spin_unlock(&li->lock);
> -out_free:
> -	vfree(buf);
> +	if (storestatus) {
> +		n =3D kvm_s390_store_status_unloaded(vcpu, KVM_S390_STORE_STATUS_NOADD=
R);

I assume we do not care about loosing n =3D -EFAULT when we are already on =
the
error path here with r !=3D 0. But are there cases in which we would not wa=
nt to
call kvm_s390_store_status_unloaded() at all here when one of the later
do_inject_vcpu() calls failed with a specific error?

> +		return r ? r : n;
> +	}
> =20
>  	return r;
>  }


