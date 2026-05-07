Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49763EBF33;
	Thu,  7 May 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165168; cv=none; b=T3yLHws/7N7mwWVZriVc4fxKrQv6FfkYlZuLJITWWDXGfomVZYve4RWVa8jyoPHhKldU5VROZ7ogYAqXNJGAw9GG5XhobKcH6E3MxWYkjTMBGqO5SpWwuP0qlkubCrlBd/9AFAmjWzjpeE5yZ8ZJCX5Mx2OnFvG9JQgbI+jWnzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165168; c=relaxed/simple;
	bh=zsln8EUjUrp5Y6kZ0XmBFTVQYogbFcejikGFaaGqhpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlXATJpVxLz76/41PC4NjxVZBtWeBKSGDNtWsL7VOFwGiWULesmMTeMXPcisHz290Jzr3KjPGNnMK+WkTYwVCXhjkJ0QQ/zgcr62mwcdgJgCezLtQntllOY+WFhWsJIKWpil0mYlRsDhqvkqAr5Iko73JgwmnisfxIO5neFDQ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MeFTy13c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MeFTy13c"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6478Jcmr1430407;
	Thu, 7 May 2026 14:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0Xv0dW7QA7aR72GysqLQaU7vnlwOTf
	o3+3pktQ9PXhk=; b=MeFTy13cY0ezqwH/ff+yXbPH+XQaGVfycV7hEnubrv2HCG
	xFqy5t3/Ag1ps2IGrgxSRuQ2pUZfIn5O+WBr1oCjk6cdio6SM379FFrudhuKGWT/
	NYGoHEnUVYH9zTP9owgqSw9NnvDp283lE04Z+Qewe4cGOWuzxVfv2zTJRle8c+Mc
	gevW7J/LQz3lrH/CMWZpCrWFGTK6tiKwSIiy720A2lZBio9WyjKKbQvwd9EWHWnb
	rANx7RXZYBB66r+/mtpiVGu/I4TPm2xWqQtUVZLScQpxRDmalNxam9dAdgKgBc+z
	bzd2UVtNpOP7QWADeN+apC9CPzvQfh6CJH0+CaMA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxx4ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 14:45:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647EdXfX018964;
	Thu, 7 May 2026 14:45:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywc5ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 14:45:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647EjpoR41484646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 14:45:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 401862004B;
	Thu,  7 May 2026 14:45:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08FE320043;
	Thu,  7 May 2026 14:45:51 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 14:45:50 +0000 (GMT)
Date: Thu, 7 May 2026 16:45:49 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 3/4] KVM: s390: Change the fi->lock to a raw_spinlock
 for RT case
Message-ID: <20260507144549.10395C64-hca@linux.ibm.com>
References: <20260505173728.160562-1-freimuth@linux.ibm.com>
 <20260505173728.160562-4-freimuth@linux.ibm.com>
 <20260506045734.11230A02-hca@linux.ibm.com>
 <d39c54bc-1984-490c-9457-5eff63edef56@linux.ibm.com>
 <20260507095630.10395Aa0-hca@linux.ibm.com>
 <191a1272-1f8c-4a67-a01d-abfdb89fcaf5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191a1272-1f8c-4a67-a01d-abfdb89fcaf5@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE0NiBTYWx0ZWRfX7N9XFplgW1Vm
 KZzV/wzDRa4s6FVdB561WMV0B7mFwuGO0+DsgPzWjUewpKklGnTz6bDEWPQu1R+z0xq48bTCphU
 R7ow36DBXpcBlYNpExCWMdSIPejETTnEkFYJh6fu2tmWNnp7WL93EiCx6S7a7hRGXHqRipX4ARG
 u/Wbv+un/nrP8GSjB6/yxLg90e4dHFVES7NYP59fIoTImoeihPBTjVzvnMEi1quDatEPbc53P0I
 DXf9YM8o5Hi8kQhpdrsm/lRMKMh6ryHcpN3sHJoVh972QuD8wnRwHm9NTb9KwKj4KyC5RmN0NEe
 +xuI8AHvOx6lDBnIKRskVzwUcUZF3QFGGlhe1yp+WU4bRWpTZo34RnfyG2BNT3liD3yjeBqgiwq
 keTnqhTfF/9xr+511tts68JgnBc1tFlRFJ3PIgTgN89MxttJ6xIOuGDXHFUFYgZKSFh+wndnRJ0
 oUfsErJ5WuUD8njpTkQ==
X-Proofpoint-ORIG-GUID: msGEYSWoF07yEm-DgxMnoWNaW50W5Lc5
X-Proofpoint-GUID: msGEYSWoF07yEm-DgxMnoWNaW50W5Lc5
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fca5a3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=xHHe0IzHDxP9u7eThjsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070146

Adding Peter :)

On Thu, May 07, 2026 at 09:17:00AM -0400, Matthew Rosato wrote:
> On 5/7/26 5:56 AM, Heiko Carstens wrote:
> > On Wed, May 06, 2026 at 10:50:52AM -0400, Douglas Freimuth wrote:
> >> On 5/6/26 12:57 AM, Heiko Carstens wrote:
> >>> On Tue, May 05, 2026 at 07:37:27PM +0200, Douglas Freimuth wrote:
> >>>> s390 needs to maintain support for an RT kernel. This requires the
> >>>> floating interrupt lock, fi->lock to be changed to a raw spin lock
> >>>> since the fi->lock maybe called with interrupts disabled in __inject_io.
> >>>>
> >>>> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
> >>>> ---
> >>>>   arch/s390/include/asm/kvm_host.h |  2 +-
> >>>>   arch/s390/kvm/intercept.c        |  4 +-
> >>>>   arch/s390/kvm/interrupt.c        | 68 ++++++++++++++++----------------
> >>>>   arch/s390/kvm/kvm-s390.c         |  2 +-
> >>>>   4 files changed, 38 insertions(+), 38 deletions(-)
> >>>
> >>> s390 does not support RT, but I guess you are referring to a lockdep splat
> >>> which you would see without doing this change, similar like we have seen at
> >>> other places.
> >>>
> >>> Can you include the relevant parts of the splat for reference, please?

...

> AFAIU it is only problematic if we (s390) should ever want to support RT
> in the future.

I don't see that coming, but nobody knows what happens in future.

...

> My original thinking was 'well, it won't hurt to use the raw spinlocks
> in the new code' so I set Doug down this road with my review comments --
> I did not consider that there would be a need for additional fallout
> like this patch, which means increased chance of regressions (see below)
> to accomodate a feature that we don't support today.
> 
> If you are saying it's OK to simply not care about RT for s390 now, then
> AFAICT it should be fine to just use s/raw_spin_)lock/spin_lock/ for
> this whole series, drop this patch and then ignore the subsequent
> Sashiko complaints about RT.
> 
> What do you think?

So... after having given this a second thought: we do not have
PROVE_RAW_LOCK_NESTING enabled in our debug_defconfig (either we missed it,
or somebody (cough) thought it is not relevant for s390). That said, I
believe we should enable it, fix all fallout and also make sure that new
code does not generate any lockdep splats with PROVE_RAW_LOCK_NESTING
enabled.

Rationale: even though it is not relevant for s390, we also change common
code; and by ignoring PROVE_RAW_LOCK_NESTING we might cause problems for
other architectures by introducing incorrect nesting of locks in common
code. So yes, your thinking is correct.

Peter, I just added you to cc, so you can correct me if I'm entirely wrong.
