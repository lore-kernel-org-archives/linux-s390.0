Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692613E5A35;
	Mon, 15 Jun 2026 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525391; cv=none; b=X1bfiRKGilAN3sROI2uAizEPVz7Bw+N0XuYHP5rhBr7TLqjQrdQfRB+nhsi0MhZRZvmy+GO2SRgBkBNwi+UfIouzhtxPzlmiRH8/oB7gmJrCMJp+XqE/Z/BZadaj1bN0nZLMwXzyqaiN4hkt+5O5xK/T4VNwnf+KLNjXenzecEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525391; c=relaxed/simple;
	bh=I+7zMw/VQBRB5Ny0GaAiRVMkJrtar/Iq0dTJJ5p4Two=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qugyb7di2DlJ9MRWtRrISiirOHhGrKFx7RYBriaHg5c5LdSumITl9RZoxvquJbpXRCk2tc+NDpxH1A54mwMD0v8w/Hd0aF5PiqL/gxopzIt+zDHkt+mg9AcHL6l8WhN3fqZDIwLWWyCPChCFHhcO2bmlX5C/gYTbFHoT1mufukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hH2SQpQh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hH2SQpQh"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAoO1a2256088;
	Mon, 15 Jun 2026 12:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jDVz+2
	0ctJhiAnjmyFpAJFmtExYdla1ebcMSf08pfoQ=; b=hH2SQpQhMS0xGIiBUTXV7i
	m7ojZ8GtKxjJhTH8Y/wTalA/UJCgh1+zlIqHMFYMN6irKDcBBrI0wIxC2BIChxnS
	4+0TzfYVfZdZ9rDMj7bGruUFbRZuswCJ9cl9cD5BL7AJBQL4L2DjcEXPQdEDyrbE
	EbnCv6gmgBZbIGhzkdxjMXW2BRpFFgnOK68OHcT8m9akYoLvyvUXQvLYVVsI5Bfm
	p64TfY8MQisjwJHiL5DGg3o2RxhspOlBfpl6K5VVqV/cHXt3KiHT2uC9sL1DJC9Q
	Ls0QVLrbHFITQCetvftQPy6+mXQ4qOKdS/gqpbOFLDhbVFxqUoESYyna97foFP4w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h80f5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:09:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FC4cQm005551;
	Mon, 15 Jun 2026 12:09:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvxhyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:09:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FC9hQV27984156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:09:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44BE72004D;
	Mon, 15 Jun 2026 12:09:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5419920040;
	Mon, 15 Jun 2026 12:09:42 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.111.70.232])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 15 Jun 2026 12:09:42 +0000 (GMT)
Date: Mon, 15 Jun 2026 14:09:39 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390/mm: Fix handling of _PAGE_UNUSED pte bit
Message-ID: <20260615140939.417dcb53@thinkpad-T15>
In-Reply-To: <20260615115000.31370Ef1-hca@linux.ibm.com>
References: <20260615091741.76724-1-imbrenda@linux.ibm.com>
	<20260615091741.76724-2-imbrenda@linux.ibm.com>
	<20260615094300.31370D7a-hca@linux.ibm.com>
	<20260615123103.118af04a@p-imbrenda>
	<20260615115000.31370Ef1-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEyNSBTYWx0ZWRfXyeWpgJZISb0J
 xjwvzVJeiojb7kW97wHJ9nd/xLGiG3gqLaxg8iLuWTuwxEAtEyy8VitvXGu74RIzwP95Pbubwlj
 /mQFVgxTewTtYaLCSmym+JS1nD45HME=
X-Proofpoint-ORIG-GUID: JGhFEVBocsT56kfI0JBcWN-EUMx3vjj9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEyNSBTYWx0ZWRfX22ngjSzVketu
 hjuW4GniyMnS5YP+aqblp57vgJ5ZdgngcWKT2egG6Yni4aPvf4eDsIIrpODa9gRC1FSrE0Qc5QH
 ICEC6WPG9f7Qg7PHAGXVVD9dZeUrxASnoXTM0HlVNtE3e/1C0+u4RAKcyLbf2DUikkZvdWWy7c7
 vsVRiuCLhwBpS6YxFq4UsNtOMKRuEwXTgq6mAVBfCsSPgE8ckPJ4YMS8gcVFNDvfPh9k2PBBlEX
 6vezBONr7ekcvBZFcZTxdC0k056xY9ytHoi8tzx18Cf7ox5wzGoituK/D9yWhfWXqQTM7/K5VVL
 5QvC7LVYIKaBrNHSpo7Wh5EXds5nvRPb8WAIpuSvt3NDsO+Z350Qfo8gK3Yv+mQabnPJRj1yZt+
 zZVfiWeOA4/d97TBKWrb4TRjPdZwpFdrvLGiFl4fQXj4qDGm46zQgULHl/MKFABLGdqrVVZ0xAW
 SQyCdndCnGMQ9IW94AQ==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a2feb8c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=cMrbAMyVcAHaeXL1GCgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: JGhFEVBocsT56kfI0JBcWN-EUMx3vjj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150125

On Mon, 15 Jun 2026 13:50:00 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Mon, Jun 15, 2026 at 12:31:03PM +0200, Claudio Imbrenda wrote:
> > On Mon, 15 Jun 2026 11:43:00 +0200
> > Heiko Carstens <hca@linux.ibm.com> wrote:
> > 
> > [...]
> > 
> > > > @@ -175,6 +179,8 @@ pte_t ptep_modify_prot_start(struct
> > vm_area_struct *vma, unsigned long addr,
> > > >  void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
> > > >  			     pte_t *ptep, pte_t old_pte, pte_t pte)
> > > >  {
> > > > +	if (pte_present(pte))
> > > > +		pte = clear_pte_bit(pte, __pgprot(_PAGE_UNUSED));
> > > >  	set_pte(ptep, pte);  
> > > 
> > > Can't we move the logic from set_ptes() to set_pte() instead? The above
> > 
> > set_pte() is also used for things that are not ptes, and in those cases
> > we probably don't want to touch that bit, although technically it is
> > currently unused for present large pmds and puds.
> 
> I can only see huge_pte_clear() for this.
> 
> If that's the only user I'd rather add a BUG_ON() there instead of starting to
> sprinkle the logic around. This _will_ break sooner or later.

There is also __set_huge_pte_at(), and there it could also be called for
swap PMDs/PUDs, where bit 56 is used. But they would not be present, and
ATM we use the same present bit for PTEs and PMDs/PUDs, so it should work.

Still feels a bit shaky, but in general I agree that it would be better
to have this logic in a single place, like set_pte().

Also wonder now why we use set_pte() an not set_pmd() / set_pud() for the
hugetlbfs "fake" PTEs. I think at least in s390 code we could switch to
the pmd/pud variants, and then be safe against modifications from set_pte().

BTW, wrt Sashiko report that just dropped in, I also wondered first about
ptep_reset_dat_prot() using set_pte(). Not 100% sure about the exact scenario
where/how the _PAGE_UNUSED bit gets mixed in, where it shouldn't. Maybe
the answer to that question might even show another fix option. But when
changing set_pte(), it should also be fine for ptep_reset_dat_prot(),
which requires that the PROTECT bit is the only HW bit getting changed,
and _PAGE_UNUSED is a SW bit.
