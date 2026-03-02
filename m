Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C19377546;
	Mon,  2 Mar 2026 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440931; cv=none; b=tYulvWvpSf1WfUfJphiLWWQuatHovYHg+QKH5HLSNEl0pD+dQw25Va9YIzhTq1UaymzXFaX491MEaWHNFdg7Xvv8+iY/4aKVGa6/Yez8nGGIS0Ya1IKaZ1J4lVgLskrLRdCOYRFLDsBQldj1EhAVaCNQCE9+u3Y9Yd34nfPFeVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440931; c=relaxed/simple;
	bh=f9EDSr4xMvzlf0BcMt7wK4RAMOjexiFU1mqT7NX5ex0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e1TzsMDW37+f2scgRVU8U2dMLQBYLbIMAvjUZ9kp/TjWHO5beECJ88HSXME82zzi/TVGJ1nu2yA4SnV4nZjTfDLdHVYjErwEZ/4QYK5HW4QchMXz+pTVW/yRM1y8WwdtRMgO+fQdikbpRSIwrjW90HXDfU8r/iG3f6f/uH4+k20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TUnBqpMH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=55jw/b5z; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TUnBqpMH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="55jw/b5z"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 5CA8213807B3;
	Mon,  2 Mar 2026 03:42:08 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 02 Mar 2026 03:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772440928;
	 x=1772448128; bh=f9EDSr4xMvzlf0BcMt7wK4RAMOjexiFU1mqT7NX5ex0=; b=
	TUnBqpMHAoydoEYTrLWDb0aZrPuVB/vK6a/3kn7OiD+pahNYTDfybpqJxDQrmOhZ
	p+CJf/OKxzEnD/PmeU86UBe0NduQ/7EELXM64rnpHJwZ6H+Vgpz3vkhH4VlBdhxy
	ATVpVVig/9BuPuFABtbgeLJVtESdN1E8hiYCed7oNJFkeXEhpKeAOIDdFxKKTNk2
	yQFM+hSdU0OVA+BsbJJxOpNcdkuBKhztB43jle8LCwo+kE9D3vWpu1CH/IzJxAl7
	Ni4aockFVahhKUU/sR1NUGUd4uniIbwyrp+lCJMvoUlefBkzz+zUDoEFtF5snOY3
	Z5QTVHaENFpsbjTfCjhM7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772440928; x=
	1772448128; bh=f9EDSr4xMvzlf0BcMt7wK4RAMOjexiFU1mqT7NX5ex0=; b=5
	5jw/b5zOyZL211O2h7RVYKBeD+C7RgaSFBdTNLBKcutQYI/y66duSBYgZ6e/wzN1
	cli4lT82sotXzrGGhWJcvpp+0oAUUKA/8CI35OVHxsQxZFQwQTgMWTDoILnq+qpa
	dEnTtOH75aAXBD0/QGvly8BH04lqemD7jrEf3y05fWiRaiklQx+CKco4pHXjGgKH
	sVgxTi9znwv5PtVZN0PjdHi9yyrS0QncCbgJKm4wKrcPIUMSrZI65lB/ufhGJyVG
	tLL+ENdz6CuqyzpGEktpbQVIKJr24QMZyZyW9Tk8JeSsYsHLMAK3xVcuB3pibpcg
	h9ptGT7+l8ZZhv08cahjw==
X-ME-Sender: <xms:X02laQcXaTZEiboMhC1dISRQUofQtLKbBCxogIq7AUOFNE0swrmT4w>
    <xme:X02ladDrcb3TxEfgVRktHyM2KDrugM3z8hVQLqW3nKXHw3d1qG732L-B7pmI2e1tz
    -4g43VUnBySEbZamkpdIaCovfcvzFYBCzA6CO1sAm6A-LWLVbrgC9A3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhi
    ugdrrghupdhrtghpthhtoheprghnughrvggrshesghgrihhslhgvrhdrtghomhdprhgtph
    htthhopegurghvihgurdhlrghighhhthdrlhhinhhugiesghhmrghilhdrtghomhdprhgt
    phhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhlhgvrh
    hohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehtghhlgieskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:X02laQYxIxjZbwaPUiOj36ZKr7OJ1zIa75Ms3G7z40wpqEkU5eo8UA>
    <xmx:X02laUlNQJpJdWuCyZkDw0YqwkMWpP6aa51YA39ENjmufl2s302Pkw>
    <xmx:X02laVFfyv05lQUqgPj5uNwtMrdw7TVuqYvCSGtzmYauVlrb5kKdew>
    <xmx:X02labiunDrF_9AdGrcrpNLIZoadV9R5UWY0ex25SxHYGbPm0jNaDQ>
    <xmx:YE2laZbyTe9V1dRV5V0iEMQkQf0P2dhbuUJzrk2x0qgrVGNp13kA8ujR>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4BCAB700065; Mon,  2 Mar 2026 03:42:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANWqLJ6kN0jc
Date: Mon, 02 Mar 2026 09:41:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 "David Laight" <david.laight.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org
Message-Id: <1ad2b22f-c57e-477c-bad6-96b9785e2373@app.fastmail.com>
In-Reply-To: 
 <20260302-vdso-compat-checkflags-v2-4-78e55baa58ba@linutronix.de>
References: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
 <20260302-vdso-compat-checkflags-v2-4-78e55baa58ba@linutronix.de>
Subject: Re: [PATCH v2 4/5] powerpc/audit: directly include unistd_32.h from
 compat_audit.c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026, at 08:58, Thomas Wei=C3=9Fschuh wrote:
> This source file undefines '__powerpc64__' to get the 32-bit system ca=
ll
> numbers from asm/unistd.h. However this symbol is also evaluated by
> other headers, among them is asm/bitsperlong.h. The undefinition leads
> to an inconsistency between __BITS_PER_LONG and the C type 'long'.
> An upcoming consistency check will be tripped by this.
>
> Directly include asm/unistd_32.h to get access to the 32-bit system ca=
ll
> numbers instead.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
