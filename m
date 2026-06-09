Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3C83264DE;
	Tue,  9 Jun 2026 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014474; cv=none; b=Rjz1NyX4PFMEE84GjguYoF2HXiCVLKcBjaFm+M6eaZhKcCTw/W1P9V3sR8Tg+1EUPmvRJm2Tazs/w5AEiCHO4xt7HQRY3avAm04GcpA4z112iJSP0x/p4vOjPIfnCe7m+vSMP65UNj82KM1Rfn1qwx9xEVZcy8dWx33nfERCVJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014474; c=relaxed/simple;
	bh=qX/L5XEwLN5iF1idpVIZod92wfeI1hQ2kQXAa+ytyrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZKXo3EVPtb89VfBc9CZomdX0d6cRePES4tGqvohM3/aB38UOJPg+eMjtPeRzhmMBqHfdQFyDflpTAy7TEmfQaLEre2IXGRZ39anUpJY5gk9Qk6zTY1oMeOAd4AdurRcZ1QkH6Aq6mjZwbuDoTBjEkMuiesk5ZEscVqysZXpc9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YI3kMwQG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YI3kMwQG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65917d1F2560492;
	Tue, 9 Jun 2026 14:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EzyR/k
	PcSy3KtlDTTxNkqDZuLkjY8R98lY53k50VoNE=; b=YI3kMwQGuxR2mT1E6mWUfQ
	FREoir44H03EjT76mjxPp6WxjIn7UjU2uPEOhT6SHfwADm+ZwmHVNhniTy4Ahcsb
	8TUKB/CSRsYyU0WwTB7uGQMGCpa3wAhTgT88FFE7EmDfkejNzs9fohmO1wiI/6mc
	tqtjKFJmKtiplg6PVkEYUgI8oSYHACokgJachhN/kJfmbVs00ZomPY6l5YVDY6c3
	/069YL+4Kj0wzd7XTtv+n4xc3kyqqL/kZmdUoczUnsMLIGnwdbeeT0S6EtSQdMXI
	G+/pO343u7oaYeLDYgQdrLOnfwfKSJPSdq8FKkwviMWQjd/H9fg0vA0hPmqoV7mA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qmhby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 14:14:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659E4n1u020473;
	Tue, 9 Jun 2026 14:14:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjta6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 14:14:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659EEKbI15991212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 14:14:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA20120043;
	Tue,  9 Jun 2026 14:14:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 513C620040;
	Tue,  9 Jun 2026 14:14:20 +0000 (GMT)
Received: from osiris (unknown [9.111.52.116])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Jun 2026 14:14:20 +0000 (GMT)
Date: Tue, 9 Jun 2026 16:14:19 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/4] s390: Idle time accounting improvements
Message-ID: <20260609141419.9217H39-hca@linux.ibm.com>
References: <20260513140129.4100822-1-hca@linux.ibm.com>
 <20260608075500.34400A04-hca@linux.ibm.com>
 <aigbbZW9gah401Y9@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aigbbZW9gah401Y9@localhost.localdomain>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a281fc1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=1zixJbAZZp2u0mOtzawA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: S0vH1Kq8B2eGjWmqxjrob3FEu7ZTiu0T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzNCBTYWx0ZWRfXxvvCD7pyNf1b
 6ng0GHNwvVChSgbpcw/7O8m/VHkFLC07tHbBhYMs6uuE6lY1Ab5GvNwziN+unbu4v9v6XTn3H2C
 rv/ZEaZCpz9zgwjCeIAtHx4wBuPedmanrFrNcOV6RL4004ySqoTVSTDNVzQ2BlgAiwyDh0u6ekE
 kfGj926i0MTGsBjcSZy64wvjPRQU4eWmupXMPXpPBYD7Y9R/E5Ggr1eMRF1ElthUK3ZqI3Y8iR7
 1w60+wZf4GYJFLZwDHqDsysvWbocXptmYffBYbbcV/4YkCihm+R+NXQhOFHTK4XUssj/Dx9zQ1E
 xmvdZ5DRrl54l7OSMsC6m3rjSBakPBvIF+QL7Z5CrkUpbgeJmdpRHoyFLwjrESiZXtRC5BMRXHY
 ww/rhywmX0sFqPHN3cvCw30mHOoGyOjM3+YXDRisAN9WFDx94PKUwXkjx0CTYI8PWDRYeG4r1a0
 TVc2NGPy9lgIB+ggetg==
X-Proofpoint-ORIG-GUID: S0vH1Kq8B2eGjWmqxjrob3FEu7ZTiu0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090134

On Tue, Jun 09, 2026 at 03:55:57PM +0200, Frederic Weisbecker wrote:
> Le Mon, Jun 08, 2026 at 09:55:00AM +0200, Heiko Carstens a écrit :
> > On Wed, May 13, 2026 at 04:01:25PM +0200, Heiko Carstens wrote:
> > > This series is on top of Frederic Weisbecker's idle cpu time accounting
> > > refactor series [1][2].
> > > 
> > > This is supposed to improve s390 idle time accounting, and brings it
> > > back to the state it was before arch_cpu_idle_time() was removed from
> > > s390 [3].
> > > 
> > > In result all cpu time accounting is done by the s390 architecture backend
> > > again, instead of having a mix of architecure specific and common code
> > > accounting (common code: idle, s390 architecture: everything else).
> > 
> > Thomas, Peter, Frederic, any objections to this series? The third patch
> > touches common code, so I'd like to get an ACK for that.
> > 
> > If there is agreement, this could go either via tip tree's timers/nohz branch
> > (series applies cleanly), or via s390, after the nohz branch has been merged
> > upstream.
> 
> Looks all good to me, thanks!
> 
> Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thank you!

> I guess ideally it should go via s390. Any chance you can push this to this
> merge window right after tip:timers/nohz is merged?

Yes, sure.
