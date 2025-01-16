Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592222A4CF
	for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033777; cv=none; b=kqlAshzyO9y5IjJnSskwjwLl7Z4lAnGTtMskBFTexclIRNqH+GNV9sN09M8zMtTG/Z+Si7uLU8CeKPunfApJPsD/e6Od7lGCwTv8WIcSLDiTwuyKY7TDFZcb5Ar/+vjIZ4jxGETa5mhvJJeJB7aVOjVeNpLaDmLG+nHCPD20gr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033777; c=relaxed/simple;
	bh=SixtGEHyx0Ll20sNHrYW42AzL6XqkNRKNahYOvra4Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abX5ILykjcjlE9eNG6DzbH5O5MoTFZFZIMmKYuDPYK3Z032dYPZ2Y4t0+F6+zNW4z6XQkuyksYaSQzqMEfeeZw1vlrBb2ib6wQP5GxBXcnM3DxAyjN6dLGwBDoOKvGni/R+uYpZJGND1DtmokFTQTN8aqDu00GbSnHU5z7QoWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pNeyTU4W; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNeyTU4W"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467abce2ef9so221261cf.0
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2025 05:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737033774; x=1737638574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SixtGEHyx0Ll20sNHrYW42AzL6XqkNRKNahYOvra4Ow=;
        b=pNeyTU4Wee181wY3gln1ZIsC2nfANHQigyORUUwhis5a/svsy2XSo7Xam0g0o1qqxH
         OV3IvX1Out0hM4WPFsipP6vuKmYyJ0K4x3mCSX4VAm5Xm3S3TDsbIIUx8pK64aicKtiX
         xLd8HeF9oG/oYmGWVbBqaGW2jBtGfU+H0aSB0gMnTEscXsxaK9xgNowcUys3eHXReWdL
         Z0oCT9i8ZxEJFZTbhygdURDe70RmsV70bc+VhaYHHSGUf9PzREFnFp57vDH/WiuzlhNO
         iOepUKMRMDultudOy77sJhRbFXhTN0QNpa+Vw4mRHcSYaNPF0pG8HeqVuzyI87pcHCug
         VUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737033774; x=1737638574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SixtGEHyx0Ll20sNHrYW42AzL6XqkNRKNahYOvra4Ow=;
        b=dLs6B9bmNfUD6c2lGIivT8+nLEvpY299KjhK4gEZ4rWt2tYdLuPPyDCU6b+OzZyYZY
         eKXeO5n25tQ6x+Xe79nDgvNmgWik04s8OuCfGFyEPHen9WW82YE5sQvtCdAVJoP69JXJ
         2yGmyqmCp9jvpE3QIE9BY1ixaR5a1b0S1MITiJ0ehKBC7BIitADdlABw2su14c8+Xbw/
         ZGUEMyeMmpMvera9DSsG0m33d6jVVNZpKpBZ3qbVYvErpyfoQMAxST4P86YKbW20raqd
         QIbDnMyIaG5CLDjnWdUrwDuqWKA5NMsN9uGIowbgWORFHhU+57oUEg+C98QKAUDEcSyq
         GHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgAECC4BlcpJ7elNdZ2oLYZ5Bfgp1vOWLQia7UoMleNQdJmdK4z0lx5CD8Sxv6XiESS7uyH+YMZ61a@vger.kernel.org
X-Gm-Message-State: AOJu0YyvpGtkWMilP4aJtUP3fCC/vnWBdJDzAxfptlSUwFFK2OpR0sko
	z1dIhk7AT+FE3axcnUGKTQXbMszZowtlUQ2eEPxXaz29AtfJj6z7cmNmJzuJscDlTmmmZa+qOPi
	1x8C1E3+oJxIq7AMHjJYy7K936RK1lt8ssu7d
X-Gm-Gg: ASbGncuRrV+E1wYFH/vd6Q3VZ/2VEga8uq/ti3d7qJBkTtd2ayxUqu/o0ZrXa0hG8en
	ArL2vRm/OZiIz3A5ViGkUo4p74TMUr2UO4G9XuYn74YK0YOtuKifNjUkgEvYwxvpOsEg=
X-Google-Smtp-Source: AGHT+IGgdmm3+dKyYphBOJrkDF9RqCEL6Tsx6LZHIZIcfENKNOrXYM9LEzERENIX0F6hf0/LX3P/eN8RFihp6QDk6j4=
X-Received: by 2002:ac8:5f11:0:b0:466:7a06:2d03 with SMTP id
 d75a77b69052e-46e0545796amr2768561cf.1.1737033773706; Thu, 16 Jan 2025
 05:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
 <20250110-asi-rfc-v2-v2-1-8419288bc805@google.com> <20250116001858.GDZ4hQctZe_PFvJ0AJ@fat_crate.local>
 <20250116102747.GAZ4jfI9HG3K-PW7nf@fat_crate.local>
In-Reply-To: <20250116102747.GAZ4jfI9HG3K-PW7nf@fat_crate.local>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 16 Jan 2025 14:22:42 +0100
X-Gm-Features: AbW1kvbCtSg9vNMeYe9Cs6fkL4An-kckhSPmCiLhYkfVvSqDDbiTwg4NAXTmVUM
Message-ID: <CA+i-1C1sXC1tbo9ytuex0eBD3gUbQwnNP8rvOhCv=JV+oSHo1g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 01/29] mm: asi: Make some utility functions noinstr compatible
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <rppt@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jan 2025 at 01:21, Borislav Petkov <bp@alien8.de> wrote:
> > Unfortunately Thomas pointed out this will prevent the function from
> > being inlined at call sites in .text.
> >
> > So far I haven't been able[1] to find a formulation that lets us :
> > 1. avoid calls from .noinstr.text -> .text,
> > 2. while also letting the compiler freely decide what to inline.
> >
> > 1 is a functional requirement so here I'm just giving up on 2. Existing
> > callsites of this code are just forced inline. For the incoming code
> > that needs to call it from noinstr, they will be out-of-line calls.
>
> I'm not sure some of that belongs in the commit message - if you want to have
> it in the submission, you should put it under the --- line below, right above
> the diffstat.

Sure. I'm actually not even sure that for a [PATCH]-quality thing this
cross-cutting commit even makes sense - once we've decided on the
general way to solve this problem, perhaps the changes should just be
part of the commit that needs them?

It feels messy to have a patch that "does multiple things", but on the
other hand it might be annoying to review a patch that says "make a
load of random changes across the kernel, which are needed at various
points in various upcoming patches, trust me".

Do you have any opinion on that?

(BTW, since a comment you made on another series (can't find it on
Lore...), I've changed my writing style to avoid stuff like this in
comments & commit messages in general, but this text all predates
that. I'll do my best to sort all that stuff out before I send
anything as a [PATCH].)

On Thu, 16 Jan 2025 at 11:29, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jan 16, 2025 at 01:18:58AM +0100, Borislav Petkov wrote:
> > Long story short, lemme try to poke around tomorrow to try to figure out what
> > actually happens. It could be caused by the part of Rik's patches and this one
> > inlining things. We'll see...
>
> Looks transient... The very similar guest boots fine on another machine. Let's
> watch this...

Oh, I didn't notice your update until now. But yeah I also couldn't
reproduce it on a Sapphire Rapids machine and on QEMU with this patch
applied on top of tip/master (37bc915c6ad0f).
