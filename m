Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80AE42E8FF;
	Thu, 30 Jul 2026 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421441; cv=none; b=F2N8uyaWRoTerKa4kNZr+9+drs8Tf8ZYjESnxXYhEx7aN93hxE0Xt2/3L8KU3RWG3QU5pELa4EZpOYFut7EAfPXchHr/LAjhOY+chX0I914ZvYcCBRdJNFvq8ODMU0XS8mjupJENtqdvFgabZLS1RZ08TMWGH8N5toEJQ6nJuEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421441; c=relaxed/simple;
	bh=OI6dq33/Q4l/nnb+PLn+wSKXEVCHSmx2hrKTyOKn/XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyG0SQZ4y5Bk2eEFcgpx7MGcRMGlKNsy+rmFAVfHgW420vT8vcDf+RO420VfXcWiYk+GaHQf/xEuZntjazo+a09HNuFwGlM8qR3/2y23Nhx6LVF2II1nvPcqK4RMxlMPLaWO8JeSBbUBoCQfqusQ+cWSWSj80zZItUQDJ1iwgC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eOxrLJzk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eOxrLJzk"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDHmtX3020818;
	Thu, 30 Jul 2026 14:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+pSaXKeKui7lgV8xvFgdoEVP4Iv19L
	4apeUJB3lQ7cc=; b=eOxrLJzkCIvuC1EtVN8PYb9n3ht5A8QKCty6485kPUXmy8
	F7FOZO/XfeRHP81SD3oWw7TOGnYvE9xZ3FzprLT1bstSY9op4ZsG7H5J/n2Z3qpk
	G39qMjSNc9B+QoBKBCWxb6PjTVcE1D6sNtqEq3F9K5+sv2VHbRIq59lkBxm3qeS7
	GR7a/kPudEjSJrYmTU2P6h7dhz3iV1q7BqEn1BoIDoH6xjffNYs9sB/5MRlQQZSS
	UVvNLRbokCaM1WlggYi9xlpaiFHNf5GHplwgw0K2YC3sFHLBgvxY6fv+Ymf9uHGA
	SC30er5drbhw6lf1XJ+I0c/duf/17hB9jfGMnKcQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nyabq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 14:23:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UEBJoQ013233;
	Thu, 30 Jul 2026 14:23:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhkmc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 14:23:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UENkUD16712180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 14:23:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6837F20040;
	Thu, 30 Jul 2026 14:23:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAE1020043;
	Thu, 30 Jul 2026 14:23:45 +0000 (GMT)
Received: from osiris (unknown [9.111.22.102])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jul 2026 14:23:45 +0000 (GMT)
Date: Thu, 30 Jul 2026 16:23:44 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Bradley Morgan <include@grrlz.net>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 2/3] s390: Implement arch_do_panic
Message-ID: <20260730142344.70140A38-hca@linux.ibm.com>
References: <20260730-arch_do_panic-v3-0-d5401e683cdb@linux.ibm.com>
 <20260730-arch_do_panic-v3-2-d5401e683cdb@linux.ibm.com>
 <20260730115445.18059Aac-hca@linux.ibm.com>
 <f11500d0-4605-41c6-836a-510801ec6293@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f11500d0-4605-41c6-836a-510801ec6293@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwOSBTYWx0ZWRfXwlsoQpjNQPE+
 +rnCfD7U0/L6da0T3ZjuajjHk5StLGZY+cFRy4cJmjeKdUYXKHnnjkLuZBHuYTLO9xZatg0kc8I
 V8BgB5/LrRjSIl/xnqSLw9t6zIkyXic=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwOSBTYWx0ZWRfX+vCh3kb6SHXC
 vLKwBs7FIX+srubg0wiR1Tk2MhwsmK6FfnIDx2zZv31VYUeMEgn/WEFC4pB9ibqnA6HRf5+nZx2
 8DuXugy5PhSuNQ3idneHKs036/llZ5zJWkViih3UYdpPTuqFxM0xeO+//l8/niyo9QXRzu/NkFJ
 T/LKiia2uG4peSH9Q++JT8yR32E4P9DAzw+qgIGKnd9iaEzhyPL5qH9HX6SqWkx7X+WaPbtanir
 BjZG3f8P2/j9gsmvo5UjVPgB01GrvQX6Sq1cV76y24CVg7Qt/xdUJl781wYYiOrSKL9kfXBRfAo
 6+10+yXvxUsFtrHpaQGntXLw17x87rmbp3/fK1ljFBBJDHzfLqal+9EevoNy4FfpZX1m38311oT
 SYkjIWZGqhZLNgai3CpN7uS3n0Ze2jUDa2KR8pMVXHY5baNMIALCC2TzWxeLihsqNWGfYW8lq8+
 h8q2RNTeMeEPAYoWuFQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6b5e77 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=TTVcD_D_EiJ8kuCfl7wA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: hYdfYg4Xle9IZDIfqTL9zftjHnt4z1zu
X-Proofpoint-ORIG-GUID: hYdfYg4Xle9IZDIfqTL9zftjHnt4z1zu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300109

On Thu, Jul 30, 2026 at 03:15:31PM +0200, Mete Durlu wrote:
> On 30/07/2026 13:54, Heiko Carstens wrote:
> > Question: why is it desirable that panic_timeout takes precedence? The result
> > of this change is quite surprising: if anybody (e.g. a distribution) sets
> > CONFIG_PANIC_TIMEOUT to a non-zero value this completely breaks "on_panic"
> > behaviour on s390.
> 
> panic timeout can be set during boot or compile time as you said, so it
> can be used to determine what will happen to a system if it panics
> during boot along with after boot. Since panic timeout covers a larger
> area I thought it should get precedence.
> Being able to choose what will happen on panic before boot is a super
> power IMO and would help immensely if one would like to boot an untested
> kernel via kexec for example.

Wouldn't it then not make more sense to add an s390 specific kernel command
line parameter which _disables_ the notifier entirely, and then you get your
panic_timeout working?

Then you have to explicitely state what you want and don't get suprised by
subtle semantic changes.

> > I could understand if this change would result in a larger timeout and
> > additional information being printed, but not that it breaks existing and
> > actually designed and desired behaviour.
> 
> For that to happen users have to "misconfigure" the system and try to
> use both panic_timeout and a custom "on_panic" action. The same goes for
> kdump, when kdump is configured "on_panic" actions are ignored silently
> and system always dumps on panic.

This is really not the same. If setting panic_timeout would disable something
else that would be surprising at least, especially since it never did before.
