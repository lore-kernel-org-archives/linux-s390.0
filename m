Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20151118164225.0c0f4011@mschwide>
References: <20151118164225.0c0f4011@mschwide>
Date: Wed, 18 Nov 2015 08:43:07 -0800
Message-ID: <CA+55aFzG+Rysab3ei4rfAG6fYgUfRgZM1Pg46wrO4zhjfOus+A@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for 4.4-rc2
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 18, 2015 at 7:42 AM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> Assorted bug fixes, the mlock2 system call gets added, and one improvement.
> The boot from dasd devices is not possible from a wider range of devices.

Is that "not possible" perhaps meant to be a "now possible"? I'm not
quite sure what that sentence is supposed to mean otherwise without
more context.

               Linus
