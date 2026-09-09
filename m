Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0065F559CB5;
	Wed,  9 Sep 2026 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960098; cv=none; b=HFiHKg+WSuTt4/kgiuXJ3eH2AOS12gBnN40oDk7Utn/wr/khfBKlG5YFFiEy/YKxz86wPL02R2h9v4SrMTz5ng5QMrdtuA7lwZnuguLTVmHrRITR143EY5WMddjTOGaiZ286fGMtIAK/2oP1Lr1MsVy9SwL85xKsECeSMnrcn8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960098; c=relaxed/simple;
	bh=u8dyLA9JPYsPT+S9BptnxRwVQjYZUg5aluZCUjRhLUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xx48lvnIDXSZs1nq2iA7pVoGfA1HWUKCp51ZbQICBXwxxn3+e9N4h/Nbb1nR1nGjPYpdek768KWvUFcWRDdMMa1/4XyyqkNLDJ1vHcfNTIwP6WKVhMeuDEvWeEaQ6W1nxzYXOZi6xgYYJU4F5bWUJvsM2CF4CmBDvCoB1tbHeD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EuCpZHWy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EuCpZHWy"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1Xnl1930793;
	Wed, 9 Sep 2026 13:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lwnt+u
	IwVb2GPV+2IM5Jzk0YcZTtM/PdaaHHgmqpX98=; b=EuCpZHWyn7am7j+RkZ0lW5
	5Ib81wwbDMz/LSR/XcnaNFSi3mqVhO82c9KGxDWz/4ALeb5Vy+ogDgqgOo6FFIZM
	ZBPTyYmQ6EVzttWWtOAIuzjDZAOdts2Rw8gh3y+ivt4iTFO5ZO6DXSCF0t/hIqbF
	thKv4uU7997K9JcNgpawg8T6Jd/ukleWXD1AXMuTUMEG5OND/1DPARIuONQt6ybF
	alJUHwEeuBnnbWmatZjFWGEOriERQCt46H17TnSASNUPdOLXBIOEV1yr/jxhO9+O
	TJWRfK5K4iQUOo/5QRj/+Eay11NaQsiP/ab0ecttPcaCzrqjuDOgWQ902/SdSg0w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqk60gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:21:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689DBEbp001065;
	Wed, 9 Sep 2026 13:21:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgj9p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:21:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689DKwm341746858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 13:20:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20A462004F;
	Wed,  9 Sep 2026 13:20:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B217220043;
	Wed,  9 Sep 2026 13:20:57 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  9 Sep 2026 13:20:57 +0000 (GMT)
Date: Wed, 9 Sep 2026 15:20:55 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand
 <david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Jonathan Corbet
 <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason
 Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter
 Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Mark Rutland
 <mark.rutland@arm.com>,
        Nick Piggin <npiggin@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Marc
 Zyngier <maz@kernel.org>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 27/39] mm: rename is_vm_hugetlb_page() to
 vma_is_hugetlb()
Message-ID: <20260909152055.475f053c@p-imbrenda>
In-Reply-To: <aqFDKJlj76O1hR2R@gremlin>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
	<20260908-b4-mmap-prepare-vma-flag-sanify-v1-27-dacf19cce22b@kernel.org>
	<20260909130141.2c5d250d@p-imbrenda>
	<aqFDKJlj76O1hR2R@gremlin>
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
X-Proofpoint-ORIG-GUID: fVmbucRpDXqYs95uPJn3gAtDgliZy_hJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0NiBTYWx0ZWRfX+XnzXV+hr28g
 E90nFzP6XF6ZObxAKEAUq1J0igT86F5x1TgyrAzYp7vCkC8fmorxhzNCOS9hnE3ypA1Hfc1ne4e
 aMiCHHlgUtwe2xnc8kZenLByslkkWcw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0NiBTYWx0ZWRfX/6M5OJCe5NLD
 NxNf1sIDRWa0GW/z4cn108sE3iVT/OK9ygEDgpxSQg8V58ZWikgcUGzCXHlfKE/kWNHqCHhb0f9
 buRoc1LWTrP/k473nMF0Qiac8/8LDJig0CEQOJUBS12AV/AZzPMgAdNAnUaFcHzPJt74KU7l5vf
 l9g+WJ5QfiKvrKPEb5/97swi4uTbHQVmrJCjCC4kqBdjtTIdvAxu8iwX5lYdVme8+LMbIdzHOc8
 NFnCacTVrOsWSqK+i/4n0TqDqFgpdTgsCJ9YBcJTI/JUPJZlE//xj4ZQqKGa1LX+S58V5svWn8J
 fSmi3TSboWlhHVfjhSRq66Ud/KkI7BzU9s8cZI0+WqqEknXSI6u77Tzemji4/eUnk/ETKWi/fHy
 yYk7Y6cUXX641skzuPwB+CyfseK1jlyQmSYKtBaz9jt/4La/RTyJQTzybmVtGVJzJoM+STiLCAI
 d5rfAK+vLixTZrIqF/A==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6aa15d40 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=jmM3fxk_Nj0IWXPWY-8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: N2JLtHebNUOVPKb7AWQq_VfpI8BmxIJj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090146

On Wed, 9 Sep 2026 12:30:45 +0100
"Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> On Wed, Sep 09, 2026 at 01:22:07PM +0200, Claudio Imbrenda wrote:
> > On Tue, 08 Sep 2026 21:01:31 +0100
> > "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> >
> > [please note that I had to prune the CC list quite aggressively because
> > my SMTP server was not happy]  
> 
> Yeah sorry about that, I already pruned the list a LOT from what b4 wanted, and
> still ended up with a ton of people (I consider maintainers for stuff I touch
> the minimum cc, but also added mm reviewers).

yeah I did not mean to fault you, I understand why the list was so
long. mine was just a courtesy warning in case people reply to this

[...]

> > > @@ -247,7 +247,7 @@ static int __gmap_helper_unshare_zeropages(struct mm_struct *mm)
> > >  		 * proof to catch unexpected zeropages in other mappings and
> > >  		 * fail.
> > >  		 */
> > > -		if ((vma->vm_flags & VM_PFNMAP) || is_vm_hugetlb_page(vma))
> > > +		if ((vma->vm_flags & VM_PFNMAP) || vma_is_hugetlb(vma))  
> >
> > Would it be possible to replace this ^ with !vma_can_gup() ?
> >
> > (obviously not in this patch, since vma_can_gup() is only introduced at
> > the end of the series)  
> 
> Sure, I could squash that into the 'use and apply vma_can_gup()' patch. Will do
> on next respin!

excellent, thanks!

> 
> >  
> > >  			continue;
> > >  		addr = vma->vm_start;
> > >  
> >
> > [...]  
> 
> --
> Cheers, Lorenzo

