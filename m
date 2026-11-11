Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392601;
	b=crOvm05M58Lq6PaJ4q8b5t0bpulR5TPHUmheY9Kglpgkqcc1+QV5IUCFXS/R5gJ0sZX0
	 mIiY6fcZLl0uAVEa723Q+MekLavHCEf6WtxAcAxLXeBZInC3qWd42V4H6NGyz9e3FPE0v
	 9xylsHJNd9hRWS+ShToTjYjl3rNqIfG51/Pe2YEV73ptbJfNtAa418mYZT3aC9+ev6dlG
	 nWJ+NxauG+Gut47SED2l6PkMrbvMBoFnIIphWbLWMiwIEv1x918w9vUQEvYi+tZVzN0TY
	 lsAt/BILELm7UiLK4uKzeXtRnZLOU0Q6/U8hb84LE/WNGYteIzWxZqttYquPwVXa3aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392601;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=4ULj0NXijTq3R1zAP8uyHKnM0ACD9LxvphraQmHtKkA=;
	b=Vx55VDYMqUFMqRDUHfGIa/QSR/hkW5OBNRvfmpyzUx08w9AspyMuxWQdiVfE7BDKksiH
	 ygSw1mZ5gXYyuhtYD4RpaWFMWFcfEy6tIUWb2DKkDPfxZ0r1eqH566Mjmz+ovHniPlrF6
	 VNbYsWvxabeGyU+bstuWukxceg5wXYXJiii5ZWEA4ghXtTwxaTVegVgpfTnmYdEFrijBF
	 9+3hGUf1h1JYanLEf0K176u9z723uapxk3gbXNRWVvszD7UTnEsLSVE/Soy50K8q30rF3
	 EPKBCcimfyFwetYIjRJqgpqx1BS3jLv9e2cnO4baTSx7fVO9BN3b4CbKB8Ky4WU041w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=aeK3Uqod;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD69606A324;
	Wed, 11 Nov 2026 10:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDD69606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=aeK3Uqod
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4ULj0NXijTq3R1zAP8uyHKnM0ACD9LxvphraQmHtKkA=; b=aeK3UqodNlDWjBScGAVJ8KTmuy
	Cdsgqaz7P9Avj5eIOHiUlVFx1jai/GcydbFP8Lme3YNPd80i59nXuTrwAnZCoh2UpnUB7Ab0QFSb6
	BIwv7I13irUypCepClj8HBG8qoLa8ElVklAHKtygKB1scRfFjqKJR1sQODjuqVbbOW+Itf7sWqQES
	4VHlsEAfXSEC2aFEXu8zWClvKXtxHscqRVYyFct07Ng0+fKdPzikJO1Qw1ORI1IO3vgDSu1st2pSe
	Aqd8HRxQm15Q/TmeXKD9qUtvDSYkk9hBH8ljj2+H2+lcqjGTnOzjiyFeCyFSJTTneszC0+D/qMal+
	iSk6Bqcw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR5U3-000000091IT-1x2s;
	Wed, 11 Nov 2026 10:23:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 27E4B30025D; Wed, 11 Nov 2026 11:23:14 +0100 (CET)
Date: Wed, 11 Nov 2026 11:23:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>,
	Andreas Grapentin <gra@linux.ibm.com>,
	Finn Thain <fthain@linux-m68k.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: Re: [PATCH] [RFC] instrumented.h: mark instrument_write non-const
Message-ID: <20261111102314.GM1779021@noisy.programming.kicks-ass.net>
References: <20261111092231.2027735-1-arnd@kernel.org>
 <CANpmjNP5p-N6v=GiETYQMxgRMsOgKOdUjDCxSHj-6=pa4NkA8w@mail.gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP5p-N6v=GiETYQMxgRMsOgKOdUjDCxSHj-6=pa4NkA8w@mail.gmail.com>

On Wed, Nov 11, 2026 at 10:59:51AM +0100, Marco Elver wrote:
> On Wed, 11 Nov 2026 at 10:22, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > I got another instance of a -Wmaybe-uninitialized in ntfs, as this is
> > the only place that enables the warning:
> >
> > In file included from include/asm-generic/rwonce.h:26,
> >                  from fs/ntfs3/file.c:10:
> > In function 'instrument_copy_from_user_before',
> >     inlined from '_inline_copy_from_user' at include/linux/uaccess.h:184:2,
> >     inlined from 'copy_from_user' at include/linux/uaccess.h:222:9,
> >     inlined from 'ntfs_ioctl_fitrim' at fs/ntfs3/file.c:78:6,
> >     inlined from 'ntfs_ioctl' at fs/ntfs3/file.c:246:10:
> > include/linux/kasan-checks.h:38:27: error: 'range' may be used uninitialized [-Werror=maybe-uninitialized]
> >    38 | #define kasan_check_write __kasan_check_write
> > include/linux/instrumented.h:146:9: note: in expansion of macro 'kasan_check_write'
> >   146 |         kasan_check_write(to, n);
> >       |         ^~~~~~~~~~~~~~~~~
> > include/linux/kasan-checks.h: In function 'ntfs_ioctl':
> > include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
> >    20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
> >       |      ^~~~~~~~~~~~~~~~~~~
> > fs/ntfs3/file.c:66:29: note: 'range' declared here
> >    66 |         struct fstrim_range range;
> >       |                             ^~~~~
> >
> > The problem here is that copy_from_user() is called on an uninitialized
> > object, but the instrumentation passes the pointer into a function that
> > takes a const object. gcc deduces that any access to that object is
> > undefined behavior and warns about it.
> >
> > The only workaround I could come up with is to remove the 'const' keyword
> > from these annotations, which of course is not great either, as the
> > functions do not actually access the data at all.
> 
> Agree, but the code where a real 'write' happens ought to never pass
> in a const-qualified variable or pointer anyway, so I think it's fine.
> 
> > This also found incorrect 'const' annotations in
> > arch/s390/include/asm/fpu-insn.h, which writes to those pointers.
> 
> That looks like a bug. Maybe split it into a separate patch.
> 
> > Any ideas?
> >
> > Fixes: 33b75c1d884e ("instrumented.h: allow instrumenting both sides of copy_from_user()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> If there are no warnings that appear because of this elsewhere, then:
> 
> Acked-by: Marco Elver <elver@google.com>

Yeah, this looks sane enough for me too. Shall I take this (after s390
acks it), or do we want to have it sit in a CI first?
