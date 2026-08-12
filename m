Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086CD4519A7;
	Wed, 12 Aug 2026 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541005; cv=none; b=XESjsELlZhsbQ8fFQ9QIYrPXkXkYpIPoWb34nhfoziJgtOCH2kLjRRLPX4B3KvR0tpJPGsYKOr7Ah0dpFouKkhugvJ/tF8PCO1Hz5HTI+C88IbvraEsbt8Lc0ClxPwx/HUnJFqi18FcBYGd4/T9ZbGSykqdleW2QZ2XPbuypqXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541005; c=relaxed/simple;
	bh=f642MzTzHyOY2HlkB7T7h5PHhhPMaswEOJfyua1uDAo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=armb4FBSMw2hwRqf4/CeHwBEDPSuU31HjGYr+7633N7qcAJVfLtNQ/nxoBcyf2LdHM3Ni8HRLCUvi3JXi0oy8lu5q+O6NOhIiK+CzHJRyHRaZEfcVyCoOUx6MWv04d5nEa/YBHlVBalBn6PyZZg5T8ePibMGdYy56u8bX9wV/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pn+kqbn+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pn+kqbn+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3j772205453;
	Wed, 12 Aug 2026 13:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SYjNsY
	sePpjGbiprGbZOgCU5YDCv5Ihh1GArRHdQsrM=; b=Pn+kqbn+8tb0WrsUEFpdua
	NNZ81sWGqZ2hKk2JIB0QSfLCWhIpqb8VSPVUVmUoWCYcPydkO3L2wlB7JxOmDfIL
	bwEFc6Z7Ge0bdj8B+mb3H/QI1ZlHd6xz7mq0tqLSKlo4gLJeJI6Ja9dmRCGJojST
	jz8yPw7r+Fa0Xu/MOvyrjxhD4xPFWUeJ1HDJCf3WM17jZ5gNALfPghByC0AG6f0N
	XH6swEN8U4qRDwqbkpkNZ3qKhQq7FEuPmpLvoc7PGh46TG7Fg1RKu+m50kUW7Vv6
	KHWYIpa4DC41hoqedxzc7a1aDfCof7pzotOZoGpzJagahE4VQ1jeGk7dAV3xFTbQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23u594-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:23:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CCuG1m030511;
	Wed, 12 Aug 2026 13:23:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjx4y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:23:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDNGhP51708336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:23:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B5A120043;
	Wed, 12 Aug 2026 13:23:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45AEE20040;
	Wed, 12 Aug 2026 13:23:16 +0000 (GMT)
Received: from darkmoore (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:23:16 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 15:23:11 +0200
Message-Id: <DKMZXD3NXDFM.OKL6M7ZZH7GZ@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, <borntraeger@de.ibm.com>,
        <frankja@linux.ibm.com>, <david@kernel.org>, <seiden@linux.ibm.com>,
        <nrb@linux.ibm.com>, <gra@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        "Christoph Schlameuss"
 <schlameuss@linux.ibm.com>
Subject: Re: [PATCH v2 6/9] KVM: s390: Fix IRQ injection with SIGP Stop and
 Store Status
X-Mailer: aerc 0.22.0
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-7-imbrenda@linux.ibm.com>
 <DKMZFBBD13PQ.1588PLS4LJS74@linux.ibm.com>
 <20260812151125.029af983@p-imbrenda>
In-Reply-To: <20260812151125.029af983@p-imbrenda>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c73c9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Zjat-7toU3qrALN4REUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfX1AFAFgC4pEAu
 +nrystiq0nvOBOHSBBbNOohN/l1iQgeFeFvFC2LMuadWwdww2OOloNGmtayZHlO3XPyAJyDNHQ2
 rjg6v2wWKAtKudro2t12I2VrDL6ZrLiV9aQQoufSJv6CI6gl+o6iBXuwr5EpyPYoWT4NyCr34jP
 UqCa62wtDH7atlO7QXDRiemvYYoruPzzqjjlc7atKn+q0by2RihqhUmTO0TLmQAbyIYHqcJcXSj
 iBBIL6K31WVUwVDztSkSynfgpLWT8ueil0tNZCvZFnwJ3rPTs9/wGbsYxmgeS2+SeftOqd3Diyf
 DPVtmHXLmj7sp5J7t3D0ReXoQXa2wAe4iZ0aVEV/cjxWCDWWOO+r8KYkoS9ITMpsUfFdCz013wT
 yQNaOpuwJczRAamExXSZbnrwVrJ6cbQ0SEDdMBPSdpwnf8J7ibi4QNm/+EHsMx8+I3D6O4/HZhF
 IZHry2Va24MwhkxC/wg==
X-Proofpoint-ORIG-GUID: pPtaw4mWPOe3tkwA4rLbd6EGWiT6bbXu
X-Proofpoint-GUID: pPtaw4mWPOe3tkwA4rLbd6EGWiT6bbXu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfX7RCHNWqhbXIl
 F3SNB+fCyWkev+G6Z4us8NjOAmtZA6IF4FXKJjsYKwuGZaxzAFVYKP0LuvvM/a9U7KJW7RJfqD/
 PIdsyL4ZvDt2P0PzEfcgJhMzQXI+yMQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120106

On Wed Aug 12, 2026 at 3:11 PM CEST, Claudio Imbrenda wrote:
> On Wed, 12 Aug 2026 14:59:36 +0200
> "Christoph Schlameuss" <schlameuss@linux.ibm.com> wrote:
>
>> On Wed Aug 12, 2026 at 12:44 PM CEST, Claudio Imbrenda wrote:
>> > When __inject_sigp_stop() is called for a Stop and Store Status
>> > operation, if the vCPU is running, the interrupt is marked as pending
>> > and the status is stored by the thread performing the KVM_RUN IOCTL.
>> >
>> > If the vCPU is already stopped, the status is stored immediately.
>> >
>> > Storing the status means writing into userspace, which might fault, an=
d
>> > __inject_sigp_stop() is called from do_inject_vcpu() which in turn is
>> > always called holding a spinlock, which is obviously an issue.
>> >
>> > Fix this by returning -EWOULDBLOCK from __inject_sigp_stop(), and
>> > adding a bool flag to indicate whether a store status is needed. The
>> > callers of do_inject_vcpu() are modified to pass the pointer to the
>> > bool flag; whenever a Store Status operation is needed, the callers ca=
n
>> > now perform it outside the spinlock.
>> >
>> > Opportunistically refactor kvm_s390_set_irq_state() to use
>> > scoped_guard() and __free().
>> >
>> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> > ---
>> >  arch/s390/kvm/interrupt.c | 70 +++++++++++++++++++++-----------------=
-
>> >  1 file changed, 38 insertions(+), 32 deletions(-)
>> >
>> > diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> > index 8e4b88bce31f..6940f4d354e5 100644 =20
>>=20
>> [...]
>>=20
>> > @@ -3188,31 +3192,33 @@ int kvm_s390_set_irq_state(struct kvm_vcpu *vc=
pu, void __user *irqstate, int len
>> >  	if (!buf)
>> >  		return -ENOMEM;
>> > =20
>> > -	if (copy_from_user((void *) buf, irqstate, len)) {
>> > -		r =3D -EFAULT;
>> > -		goto out_free;
>> > -	}
>> > +	if (copy_from_user((void *)buf, irqstate, len))
>> > +		return -EFAULT;
>> > =20
>> > -	/*
>> > -	 * Don't allow setting the interrupt state
>> > -	 * when there are already interrupts pending
>> > -	 */
>> > -	spin_lock(&li->lock);
>> > -	if (li->pending_irqs) {
>> > -		r =3D -EBUSY;
>> > -		goto out_unlock;
>> > -	}
>> > +	scoped_guard(spinlock, &li->lock) {
>> > +		/*
>> > +		 * Don't allow setting the interrupt state
>> > +		 * when there are already interrupts pending
>> > +		 */
>> > +		if (li->pending_irqs)
>> > +			return -EBUSY;
>> > =20
>> > -	for (n =3D 0; n < len / sizeof(*buf); n++) {
>> > -		r =3D do_inject_vcpu(vcpu, &buf[n]);
>> > -		if (r)
>> > -			break;
>> > +		for (n =3D 0; n < len / sizeof(*buf); n++) {
>> > +			tmp =3D false;
>> > +			r =3D do_inject_vcpu(vcpu, &buf[n], &tmp);
>> > +			if (r =3D=3D -EWOULDBLOCK && tmp) {
>> > +				storestatus =3D true;
>> > +				r =3D 0;
>> > +			}
>> > +			if (r)
>> > +				break;
>> > +		}
>> >  	}
>> > =20
>> > -out_unlock:
>> > -	spin_unlock(&li->lock);
>> > -out_free:
>> > -	vfree(buf);
>> > +	if (storestatus) {
>> > +		n =3D kvm_s390_store_status_unloaded(vcpu, KVM_S390_STORE_STATUS_NO=
ADDR); =20
>>=20
>> I assume we do not care about loosing n =3D -EFAULT when we are already =
on the
>> error path here with r !=3D 0. But are there cases in which we would not=
 want to
>> call kvm_s390_store_status_unloaded() at all here when one of the later
>> do_inject_vcpu() calls failed with a specific error?
>
> no, because the store status should have happened before the failed
> interrupt injections.
>
> The only tricky part is if store status fails, but the other injections
> don't. In that case we should have aborted without injecting the other
> interupts. On the other hand, when the caller receives a -EFAULT it
> will probably just give up on the whole VM.
>

Thanks, that would have been my feeling, just wanted to validate.

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>


>> > +		return r ? r : n;
>> > +	}
>> > =20
>> >  	return r;
>> >  } =20
>>=20
>>=20


