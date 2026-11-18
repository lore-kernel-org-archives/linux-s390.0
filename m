Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016832;
	b=hR1ckGNCd+DR52NEQ/Q/V2zxfl+oX12BZWdNMkLKfwfQ/enT0zL6BYRVkOc4Ku0M9nzQ
	 kZxpYip7CB/k+KXM72s1k94r0qBcbT6efL0LYlcjM17CLLl7wB0QcerM28WERlMMcKRCr
	 YEvnCB1orxThqmj/b/SS7dBvBtmGM4+L/dZ4ue7QRglrrzwotX/t+h3Qqg76lVPNSPv03
	 RqxKra2/IftW1Bf56Ji17V3L+3WdbZ2vUFIeDYQ0GZ6hPu7UkNWWa0h8n51oTnG62OF6P
	 EKIQ5Wfp86aKlJJqsz1nQ2VqD4BCJ0ObQ5h3s9nHBmIg+Y+21eQLvIDJVl2fiYQuOCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016832;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Rspamd-Pre-Result:
	 X-Rspamd-Server:X-Spamd-Result:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:X-Rspamd-Action;
	bh=flMGPLDMTpq68z1lJ74ODL+EiAGhlUNC3nFdUWIDwBE=;
	b=n/+lCBkNWBFu0jLHajKOPrG/TN+giYEFpzhI6B2xNxZBE32mrnXE6Ly++sTxnsiRg6ma
	 z4vb3Ur1+3WDEmUXYpCpZm3eha1BPQ7alsylOq3JwDNNsloYjTKk1x1pu+Kf1FEgTX2jI
	 Nm0ZLBpy7AyvavOYOgIhumpdT53ofxEx/kQ9ZXfjmwRiTEhAtFcju/dGX4FZYNXY6SSJr
	 yzufikrVtrX7AgZUty0qrhJbmafW6z6dHTT8pwuNph5XGENezJqUXVFVlxQy3KTHudzvB
	 ESooXWG2zyKI+M/l5aaOagwtGdINma9EqxOoO6+XcdQV5xheWQaDOxde0Ov90qTChxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B9606A320;
	Wed, 18 Nov 2026 15:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 468B9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A73A1F798;
	Wed, 18 Nov 2026 15:47:10 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Date: Wed, 18 Nov 2026 16:47:09 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, "Dmitry V . Levin" <ldv@strace.io>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Davide Berardi <berardi.dav@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org, strace-devel@lists.strace.io
Subject: Re: [PATCH v11 0/3] PTRACE_SET_SYSCALL_INFO: add support for seccomp
 syscall skipping
Message-ID: <av3Ifd4saO2_6Slq@kunlun.suse.cz>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <av2PKIf8YsEPro8O@kunlun.suse.cz>
 <av2i9kbZyMRJE9D6@cs.unibo.it>
 <av2pRG1JT9te8IiM@kunlun.suse.cz>
 <av2yDgdBWfTxvZca@cs.unibo.it>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <av2yDgdBWfTxvZca@cs.unibo.it>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 5A73A1F798
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

On Wed, Nov 18, 2026 at 03:11:26PM +0100, Renzo Davoli wrote:
> On Wed, Nov 18, 2026 at 02:33:56PM +0100, Michal Suchánek wrote:
> > As I understand it the new s390 code resolves the problem by storing the
> > syscall number outside of the registers. Then the return value can be
> > set directly. It does not depend on using the generic entry but on the
> > architecture adding storage for the syscall number in struct pt_regs,
> > and implementing the code to determine where to get/set the syscall
> > value depending on the syscall stage.
> 
> Right, thanks for the correction: what matters is a separate storage
> for the syscall number on the architectures where it shares a register
> with the return value, not the generic entry code.
> 
> > However, it seems that extending struct pt_regs breaks userspace ABI
> > (probably because kernel refuses to transfer partial pt_regs to/fom
> > userspace) which makes it unclear how the int_code that is used by this
> > new code could be added to the s390 struct pt_regs in the first place.
> 
> On s390 int_code is not new: it has been in the kernel-only part of
> struct pt_regs, after user_pt_regs, since aa33c8cbbae2 ("[S390] cleanup
> trap handling"), and the user ABI (s390_regs, user_regs_struct) does
> not include it. Heiko's patch only redirects the ptrace accesses to
> gpr2.
> 
> On architectures where struct pt_regs is itself the user ABI (e.g.
> alpha), the storage does not need to be in pt_regs: MIPS already keeps
> the syscall number in thread_info.
> 
> This is also why this series uses a per-task flag at the seccomp stop:
> it does not depend on where the architecture stores the syscall
> number.

It does not have to know where the architecture stores the syscall
number when using syscall_get_nr and syscall_set_nr. However, the
storage for the syscall number has to be somewhere, and for powerpc
there is AFAIK no such storage.

Thanks

Michal
