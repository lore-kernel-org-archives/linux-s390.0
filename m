Return-Path: <linux-kernel-owner+w=401wt.eu-S1757964AbZLIUzW@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] s390: ptrace: don't abuse PT_PTRACED
In-Reply-To: Heiko Carstens's message of  Wednesday, 9 December 2009 21:51:12 +0100 <20091209205112.GB4351@osiris.boeblingen.de.ibm.com>
References: <20091209194651.GA24919@redhat.com>
	<20091209205112.GB4351@osiris.boeblingen.de.ibm.com>
Message-Id: <20091209205442.866B8CF7B@magilla.sf.frob.com>
Date: Wed,  9 Dec 2009 12:54:42 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> Thanks, applied. Even though I'm wondering why tracehook_consider_fatal_signal
> has a signal parameter and doesn't do anything with it.
> Is that something that will change with utrace?

It doesn't change with utrace of today.  But it gives enough information
for future tracing implementations to change that logic without rejiggering
all the arch code.


Thanks,
Roland
