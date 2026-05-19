Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4B0480DD1;
	Tue, 19 May 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190855; cv=none; b=lDfz+ZL91udlW2XcVAmaPAjuQq0Cn3aYsrS5wvyFUTWuxPAYUH2cFNQv0c0q0V+8VTo2tWNOAkSfc8Ox9kFhc3zS4+f6W2XpCd7S4qyHG9Hz3Ta3hLcDd+BXNvkhy9csi5LYqRMSYF8HXIFGkw+A6ZqojuQ4mTfTVOXT4Pm34S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190855; c=relaxed/simple;
	bh=kyiFPzg1yEuX7fIrIsL4JUwOf9SnadpUGGb4dEPBddA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWuyFrWhbS32hznnRWsl0cPydoDZ2WdkEHtsupw9qiIU4FW8mb7IyGwXSWz7lugoiJ8bYAVbcpJIuAEy1VssSXzjxeLSlTOV96TKes+R/hnpv+VK8kZP3VteFEWl+IXQ8CIxRiR1GksYvgpSgV/pAIEjIHuWRiEtyJJgA5QIf1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sm3bXL4G; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sm3bXL4G"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J8I3RP2789992;
	Tue, 19 May 2026 11:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ab2qjV
	U/WgMuSdEjT33ht+4d4EX1bIxfmIMDE0mtFw0=; b=Sm3bXL4GYA+UCCjeQylDmD
	i4QjytfrmjqIwwAy8ikEZlOhSV5nRjcqBilD7WEMq1k3B50a3rNFaxv7kEGKhEdu
	DdK6x1GSvFzv85WggaLl5CWGRtlb6IDvueudqDOr5nJFWD/UdaZMaxnM08tLoeDm
	LwH+a03/kIAKwdG03NI8zNhBfXPbryrlaAx+lFQJD4J98JNJNbYDJFKZ1Ecdrm3C
	E87Ucjs9Y31iKXfwk3PCP3eAOwhy1m41DW+vQhXROTg1wKRxDt9F2lgU2alhDfno
	57zAFgYokCndUfI56/GKasuIREPYYJT7FHW+6q8+Re81kgmnJFYzXKVoSXVit7KQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mmnuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:40:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JBd6tR020719;
	Tue, 19 May 2026 11:40:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk2c1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:40:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JBei6J46465336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 11:40:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2BD520043;
	Tue, 19 May 2026 11:40:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A396D20040;
	Tue, 19 May 2026 11:40:43 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.4.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 19 May 2026 11:40:43 +0000 (GMT)
Date: Tue, 19 May 2026 13:38:36 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: Re: [PATCH v2 5/5] KVM: s390: Properly reset zero bit in PGSTE
Message-ID: <20260519133836.0d344247@p-imbrenda>
In-Reply-To: <0f114ba1-72f6-4ffb-b179-01b8baaaec4c@de.ibm.com>
References: <20260512175251.300882-1-imbrenda@linux.ibm.com>
	<20260512175251.300882-6-imbrenda@linux.ibm.com>
	<0f114ba1-72f6-4ffb-b179-01b8baaaec4c@de.ibm.com>
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
X-Proofpoint-GUID: 56OoCYomJ7swpYka2fULvTz0x-V2nYgO
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0c4c43 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=lyqXx9i4DOjL6YLBd3gA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 56OoCYomJ7swpYka2fULvTz0x-V2nYgO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDExNSBTYWx0ZWRfX8OQvWwJUFlXu
 2PbRZF1BRJmj497Rhq9AlIWZ+WHTduUsqKxokziMDy9JHtVVIKg3axxOeF40X1ia8NaAw8jyR8m
 7rZ0sLQLhqT8el61R84kMnkeCXkb5iOX+9mry/caSW07y2lceyUrxDVcFGE9unzyNdnTxIE2FG/
 Derh7tMZ7IsJBrjJ+iQ5MSl6nqa2ib/ShPu8ybbeB4wGdUm+zUyheL58h94MHws5X+7PUh4766W
 zKUQLk/s2AxTqcAjQkcR8bd5Mzr/6dhv8Y69Bfm8Qjhh/CwEGPeFO1SIc1aZKdidgTPusAHEVG/
 BM+kFCN2za6NZ1QT3bSeWlI8CRUQnEolCTp8Th/dIQKuMMq4jyT/dDnxa2WPCFNJXC99m+vtqWJ
 ca4ApGT6Q6Wzq8lwM91sHfOd8axZUsdaVz6PpfHV9RZLPTxMYVFZ4CqFxcrhft/ZxqCpVyJwW4+
 CaaHghfM695ZeyfDDWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190115

On Mon, 18 May 2026 13:44:45 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Am 12.05.26 um 19:52 schrieb Claudio Imbrenda:
> > When calling _gmap_ptep_xchg(), always clear the pgste.zero bit. This
> > prevents the page from being accidentally discarded when getting
> > unmapped.  
> 
> Ideally have some example in the patch description, that makes review easier.> 

will do

> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>  
> 
> Was this broken before the rework as well? Do we need a stable backport into 6.19
> and older?

no, this breakage is a product of the gmap rewrite

> 
> > ---
> >   arch/s390/kvm/gmap.h | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.hcd R
> > index e490f2995a26..4de9ed8d58ba 100644
> > --- a/arch/s390/kvm/gmap.h
> > +++ b/arch/s390/kvm/gmap.h
> > @@ -199,6 +199,7 @@ static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, un
> >   	}
> >   	if (!ptep->s.d && newpte.s.d && !newpte.s.s)
> >   		SetPageDirty(pfn_to_page(newpte.h.pfra));
> > +	pgste.zero = 0;
> >   	return __dat_ptep_xchg(ptep, pgste, newpte, gfn, gmap->asce, uses_skeys(gmap));
> >   }
> >     
> 

