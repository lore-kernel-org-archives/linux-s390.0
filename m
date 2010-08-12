Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andreas Schwab <schwab@redhat.com>
Subject: Re: [PATCH] partitions: fix build error in ibm partition detection code
References: <20100812083104.GC7814@osiris.boeblingen.de.ibm.com>
Date: Thu, 12 Aug 2010 10:53:38 +0200
In-Reply-To: <20100812083104.GC7814@osiris.boeblingen.de.ibm.com> (Heiko
	Carstens's message of "Thu, 12 Aug 2010 10:31:04 +0200")
Message-ID: <m31va4nre5.fsf@hase.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Heiko Carstens <heiko.carstens@de.ibm.com> writes:

> -				strlcat(tmp, sizeof(tmp), "(nonl)", PAGE_SIZE);
> +				snprintf(tmp, sizeof(tmp), "(nonl)");
> +				strlcat(state->pp_buf, tmp, PAGE_SIZE);

What's the point of tmp and snprintf if it just creates a copy of a
constant string?

				strlcat(state->pp_buf, "(nonl)", PAGE_SIZE);

Andreas.

-- 
Andreas Schwab, schwab@redhat.com
GPG Key fingerprint = D4E8 DBE3 3813 BB5D FA84  5EC7 45C6 250E 6F00 984E
"And now for something completely different."
