Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294840F732;
	Mon,  3 Aug 2026 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787755; cv=none; b=fyKn9S7AsOnUYIomheYg7ivL0slu74hs9llzqi9HxHggUo1OMoqE0LCvizfGFhl+PsrXKzz1/6qlNfOnYX0dKMHrTvg8HEzii6Ds8PmHubznwMu7hLHR6PliT1q57e/p6kknTw8h1y66F0mxLVR4j2T7Dt7EJWn9OiDgYhMvLpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787755; c=relaxed/simple;
	bh=6NbWN1XHjF1fj9AFwj/Mx9k9fsq6Ll+iCjCiEH37BuQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=p+EyDjgNA6pS/J/6Hn5d6kyKZvpH6OIXeA8eV5TALHM2M3cOf9f10Wwd/W5s4XNXNOq7R/pPl9a0B+XrP6BTKLqsBwKVAe5mDtbw1109gpp/yGzV74eEakmrqh4779NpQLpTZeYvRxAyMFug/naPdgApjRRkMDXTwwyQMS3a7qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/Em5m71; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/Em5m71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90731F00A3A;
	Mon,  3 Aug 2026 20:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785787753;
	bh=6NbWN1XHjF1fj9AFwj/Mx9k9fsq6Ll+iCjCiEH37BuQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=C/Em5m71NvwzWRGJ3FSJWVoI7YxUU+jCWSuSebR/QXetyubxXJT7svGlOe3j+hhpb
	 4MlE+gtSCSGC7eqTMeFM5VSiLmN8GK8ZJ10RphgA6libibRBvisF76UB8vti8IIODI
	 aHEH1dcL1gC5Jw8XsdxFo1nKF5DeaiOT4dgw7CyBO6WBXr3EB5K86H2nFnCgbWKeNt
	 JfK3Gm0JIYae9pVdClGqRt3om0aDemAJUobxYlyDViQEhrbWUY5BEzM4dO3pKWyWjB
	 87Ol3XbUcUdjyke1XhTT8rZZc/Z23+80GRm7RG+Q8JIQdkJgKqI6m3nHMnR2E5JpD1
	 ceP6+WSH6Sngw==
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 22:09:08 +0200
Message-Id: <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Heiko Carstens"
 <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, <driver-core@lists.linux.dev>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Sven Schnelle"
 <svens@linux.ibm.com>, <linux-s390@vger.kernel.org>, "Linux-Arch"
 <linux-arch@vger.kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260803180931.97202-1-ojeda@kernel.org>
 <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
In-Reply-To: <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>

On Mon Aug 3, 2026 at 9:56 PM CEST, Arnd Bergmann wrote:
> In theory you should be able to use rust code without PCI MMIO
> support, but I can't see any practical downsides to making rust
> 'depends on HAS_MMIO' to avoid having to add those #ifdef.

I think the implications should be minor without making Rust depend on
CONFIG_HAS_IOMEM.

I just sent out a fix [1]; the only annoying part is [2], but we should cha=
nge
those doc-tests anyway. For the one in rust/kernel/io.rs we already did in
driver-core-next.

[1] https://lore.kernel.org/driver-core/20260803200249.3494259-1-dakr@kerne=
l.org/
[2] https://lore.kernel.org/driver-core/20260803200249.3494259-2-dakr@kerne=
l.org/
