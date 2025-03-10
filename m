Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463152253E6;
	Mon, 10 Mar 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611056; cv=none; b=JZ+HcVgOPecZyrlOH0hBu9DyWWhCpm/bM5vH7vcWdzhNqOmjdXpysa2d8kOYLA9nwIP4Gn7I1u8GTiI4LGemlk9IphaSRmvnEALFti999qQse2cTtmi+I1i23jMPM7wp1Mbus0zlWGzg++MZlCshCVQA4JpgB2izdN37RTomrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611056; c=relaxed/simple;
	bh=/Z94/FZmdG/LXzRBXd/oSyI+aY/5CPxrcqyu7GWwmYM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=W9+fNg7MOmFjYBACuYjm2aBCd4uiAHV40ldwLoj2HK4wJA+D9p6vqqdI0VhCrO55NbBKL5c69CXvm3+FWVJwryoTVha5oW2b6fBjo0SuyiRt1JA4GFAkuwxlPSIsFXS9lFr18eDKDYsO+MaIQSq+ISMsMLNEabYaRgOfo3F7KOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=nhroAxLz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kadsx4et; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nhroAxLz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kadsx4et"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 240141140187;
	Mon, 10 Mar 2025 08:50:53 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 10 Mar 2025 08:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741611052;
	 x=1741697452; bh=Dcifg0sI1uowxb8ImXEUeIxPiiGrASO0jm94bzoN2lE=; b=
	nhroAxLzLIDLmcMigo/SnJ03ipGo3hmWAPNy5EbNluSOiF5h9DvSlcwKlBKphXpa
	c4+qT4sO7+TF8EqCSxxeYOCQEiwqFPOnhcZvaHrSbP8vdgbsF3xj45rhBXNqSfRg
	UuOqou0SgrNMCI3sfsDNNjxg87oCpGKA9oFsQJSCqMg+QHJG/5PEIah/jupFUipO
	gWe6/k18OT0T1NqtHjNkXV6JR/dfU90sCQczow/vmWdXRb+SJ14naUXp4Yhd+Ooy
	edWJcC2n9Le20i+gxz6iFbnOz26lOQuA3hNW2ALoL43MF+HCQeYKZySBLQcxKVpB
	iP2J9jHun5dFo+dCorAy+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741611052; x=
	1741697452; bh=Dcifg0sI1uowxb8ImXEUeIxPiiGrASO0jm94bzoN2lE=; b=K
	adsx4ettZaj//qI3lvzOBb2toDO3vNcMbJZXskicIPnwxK2DZTJk4p+sn3euaUQX
	J8auB2YOkSo2J/kNqUWMrDJSt1MHA6QZ6KgcvsOjXcbrgFD1LQzCNUoo6A/aky5H
	SvFQ4QnlkVqJRfyAmMDVDvVbDCmwNG/9YGRPTPDrlfLUPTCHLDzopaVuM+abIxDK
	BFvKVBsotdH9u3X6ZazLtgYeAxn2eu36jjqQg1WcWrUI7zfV5t37rsCkvZrielXk
	hMJUH8z4zt6Ok03GQxMUeHNJcZtfHFzpp2YxgbjIEUeh6SyQweg6JrTeeOP8A+V/
	VNH6gs59sNjJwKKQIjXWQ==
X-ME-Sender: <xms:LODOZzx3RCKv4fb3TMvr0ZiZ4yaDpxb-e7UJOX9P-sj9iFP8p04jMw>
    <xme:LODOZ7TIjFXmq1Kp-oZrPfyMbQzvmUCIXk_8Atg1Q8OFF13ERLrGdMToVNtZKdRoW
    O0cu6RN1mZEJqBHglg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepveduveeigeekiedvleduvddtgfeuteeihfdv
    jeefkedtgfdvhfffhfduveehgfelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsh
    htrggtkhhovhgvrhhflhhofidrtghomhdprhgrshhpsggvrhhrhihpihdrtghomhdpghhi
    thhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprghgohhruggvvghvsehlihhnuhigrdhisghmrd
    gtohhmpdhrtghpthhtohepsghorhhnthhrrggvghgvrheslhhinhhugidrihgsmhdrtgho
    mhdprhgtphhtthhopehgohhrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohephh
    gtrgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehsvhgvnhhssehlihhnuhig
    rdhisghmrdgtohhmpdhrtghpthhtohepthhhuhhthhesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqshefledtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LODOZ9WEk_6DrAvQQz9ZvNMCYtJ2A8Ix8_kQvUsThP8IQ3QEIzAwnA>
    <xmx:LODOZ9hYZl1OXSbU_7ZdNadTr6bDgO_6n5Br3JrGDVO_aaauJBg2Vw>
    <xmx:LODOZ1CoyStZZQ3bhB0NjNk5RVt3XlAuPb-LHqfU7dFz8bGuJWRXlw>
    <xmx:LODOZ2Imu9xkbRuZFF8HdQ31ArwVVETCIY0tGWccemgraRnE3VsjUg>
    <xmx:LODOZ_DnSTaH8pZcdgfr8bfUvSxWiBBzaLfLdN84B_fRM1yHVhvbSuq1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8D7F62220072; Mon, 10 Mar 2025 08:50:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 13:50:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Huth" <thuth@redhat.com>, "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>, linux-kernel@vger.kernel.org
Message-Id: <1be19a7f-f43c-4025-8cf9-5f831c4125f5@app.fastmail.com>
In-Reply-To: <7eed4668-9352-45d6-8116-235c8be43bfa@redhat.com>
References: <20250310102657.54557-1-thuth@redhat.com>
 <20250310104910.27210B18-hca@linux.ibm.com>
 <ab1ab15a-89e1-4c26-b7a2-6147a10a2fca@app.fastmail.com>
 <7eed4668-9352-45d6-8116-235c8be43bfa@redhat.com>
Subject: Re: [PATCH] s390/uapi: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 10, 2025, at 13:14, Thomas Huth wrote:
> On 10/03/2025 12.07, Arnd Bergmann wrote:
>> On Mon, Mar 10, 2025, at 11:49, Heiko Carstens wrote:
>>> On Mon, Mar 10, 2025 at 11:26:57AM +0100, Thomas Huth wrote:
>>>
>>> Did this cause any sorts of problems? I can see this pattern all over
>>> the place, so why is this now a problem?
>>>
>>> Also, wouldn't it be better to fix this with an sed statement in
>>> scripts/headers_install.sh instead? Otherwise this is going to be a
>>> never ending story since those things will be re-introduced all the
>>> time.
>> 
>> It should certainly be done in a consistent way across all
>> architectures and architecture-independent headers. I see that
>> all uapi headers use __ASSEMBLY__ consistently, while a few non-uapi
>> headers use __ASSEMBLER__.
>> 
>> glibc obviously defines __ASSEMBLY__ whenever it includes one
>> of the kernel headers that need this from a .S file. Unless
>> there is a known problem with the current code, leaving this
>> unchanged is probably the least risky way.
>
> Well, this seems to be constant source of confusion. It got my attention by 
> Sean's recent patch for kvm-unit-tests here:
>
>   https://lore.kernel.org/kvm/20250222014526.2302653-1-seanjc@google.com/
>
> Quoting: "This is essentially a "rage" patch after spending
> way, way too much time trying to understand why I couldn't include some
> __ASSEMBLY__ protected headers in x86 assembly files."
>
> But also if you search the net for this, there are lots of other spots where 
> people get it wrong, e.g.:
>
>   
> https://stackoverflow.com/questions/28924355/gcc-assembler-preprocessor-not-compatible-with-standard-headers
>   https://forums.raspberrypi.com/viewtopic.php?p=1652944#p1653834
>   https://github.com/riscv-software-src/opensbi/issues/199

Right

> So I thought it would be a good idea to standardize on the #define that is 
> set by the compiler already. IMHO it would be great to get it replaced in 
> the whole kernel, but that's a little bit bold for one patch. So the obvious 
> first step towards that direction is to replace it in the uapi header files 
> first, where it hopefully will help to reduce the confusion in userspace. 
> So unless you really don't like this idea at all, I could continue with the 
> uapi headers for the other architectures, too?

Standardizing on one of the two is good, and using the one that the
toolchain already provides makes sense. I would prefer a large patch
that replaces all of them (uapi and internal) and removes the
definition at the same time, the way the kvm patch does, but it's
possible that this causes conflicts with architecture specific
patches.

There is a risk of regression when changing the uapi headers, when
new users of the uapi headers don't define __ASSEMBLER__:
This would then work with new kernel headers but not when building
against older headers.

There is also a (smaller) risk when there is userland building
assembler files with a compiler other than gcc or clang, if they set
__ASSEMBLY__ manually but the compiler does not set __ASSEMBLER__.
I checked that gcc has defined __ASSEMBLER__ at least as far back
as egcs-1.0.0 and gcc-2.95, probably longer.

     Arnd
