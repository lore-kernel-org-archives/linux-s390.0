Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A026F2A0;
	Thu, 27 Aug 2026 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787830813; cv=none; b=hAJQT/vMgCSotnbc5Ev1D6rTaMkQx8i9AZtOwKb2zPudVcg/pwhoyGDoB0FFR9gAiU7XQ4A0NS4d/QZ8NhNJhj/UrezsG5KujIhDOMZIQ8jQ/X8HOwVKBMOV/Sw6vnLCzGsqUQpnRUFm8cl+qqBKjG11lm4w0Jrr+xmeb+KcmJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787830813; c=relaxed/simple;
	bh=OqDOEbxXgcC1UcXKIjK3CW7An3vCFYmUhfaZcxZukDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCSICMx7gvB0NgiYSVjyguzlrC/N9DtB/yxMLyebsvlswXdI7oX339T1SpPAr/+RRuO94iq71GeM8RMw/MZhS77XPFPN8rxsu06pphrHqCml3v8S6HhvkkvtWENozNMVXJF4EYvpkSyedXTZ46+eDD5Va0/qFct3iK8S12J46hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W7mcRDur; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W7mcRDur"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9WGC0732911;
	Thu, 27 Aug 2026 11:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hft1u0fMlCKnLKkYrKeD/za/SEhliP
	K6FjjWQWyvfYM=; b=W7mcRDurVpXKXB55mZGGe9La6bZgDc9lYciMeMiu2rbJXm
	KPA+TA4sg4WXgIFJ71KTTpEWnQ1vkTBvu7DxAGc/NxJWwl3UHVyevDeJsiqrlxV7
	2EamppUEs5WVo67b7Re2cKaD++JZxLOjnh7QhqmymLWUvFzu7rbuYbNmu4m/dQ1c
	im/2FBF1UciQ/pd54cUcX1/lkCsEfAZ7YM5rMO6mkvf9XM3HEezrv2JOAICbeBZ8
	YmOfA9PvilyNzksC06Xe294rBuYHY8yA75nmNVp6XJRl/HJsb+/jsi5DCvVIwn3R
	ZZAhRMtm914O0AhSqn+k+Dp62TyD1rub3a9H+fdQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er4yt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 11:40:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RBQIuc017201;
	Thu, 27 Aug 2026 11:40:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qg0yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 11:40:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RBe1jT53739786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 11:40:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D24620040;
	Thu, 27 Aug 2026 11:40:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED8FB2004E;
	Thu, 27 Aug 2026 11:40:00 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.20.232])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Aug 2026 11:40:00 +0000 (GMT)
Date: Thu, 27 Aug 2026 13:39:59 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v7 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <b0d59b27-8d15-499a-aced-e5b247ed40c1-agordeev@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <d7fd78377a7278108ef501cf76571e80caef5968.1786956464.git.agordeev@linux.ibm.com>
 <20260824104048.11040Cdc-hca@linux.ibm.com>
 <73a0a916-b39f-4ebe-bffe-448928b13bef-agordeev@linux.ibm.com>
 <20260826130257.21444B1a-hca@linux.ibm.com>
 <87a3147f-e993-4629-b0dd-a54aefbf20b1-agordeev@linux.ibm.com>
 <20260827081156.3869103Abc-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827081156.3869103Abc-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: g852VGYQV57aImlgpSXSr7lgSbZAjYga
X-Proofpoint-ORIG-GUID: PCitcdLPSed0qO_DEQY_0xyJ0WeyIiyY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA5NiBTYWx0ZWRfX4RPE8U9cgIV/
 uZuXvUy2N/OSt5fdeft120XXFoPOeSxq5mpMTDWgjf0B8YgADiHIcbjHZ4d3enc+6hgg2ZdaA22
 /oxqlpOQDunoOSzqq1pwfpw/wYgCvgnG30Y8fyVZ0hHqtzqMQ3AKtMZwInH5/PieUY5qeZxeZUi
 GjTBjWqHhjVpB+ljhHKEUPQtGqbVJd1Wv8jw8DhkbvsAgOwlo0u6HHGKoNqrpqwxZD9cPA99mrH
 GcldPPcYeKBJMvQVs15E0ibrP9zQUIep9K6BcwPD/YCFfpoGQDL7vS1q0+T++Cbi/+4EFZwky9y
 6JOc7E2ISFoErUjxCYV4F0dNlMVcd24A8TEEry9Hw73Q66ANksoAKbvtGQGDvAMlWXQnX9Sa2Wl
 pLEcUaFZkxAWsGDH8cKyUFEY87SB+fzA9qsupKVgNKEuExEhjzdDRcaN48i/3SGLMS+o2tmatmg
 QlQFIb0RGCnJ1ONr38w==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a902216 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=uroAWBtYYZKLiyjPLxIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA5NiBTYWx0ZWRfX1bqF5R//rcDX
 7ajB85l0g5erJqSt1ReSbQbS39Zs89KlZJ/9gb+NpHGL7zgLBfqHpWSzJpaXn9HXvBWElJEBFuX
 DgVmsGff+ZojOtGlo8JcEbBsJvhNQ5s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270096

On Thu, Aug 27, 2026 at 10:11:56AM +0200, Heiko Carstens wrote:
> On Wed, Aug 26, 2026 at 04:34:25PM +0200, Alexander Gordeev wrote:
> > On Wed, Aug 26, 2026 at 03:02:57PM +0200, Heiko Carstens wrote:
> > > Would be nice if we could avoid the not so obvious local_bh_disable()
> > > and local_bh_enable() pairs.
> > 
> > Calling ptep_get() from BH context was certainly unexpected, but the way
> > local_bh_enable|disable() pairs are used is actually straightforward.
> > This is a slow path anyway, so I would think the simplicity prevails in
> > this case.
> > 
> > But again, I will try to avoid that.
> 
> I do agree that ptep_get() being called from BH context is not what I
> would have expected too. But then again, nothing prevents people from
> doing that from irq context too, no matter if that is sane or not.

I am currently looking if any interrupt handler does such a crazy thing.
If not, I hope it would be possible to nail this requirement with the
maintainers and e.g. add VM_BUG_ON(in_hardirq()) to ptep_get()/set_pte()
implementations.

But even with BHs we have an interesting situation: calling ptep_get()
from a BH while in the lazy MMU mode is actually a read hazard. IOW what
I hit looks to me as a bug in generic code, and one that looks very
difficult to fix. So staying with local_bh_enable|disable() would be
still a good tradeoff.

> Imho the "final" version should either be implemented that it can go
> without disabling bottom halves, or, if that is not worth the effort,
> even disable interrupts, just to avoid other surprises.

Yes, that would be the last resort.

> Plus a comment why it is needed, please.

Sure.
