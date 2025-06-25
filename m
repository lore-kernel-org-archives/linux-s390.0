Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E79E25E806;
	Wed, 25 Jun 2025 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854083; cv=none; b=UCfays6U3p76bIYIxXqjYtjXX9CbZKdDMNQQTG7xQyVNoLF1rn+XN7mIpTmCNPlUaFsKhSmEY/6+j7tYoCuEDeKI+4eH3s0AEphMgazHFk2I+wycf4RHmc2Sx0uhal6I6oZ9cpmOE3uPkOxICvW2RnxJIu8ulepjCTLPzo6M7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854083; c=relaxed/simple;
	bh=j9lxAywOv5yt4LeQ6A3AxT624fpEB3GL4l9rgh6gKj8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OjWncCcpEEB441kwaMnil4R5UBP5vXajxu5F22S1LZFiRBlJ4T+ZCDOyGw0KYXNbbW9JRdneHyAng+tvVISKDun8AheBEtq2zB1d8J7xVmGsgT32d8no66MryM3c0fq/ETAz2Rv/DRuqTk10RFVoBpWOhjIXmY+0vzCMXEHYop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=D/cOxRnO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="D/cOxRnO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j9lxAywOv5yt4LeQ6A3AxT624fpEB3GL4l9rgh6gKj8=;
	t=1750854081; x=1752063681; b=D/cOxRnO7VMqyRtGInj2VexJGr2raup6RlPuGSVHyN6lRqY
	wxmERjFFyTtHe3UyBYwGvO6/vhu/JsDhihck9/wkvkDMUALxRdPwSMJ9y/LHmLPxyxBeiAxD2dWhM
	2EkoXrhRyRM/pJS5/3lHBj0ADeol0FzhbYYu1IQnHoJBw80hE+/9yeX0DzxFRhwMzD4zvhFy4ABnT
	7eKTYQme/O6mGvrfdldpDPEApYfHyl01qIEnkgVVFV3G6NSpZ28FBZtNE4+ZyDxoc6b8ALPOXmdsL
	d4YBPGGdrHDY8D2dAbR1SfwdlfQSFsFigZvecjKVaK+0fqdMc1jA2VqkFJyAIMrQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uUP7I-00000009xkX-2M7X;
	Wed, 25 Jun 2025 14:20:40 +0200
Message-ID: <dd87fa28e596126536d79281e87e2e0f52d9dfd4.camel@sipsolutions.net>
Subject: Re: [PATCH 6/9] kasan/um: call kasan_init_generic in kasan_init
From: Johannes Berg <johannes@sipsolutions.net>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com, 
	glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, catalin.marinas@arm.com, will@kernel.org, 
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
 mpe@ellerman.id.au, 	npiggin@gmail.com, christophe.leroy@csgroup.eu,
 hca@linux.ibm.com, 	gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, 	svens@linux.ibm.com, richard@nod.at,
 anton.ivanov@cambridgegreys.com, 	dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, 	tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	chris@zankel.net, jcmvbkbc@gmail.com, akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com, geert@linux-m68k.org, rppt@kernel.org, 
	tiwei.btw@antgroup.com, richard.weiyang@gmail.com, benjamin.berg@intel.com,
 	kevin.brodsky@arm.com, kasan-dev@googlegroups.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Date: Wed, 25 Jun 2025 14:20:38 +0200
In-Reply-To: <20250625095224.118679-7-snovitoll@gmail.com> (sfid-20250625_115328_891177_CC2D325A)
References: <20250625095224.118679-1-snovitoll@gmail.com>
	 <20250625095224.118679-7-snovitoll@gmail.com>
	 (sfid-20250625_115328_891177_CC2D325A)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-06-25 at 14:52 +0500, Sabyrzhan Tasbolatov wrote:
> Call kasan_init_generic() which enables the static flag
> to mark generic KASAN initialized, otherwise it's an inline stub.
>=20
> Delete the key `kasan_um_is_ready` in favor of the global static flag in
> linux/kasan-enabled.h which is enabled with kasan_init_generic().
>=20
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218315
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>

Looks fine, I guess. You can test/build it without qemu - on x86 - by
using 'make ARCH=3Dum' or so.

I'm assuming it'll go through some kasan tree since there are
dependencies:

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes
