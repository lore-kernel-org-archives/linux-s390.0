Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051ED19E836;
	Thu, 20 Jun 2024 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879366; cv=none; b=W8kXyZsuv8L0CJb1USW0fyxoiSD0BE7hhciGujZ5AnRziZRA/hRY98UjeTXO1SL94iXsEyAo52c4gHL9BBq16nv7oYmlcDdFk7f+hFhORfb9C8/APP5GmeseGfSKRreHzqe7j/bdGzsed29KGtp+zBB1/YvZ9jAlvS2E6zM5BUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879366; c=relaxed/simple;
	bh=ULhVz2guPZrIcJny+Sst4LCYE9jyp7O3sWvvdLlXHGA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=i7XB4x+L1bfDGPxjty5+KNGE3tbX6H7u8/139CEtsY6AIScApoddWxwlGIsPTw3mO3sRn7lFDpdvLGvBtCIwL15RH6VG79q2M0AWjs1htfrMeMEKGxvR8bF3tYwWzTjzvgcONhHnx5juoWYhMMs1CIsx6M8mkxipywFDGMtZJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lgDJkdXP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RVIL8M8t; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lgDJkdXP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RVIL8M8t"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 32B8318000AC;
	Thu, 20 Jun 2024 06:29:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 20 Jun 2024 06:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718879360; x=1718965760; bh=9DuHh1KUC6
	QNlhdJh8j9SaPiDZmfHHzRY28gydQgPZU=; b=lgDJkdXPTSb9wVrl66jQWjyl4H
	HcSr6DUI/PYMS/q97Aj3DgRgWjTF6AOIosQUQJXU3PksFQ3lHMbXK77Ry4Dk4xh2
	3AQyMOpQpP38BbHX7XKNgTOBqTDxkSeVQsa0DHBf6jo+Zv5jcermhdXOJJvr1dUx
	NzmILs6yJhAsXSlnyY9AyhWGjMXFFo+WIsJoD+/+937gkHITZBYHe2cidNRIs5Y5
	H8Rkm14XzWf1H50rW8mWFHA1UfDFlp9ryImDHRT4n8CALCZidl0INl63OJAOQDx7
	WG8j83SrozcXwCoQnBRsUCf+uVqqOv97b3xzDNbBoyJ0DY5N3qY7VODhuqCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718879360; x=1718965760; bh=9DuHh1KUC6QNlhdJh8j9SaPiDZmf
	HHzRY28gydQgPZU=; b=RVIL8M8tcKZ25A9GuQ66TolFwY1RPdLTIp+s48K2SkI1
	zH2QCdoAmAewScpvQqwt24uLGl4JFm+UViGh1Hn0jJhgWR7jk/ogfIT/9oh29bPd
	/p+oDjaVXE18gK2Ba8Mz1oDI5IkuHbIlxJJEVutJunzC5peqn8vLvhnMJ4Iryd/Z
	i+hR/4GmJoRlFjZClts8KW8q/5yF7RZo4w25Z4Nfuch4URBRkcoi+6XTATyPc5CK
	IXZTxZU1UohSe19h+Ii4yQ/r3NjYwnMRp/2guduFYdUvDgzwZW4yXQfCbMQONl72
	aIqdsde4esOxe7S7b2oRMPD36i8+XQSw6eMjR+lzpw==
X-ME-Sender: <xms:fgR0ZgLXboG61Zy1MNizip_6Zfcv03o4i0RSJ979g7D-WMaEqNQt8w>
    <xme:fgR0ZgJ0K-vP4Lc2SvirRHGMKPXpR8PdWYBxkN27Z3YowSXDMBSH_J9zJXb_g1Mel
    UxdyoXLKiym7QWyyvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefvddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:fgR0ZguJ8tD1UnvGuFay1gm9GVgufGFboD6kzGjH2I6cXuImv6Q7wg>
    <xmx:fgR0ZtanawMt-akRZQTBH0XVykpXiNHxEvMwA055m42--7z3ITm8rQ>
    <xmx:fgR0ZnZ-LLcLPtOJZZ1bsV8uNKO-HaHdsnsiw-IPSdh0-pqbmaIYXg>
    <xmx:fgR0ZpB4PmHz9pHcUesDdzlln4rI6txmkVL0XEWVzhpFohNkyKOZaA>
    <xmx:gAR0ZlYt-PEggbe8ljD5PMuoClv-LARlpWRQn7W2zpCfbtibABS4tNEG>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C1E51B6008D; Thu, 20 Jun 2024 06:29:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d02b4ddf-f686-4b53-af52-68762c38df94@app.fastmail.com>
In-Reply-To: <20240619214711.work.953-kees@kernel.org>
References: <20240619214711.work.953-kees@kernel.org>
Date: Thu, 20 Jun 2024 12:28:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <kees@kernel.org>
Cc: "Yuntao Liu" <liuyuntao12@huawei.com>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>,
 "Leonardo Bras" <leobras@redhat.com>,
 "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
 "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] randomize_kstack: Remove non-functional per-arch entropy filtering
Content-Type: text/plain

On Wed, Jun 19, 2024, at 23:47, Kees Cook wrote:
> An unintended consequence of commit 9c573cd31343 ("randomize_kstack:
> Improve entropy diffusion") was that the per-architecture entropy size
> filtering reduced how many bits were being added to the mix, rather than
> how many bits were being used during the offsetting. All architectures
> fell back to the existing default of 0x3FF (10 bits), which will consume
> at most 1KiB of stack space. It seems that this is working just fine,
> so let's avoid the confusion and update everything to use the default.
>
> The prior intent of the per-architecture limits were:
>
>   arm64: capped at 0x1FF (9 bits), 5 bits effective
>   powerpc: uncapped (10 bits), 6 or 7 bits effective
>   riscv: uncapped (10 bits), 6 bits effective
>   x86: capped at 0xFF (8 bits), 5 (x86_64) or 6 (ia32) bits effective
>   s390: capped at 0xFF (8 bits), undocumented effective entropy
>
> Current discussion has led to just dropping the original per-architecture
> filters. The additional entropy appears to be safe for arm64, x86,
> and s390. Quoting Arnd, "There is no point pretending that 15.75KB is
> somehow safe to use while 15.00KB is not."
>
> Co-developed-by: Yuntao Liu <liuyuntao12@huawei.com>
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> Fixes: 9c573cd31343 ("randomize_kstack: Improve entropy diffusion")
> Link: https://lore.kernel.org/r/20240617133721.377540-1-liuyuntao12@huawei.com
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
