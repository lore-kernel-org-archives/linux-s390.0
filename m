Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEB135201E;
	Tue, 19 May 2026 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190873; cv=none; b=ZfimkFJ9AAHk/nQftVMwFI/oHcdo2oHtAw55ji+71BRieajPcH00WE+9hqncDo2aD5gKFF5a9FaslHBZ6zQlRVZ4wdRN2DMOT0XdT1yzQYRJs2KKMcUOd1xabQjJWvHgCsneFDbrzlAOTEH/7YCQSTvFbwSR1IXGtXp30xvnpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190873; c=relaxed/simple;
	bh=R+9WYga11ti31QesE719nM772KdQaqIuXMLtUR+/EII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5bARbLVk+SsY8pkBw5aUCpDFQAa8h2duSTrv+HxLYKI6yPI85+OtZMbE/GP0EmPsMBTP61Xeb+EtLykO2dPAlcufJptZd4H4P6TGRMp62vrxvPl23vAbstE1LV4ZkbUT1lx1ktmuAGFJ/n5ntd4Xx4pcotgPGSWDo1MCLFOB80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NiJ5A6sQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NiJ5A6sQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JB34LF3464297;
	Tue, 19 May 2026 11:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lrlJgW
	pi52CODVwB2FAw5yvQ0x4R7OUAC3FeQXBxj/M=; b=NiJ5A6sQokdb8k/S/h6vvm
	Xd6VcNuLSn0Xmwtnhz0GvU/NsmI72Ra5Qh/7/9wX4bDFlZxogUKGEqhbVSm5Qu33
	+FoBTbT6Sndqr0w68MRQz+gWDHCRlt81QNrvCdoa7hL9jJQ6FEYJCf3l4qUzB96C
	LkIgTwMIGFx3+p4pfcuWYhNgfKbCVSRqmUdaqHgbaL1UTLyDTJW3aYJ4BVgI6RPh
	iv3Ckjm2pHyFjRo4sqPHjjxLy+4bdExDWwWMCzmlUg9KcvO9ehcF1VT1DfMUy7wi
	lsNRWdwsRylejlCM3vRmWNP5GkQV+1zIJiKfHrrCGkE3H3EHCwXgWN3TGkCckvJA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74vprs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:41:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JBd6FJ008357;
	Tue, 19 May 2026 11:40:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq2jd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:40:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JBemqF35324182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 11:40:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70C3B20043;
	Tue, 19 May 2026 11:40:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8592020040;
	Tue, 19 May 2026 11:40:47 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.4.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 19 May 2026 11:40:47 +0000 (GMT)
Date: Tue, 19 May 2026 13:40:25 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: Re: [PATCH v2 3/5] KVM: s390: vsie: Fix unshadowing logic
Message-ID: <20260519134025.54bd501e@p-imbrenda>
In-Reply-To: <15cb5a1f-4342-4d24-81ca-9397f3f83288@de.ibm.com>
References: <20260512175251.300882-1-imbrenda@linux.ibm.com>
	<20260512175251.300882-4-imbrenda@linux.ibm.com>
	<15cb5a1f-4342-4d24-81ca-9397f3f83288@de.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0c4c53 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=5DatlnN7Cv2tYkhk1M4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: bf-Xj0L73GQacLQS9o7_xKAvpVQy3omH
X-Proofpoint-GUID: bf-Xj0L73GQacLQS9o7_xKAvpVQy3omH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDExNSBTYWx0ZWRfX77mkfnjD5uQh
 JDK0W74ceDD7ZvVOC37Ygt3ttU8s3Gkbql8vo52R+n8SOpp8SELwO/DJH7jCP2bdnYzHg3VBb7Q
 74/eIpIP/wwqyNCtxOW1kBf3cl4Sd7+m9XX8i0OJSGdHUi5rLet8EP+csl+71qFo/SooRRZQHYD
 6kyBOqDrONdMqQ91sbVpgSYXO+cDM+T6LztYTx8smaFxIsBEtkIMknqBRBIZRLnpAf8gMxrCN1e
 D55mF7LKgfrgfxsasK63e3htDdXHmhPPvpHSDpoZqIjuu8SFHiZAhk0dQoRdxqpYwS672eqCZGe
 /5XyErSHD5RcPzYg1bjSaD6b5Exq7G8FRsfpPjX676O2Sdk9rJoy14CfMVF1FCyJ6JbyEpvlheL
 /0TXd3zy5DFKyfj/f2Y9d8kbo/cPAbdGLAgP+p7zbJfTMdN35+0L6+FEjuLsE0Lkcch9yzIzJMX
 IhiEBkFNUrXLvK3IFjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190115

On Mon, 18 May 2026 13:28:44 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Am 12.05.26 um 19:52 schrieb Claudio Imbrenda:
> > In some cases (i.e. under extreme memory pressure on the host),
> > attempting to shadow memory will result in the same memory being
> > unshadowed, causing a loop.
> > 
> > Add a PGSTE bit to distinguish between shadowed memory and shadowed DAT
> > tables, fix the unshadowing logic in _gmap_ptep_xchg() to prevent
> > unnecessary unshadowing and perform better checks.
> > 
> > Also fix the unshadowing logic in _gmap_crstep_xchg_atomic() which did
> > not unshadow properly when the large page would become unprotected.
> > 
> > Opportunistilcally add a check in gmap_protect_rmap() to make sure it  
>                ^
>    Opportunistically

oops

> 
> [...]
> > +static inline bool pte_needs_unshadow(union pte oldpte, union pte newpte, union pgste pgste)
> > +{
> > +	if (!pgste.vsie_notif)
> > +		return false;
> > +	if (pgste.vsie_gmem)
> > +		return (oldpte.h.p != newpte.h.p) || newpte.h.i;
> > +	return !newpte.h.p || !newpte.s.pr;
> > +}
> > +  
> 
> The newpte.s.pr part is new and seems not related to the vsie_gmem change
> but I cannot find anything about this in the patch description. And I dont

it's part of "fix unshadowing logic"

> understand this part. So either some explanation here, in the patch description or
> a comment maybe?

I think a comment explaining what's going on is the best option

> 
> >   static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, union pte newpte,
> >   					  union pgste pgste, gfn_t gfn, bool needs_lock)
> >   {
> > @@ -180,8 +189,9 @@ static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, un
> >   		pgste.prefix_notif = 0;
> >   		gmap_unmap_prefix(gmap, gfn, gfn + 1);
> >   	}
> > -	if (pgste.vsie_notif && (ptep->h.p != newpte.h.p || newpte.h.i)) {
> > +	if (pte_needs_unshadow(*ptep, newpte, pgste)) {
> >   		pgste.vsie_notif = 0;
> > +		pgste.vsie_gmem = 0;
> >   		if (needs_lock)
> >   			gmap_handle_vsie_unshadow_event(gmap, gfn);
> >   		else  
> [...]

