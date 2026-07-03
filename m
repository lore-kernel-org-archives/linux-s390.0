Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44203B776D
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074451; cv=none; b=t/q8eA5F5fuM1d/OE0lCzYzD8A+eiqjfawWtePXgu9HoAZEZ8TkBVbWuU4sVIwkYO/oKNWJ1hCxp+fX5u9jC/FfN9iNP4bGdoobK6tnSkAAYKympR2t6WNaE0Bqf8L5bE42ujrbHp0RbGOYuyo5U2YTJWug7KOsdBffqM6Un0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074451; c=relaxed/simple;
	bh=qX3mh1ZmKRwgtJ/XXa2YTIP+rQRpYl70DOmHi35hP9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3YV4KfTbz57oWTezl6ThOfcVnXmgvThMAFmEqICmrdqKZUmETD9+qMwrDwJZIMBnQq1IyYVCK/d60XmsjR+Utb0hsXdauq95FSVzUIq46tawUve9iTuXpDaDiqVIIXJxHz6QPS1u3UUOksbpNJEuqhjUBBbWyeF6jNrCKpwAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F70A74890;
	Fri,  3 Jul 2026 10:27:27 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Date: Fri, 3 Jul 2026 12:27:26 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
	oleg@redhat.com, richard.henderson@linaro.org, mattst88@gmail.com,
	linmag7@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
	will@kernel.org, kees@kernel.org, guoren@kernel.org,
	chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org,
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
	deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, chris@zankel.net,
	jcmvbkbc@gmail.com, peterz@infradead.org, wad@chromium.org,
	thuth@redhat.com, ada.coupriediaz@arm.com, kevin.brodsky@arm.com,
	linusw@kernel.org, yeoreum.yun@arm.com, song@kernel.org,
	james.morse@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
	liqiang01@kylinos.cn, pengcan@kylinos.cn, ryan.roberts@arm.com,
	yangtiezhu@loongson.cn, sshegde@linux.ibm.com,
	mchauras@linux.ibm.com, austin.kim@lge.com, jchrist@linux.ibm.com,
	arnd@arndb.de, thomas.weissschuh@linutronix.de,
	sohil.mehta@intel.com, andrew.cooper3@citrix.com, jgross@suse.com,
	kas@kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v16 01/18] seccomp: Convert __secure_computing() to
 return boolean
Message-ID: <akeOjqMy7HVgRRCr@kunlun.suse.cz>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-2-ruanjinjie@huawei.com>
 <akdp6GAu77-ipsXA@kunlun.suse.cz>
 <87cxx4mmim.ffs@fw13>
 <akeIK5TRCjlKbzbp@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akeIK5TRCjlKbzbp@J2N7QTR9R3>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 8F70A74890
X-Spam-Flag: NO
X-Spam-Score: -2.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-2.00 / 50.00];
	REPLY(-4.00)[];
	RDNS_NONE(2.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL1f5ktcu9q8c5toc5bju644qd)]

On Fri, Jul 03, 2026 at 11:00:11AM +0100, Mark Rutland wrote:
> On Fri, Jul 03, 2026 at 11:48:49AM +0200, Thomas Gleixner wrote:
> > On Fri, Jul 03 2026 at 09:51, Michal Suchánek wrote:
> > > On Mon, Jun 29, 2026 at 09:05:59PM +0800, Jinjie Ruan wrote:
> > >> -	if (secure_computing())
> > >> +	if (!secure_computing())
> > >>  		return -1;
> > >
> > > Hello,
> > >
> > > I am not fond of this logic inversion. The boolean is meaningless in
> > > itself.
> > >
> > > Previously -1 was used to indicate that the syscall was filtered but you
> > > chose to invert the logic choosing true to mean syscall was not filtered.
> > >
> > > You could choose true to mean that syscall was fitered avoiding this
> > > inversion.
> > 
> > That's just wrong. Boolean logic makes more sense with having
> > (!condition()). Just because the old 0/-1 nonsense had it the other way
> > round does not mean it has to stay that way.
> 
> 100% agreed!
> 
> Bikeshedding below; sorry.
> 
> I think the bigger problem is just that secure_computing() is a terrible
> name that does not express the intended semantic -- it's not clear
> whether "secure computing" means "seccomp permit the syscall" or
> "seccomp is enabled and some special rules now apply" or something else
> entirely.
> 
> If we're changing the return type, it might be worth renaming the
> function something like:
> 
> 	seccomp_permits_syscall()

Then not only it is clear which way the boolean value should be
interpreted, it also pervents the accidental inversion of existing
calls. Overall great.

Thanks

Michal
