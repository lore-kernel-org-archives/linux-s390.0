Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F2C8E1;
	Mon, 17 Jun 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656414; cv=none; b=YjuOqFY5x7XaHwMGbOrpboAd/6YUWb+TFA6vcVPcsSORTyR86uN86q94K/uCRILT3bE/c/ww4fBSVdN6YXZoJQaP6Gw/YvwPkw5fD0OHnOCX/mlMAxg/nv97NlumV5tcmYaeLGXw3PNpE1m9JefL07yUYPxl4mbUKEOei0HjH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656414; c=relaxed/simple;
	bh=jaVlw/Bw2+IaY2P1kl0q/XJdhyk5gRvGocCy6MEcCw4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=m58qUYFwE05jOnYoUQcfrSWGhkOdWs4nWnPsJYDv6D0wY53G+iENwaL+A3gJlj1T8u7F8XosNkzNa6ulg7GPFhKluLz/mc7E1AK9WiueOJogirjlH7VmimAP0ww/nm488Fhjp5JMfFVBdP9FWIr5M5WUEDlhab5SOTnRebqglVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=vi3Yte+C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eYSZp6yr; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="vi3Yte+C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYSZp6yr"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BF5E01140294;
	Mon, 17 Jun 2024 16:33:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 17 Jun 2024 16:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718656409; x=1718742809; bh=ZOPzmcgBhQ
	zo1keWksdhYbdPIRd3lKjznmVOskNt6RY=; b=vi3Yte+C00ngmRPurQDjKom+Mo
	7I2cXSkKKNSB3XaghDFBbW/yX9/IPU+rRKCyWAzl47+aN0dJBwZytlg5eKZDKpm5
	dOiXtBQU2BvderPOj3+4RvUFl8vYgwvsbZr3TlnTMBmZWtRjZc/TZZPY1xKS0pNm
	iT1u2dIQ83IHy42PfsHGyuPMg9xXEfY6JbVGbLlnuT9ITi0YW1sUEKFPzZUxUzyU
	hHDvY0sHFOMj5nBpXl1+gU5e9HP1nt2XufkwO9Zm0HlGMAjEbcrR8PaP7GQThCXi
	o10cA793EMGQuhQbpeLx6h1+fEc070+pfF/iLmR9wXYi7yqbWdxxXIN6JTwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718656409; x=1718742809; bh=ZOPzmcgBhQzo1keWksdhYbdPIRd3
	lKjznmVOskNt6RY=; b=eYSZp6yr4uIcpX4K/DSJxA0dcLd9y5bZ93XJW91IS+C4
	gjlAwhWHe/cuYtu2t9+rR1CaidAkP9kO5FnK4pWFz4Ta3t/i9hDoTxbVdm1uXwiB
	gRy/ef0i36wnqwPqn8P56M2NiEr5yLX0OScuw6P5oot20Us5csX45S3F/sjwoW/K
	jY+2IM7qYf1Ociil3fiITp5HY/Z623KIkN0U8yjx7x5RVhgeaEXChzSSyjZlEZr0
	uP15pIaWS1R48nSrhZyHw7gG1RXV/65B3hv5y1lPdqLLnEx9V5PAik8nGf3RNlrT
	sApmUyi6IVJcpU1ug8ooT0Lc7HadGojIEFTc9juqew==
X-ME-Sender: <xms:mJ1wZlJSv-bIOceDxEPYcbRc7MEi36kkxS0h0ztbzdDFL1m7X_X5aQ>
    <xme:mJ1wZhLV-WrMVzF2QVsFYrRlHraCxhVMp625Ohg5bOqu-N-c3VGKIvRTayuuAXgmm
    d1s02toKF-LUXGI3GE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:mJ1wZts8xgHY9hrr66fNkOvtkPVWByYLruSPKGDiNjYZ5fwbpQAJCw>
    <xmx:mJ1wZmYX3CRvz-zIy_A_kY7FVCjE2JLb1l9FDUhw44LCWjo7zQBpdA>
    <xmx:mJ1wZsZeB7E86sMRNAP0sjDBwEfNKoOuH1K3VlS2sMybSFBUufdT2Q>
    <xmx:mJ1wZqDat5LjPLNQI4zkBx2YzhSH3yjp5jBIBwyGIEhULpAH_pnbFQ>
    <xmx:mZ1wZoKoS86N3mTV8tHw8qF-NH8CoB31Le40nQ6TOtL4j9BaC45Be_ER>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 876EDB60098; Mon, 17 Jun 2024 16:33:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d0959336-4430-4062-b909-54d553238468@app.fastmail.com>
In-Reply-To: <202406171122.B5FDA6A@keescook>
References: <20240617133721.377540-1-liuyuntao12@huawei.com>
 <ZnBbr2CAqBGDe2aN@J2N7QTR9R3> <202406171122.B5FDA6A@keescook>
Date: Mon, 17 Jun 2024 22:33:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <kees@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>
Cc: "Yuntao Liu" <liuyuntao12@huawei.com>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, gor@linux.ibm.com,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Leonardo Bras" <leobras@redhat.com>, "Mark Brown" <broonie@kernel.org>,
 imbrenda@linux.ibm.com, pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH] remove AND operation in choose_random_kstack_offset()
Content-Type: text/plain

On Mon, Jun 17, 2024, at 20:22, Kees Cook wrote:
> On Mon, Jun 17, 2024 at 04:52:15PM +0100, Mark Rutland wrote:
>> On Mon, Jun 17, 2024 at 01:37:21PM +0000, Yuntao Liu wrote:
>> > Since the offset would be bitwise ANDed with 0x3FF in
>> > add_random_kstack_offset(), so just remove AND operation here.
>> > 
>> > Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
>> 
>> The comments in arm64 and x86 say that they're deliberately capping the
>> offset at fewer bits than the result of KSTACK_OFFSET_MAX() masking the
>> value with 0x3FF.
>> 
>> Maybe it's ok to expand that, but if that's the case the commit message
>> needs to explain why it's safe add extra bits (2 on arm64, 3 on s39 and
>> x86), and those comments need to be updated accordingly.
>> 
>> As-is, I do not think this patch is ok.
>
> Yeah, I agree: the truncation is intentional and tuned to the
> architecture.

It may be intentional, but it's clearly nonsense: there is nothing
inherent to the architecture that means we have can go only 256
bytes instead of 512 bytes into the 16KB available stack space.

As far as I can tell, any code just gets bloated to the point
where it fills up the available memory, regardless of how
much you give it. I'm sure one can find code paths today that
exceed the 16KB, so there is no point pretending that 15.75KB
is somehow safe to use while 15.00KB is not.

I'm definitely in favor of making this less architecture
specific, we just need to pick a good value, and we may well
end up deciding to use less than the default 1KB. We can also
go the opposite way and make the limit 4KB but then increase
the default stack size to 20KB for kernels that enable
randomization.

       Arnd
