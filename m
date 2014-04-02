Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20140402091445.65c6b660@mschwide>
References: <20140331092400.17071766@mschwide>
	<CA+55aFzPP6kBzWrcvps6NVu=f-FUtrfs1U6DyRpdwX6hH6PM-Q@mail.gmail.com>
	<20140401085218.72f67e51@mschwide>
	<alpine.LFD.2.11.1404010827140.26309@i7.linux-foundation.org>
	<20140402091445.65c6b660@mschwide>
Date: Wed, 2 Apr 2014 13:19:36 -0700
Message-ID: <CA+55aFzJw4DrsMnr-D-gC18UJZsFB9kC_7F1PAYJA5X8Yb4+QQ@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 3.15 merge window
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 2, 2014 at 12:14 AM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> Part of the problem is this lovely piece from include/linux/preempt.h:

Oh, the pain. That's annoying. Oh well. I guess we'll live with the
ugliness for now.

         Linus
