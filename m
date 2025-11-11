Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2966732827F;
	Tue, 11 Nov 2025 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864940; cv=none; b=EdaAJVtYhw48VnLDBOTn55ciFrAYXyJMJvASUcRj/tFo1NbxVKv4pgMbigD9AIcV+jLkL3SvzsgJhC85kt7QJpfO6Ndh/gl0d0ZOok31rktMVB8fV4qVXobgejBt2EJTF8Cd2nKbiR5jsE7rrYJHUsfdxFo0d6heNtXuJnbJ1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864940; c=relaxed/simple;
	bh=cz32zYSwqb1PQwJobwLomOiySUR6tQ6fOUsgjeY7AEs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=b/uYsooa4Z+qHMTvWJtBAeZ+M2FHSgtywa8IIdrNGWHB7rVbUflL88aQFf9mLp/cAc8z8wkbyAZHNtwkSI8wN8Aavuiuij5V429MgMao3bmphiJzH+vdEOeSu5nNozjCCMjZgpiw21cZzpTsQJIGsrCqmJ3mPeB33maeAWTpess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JibmJuZ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FZstT35i; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JibmJuZ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FZstT35i"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 187E0EC00B6;
	Tue, 11 Nov 2025 07:42:16 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 07:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762864936;
	 x=1762951336; bh=t83Ou404aXmm0kHf+liFHD5vp+Jq6h/HE7hxSSqNQM4=; b=
	JibmJuZ2LTm29ue9/WbzZMU5N5DLUcOSp78hofujU2xZ9Q127kN/OssfV5W45hW5
	hUiRrvEgNwWojWZYXxDd/KIdyxIO7TiNwVSEvUvgmaE/nyERHJ2JrW1KlD+6pjTb
	YSX83awqmbQYOUgu/IJ4OvjnMIVMGDpNHM8lhC2TXBlr+X6rDRRcnVaLAsxOpKY3
	CWoRuQf8EhR0IwWsrk8FgNRYRLkrV7wIXRdy9YHjH3pFwnHmn+ai5Xi6LE6Vb4nx
	QUqKg9xD9QF6utPPq7O9PFxESS1qwh3t5TLp0AnCxZh5fWXbL5WiTCniCi7hcky9
	FZ4lKcaDxGjNhCDyk7lfPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762864936; x=
	1762951336; bh=t83Ou404aXmm0kHf+liFHD5vp+Jq6h/HE7hxSSqNQM4=; b=F
	ZstT35iVuamPgchGRgIr5TJsWorDc3G8IzQ1SROewxjhZSMdUNqCPghFuUR/4Yct
	vYsbO0t8bFlt8DASsHD8DEeMw36BafMYomAz0XU4A+dfHJjJMownqCVD0APPdVoF
	LBmNrzvj5GYjXkijg4C/SWhYr9DnlLcAjR5BFvnyUHrNVLgDzb7+3hu6y3Vh4bpS
	75BljSDCZ1lUVedUUKum9m5NlvU9lFAJNQCWB6d9Y7WOichVJHoTOwJLeShkT9tH
	HDGPVH2lrg408dmbgHDZaTy8yFlhcdm6zXmvMicAIFhSBzDA8IpyMQ5c7iobktqI
	jZggN2Okw7ZKLl3CreFlw==
X-ME-Sender: <xms:Jy8TaSHR04fw7GoBuiiKVAJlm329x6mvjJnux8fuJiFDY0nQdhEA7w>
    <xme:Jy8TaeKEDmcW5ZwkjZxbtzohL6pCVOFaMqUo7XeJTZFPLIGzPYo52EDfYfGMYNIpQ
    723BwXa9v9l8AjNROJa3h7C2W-WCK-wbcJI5bPclCggpXRF2ZcjosI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduvddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Jy8TaRrauODixvUAE3Ct5jhL1XXDw_YqnvtPngkQ7Ma7MfHq4OcCiQ>
    <xmx:Jy8TafgLhVVxsW0bQhkIrfb39EpUpoMQIsrDD8uZe1ak91enCuz1TQ>
    <xmx:Jy8TabMD0tqXl3aNfykVhqttGQYgLNh4boNxw7Z0vjANTGp324Gycw>
    <xmx:Jy8TaRzQ8zrivufqAnGn9mYJ0c8vPygkGPX4ksK3KwVkidHdAr8SYA>
    <xmx:KC8TaYaTy9TUotw93g9-X4RsvKDW9-YQDItWtSnRWl0G9nsQMqK8lSlp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 84B25700065; Tue, 11 Nov 2025 07:42:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMQSEuwlfej7
Date: Tue, 11 Nov 2025 13:41:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Heiko Carstens" <hca@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Andreas Krebbel" <krebbel@linux.ibm.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Message-Id: <34f6144b-600e-42f3-88f5-3e712a328986@app.fastmail.com>
In-Reply-To: <20251110185440.2667511-1-hca@linux.ibm.com>
References: <20251110185440.2667511-1-hca@linux.ibm.com>
Subject: Re: [RFC PATCH 0/8] s390: Remove compat support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 10, 2025, at 19:54, Heiko Carstens wrote:
> Remove s390 compat support to allow for code simplification and especially
> reduced test effort. To the best of our knowledge there aren't any 31 bit
> binaries out in the world anymore that would matter for newer kernels or
> newer distributions.
>
> Distributions do not provide compat packages since quite some time or even
> have CONFIG_COMPAT disabled.
>
> Instead of adding deprecation warnings to config option, or adding kernel
> messages, just remove the code. Deprecation warnings haven't proven to be
> useful. If it turns out there is still a reason to keep the compat support
> this series can be reverted at any time in the future.
>
> Arnd, we talked about this two weeks ago. I would appreciate if you could
> have a look at this series, especially the last patch of this series.
>
> Patches 1-3 are just some random cleanups / preparations.
> Patches 4-6 remove compat support.
> Patches 7-8 switch s390 to generic system call table generation

Loooks good to me overall,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I agree it's rather unlikely that anyone is still using 31-bit
binaries, it was only really from 2000 to 2002 that commercial
distros were missing s390x support. Debian moved to 64-bit-only
much later than the others, but had both fewer user and fewer
third-party applications that might require old binaries.

      Arnd
