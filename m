Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96547F3C0;
	Wed,  7 Oct 2026 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374520; cv=none; b=RnyqGuQ4WQsV6fdA22G25OmWsbYZXLMcCdl5Wp13NBOkNPrIZ9f3+7wbxa2GzB8i7EbQbJj1PtR8XE9VQpTCEaIfVswVj2eWAUftmQ+bbh4Qu0pyCxGkmq1IraEh/e/0ctvzsgARDBa3Y3yG4bfO2OaMNapdDVw3EgEH7twbYK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374520; c=relaxed/simple;
	bh=x5rx1rEEQjX09/gIBm60rmF6eOyN+ppzro2QQXRgW6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us2kvk2XERQDX7rHpzgrhRdM/lFvC3q2TMXTSZSkNx2tIfksSzpNkWdj2XfIeRylC+XN4z8bx/NxLLWJlYDyStNmd8vXwvNQifkjlwMEMMYcm1FYTr4yN0EHlJXsAUPoXIa8VwORB5h998C0+rNZ2zqAnXy/RU6nQnPairig1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QeXVJsw2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QeXVJsw2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZuaO596960;
	Wed, 7 Oct 2026 12:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OP9cKi
	egW2Sf8OrzRJeLPIAdX2vJcSikge4+88IDcVI=; b=QeXVJsw2jUm3BkG4C8LpDF
	xIXbcsqvdDzzuifuO9Nz0YZe9ODp6qVOB0QfxVZXLUTpVocjq0502lzOiQjupeaX
	hdcJqTCge5Q2AqOgZpEQVq/OsteaheeCdYGa3gn4ghosGwoLM0QYMlFZGWmt19h0
	WmdtVbWrYWso0l3NGcoO1jKKViH/pES7HoArQ0G3fuKnLZUbx7xiTMTAlyzNEYFj
	1hgqBkH2mMbcvXCpXMLUsod+7jhDA+ZGVCAVLv23HJEE9vDDiNEY5WZYq1iinMK0
	m/GLJw0qPR4kyxXCqtcLhXgTcmhrVCVQGETzBuuNz6xmU5T3pQZUbTa/JmRgkM+w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrn7xs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 12:01:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWjxV567659;
	Wed, 7 Oct 2026 12:01:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3tsd34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 12:01:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697C1fGA45089256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 12:01:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 471D120049;
	Wed,  7 Oct 2026 12:01:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18D4F2004B;
	Wed,  7 Oct 2026 12:01:41 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 Oct 2026 12:01:41 +0000 (GMT)
Date: Wed, 7 Oct 2026 14:01:39 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v8 11/15] s390: Distinguish hardware and software PTEs
Message-ID: <39e41d74-c4d5-49ca-8dd7-01e292eadb5c-agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <c22ed0a2d9ff0f4fff69a17332a377c460d993dc.1791365932.git.agordeev@linux.ibm.com>
 <sashiko-outbox-162958@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-162958@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfXxrKmjSizp+FV
 z3P70sgry06WtyMJPrhV36qKDwWIzPRurbo6o8hHgv0LvPVmvxuDWtAzf1s2P/1iJUJfIXj5Oh+
 BBKtRYvHOBV22uJiWNNMk4ktioCl2/k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX0kUPLKV5BaDg
 Uxjtj2Bo/wgrC34toY5QYihw80JOcFeQyyRIJtxmn8E3PR1DvkxSr5YN3fi9B0vvjvsL9tNUHz1
 lU5Wo+338a6+RnkXrVSm1+zTpjtXJXXj7hsv52a+Buh2TnyDNlEIgLbVo122Sp/ac9Cc+9pCnH3
 o/crrOJNR8hp36vX1kmQOwRm0ZmuYcXiV8TyBe11195cDsbN1t8eE73KmgrJTxDDArrszvy9VIa
 yTknE4iPmrOJ47X1sojjkz+5IlnJJKbt6ZyeSM7fOSLCs8qDStax0w5FgFG5qlSu4NGYOYHmo9N
 daCCGlFixftjSHk5hxi/1lUG1Go+LfRf8OucM73LEND0/UQjrMIzDWsCoJ1IHI6uUSvNm5iUVHz
 7LRGwULKR3dJ7XMIvZobfINbOveoKPgUs8RGRxzlWOcOejaYjckONKt2xMUPrki1Rqtmy7jZYBI
 kHR4asI1i0kVBJg56Xg==
X-Proofpoint-GUID: zuHljY0zcu9Y246ZzLJ9dG492wVdRNce
X-Proofpoint-ORIG-GUID: zuHljY0zcu9Y246ZzLJ9dG492wVdRNce
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac634aa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=zseqTb3Fjr7VJKUAxi4A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

On Wed, Oct 07, 2026 at 11:57:13AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] s390/mm: set_pte() discards _PAGE_UNUSED clearance
> --
> 
> commit a9d06a7ccc3dae14aa4eb7e5a46302fce251265b
> Author: Alexander Gordeev <agordeev@linux.ibm.com>
> s390: Distinguish hardware and software PTEs
> 
> This commit introduces the hw_pte_t type for hardware PTEs on s390,
> distinguishing them from software PTEs which continue to use the pte_t type.
> It updates various memory management functions and callbacks to enforce this
> type separation, similar to ARM64. It also enables the ARCH_HAS_HW_PTE_T
> configuration for the architecture.
> 
> > diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> > index e882663a58e77..c47264f3abf21 100644
> > --- a/arch/s390/include/asm/pgtable.h
> > +++ b/arch/s390/include/asm/pgtable.h
> 
> [ ... ]
> 
> > @@ -978,17 +978,19 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
> >  	WRITE_ONCE(*pmdp, pmd);
> >  }
> >  
> > -static inline void set_pte(pte_t *ptep, pte_t pte)
> > +static inline void set_pte(hw_pte_t *ptep, pte_t pte)
> >  {
> > +	hw_pte_t hwpte = (hw_pte_t) { (pte) };
> > +
> >  	if (pte_present(pte))
> >  		pte = clear_pte_bit(pte, __pgprot(_PAGE_UNUSED));
> > -	WRITE_ONCE(*ptep, pte);
> > +	WRITE_ONCE(*ptep, hwpte);
> 
> [Severity: High]
> Does this discard the _PAGE_UNUSED bit clearance?

Yes, obviously. Sadly, not to me ;(

> Because hwpte is initialized before pte is potentially modified, the
> WRITE_ONCE call writes the original snapshot to the page table, ignoring
> the update from clear_pte_bit.
> 
> If this _PAGE_UNUSED bit incorrectly remains set on an active page, could the
> hypervisor (z/VM or KVM) reclaim its backing physical memory and cause silent
> guest data loss or memory corruption?
> 
> >  }
> >  
> >  #define ptep_get ptep_get
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1791365932.git.agordeev@linux.ibm.com?part=11
