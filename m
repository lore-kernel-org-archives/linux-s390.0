Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98C19E831;
	Tue, 13 Aug 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562036; cv=none; b=a4Eg7zlnMTjWshNBbSULp9S+vCjEPdp6quni1GH48l+9MP8vQTmL6vJ38UzFqaRyNvvLC2bR6WOhbHrgbjcsWWZT87z8FJVjZnne49WEglOXc/DkvQp4VMACKUvL2lQFhG+FeZ4TKT6fbDPkVOBn0JfAxM6kmUd3pptk6qeoZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562036; c=relaxed/simple;
	bh=V40vtNjwzGLNCCt68Yz73rtKAj1di36sAeB6peUqnPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQWtMyeFUnYbvnyEtieEjbhg01WSyAJDWjdfMfRbIFmtqu9AB+zf3l3vFfWs3yPCZ1YSdaPj5zAuGkjAwF2nCKB/uEpm8AEZM/S80kHbd9RIDU7MyCoxh6B1n6+LlAYKcuMzVe9nKy+Bnbg+2v959koXIpnI+CSI1pjkONh/6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DB9IDQ1A; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DB9IDQ1A"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 828951151ADA;
	Tue, 13 Aug 2024 11:13:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 11:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723562033; x=1723648433; bh=TTJo0dwlhYuw65a/8dXX89xJMsBi
	5E/g7VpWhakXTAw=; b=DB9IDQ1AKHuSDtrMc338xQnd5fiRIQe8PSgxMMWfFGKA
	m/ur+iYp8iPTvWmSt6mAWU2t9maLpz71gRDhZjVuRTiXWScqSnjcxlbgkVwEtQ3h
	hjp7vD6WH9oAfale31o1EMYf+QU15cm3LPYz1YRLdccxSnZIQ8XYXnNEA84jqQka
	8igIc3pi/JJJkxD5NiqyrVlV3VlMq2uPB+omTt2v6Brcvg9SW69dyGWO1Oom4jU3
	0s/jZ5EZS0HLbhd+5o8WHrnAuZnVjgzgX+tsIN+lDq/kW9B64uaPlGcpTcVgRcJI
	UtNEpUuRo3eiAmAR502itrGXjm5LzqQn5C1chK83Fw==
X-ME-Sender: <xms:MHi7ZiAJKirRQQM4cKUO85dFkmnuX8hlgcHZiFry2vsOt7IZUKjUGQ>
    <xme:MHi7Zsi-jilgvn-IDdpN-AaCKJsL8ckca9X_4Zsom6kKUR0Xvm87fAsw4YAAwsFLv
    HWxlKTUxK_ZPCc>
X-ME-Received: <xmr:MHi7ZllD7zi45hwJd9ExcxNa0xeJ-IQvqdncvWCNLD6nIAiw7Z8Ne3O0_RKVafwK8COPWvucID3JDwRz_9BJ7oH4ofsGiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepffetvddtieduteduleffveelgfehkeetudevveev
    leehheekkedtjeeifeeuffeunecuffhomhgrihhnpehnvghtfhhilhhtvghrrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhs
    tghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhufigvnheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopeifvghnjh
    hirgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehjrghkrgeslhhinhhugidr
    ihgsmhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpd
    hrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehp
    rggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghlihgsuhgurgeslhhinh
    hugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehtohhnhihluheslhhinhhugidr
    rghlihgsrggsrgdrtghomh
X-ME-Proxy: <xmx:MHi7ZgwPUb3rJCDNg3bB1De9qNdZRXzrx6bmXqpJOmZ37WqRLyzpEA>
    <xmx:MHi7ZnT0W_IKseXJ9vRUBfmk9KuCGtJilEiqQ8OzYMdBNw72n1UwQQ>
    <xmx:MHi7ZrbpnUK7Z10vVFDDEi6usa683qdfLYMlFszHzI9GOjKR2O5sNw>
    <xmx:MHi7ZgSYm_fb1bgzv6i9lIwky86TtKYkiaw0o1KVxhHTLcCM6sKE6w>
    <xmx:MXi7ZmKhLR4sSGm_0gP343jLYhkXzLtntEW3l1RTiFvn_3ifPwjPWTFD>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 11:13:51 -0400 (EDT)
Date: Tue, 13 Aug 2024 18:13:48 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com,
	jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	danieller@nvidia.com
Subject: Re: [PATCH net-next v2 1/2] net/smc: introduce statistics for
 allocated ringbufs of link group
Message-ID: <Zrt4LGFh7kMwGczb@shredder.mtl.com>
References: <20240807075939.57882-1-guwen@linux.alibaba.com>
 <20240807075939.57882-2-guwen@linux.alibaba.com>
 <20240812174144.1a6c2c7a@kernel.org>
 <b3e8c9b9-f708-4906-b010-b76d38db1fb1@linux.alibaba.com>
 <20240813074042.14e20842@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813074042.14e20842@kernel.org>

On Tue, Aug 13, 2024 at 07:40:42AM -0700, Jakub Kicinski wrote:
> On Tue, 13 Aug 2024 17:55:17 +0800 Wen Gu wrote:
> > On 2024/8/13 08:41, Jakub Kicinski wrote:
> > > On Wed,  7 Aug 2024 15:59:38 +0800 Wen Gu wrote:  
> > >> +	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_R_SNDBUF_ALLOC,
> > >> +			      lgr->alloc_sndbufs, SMC_NLA_LGR_R_PAD))  
> > > 
> > > nla_put_uint()  
> > 
> > Hi, Jakub. Thank you for reminder.
> > 
> > I read the commit log and learned the advantages of this helper.
> > But it seems that the support for corresponding user-space helpers
> > hasn't kept up yet, e.g. can't find a helper like nla_get_uint in
> > latest libnl.
> 
> Add it, then.

Danielle added one to libmnl:

https://git.netfilter.org/libmnl/commit/?id=102942be401a99943b2c68981b238dadfa788f2d

Intention is to use it in ethtool once it appears in a released version
of libmnl.
