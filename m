Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F83F0ABE;
	Wed, 17 Jun 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706809; cv=none; b=Ns+XNOHe9n8DK94GutHXZXAlvXN4QEhcGPchy31hiRUCvnAf/ZbZsL1VaEcbSD432ie3nxApDFeVW/RVAddnR26FrnKj/Z+LkrHiwXzq7s56nXncWCCoqgm4sFJzHxjNlP4c7syQXEKHpvYNdixmPaByuLS11YTd7lsAWYclIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706809; c=relaxed/simple;
	bh=jXeSOh4VFenwYT2HWgIbLc3nk8iGxw2IneJSDPFqXxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDpCLcRoRaHEscSbvNXpQD9T09TCCUTx0wMpcKEXK3vyQInlff3nGN5sgLBCTaa1Eaz2JZOKojbzplk16HtTk4aaAEaT+eoyBwl97UoqKDVl/LkTPv8F7swyw/SRjDQOwNw/z0W+17LUq01fIe5TS0SzO/8gcj36GiVJvAG8Qx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T6kvJK5u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T6kvJK5u"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HEJdlk556632;
	Wed, 17 Jun 2026 14:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rFh+1K
	SkcqGDZrCLLyOIzHrEzvKXhWwVpK2D+D+7gPs=; b=T6kvJK5uEm55zFh0RQTf9x
	Ppi5gJx/meUlSn4eSajjDMITRNui7/cUxCzB3yX8YSJb962meJcJNXp5t+PafZAA
	yNAUJV04Y47w6KiEowI05NrNPui0rcDAIrNlNIEgtU/nM1meDkFniOicVJCHyfxL
	SwU55v8HLkalesI4vJhlr9Hmf1FLaUeCjFTApK1zS4wDNCEtcZgAwTZHJjGWJ6oo
	g8bQpFJRfaBzcZQUggFIBwWyq4bK4sSm4yBIZ2KZOBJ6x8RXHwPh9oEepMg+qRAA
	56ifXWqVIuyIwQjGG0c9Vpwgj3pP/LJYsqTm+wXGCVu+bS/5WrSY/aFbpiOM3iUw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxbbd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 14:33:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65HEJvVh023370;
	Wed, 17 Jun 2026 14:33:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva3juv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 14:33:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65HEX8x645875464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 14:33:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 285D92004D;
	Wed, 17 Jun 2026 14:33:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F025620043;
	Wed, 17 Jun 2026 14:33:07 +0000 (GMT)
Received: from osiris (unknown [9.224.90.220])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 17 Jun 2026 14:33:07 +0000 (GMT)
Date: Wed, 17 Jun 2026 16:33:06 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/4] s390/idle: Provide arch specific
 kcpustat_field_idle()/kcpustat_field_iowait()
Message-ID: <20260617143306.104264Acd-hca@linux.ibm.com>
References: <20260513140129.4100822-1-hca@linux.ibm.com>
 <20260513140129.4100822-4-hca@linux.ibm.com>
 <ajKsG0JP6qTssQBX@monoceros>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajKsG0JP6qTssQBX@monoceros>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a32b028 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=c3-jOVFDwnkSs0V34ZgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEzNyBTYWx0ZWRfX8/73Ogej09YL
 Lw43Rj6fyIERk3ZXjRRubV9rmtx3NIMIScd4tJOip8ci8Jg0SXTJaaFMLUQDxNYgQn380oMSAYg
 rH1cULv7qNF+8nWYc4ccJ6dCOx1l4wK2e/7EghGfkT47YaRqAwcPkly3wqMF0qcpKZzoU8W7s3f
 fzR5NQ8kDA7YGoEb0u1WBSUCS94DhdpT/XGySAyFhokJHvm+QrnvYglgT7hdPnt6MjHwPmPUJuU
 uBcJQYn6C93mowIOJkwiKelVfH8qWlVcEsr5KTSTA8GMvzQiuybqtfORLf0/bRhNrFUAo8k7JAQ
 B+QIA/siMTVCm1ITGnef3h5+HA2qSUXqjWhl3XI7Jl0grcW5OQ0np8MPel8iw5SsMsLywLu3SKW
 Hwe6UjaVkelH++RXNWQqjkxkM5r7Op+Cjw+WBdf2Mk4MCX40zi42HV4ExDZtDPpmjBx80fRfJa2
 R3EGxuUpegFFcUhfzQA==
X-Proofpoint-GUID: FpHC1GfyEBalZQd1-M1PBcE-lU-___FQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEzNyBTYWx0ZWRfX86xjepYZ236x
 Uzr7z9kyH5wpPBOyo3RaC3ef6IuBAJlJlTpiU+FR0+8nVog8XcZoaCcj2hCpYjSa5OAy2zsu1Ap
 HBm0kx5TDXcBAneQFarSFqAMni55D54=
X-Proofpoint-ORIG-GUID: FpHC1GfyEBalZQd1-M1PBcE-lU-___FQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170137

On Wed, Jun 17, 2026 at 04:18:14PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, May 13, 2026 at 04:01:28PM +0200, Heiko Carstens wrote:
> > The former s390 specific arch_cpu_idle_time() implementation was
> > removed, since its implementation was racy and reported idle time
> > could go backwards [1].
> > 
> > However this removal was not necessary, since independently of the s390
> > architecture specific races there exists the iowait counter update race,
> > which can also lead to reported idle time going backwards [2].
> > 
> > With Frederic Weisbecker's recent cpu idle time accounting refactoring
> > kernel_cpustat got a sequence counter. Use this to implement s390 specific
> > variants of kcpustat_field_idle() and kcpustat_field_iowait(). This is
> > logically a revert of [1] and moves cpu idle time accounting back into s390
> > architecture code, which is also more precise than the dyntick idle time
> > accounting by nohz/scheduler.
> > 
> > For comparing cross cpu time stamps it is necessary to use the stcke
> > instead of the stckf instruction in irq entry path. Furthermore this
> > open-codes a sequence lock in assembler and C code, which is required to
> > update the irq entry time stamp to the per cpu idle_data structure in a
> > race free manner.
> > 
> > [1] commit be76ea614460 ("s390/idle: remove arch_cpu_idle_time() and corresponding code")
> > [2] commit ead70b752373 ("timers/nohz: Add a comment about broken iowait counter update race")
> > 
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> This patch became 670e057744e0cc8047bf96d15d18c46e16ae2e93 and is
> included in next-20260616.
> 
> s390 allmodconfig fails to build with:
> 
> ERROR: modpost: "arch_kcpustat_field_idle" [drivers/leds/trigger/ledtrig-activity.ko] undefined!
> ERROR: modpost: "arch_kcpustat_field_iowait" [drivers/leds/trigger/ledtrig-activity.ko] undefined!

Ah, looks like I missed to add EXPORT_SYMBOLS(). Will fix.
Thanks for reporting!
