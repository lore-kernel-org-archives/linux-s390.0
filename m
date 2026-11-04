Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804771;
	b=H625gFa1jePZ7rzDFFIYG/VBoIGJCZezaNCMdmG5uNsj3nCc5Yp+KDJEUhw7YIX1y7q0
	 WmmFOxtlYP8ikDRdOMnS2RZjy9R7e4oOzL/YAZ7jywm7/Tq3dgVzYdADDKXHEjSIoPzBn
	 GyOzl2snlK2SB9aDzZgOw/qGLfSPI35S1wHmaeBg/KfePghfceYtvgIggZ3MVnZqXVRNS
	 rVkbSGCUScuyNLuzIH7ghx7S8IK4jlSPulbeaEvGiCCRVPW+m3IU0Hk4TelWm9/FUkC0U
	 zEn8CQdZqLsi6LhCR45xwO5ivsbq+6ybwAUcqK+o7eP7vvDVTvu2BkTT8RmE6qEUxQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804771;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0on+FX88kbjKDIgT8gJnpNAKZ+JU/nrW4Lm72tYTJpY=;
	b=csBa2QNw+2TvLVpq5RxOfwXLRz8Ogma5G9p2I7knXXEBl5gUOQN7nRA/AqOXjy7Rt44Y
	 h65xx+vsqLe8ltkDFOgAr5J73KsoO7+cdmmVbMNNSMOl1aO5ZvaIaWpaotkYI72trfMcD
	 IonqX8yMU5TDfgVPfj22CDjqtBbCp0UVcNHBn4f9XAjpKfFXDmnxUVC05pwzIX1xM3V7s
	 edehzl46oWkX8fIpQttevKbj7N/MBSLcI6ywcvlyUNPPBURZw1eDOtp2Vd51m07Y7yyto
	 moRO5qxd2X0rwG0bclYYFPUJkUdgut3I5nyzD4T1nmVxy7lZ+oCcYLO/LRcZG6/9K7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WXvUYYCx;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67614606A334;
	Wed,  4 Nov 2026 15:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67614606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WXvUYYCx
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bi8tI387910;
	Wed, 4 Nov 2026 15:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0on+FX
	88kbjKDIgT8gJnpNAKZ+JU/nrW4Lm72tYTJpY=; b=WXvUYYCxHXBzo3ClgLKZz4
	uRPzgVOYbDfLBUwZy5epUrI9vKgZ8ITcx466Doilhp6M0ofyAzSm55jrY5fmufMp
	oRvKrqAJE6MT7b24umZJtYxOgQ0YuJVDne6axLJQNcyUw7Wd+qvR2KoFk0cRzrEM
	Yy9RKujEBnw/z4JxlUUVVIhPf5LIuktK1dsg9fKLMPuCZH1Fij1vp1Qnzb38jDqk
	cJjbT8TtHcgl5f17tjGIWlROdPkPgpglr145Bs4MuYwjIahNXVyhvOOCO1fV54SR
	fcdK1hDOEabXslmsb1b7NFrzUp/1lL6pvQjfWfaXVTvHtRmlnyVZM6nagC7UFbOA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhvd5m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 15:06:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BaldD2894843;
	Wed, 4 Nov 2026 15:06:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqsf5b2su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 15:06:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A4F606s26739140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 15:06:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 793BD2004B;
	Wed,  4 Nov 2026 15:06:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C3F920043;
	Wed,  4 Nov 2026 15:06:00 +0000 (GMT)
Received: from p-imbrenda (unknown [9.68.31.243])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  4 Nov 2026 15:06:00 +0000 (GMT)
Date: Wed, 4 Nov 2026 16:05:58 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: Re: [PATCH v4 7/7] KVM: s390: Allocate page tables when CMMA is
 used
Message-ID: <20261104160558.4bfab884@p-imbrenda>
In-Reply-To: <4fe568ee-bc18-4899-8ced-853046949bd2@de.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
	<20261028185422.272146-8-imbrenda@linux.ibm.com>
	<4fe568ee-bc18-4899-8ced-853046949bd2@de.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MykE6Ji0ThPeAFJhWinnRId9yfYvAFFf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1OCBTYWx0ZWRfX/d6GxzCRWSA9
 Nt02K8/cSqI+y0watoHoSRVYgw2NjF5SudYVrxmoZCQGU+zwqOBcgG5g3nzNs2m2RJk7i0S1WtP
 gAGFUU31j7dXjsdmoN1f3GJGcUjMTbs=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6aeb49df cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=1hq0dM-71BVALnanI5MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1OCBTYWx0ZWRfXzVtyys4XqD8/
 JgpVqEYOjF+Ambd3iqBtgsKTfAZAY8JzN2lt3/UEnnmlwkb2QhYVjMaa+fR2vT77mgZT/et1+S3
 7aUeeBrd5Jdz4CwF49JT18DLCSKPNK0jZxprdniC/yCRQ1Rp0+nNhtvi/tr0OdhgcILH+IHmTiU
 mXWhqqG71dwos6W9Qltb6+VgihEBgmM5MS1Riv2dsMtrMTRz9ncex3DNOAF6JFiPwAEvUqkIrEx
 UBsoHwkpyL3pOKRXIKmCFIaM+zC1NnvKX5Zj2e6ii1dRD1xze0DNew6Imju3zRZzG3h2EPwMDRq
 cgST8B2IiZjX+leBIqcs7DEes62yAOG2LhNO0jqo202VxZfUxmh6x1965zgMq33Rn9rQ6AVNVSA
 MmmvcrkmlSDaSoCUax3HKU/BVdPwoKtFTFJCA89ROn+un4Q5NMjL55BdHH+Mns0azV0lvsbJOlG
 usTsoHUADwTULZjNtxQ==
X-Proofpoint-GUID: MykE6Ji0ThPeAFJhWinnRId9yfYvAFFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040058

On Wed, 4 Nov 2026 14:28:02 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Am 28.10.26 um 19:54 schrieb Claudio Imbrenda:
> > When ESSA is executed in the guest for the first time, allocate all
> > page tables and split all existing large page mappings, regardless of
> > the hpage parameter.
> > 
> > With the page tables present (even if all the entries within are not
> > present), ESSA will not cause page faults.
> > 
> > Without this fix, ESSA will cause a fault on the first page of each
> > segment (1M block). If userspace is backing the guest with huge pages
> > (hugetlbfs or THP), the page fault will be resolved by faulting in the
> > whole huge page. The result is that at startup the whole guest memory
> > is faulted in, since the guest will mark all of its memory at boot.
> > 
> > With this fix, no extra guest memory is allocated. This will also
> > prevent the first page in each segment from being faulted in, regardless
> > of hugepages.
> > 
> > Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>  
> 
> Will that prevent THP?

technically not, but it will be ineffective, as KVM will always use 4k.

there is no way to have cmma and THP and not allocate the whole guest
memory at boot.

please note that I am planning to drop the last 2 patches in this
series for now, since they currently have issues and I currently do not
have enough bandwidth.

> 
> 
> > ---
> >   arch/s390/kvm/s390/priv.c | 5 ++++-
> >   arch/s390/kvm/s390/s390.c | 5 ++++-
> >   2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
> > index 856939acf012..4f0dd3173ab9 100644
> > --- a/arch/s390/kvm/s390/priv.c
> > +++ b/arch/s390/kvm/s390/priv.c
> > @@ -1248,7 +1248,10 @@ static int handle_essa(struct kvm_vcpu *vcpu)
> >   		 * value really needs to be written to; if the value is
> >   		 * already correct, we do nothing and avoid the lock.
> >   		 */
> > -		set_bit(GMAP_FLAG_USES_CMM, &vcpu->arch.gmap->flags);
> > +		if (!uses_cmm(vcpu->arch.gmap)) {
> > +			set_bit(GMAP_FLAG_USES_CMM, &vcpu->arch.gmap->flags);
> > +			gmap_allocate_all_page_tables_best_effort(vcpu->arch.gmap);
> > +		}
> >   		/*
> >   		 * If we are here, we are supposed to have CMMA enabled in
> >   		 * the SIE block. Enabling CMMA works on a per-CPU basis,
> > diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
> > index 18fb200f854a..739e8c23c3ae 100644
> > --- a/arch/s390/kvm/s390/s390.c
> > +++ b/arch/s390/kvm/s390/s390.c
> > @@ -2359,7 +2359,10 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
> >   		}
> >   	} while (r == -ENOMEM);
> >   
> > -	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
> > +	if (!uses_cmm(kvm->arch.gmap)) {
> > +		set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
> > +		gmap_allocate_all_page_tables_best_effort(kvm->arch.gmap);
> > +	}
> >   
> >   	return r <= 0 ? r : -EFAULT;
> >   }  
> 

