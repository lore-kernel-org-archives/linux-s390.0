Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CA23B9956;
	Wed, 16 Sep 2026 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550736; cv=none; b=tI8Wh9HqdyWwMaIod1YMgp+4b710Id9gz2p5Nv/znNC0KafN+8nfIo1EEiWHIQemw6TdfMCPEcUkzqCOzpfPNRZxQuaznkysS2DtrG9ujaJw30gmXgJofX8a5Wek4U5Mm+V83pV+MZAMx6gkE3fOBKpfgkRVXIhW8StdTlSVd04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550736; c=relaxed/simple;
	bh=iuXXbD7uxKDh3Ic6oulkLUlru98vRoGU6FlR9rDeiG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU1CPALlSX968/sGphd7+8+0wigiFs+HOwXc9V+QkZnnIPJ0Ydscg8fVGuAHQPkM/kSa4yUWd0KNpOb+nbj6F4zgbc3p+aj58LM58cnLR5Is7pv3SAUNUHAEN7rTcSH7fAaylPAHdO6+fTdVzibEMAv7WmS3W90xyzL0S7SqnSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ldIN66i8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ldIN66i8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLVe6i1951647;
	Wed, 16 Sep 2026 09:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=HZ+Ccevsvuty6HV46TCyBPDp7xS5D2
	OwvS5lkpCi+iQ=; b=ldIN66i8vpDl8fqfqbjs6PXetPPKso944h32ENdyEUBAxs
	zCgkX7x276q/nxizdxKzDbYIX/iLYzKCMQIDTSkNgEZQVURxGniql8F4gChoOZgb
	jMJsfx0eKtV7Q8wQSf1hrlxrGfm12R7pW+bRR7D9kpSxxYhfW3cWXKR7qNZWQMyC
	qKyrHXIlQAmXnXRRV1Wv3VP69G1KO5UwmL0Q/V3IrkVIjluOljeyFg9AgveB2NMO
	bgLBcnNK6Xo5uPz6eHDJwU7XEVt3siQkYmIl3yY/YIgl/xfFgnUyu1UmgLB7k7CC
	N6K4htIZ5fteMsWEXuEFUXRjDYTXF1f/JzIiNdmA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83ur9y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 09:25:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68G7eegd414559;
	Wed, 16 Sep 2026 09:25:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03bwkt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 09:25:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68G9P7hU27066864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 09:25:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA10A20043;
	Wed, 16 Sep 2026 09:25:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 423A120040;
	Wed, 16 Sep 2026 09:25:07 +0000 (GMT)
Received: from osiris (unknown [9.111.77.138])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Sep 2026 09:25:07 +0000 (GMT)
Date: Wed, 16 Sep 2026 11:25:05 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 06/13] s390/cmf: Use kmalloc() for the CMB area
Message-ID: <20260916092505.15587Ae2-hca@linux.ibm.com>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-6-e931086fdde1@kernel.org>
 <20260914175952.14910Fc6-hca@linux.ibm.com>
 <aqmQf-H4yeSnE2Ko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqmQf-H4yeSnE2Ko@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExNiBTYWx0ZWRfX69fUZptnnHUU
 LrrBMk4p73kYj02sbSnZri/y2AhmHbqevea4IIiaytd0Kq+FJB2PQ/W0U3wmgWlO5WFi+MOvuEV
 oEkveSBkpOAgaUHmMMwc9cmVp8KN+8BWe6xWmHtDXR56RAmVhCVE2H/SoEvTGpDwuJDvgpi+AFx
 1gaxDpuGfCuL+zHWZdN6sQ8fD0VLA62fTeKZA/UxwKXsdCAf802MGlJgVXmS6I3KmY1H69Ig4MP
 IBY2iq2h8QeCFiZ1AIjfBVlOVvjdoajgMYnvzd8MVWQ7DVVfmawNNRxMw51OJUDu+HO3MIsdo2a
 4gaPfomddxQooCUrBSxj4UJ0INoijEAxCcqOvMbUl0IL9K0lgruC89rzkIgzg+I+rNjrNTHIQAj
 cCOrgpq4wKQtRkZCNtWHbYG7/BfzZBJah5SI3vxXPlrkgBtvPjl/J4lpNLXtlEdOCEvw/HQUQw+
 zHKYMUNbh+94N9+NLYw==
X-Proofpoint-ORIG-GUID: g8mDs6ZcI7hyKXA-rqQ11cv1ZxLPEDED
X-Proofpoint-GUID: g8mDs6ZcI7hyKXA-rqQ11cv1ZxLPEDED
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExNiBTYWx0ZWRfX71SwQcJHROeH
 /6MGV/0cYTm5Hq6vhhaLZcR2912LzjWY7QKhUJzheCgdzmrVZzXwocHdeMDW7u4cJ1GJxlq7no5
 TVlSmYQKWN4NI5m5xCGkWfCaDzulRwU=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aaa6078 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=jh9rqw0bRQUQ3So_9I0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160116

On Tue, Sep 15, 2026 at 09:37:51PM +0300, Mike Rapoport wrote:
> On Mon, Sep 14, 2026 at 07:59:52PM +0200, Heiko Carstens wrote:
> > On Thu, Sep 10, 2026 at 02:00:08PM +0300, Mike Rapoport (Microsoft) wrote:
> > > -		mem = (void *)__get_free_pages(GFP_KERNEL, get_order(size));
> > > +		mem = kmalloc(size, GFP_KERNEL);
> > >  		spin_lock(&cmb_area.lock);
> > >  
> > >  		if (cmb_area.mem) {
> > >  			/* ok, another thread was faster */
> > > -			free_pages((unsigned long)mem, get_order(size));
> > > +			kfree(mem);
> > >  		} else if (!mem) {
> > >  			/* no luck */
> > >  			ret = -ENOMEM;
> > 
> > This is the only patch which made me raise an eyebrow, since the allocated
> > area is smaller. But it looks all good according to the architecture.
> > Since the allocation changed anyway, it might also make sense to switch to
> > kzalloc() and get rid of the subsequent memset() (not in the context of the
> > above diff).
> 
> I suppose separate alloc and memset() are there to save a couple of cycles
> when another thread is the first to allocate, no idea how important this is
> though :)

I don't think this is important. Anyway let's keep this as simple as
possible and just do the conversion without any further changes.
