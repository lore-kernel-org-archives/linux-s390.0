Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B203AF654;
	Mon, 27 Apr 2026 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280514; cv=none; b=M/8z0nWVKQiTQSen9tlPqmS5Ef1DKllqyBNzrypK0tEUjHTEKPQy0yUk5qfe7R64xKMMA+TeV7guHCU20ITCh4lIiBDFX3BtXkdOMxR3A1lpK8pLpPRE5bzWKXoAacm+FWUHOHU9ox9da1VaU23MaSX0Qh3NqZGPOY5GsZXF6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280514; c=relaxed/simple;
	bh=Mg71pf61utHxZKFAnjwlTlBKj56rqE7pzsQH05ujJnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMRdD9wYaNb3dsNo2uMU3OZeNNTUJFJuy2FqQutDMYo6G4XwS+d6y8CtlnqhH15am6/7LOpDbCjLM0N+aZqfELOM1/VVU/iDLPeXqz+DbPEDydICUsPPeafN07wkqFVlsKEUam2NjS4wKOHM0USWb3brAeAdmpklbpnrCMUR2Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DgStsnVo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DgStsnVo"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QLq49J2652173;
	Mon, 27 Apr 2026 09:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=zmk6DXmeTYCrC2/6PymHBcrqJO1bZE
	MLU2hVDCq6V40=; b=DgStsnVoyg2jmP8mzAEZ3VWAASgzbCNOBDmIydLGpwoaXz
	JSX0iJEGLHjjYabX0BGyO7JasE+Udqo+3RTHl3H+VPXQF9t++oDmdg2bZkIY4BnR
	VrQQXHEPCUXRaA+fbnEZqXdB31Jy6JArc4QQByhiJSoDLIf32V9bK5iFPGyQAI+q
	BOVBsvmhalb41CIZJMREu0GRjvwL/wGJt6IRtTT4WXuDcmNZmo7LEBEGMvyHlzvU
	JcxegxLUtxtZnT6mHDICyl8SqCvJII++JguqOd496OFOVDudzQ5a3iFHkmVPfrxO
	PkT8w5dqc7eGvWdQj9ZVyNW2LnwF/Bngo9mDQ9jQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8v6rdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 09:01:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R8rtP6004685;
	Mon, 27 Apr 2026 09:01:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy47ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 09:01:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63R91WsL41615756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 09:01:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1960A20063;
	Mon, 27 Apr 2026 09:01:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67E9C2004D;
	Mon, 27 Apr 2026 09:01:31 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.9.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 27 Apr 2026 09:01:31 +0000 (GMT)
Date: Mon, 27 Apr 2026 11:01:29 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped_walk: add missing pgtable entry
 accessors
Message-ID: <570e049b-1e9b-4030-9f80-d44162979a50-agordeev@linux.ibm.com>
References: <20260427052000.196402-1-agordeev@linux.ibm.com>
 <ae8g4jipQxQZRe6E@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae8g4jipQxQZRe6E@localhost.localdomain>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69ef25f0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=3mycV0Wr0ScokfTl4csA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: iS7_IKrtN8NgHGoW9hdwneOKkL3-MuLb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA5MyBTYWx0ZWRfX2/ZYHwOxmLxh
 zQAkT4X98mKyW2oZIYPOcL2usGOWi7JRQEKx0MsD06PG/sv5H+QOzuCFUdouxDLpowB+F9yuCch
 nkQhROnBSS27RopHrXYW/DdkYpA6YOKiz+3B1sSOyeshR2ME03kWAQNpwXxfvjKWY3T/yBEFXon
 v5E55O0xLd1sy+GyyFEy6mQrXFGRAfudaU8VbcO6VkGMxMkYPaUYDhOSBZqrsL/wzL8JDhSxEqz
 KZl0SgK6StWjvpW07dSOSSzynxrDgrwZtV6eDyQ6T5PuDv49Oae+mTNq2vg0ZOuQ78EJcAPBGFt
 XCFgtHwzxSFyGNAAxNax+ht4Y6RtBLupr/5w0XLs85IQStDHMg80rzVmJSa7GKXMR6eo+wWgL7o
 OGmAV4S61IFIublU7TTSIxwoerBVq/P8cSh5cRxqbzVNG6SoUhXFVnt6F80bZsLD4wdoXmn0PZD
 DcObcQLE0roMUwN5IOw==
X-Proofpoint-GUID: iS7_IKrtN8NgHGoW9hdwneOKkL3-MuLb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270093

On Mon, Apr 27, 2026 at 10:40:02AM +0200, Oscar Salvador wrote:
> On Mon, Apr 27, 2026 at 07:20:00AM +0200, Alexander Gordeev wrote:
> > Convert pgtable direct entry dereferences to the corresponding
> > pXdp_get() accessors. Use ptep_get_lockless() variant for PTE
> > reads when no lock is taken.
> > 
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > ---
> >  mm/page_vma_mapped.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index b38a1d00c971..a4520bb10d2a 100644
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> ...
> > @@ -317,7 +317,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >  				goto restart;
> >  			}
> >  			pvmw->pte++;
> > -		} while (pte_none(ptep_get(pvmw->pte)));
> > +		} while (pte_none(ptep_get_lockless(pvmw->pte)));
> 
> map_pte() might take the lock if PVWN_SYNC mode, or am I missing something?

Then ptep_get_lockless() would not be a problem. But if it did not
take the lock, then it is a problem.

> -- 
> Oscar Salvador
> SUSE Labs

Thanks!
