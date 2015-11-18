Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 18 Nov 2015 17:55:37 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [GIT PULL] s390 patches for 4.4-rc2
Message-ID: <20151118175537.0216ce69@mschwide>
In-Reply-To: <CA+55aFzG+Rysab3ei4rfAG6fYgUfRgZM1Pg46wrO4zhjfOus+A@mail.gmail.com>
References: <20151118164225.0c0f4011@mschwide>
	<CA+55aFzG+Rysab3ei4rfAG6fYgUfRgZM1Pg46wrO4zhjfOus+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 18 Nov 2015 08:43:07 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Nov 18, 2015 at 7:42 AM, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> >
> > Assorted bug fixes, the mlock2 system call gets added, and one improvement.
> > The boot from dasd devices is not possible from a wider range of devices.
> 
> Is that "not possible" perhaps meant to be a "now possible"? I'm not
> quite sure what that sentence is supposed to mean otherwise without
> more context.

Yes, for sure it is. Stupid typos ..

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
