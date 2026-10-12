Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9359947AF6C;
	Mon, 12 Oct 2026 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807688; cv=none; b=Bk3y/f5Q/3TBxe7jhK36bylKYsInHd8PPDP5Y+zqX3coAOWJ0IsKM8c0BUod9tvRpg6NA4mSQttVhfl9Ofewf5m3jK1epBKRYzt9Zw0jkiiGVM74soXZ9coteib5Dl9vXtAvPBQwuXz0BgY8fz2ntmG2FZcgoR/0mZyDvrjPgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807688; c=relaxed/simple;
	bh=a35ocaL31wbmKYzUvkg4JUUM94aCYQhTIWtGS4k2I5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFcqdBsu+uDrfT0lsu50rG19kc/NA8UeU+C/ckY0AyMJNsAvbaWVx7IWxh+SixG7eDuJsT+tSLvD776J2OskRRYNIdT7wobbNoctjoWJb/uhngiYxQ52BOFJAUcDi0DAZ9aChbNx4KDR9lSpYXg1g6gT/KHiHDCprKHZTNoLpZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VW6VZAaM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VW6VZAaM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEdHO231696;
	Mon, 12 Oct 2026 12:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FDv2fRxFtGuOZ6oTW2p78C4pgmWvur
	vBPpEdBWSnJSU=; b=VW6VZAaM8OVyDlS2GwoaWebYQw7bM5mHskv6NZf2oA/TcR
	723Qn57poJW5YoGVJoz4HVSGgCUL8EJlww5Mxcua9z8Y4G/VkccYFeuMyTVzXY/N
	utPOLLZv4K/FtiKyQgggXxiIc325igUCZhZga52hmrEuXN6IHVnNzDTNipe9blMr
	kLiR/lImz3iDqWmMZhXhipWUpuaZPjXvu1pNeh5ZtpZ/qYELcdMjmBLdHA2k9MRU
	ea0CGUvcGuewBTOFtSb28B2Oy+sBSCV7cF9+gAhH828fvH82yDeebNLm9qHSmamz
	YGi1RNLNfFNuVeJJeTp/rRHtNmSlVCubtokA96CA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w0f2r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:21:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4uxE013441;
	Mon, 12 Oct 2026 12:21:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfvw88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:21:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CCLM4B40894872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 12:21:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BC1820043;
	Mon, 12 Oct 2026 12:21:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CA1620040;
	Mon, 12 Oct 2026 12:21:21 +0000 (GMT)
Received: from osiris (unknown [9.111.15.154])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 12:21:21 +0000 (GMT)
Date: Mon, 12 Oct 2026 14:21:20 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 03/32] s390: Clear pt_regs flags field
Message-ID: <20261012122120.19350Cf9-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-4-hca@linux.ibm.com>
 <c7915254-f6d4-4dc6-8e90-2637bfd75a77@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7915254-f6d4-4dc6-8e90-2637bfd75a77@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfX8vzdGzHZuffs
 EQW8hLwUm7zCnPIp77wEBQExlJ21jRHsQhatfwHHGBS/mVM9Ta9O6l5Q9oSUJcXTmkF2ViqrSOU
 maG1aY2XFhiFtN8hpHWqIjbbUWnGuuE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfXytoIUlSlY4pf
 SfHZRhJxV2Ov+/i83OvQJjSvIsPuPP5bPT9Vjn8IAzHbasnT2bj5FhSLg40emhgnitq/ENl1Zs1
 g73F3NAiMCURm5yxh7x4uMISziDd+nz9b7ZZnji7eS9lQoZZMZnDVgybNkl/71Hxp19TYel70Ts
 gXTx3N0waod/NpJZ8Kq95B+VbfmxlngAtogQicWtmSUhccWjGQfKUy1s8TnEXOKr9QlrKGO9Puz
 mlnCV0e5QRqD3Fkz6fgf+AhqXPzyMAZXBzz9duzCmVZ8FB5Lfc7nhYAiV4UWlv2/0jNAOlDcdv0
 Z3Rr/M1/s0gamXWKj8i4MG6sH13Ptw+FumkwTOLzputPXYsKBYHufLP6rJRQVRC3y7UZGlj5R9H
 yk61WaYs9LMvTsCT/a9c08ohsilVeMM19FjoeApo6m1oioW3Q2A11UuQ1OCcNuw2qh0IDTUUA7j
 xUwlmo0ELTr/SmD92sA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6accd0c6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=e2fcsRMGdPZ525QvWPYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: cUUOoFTsRPSsVt1iFbGwNkrgTxX4n-7I
X-Proofpoint-GUID: cUUOoFTsRPSsVt1iFbGwNkrgTxX4n-7I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120048

On Mon, Oct 12, 2026 at 02:15:39PM +0200, Ilya Leoshkevich wrote:
> > diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
> > index 1fc153d8385b..b8e3c065fbec 100644
> > --- a/arch/s390/kernel/early.c
> > +++ b/arch/s390/kernel/early.c
> > @@ -154,6 +154,7 @@ void __init __do_early_pgm_check(struct pt_regs *regs)
> >   {
> >   	struct lowcore *lc = get_lowcore();
> > +	regs->flags = 0;
> >   	regs->int_code = lc->pgm_int_code;
> >   	regs->int_parm_long = lc->trans_exc_code;
> >   	regs->last_break = lc->pgm_last_break;
> 
> Just for my understanding, why can't we do it in C for all handlers?

We could - it is handled inconsistently currently, and I used the
existing pattern. This could be cleaned up as well across all
exception handlers.
