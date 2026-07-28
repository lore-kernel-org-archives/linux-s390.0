Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279EC45D1A6;
	Tue, 28 Jul 2026 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250217; cv=none; b=JI59mtSu6gb8sqVPY0y+dAldb2rhVGeDPUNOpn08CXdsn4dz713C5gy4J8fOa2ktSO1JRsr/smOn7ZYGKQWBj573qIPQdLqCZM9gyzLTm6eM0UQSR+ioEo62DRA1PS1doIdgcm6pS7pnGh8WKkebu2zzYLlbUN2ifKBmo4HoSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250217; c=relaxed/simple;
	bh=jixQe4nGYBKzIc7uRjN5MuMKaJ3xDpnoiYY9eCFzzCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4QWrFx1qL4An7hoZdSUR7rL3pVu+x3dPE4aOCIRbHbyVsU669MGzL/aZzM5D0IkxoH4J00B9ow2lGCm0VkPl4Atd+W1ERA7us8lIckD/DbPcmKzGGD3vEbh+fxSI2mZLfc439TBTvFjP6VLWzfmw4/p6afRHgh+EXMwJtTppas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lf8qU6uk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lf8qU6uk"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SEljpY1459403;
	Tue, 28 Jul 2026 14:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P0j9PR
	GK7c1wjedrc8EaCglxKV9ZSEfkzPpg75aNaIs=; b=Lf8qU6uk6nbt31URgpn+rB
	4E71ejeymbyf5YRkEMtaUzNETDPEeIeuruPBs9qq3xOTBa8MqyaVqdazzw3WD6JC
	adSLSWQE7v0/wAKx2xrUkPkOJx3P6yveeQqa9AdhWLaZ0+Ca7CE3Ox36ZrACl8xj
	vPfzRuHM89p80gRT+TjMUXwRqhg5qDPGX5sPOuM9ofec+BbP5gIFDgEUQ7RM0IE8
	mF2ttK5SZohf6uw0GGzKQ83hlwQb4x4tNPc9kE8ZUDwTSmZ4l4N8W0fEtM7EBKgn
	UHAMqMYgcxVrLBZs10qhe8xyChJVQU7P8XliMdCPAmPzif9gWMnlmR8aJ7XHsWXQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7dt4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 14:50:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SEffOh021483;
	Tue, 28 Jul 2026 14:50:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw2fbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 14:50:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SEo2vn27853226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 14:50:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBF2D20040;
	Tue, 28 Jul 2026 14:50:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B60BA20043;
	Tue, 28 Jul 2026 14:50:01 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.73.241])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 14:50:01 +0000 (GMT)
Date: Tue, 28 Jul 2026 16:49:58 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: Re: [PATCH v3 07/10] KVM: s390: Return -EINTR if a signal was
 pending while faulting-in
Message-ID: <20260728164958.23b8e391@p-imbrenda>
In-Reply-To: <1f9d8fb4-3b38-4495-b8f3-cdb51ba1318c@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
	<20260727150254.236021-8-imbrenda@linux.ibm.com>
	<1f9d8fb4-3b38-4495-b8f3-cdb51ba1318c@linux.ibm.com>
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
X-Proofpoint-GUID: k_tCYUJQDn_ve6lOV8HQQexlHDav8jSk
X-Proofpoint-ORIG-GUID: k_tCYUJQDn_ve6lOV8HQQexlHDav8jSk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEzMiBTYWx0ZWRfX80WXBDmSYNoQ
 7mmS2muICEgDyYQDFoqWuKjJY0WV5q+FLxVbavS0ui67gFFVkf1Oftu3VNzhwF/q0soM06FMXm3
 Rf1Zt2fI8mJtxI7XfwsdNXvlLQpSgOO+qNeNjmnzC7dNxW+wsIgm7pDfRFQJdsobZnfiFSyXP3C
 h3P/8zjmaealGZTam1wp+1TY74C7n+BzHbVFbSEcrAddwzlr5VVbPlQXOsHbi/MrEes2fFx05zY
 RF5rpo1Ubbm0c/49FwOO+QoExU5BwJYgLeqgNQT7op+V4gB4K3qSZXHJEtjn0wUGkzRQd84Mpie
 D0dnfS5AhPjUYNpwOMP7tHFb0JW8SBqC7Tp/N0eWbpjal/XUaMLC5OdFzEZHFqV1orwjyVa5mdB
 2t4Mjd3t5CA4z6bIVR4gtAOLiKVm2TvEv/5rRoWoEsajcjpLP+rC2zexQhyrKsRUdrRs9YBaG/O
 oNXORVEBtdbOIso3j3A==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a68c1a2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=5piRC5TjQ-BYy-1OIBUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEzMiBTYWx0ZWRfX1oPW5Hx33IT3
 uQL3CMlkePoVGaLv2VJ5TnePHPveeFVPtb7pNsWKOSYM7nila605uvjABuITMWi4QyLHz/SKO4+
 Vyt2ZYWN5IT0dgHfDeW+bw7fnwkK++A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280132

On Tue, 28 Jul 2026 16:28:38 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 7/27/26 17:02, Claudio Imbrenda wrote:
> > If a signal is pending while trying to fault-in a page, return -EINTR
> > instead of -EAGAIN.
> > 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
> > ---
> >   arch/s390/kvm/faultin.c   |  4 ++--
> >   arch/s390/kvm/intercept.c | 18 ++++++++----------
> >   arch/s390/kvm/pv.c        |  2 +-
> >   3 files changed, 11 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
> > index fee80047bd94..4ff4c5970956 100644
> > --- a/arch/s390/kvm/faultin.c
> > +++ b/arch/s390/kvm/faultin.c
> > @@ -92,8 +92,8 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
> >   		if (is_noslot_pfn(f->pfn))
> >   			return PGM_ADDRESSING;
> >   		/* Signal pending: try again. */
> > -		if (f->pfn == KVM_PFN_ERR_SIGPENDING)
> > -			return -EAGAIN;
> > +		if (is_sigpending_pfn(f->pfn))
> > +			return -EINTR;
> >   		/* Check if it's read-only memory; don't try to actually handle that case. */
> >   		if (f->pfn == KVM_PFN_ERR_RO_FAULT)
> >   			return -EOPNOTSUPP;  
> 
> The code above is what I'd expect from the description but there's more 
> code in this patch. Are we fixing multiple things?

I'm also fixing the callers that would not deal with -EINTR properly;
I'll fix the patch description accordingly

[...]
