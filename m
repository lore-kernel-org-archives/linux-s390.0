Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D1305968;
	Wed, 24 Jun 2026 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290573; cv=none; b=tNEQC7ODwSwJdLJJ2jAQOyC86LKWEPXInG2O0qD5Lafzr7YFWSsC9sPf/sfMnWN4Kc9o8bnuR483WgvxfXLoXcOkif5AVyj7OJmk++lWaLeUyWDuXfw3qahin3oBH1oxLWRMxOhFRUv6CE5GfJjOiHyoUAOdI6odTpO4kDui+bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290573; c=relaxed/simple;
	bh=gSPhG2eKaiWLAUa1dJ4fJ9j6UolWubCKqUK/5htKEao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujD/eqRJnwNvNSX30HNF1IuXkpvH8vu1dOc5WjWhqOoQtGURbx4uROnzAcIeLq3ZXoHlGEdOtmohyeyx/LHEpH8dURELM6J+8pNMM9lnnpebMHGkZy2E4+toHtHDAA15zMecu38rpk5JZieU/1RcK5eS2cnK9X2DYvoxecBjrfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NgLtvUQR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NgLtvUQR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O6IPM6299255;
	Wed, 24 Jun 2026 08:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Pa6kvw
	92RiS8uZ0QuGMen17hdXAXB23gKzEmfp0omh4=; b=NgLtvUQRv0uLyV+XfD1sLl
	FZLj4TsyHTjFtnMQcM4W+1gKKuF3FBOHeVcjQsvz4KxBC0AFjZTlscAIucdOpqCw
	/sFbuOasQWrPj8zP7OgtwkfCqe9D3Lmnnu8pY4SNkyy8qKvvV/AbCT3OM4oKx+Ia
	D18Xe/qQEnBdwnKDI9WHsKicTyhU/d3+gufYuHUDPRsFi9wxSGK0i+Q8DM7zr7jG
	gytD7g0fOQ9sF8Fk571VyN/oz5BTWezWAprk6VG6/wMVAdFHqpWirtfgDDU4q7oC
	ii4/79ONiCC1SvjpavpZPxDI24rb5GFBS/s076LwtgT2SWq+s9rybDAV/LjO9xIg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqu4fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:42:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O8YbTC021859;
	Wed, 24 Jun 2026 08:42:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyqd0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:42:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65O8ge8S41091406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 08:42:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E8C22004D;
	Wed, 24 Jun 2026 08:42:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BF3E20040;
	Wed, 24 Jun 2026 08:42:40 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 24 Jun 2026 08:42:40 +0000 (GMT)
Date: Wed, 24 Jun 2026 10:42:38 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: s390: pci: Fix GISC refcount leak on AIF enable
 failure
Message-ID: <20260624104238.691a3e82@p-imbrenda>
In-Reply-To: <20260624061910.2794734-1-haoxiang_li2024@163.com>
References: <20260624061910.2794734-1-haoxiang_li2024@163.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3b9885 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=Byx-y9mGAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=A-BEMzGee-1drNj13wIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2OCBTYWx0ZWRfXwlODs4Gbts6k
 uzwhF3nV0SMsTIRdNIQhLqZ6DwnPj7+4/qbf+HpMr+tDT0E6y6IvDs0RDpt+mZj8HY2elLADoMd
 G3lPpnjO9mj72O9ZEE0U4sFoVd0xBDd/RhhuBzHRBueb5YUUQSnbHB8KkjezmoQcBv22AH5mB2u
 fE/6jBZ/FhhiMYNOBdWB0aFXQ/9+rAx9wAZcvDvnoImBNmFP5bK8zZdcWUqjFLTb3iEYIGJzEA4
 XMpd/6sEZtnit3SsO7FJA2oUoi/9hWOmpZoLkVRDYWtmVGgZ0tIxoyqOojHJihjZ2M6Rqg+toLs
 6KQZ58NM/z26tGvGhWxgI8dqjW1PkJ+2C5BQWnlB0hpWBp5s4t3OtwZ1UoqQ7siFH2RWN9ihepu
 vMMKV0JIa4PoLG0HyeYQZOX0Xm6N9A==
X-Proofpoint-GUID: kGfPIicU1H7wY9S5DKPSaesaWGdNp0Qz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2OCBTYWx0ZWRfX1UYUatSmAX1d
 bIPe+pFv14vUcN+2KFsfaORlEMmso3cQCO9GC9op12NDLaCAp4BOvtRkfbq9mH9wvig3Atj2FkC
 o73Pq96XDxOgsVh7GNvPcAZgoi4Pjx4=
X-Proofpoint-ORIG-GUID: UnbhvDLrBOaB38E1SgIq23Y2ugWEQzlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240068

On Wed, 24 Jun 2026 14:19:10 +0800
Haoxiang Li <haoxiang_li2024@163.com> wrote:

> kvm_s390_gisc_register() registers the guest ISC before pinning
> the guest interrupt forwarding pages and allocating the AISB bit.
> If any of the later setup steps fails, the function unwinds the
> pinned pages and other local state, but does not unregister the
> GISC reference. Add the missing kvm_s390_gisc_unregister() to the
> error unwind path.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
> Changes in v2:
>  - Move unregister call after "out" label. Thanks, Matt!
> ---
>  arch/s390/kvm/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 5b075c38998e..686113be0530 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -328,6 +328,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  unpin1:
>  	unpin_user_page(aibv_page);
>  out:
> +	kvm_s390_gisc_unregister(kvm, fib->fmt0.isc);
>  	return rc;
>  }
>  

