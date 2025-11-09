Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C91DF27F;
	Sun,  9 Nov 2025 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762709748; cv=none; b=AjxrVU+seaWcWu12UQ+et0rLOSk3Pashw0ybLUTNxpItq2P0tb5kNfg3i7lsXZYhhUKrfPKYusdR8QfWkt/cCYRzAEFOU9YhHWM45GWCU5+Er8XGmse7qVKXY370xK8B4fLxTxdGNiGRGrjxR8AEr1jJDr9da8+9DsuzVzDU3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762709748; c=relaxed/simple;
	bh=SX5qwi6eNiE8f8w3vxCMss5uGddaU6pL2Sh1O+bLbjg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ujk1D40+iH1jxYXhVfi+BrEWyz8ELbnAkPSEvYIctAayp0CDd6KFjCInkgjqLcqQSSplNvzsXBKG1iGXClTU/bET4cC/7mV6/PUAjks0kMFiC+Us63YBzGwHMwCokeXD50/imdd3YZ2DeIMwbE4xRHu4GcgvBHZni05rmZjblN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gKnpuhGp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uq4E6ndl; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gKnpuhGp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uq4E6ndl"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 23FE37A00B0;
	Sun,  9 Nov 2025 12:35:45 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Sun, 09 Nov 2025 12:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762709745;
	 x=1762796145; bh=zkWdqhs5qH8DQ5ZU8oXdGGm7z8JLhJ4sUco0+8wMPGI=; b=
	gKnpuhGp2ATsb733vArbYloqQv3B7wkoOXcOG8R0466GWKLNpKoIBFztbEuthP0z
	/C2OKbiRNIIO4rAgf3lDV76FvNBnqL0B92TiQf1Nvb5kvY95tKdEKCsxvoFTV4Lr
	NfyMk7ghZOoCBjAcZdxm1FYFeDMEyv1fwRlWsbd0jPUpSNjmsSuqY7IFsMRuw76K
	O0x33vwxAIclfLwtRriBpqcLswG4+FUvulZSk1kwCjjOiOMfL2RD71XvNkxESLT3
	6DtTQPHcC2ikfwjlD1gH1DqEXOxTrle5D6ewoU6hKt3xxkagqP3Qc6kmFHbmOWsk
	LmGg1YtOi+FOCT7XQ9fMCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762709745; x=
	1762796145; bh=zkWdqhs5qH8DQ5ZU8oXdGGm7z8JLhJ4sUco0+8wMPGI=; b=U
	q4E6ndlRwyc6WM9yDJcTjxjc2euuF6IQDBJK73X4ZMPCTulkxrHGhvurVMB5rwJ5
	iedSIPqIxBrvr3VhBG4ksxLL+REgOkxE0iN+hJqVGaxkMpu9uADFCp9d7lc2J4Qo
	JqSbfUSaYgyrp9mE98suHlUy0TxXEYf4V2OhRv1v1/4GQ9yv2JAw2+52t0SdB9IU
	COeQW+a99Ctxr+hVBOCOHV7dNvJC5btQlRc6/t/b5rC4MXd4gAkh3V+PYQTPJl3p
	x1/xNSccmgn/ia32xWSRDRzmRiwZ20fXCVnoiGQpJ+jCTwyjZ51jMfQbP4Z2nvpr
	VpG75lfqP1cTT31x3yLsg==
X-ME-Sender: <xms:79AQaZ2wy6V5TXmnLwhkimIMWJLDxM0K5DHiX8H8cqNkkd_X6IXSeg>
    <xme:79AQaa4UsmpW76Yo9_SS-ybD-W_6Na1uIdlmLGGK9qrZre74BTvjSUGIUxgqhthq7
    nfDglIw5fT6x7C5IEVYzg1x6ayYAqZSgh3ppHrXOGRPMgb_y62f3hep>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepuefgiedtueetkeegkefgteegvefhtefhvdfhfeeuffekvddtfefhfeejueekkeet
    necuffhomhgrihhnpehsthgrtghkohhvvghrfhhlohifrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdgu
    vgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghp
    thhtoheplhhlvhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhorh
    gvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprggrlhgs
    vghrshhhsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvihgusehrvgguhhgrth
    drtghomhdprhgtphhtthhopehjuhhrihdrlhgvlhhlihesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhhuhhthh
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepvhhstghhnhgvihgusehrvgguhhgrthdr
    tghomh
X-ME-Proxy: <xmx:79AQaUX-mRTHMaM8KXxIdPB723EQLQbLF3CToa1sSuZFpQU0giZskQ>
    <xmx:79AQaU4LIQtHJ_igqGA1sGDOhr30DVAUcyPPDHCqoebdCRBAM5vIQA>
    <xmx:79AQaaCGFzfr0euNv1R_ImVIE-bDa3Zgxx5fLpuProtCZQuXH3oLfA>
    <xmx:79AQaQfRvLyJP0kEFoWE3XMqSqUqYHxHzrgLR1edv7irXAlH2kaVDA>
    <xmx:8NAQafBae_4ppLQQE0o9JLUmdbyk9ps1jColVmL90Iyhbg-_r-ja8GrV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D39AC700065; Sun,  9 Nov 2025 12:35:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APT2ySTFY01B
Date: Sun, 09 Nov 2025 18:35:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Xie Yuanbin" <qq570070308@gmail.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "David Hildenbrand" <david@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Segher Boessenkool" <segher@kernel.crashing.org>, riel@surriel.com,
 "Russell King" <linux@armlinux.org.uk>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, pjw@kernel.org,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Heiko Carstens" <hca@linux.ibm.com>, gor@linux.ibm.com,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Andy Lutomirski" <luto@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "James Clark" <james.clark@linaro.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Benjamin Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
 "Valentin Schneider" <vschneid@redhat.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>,
 "Thomas Huth" <thuth@redhat.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Andrey Albershteyn" <aalbersh@redhat.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, david@kernel.org,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, max.kellermann@ionos.com,
 "Ryan Roberts" <ryan.roberts@arm.com>, nysal@linux.ibm.com,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
 "Will Deacon" <will@kernel.org>
Message-Id: <a034a57e-d9f1-4c56-87f0-e9126246849d@app.fastmail.com>
In-Reply-To: <20251109170402.145012-1-qq570070308@gmail.com>
References: <20251109113152.GA2545891@noisy.programming.kicks-ass.net>
 <20251109170402.145012-1-qq570070308@gmail.com>
Subject: Re: [PATCH v2 3/4] Provide the always inline version of some functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Nov 9, 2025, at 18:04, Xie Yuanbin wrote:
> On Sun, 9 Nov 2025 12:31:52 +0100, Peter Zijlstra wrote:
> Adding the always-inline version of these functions can provide better
> guidance for compiler optimization, but it does indeed lead to more
> complex code.
> The best solution may be to prompt the compiler to always inline at a
> specific calling point through some keyword.
> I noticed that there are also people discussing this issue on stackerflow
> , but it seems that the current compiler does not have such a feature.
> Link: https://stackoverflow.com/questions/14571593

You can mark the caller as __attribute__((flatten)) to force all
functions to be inlined into that one if possible. I don't know
if that would be helpful or desired here though.

     Arnd
