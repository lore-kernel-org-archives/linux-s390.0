Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132842F5A02;
	Mon, 10 Nov 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810560; cv=none; b=XcuGx9WXHxGuy4ae2H5MnWlvifQhG4cz2sNHxz1gGbs5yNsYjOCq4Q5lWPZ5PHRJng8N8MSxaNej4TKVwgksbZt2VIv2zjN6mFQwks80Nnkg8Tf69Vbt7HCA2qcDff2tQAIRs5go13jti/wfY6j/TJv5XsgUV/ZirgbBGFMz8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810560; c=relaxed/simple;
	bh=yIki8igROS6GCmuFbod4QpApb8OL7a+bePWe/7hhQAQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JQhrZ0iLuivQjb8sQ+UCoeQqGIj7U535wGUwXptO9QvKHzpbFJCHjfZ1L70BO49b3S6faIqNB4QoF0YrPJ2C3nISLW6OF+Td1wwZ2LnH5Caol5s7IBGleRp/4HYsFsfhrPLgTw5A0H4AylqljVmvIIoN3fKshAlDjWsHYg9Ba0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rNS8K34L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JbF17uwY; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rNS8K34L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JbF17uwY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A52C14001D1;
	Mon, 10 Nov 2025 16:35:57 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 10 Nov 2025 16:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762810557;
	 x=1762896957; bh=8uzTie17JQqKEWIM88SVYe2StgJuVQs2CtS74P67MtY=; b=
	rNS8K34LTz1i52qvMiOzWR/ZE7R05B4sLFjpCcLznbYtp5msn9wcto/MnQZvCjGy
	0mLsIbZwmMFlnqXyEixcAIP3jjuxtaaTrRyRcFBWSiGNHSCL8xL+CFEpE3xhBTD3
	0h5DBcp0a12F87boSgtyORyakySd+5mtOMrLvqc0kbkXyB1aphg+6PNwrZTKaGGg
	jdZWsym1XSoTcuz70YZnmQPqBugRySlxWclR/L+o11Ivs2Qv6chDAoID/BUpAiJS
	2DW9UBQhq+UDhJ++/NFZpzo/w0qmrTwiEYOVN3xOC7Jtsza34NE5AYtqSkfFlmHJ
	NfUkPIFLCxE3md204BGnlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762810557; x=
	1762896957; bh=8uzTie17JQqKEWIM88SVYe2StgJuVQs2CtS74P67MtY=; b=J
	bF17uwYqjl8UngJLsLWV0FUmVSAvbCaftnWJxAv2mkpg7Ke94GthtH8St0VbAQbQ
	joZz3wqwFSxqcLuIX6Eexss9PsvLMrojy4vs2Z1q2bErY9cdQHXF17gyvtiz1PqU
	JXOrImHXKgGo/UaZxS/9rg6ywJPIeKoQAhsxgoS/P7fTuQyVXzxL0Rpv/AK+iN0X
	wWTll7IWm5Ra6j8Jd/enNtwEZoHD3jfaBbdMO0b/Dqp9ldMOV+2oE7Akvp5e6xGR
	0F7JwnC9q/WESfgDanVMujboFlqgwZ+qlqxBC8IFJbBO+JjjllDX/WpDezHeEgI3
	IR1vdWZlbF875sFTQhJGQ==
X-ME-Sender: <xms:vFoSaapgoWBi1AL2bBiM9oFCfwegu81f7kQIMvgVmBWY-s0C81j9lA>
    <xme:vFoSaTe41YVKgbHGN8JheVz4XwSPWl2OT6fqvLa4QazsvHJ1zSU-29xQdgiIYcw7z
    BciLPqw6k-y11BSCZtWuZVZmeYQT_CqakWEdr2G0MHedgXTcqk2lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopegrghhorhguvggvvheslhhinhhugidrihgsmhdrtghomhdprhgt
    phhtthhopegsohhrnhhtrhgrvghgvghrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpth
    htohepghhorheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehhtggrsehlihhn
    uhigrdhisghmrdgtohhmpdhrtghpthhtohepkhhrvggssggvlheslhhinhhugidrihgsmh
    drtghomhdprhgtphhtthhopehsvhgvnhhssehlihhnuhigrdhisghmrdgtohhmpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshefledtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vFoSacPCjWbDJ3q8wkEBZB3_wU_EQ1B4g1sD09gCuuyOzxAZ2Aqn2A>
    <xmx:vFoSae3x_6MpoasC7x09ioWS_2Mj_55etW6eDCHa3HoPJcWV0KH1Rw>
    <xmx:vFoSaQQLnCOyFmIdeC-bV9LugiXtdfzRlQV212Gxl33qoWvFWpKSRA>
    <xmx:vFoSaZmzN7jUP5Q5Qh7V79TdBXugm4pjm_oTZEnDDSXdrwp_i-FmYw>
    <xmx:vVoSaVxXvP95_jS3eN3toAHbas3QKkRr1w-rnaexericbP60E5-1lYKq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AE18C700063; Mon, 10 Nov 2025 16:35:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMQSEuwlfej7
Date: Mon, 10 Nov 2025 22:33:32 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Heiko Carstens" <hca@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Andreas Krebbel" <krebbel@linux.ibm.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Message-Id: <fdeed5df-5c97-4df6-9475-874fccc5b0c5@app.fastmail.com>
In-Reply-To: <20251110185440.2667511-6-hca@linux.ibm.com>
References: <20251110185440.2667511-1-hca@linux.ibm.com>
 <20251110185440.2667511-6-hca@linux.ibm.com>
Subject: Re: [RFC PATCH 5/8] s390: Remove compat support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 10, 2025, at 19:54, Heiko Carstens wrote:

> diff --git a/arch/s390/configs/compat.config b/arch/s390/configs/compat.config
> deleted file mode 100644
> index 6fd051453ae8..000000000000
> --- a/arch/s390/configs/compat.config
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -# Help: Enable compat support
> -CONFIG_COMPAT=y
> -CONFIG_COMPAT_32BIT_TIME=y

I think you missed a reference to this file at

tools/testing/selftests/nolibc/Makefile.nolibc:DEFCONFIG_s390       = defconfig compat.config

> -/*
> - * A pointer passed in from user mode. This should not
> - * be used for syscall parameters, just declare them
> - * as pointers because the syscall entry code will have
> - * appropriately converted them already.
> - */
> -
> -static inline void __user *compat_ptr(compat_uptr_t uptr)
> -{
> -	return (void __user *)(unsigned long)(uptr & 0x7fffffffUL);
> -}
> -#define compat_ptr(uptr) compat_ptr(uptr)

This opens an interesting question: since compat_ptr() now doesn't
do anything interesting any more, do we still require drivers to
use it for correctness, or do we stop using it?

The cheri/morello code was repurposed compat_ptr() to support
both 64-bit and 128-bit pointers in userland, and that has a chance
of coming back in the future, but that's not getting merged and it
isn't clear if any other 128-bit pointer support in the future would
need a similar trick.

     Arnd
