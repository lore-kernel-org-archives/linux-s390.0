Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7EB3ACA5E;
	Wed,  8 Jul 2026 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783544299; cv=none; b=oa7FfvkRphbZDe1cxWwrAav/lgtFf9KI5FsON1GrD+9A/BWb3FmbwMI33F03Obcb7sUzDUBjNlrvuikO3Cp8Ny3GesZtTtJUYv9ETGLVJ2+CMhF9NkkUid3CvVexcEOHVP98Di8f3Er2PX+agjHMKZ7qV5KsnZpAHE4Qd8+gYv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783544299; c=relaxed/simple;
	bh=KapMEa4fkNwzhFYaHcDynpkcuOR37YUwMAHpBwDRVP4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nBBdYt8ph8Cfst0ZXh6Tz8PWXnIPBwhZdTfs3mBVVFywpVBprdpd/30YgM5XeNIyDxf3mrc8edCvz/qiEce4UgVNW3FCm54KM95QtHgnuAffM8tuw+ePN+x710UftTJW/iWfmgU58bsn34JHhDyclEAzsnnpJRb5PJkVYJi4GtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=ASe5j6xg; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="ASe5j6xg"
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 16270C3449;
	Wed,  8 Jul 2026 23:57:54 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 16270C3449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783544296;
	bh=hJBHj3v5/Gy9cfslRHy86J9BqBTgDtn5Jmjc8wTF3Qk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ASe5j6xgqpQoGzd8fN2p0AV5mCM1uJJHCeUg2Rlxt6R3B/rFXg4YDm9qyballB0nF
	 MeA/AN3+LNtRqPRnWZ4RGvlOENBWHlzAAxkuy1RqiTPYNETGIv1etVCKTLohwMPCoB
	 NT/6RCbGnbqh9lOdElft3AHTFq8jVQMEygtI/j0tzDA/4gvnPpYZvymBxJHR3zU5cs
	 Ryz4Il9J/Fs/gye2m6KRNK1BfV12o1cIIRYuxI4bkUCt9PsJIjMYawd5vkU/JPUcgj
	 eyZA8hvZdnwNhc4mJqzKcQusbBCBJYXxbEKsRMMMd2jYEyC+qotSrdgXnQbdMbEvhN
	 tyu/tFqF5098Q==
Message-ID: <c765cd31891e0c222cb78697e55c4caa6dd0bded.camel@rendec.net>
Subject: Re: [patch 07/18] s390/syscall: Use
 enter_from_user_mode_randomize_stack()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Sven Schnelle
 <svens@linux.ibm.com>, 	linux-s390@vger.kernel.org, Michael Ellerman
 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,  Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, x86@kernel.org, Mark Rutland	
 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski	 <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson	 <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>,  Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,  Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,  Richard Weinberger	
 <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann	
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>,  Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, 	linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, 	sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?ISO-8859-1?Q?Such=E1nek?=	
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org
Date: Wed, 08 Jul 2026 16:57:51 -0400
In-Reply-To: <20260707190254.030598804@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190254.030598804@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-07 at 21:06 +0200, Thomas Gleixner wrote:
> enter_from_user_mode_randomize_stack() replaces enter_from_user_mode() an=
d
> the subsequent invocation of add_random_kstack_offset_irqsoff().
>=20
> As a bonus this avoids the overhead of get/put_cpu_var() in
> add_random_kstack_offset().
>=20
> No functional change.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
> =C2=A0arch/s390/kernel/syscall.c |=C2=A0=C2=A0=C2=A0 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --- a/arch/s390/kernel/syscall.c
> +++ b/arch/s390/kernel/syscall.c
> @@ -97,8 +97,8 @@ void noinstr __do_syscall(struct pt_regs
> =C2=A0{
> =C2=A0	unsigned long nr;
> =C2=A0
> -	enter_from_user_mode(regs);
> -	add_random_kstack_offset();
> +	enter_from_user_mode_randomize_stack(regs);
> +
> =C2=A0	regs->psw =3D get_lowcore()->svc_old_psw;
> =C2=A0	regs->int_code =3D get_lowcore()->svc_int_code;
> =C2=A0	update_timer_sys();

Reviewed-by: Radu Rendec <radu@rendec.net>
