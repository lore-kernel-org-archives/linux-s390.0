Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F403A8FF
	for <linux-s390@vger.kernel.org>; Wed, 21 Feb 2024 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501397; cv=none; b=br+7y5zog12nQBHn4oRaoFLuuybJmMKGPeUhXr4n5G18t7Dnun0kLru+mkRlIGhAcJxAB4ciUjEB2QyMWpGpZYltZTikj7Cv8g6EmTx1l6tMnI8UBdiaVWryFsvPxiRxU7PBpfTlStECn6Z4jDJjKGTLMPmJ9Hdsvj/utihNVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501397; c=relaxed/simple;
	bh=i+odruXpyZDoj4T7F8WmFZTqW3BkqIyHP+enJNkvL0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfDvkgvZo8mVJE6oPv5BMFLMHupkS3P7u+JeyaW/vfuxdN5pbI6ERjT9H0r5wgZqmv7Rh85Kd+sg4ZTDB2p/RsVCfVIrd5fclsjL9NoQ365zifJijKb/LnCNnnGK5keP7/iSUBAgrh2MopH745lm7SwwKFBuCKBZOa9byZjuUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nK6HEOCC; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nK6HEOCC"
Date: Wed, 21 Feb 2024 08:43:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708501393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AHnDceGRllGyFNwVPyWXmLC366QTA5U6qIHUNwq3W10=;
	b=nK6HEOCCA3Eu2DEU+TcbMEtKnxyqfX8YsIDv/VqRpUam3ioTYkbrj5SGaA/AK/NSr7gyoP
	pyFpzsZ66buwFwCYKu4rCN+k3RyWJ6ZPXA4f/Ry0bgbGHxDx1VwSmPIricXPXowq6w/QuS
	QB/AF8iF1IpXujmUUGzNyalGq/m2cA8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, 
	Laurent Vivier <lvivier@redhat.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Nico Boehr <nrb@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Eric Auger <eric.auger@redhat.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@redhat.com>, Marc Hartmayer <mhartmay@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org
Subject: Re: [kvm-unit-tests PATCH v5 7/8] Add common/ directory for
 architecture-independent tests
Message-ID: <20240221-5417524c1ca5d615f005c7d6@orel>
References: <20240221032757.454524-1-npiggin@gmail.com>
 <20240221032757.454524-8-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221032757.454524-8-npiggin@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 21, 2024 at 01:27:56PM +1000, Nicholas Piggin wrote:
> x86/sieve.c is used by s390x, arm, and riscv via symbolic link. Make a
> new directory common/ for architecture-independent tests and move
> sieve.c here.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arm/sieve.c    |  2 +-
>  common/sieve.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
>  riscv/sieve.c  |  2 +-
>  s390x/sieve.c  |  2 +-
>  x86/sieve.c    | 52 +-------------------------------------------------
>  5 files changed, 55 insertions(+), 54 deletions(-)
>  create mode 100644 common/sieve.c
>  mode change 100644 => 120000 x86/sieve.c
>

Acked-by: Andrew Jones <andrew.jones@linux.dev>
