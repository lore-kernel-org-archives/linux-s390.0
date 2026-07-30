Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4F4014BB;
	Thu, 30 Jul 2026 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412503; cv=none; b=vF8X0xqMmu+fUE4ozXyYCFB7B8n+6ClGYka4icJuM4WWOsK5OU9Weip1fCqNtAOez7bg9YDEXj8ThaDGennuyM1QtTX3hWL6jLqcglAFj1TUIMyG0yd4KSx0IdUwgZlbCsXT/WJa2z+IW2Bk3eZff2e1imFA4nyDSuOXE58wTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412503; c=relaxed/simple;
	bh=f2FGjSU7PQcQ6pCLBbrunFcuMa4gsFA6dJ2X1WjOpqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJL0LJrYNBOQazyy70zC3aIzSK3MI6tWtVZyjgf+K061kA3B8AGHbH5aCQIZzZxqeOoRzYQSH7T9yoXWHa38lDzGBaiqO4sP3K1pXhLW8vjxpzV31kNekQtmGOxxXS6TZ33PO+3GdtL1e2ig2WnnKs8esI8ZJ1/NNdGEwZvWIbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dx9IHtp9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dx9IHtp9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHkbc846050;
	Thu, 30 Jul 2026 11:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YyBLCkOgf4K1uTZCM0DqV3UlW9hn/f
	C6mGXiJu9JRgo=; b=Dx9IHtp99VoXWEFNCLlUfIS5mp8na2B42Pfju7rL6IXfaw
	bs7V4djwxqrjzsAcegOlV4X+MP+QaqJxzY5nLx9wXkEiVEm9CDgpvytkldEIELw6
	S+PnexisgFaGHMsLCPHhHMHy5F8ghOfFUaXUQECAoXmZ9gGCLk7NE0+hv2QRr7Ca
	ooHPsF+U8Gyt+8k4+QTpQbprLrry6cO/ccLqG0ECv38ogiaoT4sKiuK7EEKOUexa
	N6zCbxiygUjDTYQZlvfzqEb/c+/d9bgnaH4IlnLVtwNXWwZKNcji7GnW2fXD8SJC
	3KbeFnYDuviotUm92sUGqur5p8M/AufbuYZQ8QJw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycqer6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 11:54:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UBfGaW023444;
	Thu, 30 Jul 2026 11:54:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhk2bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 11:54:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UBslVd31588978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 11:54:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AC3320043;
	Thu, 30 Jul 2026 11:54:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC83C20040;
	Thu, 30 Jul 2026 11:54:46 +0000 (GMT)
Received: from osiris (unknown [9.111.22.102])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jul 2026 11:54:46 +0000 (GMT)
Date: Thu, 30 Jul 2026 13:54:45 +0200
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
Message-ID: <20260730115445.18059Aac-hca@linux.ibm.com>
References: <20260730-arch_do_panic-v3-0-d5401e683cdb@linux.ibm.com>
 <20260730-arch_do_panic-v3-2-d5401e683cdb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-arch_do_panic-v3-2-d5401e683cdb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1fXfNg7Hvx6Y46HC3902dNvsuRw1TATp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4OSBTYWx0ZWRfX2caB7v0qsDQx
 Z6qw2tV3Y1ozoUzr2pDFPpUDXiUtzZjiBhLwWKzP3cduDIKdDhfVE+2ciFxhw/FI3n+J4QEkDnp
 2pCfG0gk05fbVarBQIr6eHltzElIhahmkORALYr8lCpzbAIHp++zopHBldrXmM8u8EJUOLoVMYM
 xS+9wB5BLIAHeB5oqEfYO0VJja5Xk4cdOGmHVEMhAcrZTnKiMiM0qDhtlakXxaPOSiTlvHKy0+F
 Okuz39iM7leP37SlJFRAep1CHENp0rGX5sIdKHUSs9Oo3u4hR5M3XPSDcEjVFAeiTZwtWkEOS8t
 73fM01eSpUk+E2dOC9a92UfRwmVENq22ZqBCWK2NcrSDk6LT95Yo8p3HuWOeSPWNSEUB4grwF7c
 gzA3zJ69pm1JFICFsSa2HpjRt0xK1gcmOG+TBtQnZ30aRBEfkbAlyMB6pUXBwhzlxRfBIiMZ4hG
 A8HRzZOl1uWzryHZ1gQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4OSBTYWx0ZWRfX0z8ALQhHdsKC
 ge35XqasJ6u8t9qQEjy/1zETGcWTYdCH7V8ygwpV50bIiVx3zj3+qiW3hATkaYZo+0zgRfUi0TE
 yzqCRZOaeAhOLESaZs0d+jjYI04zDm0=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6b3b8c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=-JCyyWmiuEp79ddJ_woA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 1fXfNg7Hvx6Y46HC3902dNvsuRw1TATp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300089

On Thu, Jul 30, 2026 at 11:23:28AM +0200, Mete Durlu wrote:
> s390 has a custom panic handler which carries out user specified actions
> during a panic scenario. This handler is invoked via the panic_notifier
> call chain and executed before panic_timeout value is evaluated in
> common code.
> 
> Use arch_do_panic() hook to invoke arch specific panic handling instead
> of using panic_notifier call chain. By reordering s390's panic handler
> allow more information to be printed during a panic.
> The execution order of panic handlers now allows for user specified
> panic_timeout value to be taken into account. This fixes the broken
> "panic" kernel parameter for s390, earlier it was just ignored
> inexplicibly.
> 
> This now means that the panic_timeout value takes precedence over user
> defined on_panic behavior defined via "chshut" or writing to
> /sys/firmware/shutdown_actions/on_panic.
> 
> Fixes: ff6b8ea68f4b ("[S390] ipl/dump on panic.")
> Suggested-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
>  arch/s390/kernel/ipl.c | 19 +++++--------------
>  kernel/panic.c         |  3 ---
>  2 files changed, 5 insertions(+), 17 deletions(-)

So, finally I took a closer look :)

Question: why is it desirable that panic_timeout takes precedence? The result
of this change is quite surprising: if anybody (e.g. a distribution) sets
CONFIG_PANIC_TIMEOUT to a non-zero value this completely breaks "on_panic"
behaviour on s390.

I could understand if this change would result in a larger timeout and
additional information being printed, but not that it breaks existing and
actually designed and desired behaviour.

This change also makes it more likely that the system deadlocks on console
messages, before the actual arch_do_panic() is called, if I'm not mistaken.
Which would also be a regression.

What I like about this patch set is that it removes architecture dependent
ifdefs from common code. But the side effects are very questionable.

The "obvious" cleanup would be to move only the existing ifdef'ed code
into arch_do_panic(), and only then provide semantical changes, which
wouldn't need to be part of such a cleanup series.

> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index 3c346b02ceb9..6a5fa9213450 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -2111,11 +2111,15 @@ static ssize_t on_panic_store(struct kobject *kobj,
>  			      struct kobj_attribute *attr,
>  			      const char *buf, size_t len)
>  {
> +	if (panic_timeout) {
> +		pr_warn("on_panic action will be ignored in favor of panic timeout (panic=%d)",
> +			panic_timeout);
> +	}
>  	return set_trigger(buf, &on_panic_trigger, len);
>  }

I'm wondering why AI doesn't complain about this user trigger-able warning
message. This is not good. *If* we go this way, writing to this attribute
should simply fail, instead of giving the user the impression that something
has been configured, which would actually do something.
