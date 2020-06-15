Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200615130032.931285-1-hch@lst.de>
In-Reply-To: <20200615130032.931285-1-hch@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 15 Jun 2020 15:42:51 +0200
Message-ID: <CAK8P3a3CWhrfyR4taGip8xE3U6HcRMtKBY5A69_cqzJwU1N+Cw@mail.gmail.com>
Subject: Re: properly support exec and wait with kernel pointers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Luis Chamberlain <mcgrof@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 15, 2020 at 3:00 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> this series first cleans up the exec code and then adds proper
> kernel_execveat and kernel_wait callers instead of relying on the fact
> that the early init code and kernel threads implicitly run with
> the address limit set to KERNEL_DS.
>
> Note that the cleanup removes the compat execve(at) handlers (almost)
> entirely, as we can handle the compat difference very nicely in a
> unified codebase.  The only exception is x86 where this would list the
> handlers twice in the same syscall table due to the messed up x32
> design.  I had to add an extra compat handler just for that case, but
> maybe someone has a better idea.

I looked at all the patches and I like it a lot. I replied with some suggestions
for x32, but maybe I misunderstood what its problem is, as I don't see
anything preventing us from having two entries in the x32 table pointing
to the same function.

       Arnd
