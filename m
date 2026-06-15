Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23B33065D;
	Mon, 15 Jun 2026 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524217; cv=none; b=Bl4oWCzIlsljORN0YDL7hhRSggjUMhpxyEJKjMWFqRarU7QxpHu1YA60S6aXn7DztACRlil8gwwTTl/Algq/SVa3HTj0Jqg1k+qMM5I3Q2VB94Kv9du4qaJBv3dHDMxSkZyHTDP1g3+cR5ar+rA0jzRfDykyxeX2YMvwpe2sock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524217; c=relaxed/simple;
	bh=0dKKc3ld23rgr39SkexU7JH1a1YHzSiyMn7wyfdxNDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2TWsAs88r6VCGNpX+PjOSXByX4Gg/csUPdlnZ7wnumDCrtiWwRnRSO0NJAzXTuoCRplJH0qFJ93X8zmjqBHChcZ94YE1zV7rzKaB7Qs8vKNsgxQqCjdT3sq/mXlYt+Wrai/gAewtCFIFsHDCJic8dnlwb08R/1vB/g7QbWFEq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LHrLrR28; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LHrLrR28"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAqW7e2233272;
	Mon, 15 Jun 2026 11:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Lvsxy/Fmbv3ehJkCFf8TSiSZf6+Ko+
	PafLSFmgei1Zk=; b=LHrLrR28H3WZd4KeUSA1H4O7MbM+FjH7UKScUHCPvAfX1Q
	zUcHwDHsQUvFi8nll1DbAc4tY6wP5OLYWA9TLLr5rDVST9qHdI6P+84zVOAetXPl
	12K0QNXwAj3Au4XL1eMIJCm7kJj2u3E5BOkXVaLN74TjU+/s7IA33T+VDIF5LT9N
	v+6JP8FUSTZByEmtGU9XclU0nvP6+f5U79lCZQpbqt15l+q+dQSLtR23Uj5nAoJh
	TzSbFLYUFCUGCV1jyJH8rxeuNc7HJeoFbQUqaw8EjPLp8xu6ErD2LlhKnarE+vhg
	PiilkhgVGknzmZ/Xo3MJO07NrlupoY5eUldxtJtA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v27tv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 11:50:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FBnbxK010264;
	Mon, 15 Jun 2026 11:50:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1gxabp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 11:50:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FBo2pj51118552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 11:50:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A98D220049;
	Mon, 15 Jun 2026 11:50:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F22F120040;
	Mon, 15 Jun 2026 11:50:01 +0000 (GMT)
Received: from osiris (unknown [9.111.80.197])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Jun 2026 11:50:01 +0000 (GMT)
Date: Mon, 15 Jun 2026 13:50:00 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390/mm: Fix handling of _PAGE_UNUSED pte bit
Message-ID: <20260615115000.31370Ef1-hca@linux.ibm.com>
References: <20260615091741.76724-1-imbrenda@linux.ibm.com>
 <20260615091741.76724-2-imbrenda@linux.ibm.com>
 <20260615094300.31370D7a-hca@linux.ibm.com>
 <20260615123103.118af04a@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615123103.118af04a@p-imbrenda>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEyNSBTYWx0ZWRfXz4L9zh2iFVRL
 wMByOKkFR1sy/cLD2r7atGOoDTyygmf7Ldwbtp9Ldqr3PlPuHbR9dTLompITD3tq6JgPZW8Q3xq
 18yjTszRcpue8vMvE+UkiKInTcu50Z8=
X-Proofpoint-GUID: 0ep69pgvSHeSdQaNH-B-5KWRQ8hdtpMi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEyNSBTYWx0ZWRfX5zX7bHWlzDDd
 W5ET+OOc0lrMnESKm6ZUBbWRm5vgAHiqYtdRtlpnMwDn0nWB1MRN9VY06Za1yn3jnaiTmIRG0xp
 TgjPZ1MmuxyXNfT8YBFeYicdY5Zr64UpeINgJSVV46RcvT6PzbvLxsGBLfoRCy+eyycPITm/7uV
 joxrPlNPObwp0v7mflue1JsxhFMKKKVN6MBYgAyMRpU7jgOnV85FXOl2duZ/xIjOS2+DySp8m4b
 sCMBC0KiKGKSgRyvwxpnRY00AAIeZSMvMtV2HAueKuzJo5yVPeTH7DqqLcR6h1/k49h9dJKFasZ
 1WQDp9cotB13oGYN4HGgsE3ZsAwey24cFCmUqGlQQBAiY/GzuQ2rl7BHBmSCuXDH+/xuBWSAsH+
 ZODr2AaHa/IayKa7tl1pEARmvnR421mm1P4V+oePUYWEjqap+w1U+3x0ZTKHHndqMQSidsSKMQP
 tOEyPEcg8I9/GSaCW0w==
X-Proofpoint-ORIG-GUID: 0ep69pgvSHeSdQaNH-B-5KWRQ8hdtpMi
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a2fe6ef cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=eJsfp5Q3Ls_MATEj3MsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150125

On Mon, Jun 15, 2026 at 12:31:03PM +0200, Claudio Imbrenda wrote:
> On Mon, 15 Jun 2026 11:43:00 +0200
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> [...]
> 
> > > @@ -175,6 +179,8 @@ pte_t ptep_modify_prot_start(struct
> vm_area_struct *vma, unsigned long addr,
> > >  void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
> > >  			     pte_t *ptep, pte_t old_pte, pte_t pte)
> > >  {
> > > +	if (pte_present(pte))
> > > +		pte = clear_pte_bit(pte, __pgprot(_PAGE_UNUSED));
> > >  	set_pte(ptep, pte);  
> > 
> > Can't we move the logic from set_ptes() to set_pte() instead? The above
> 
> set_pte() is also used for things that are not ptes, and in those cases
> we probably don't want to touch that bit, although technically it is
> currently unused for present large pmds and puds.

I can only see huge_pte_clear() for this.

If that's the only user I'd rather add a BUG_ON() there instead of starting to
sprinkle the logic around. This _will_ break sooner or later.
