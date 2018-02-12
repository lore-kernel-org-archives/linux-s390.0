Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 12 Feb 2018 12:29:40 +0100
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/17] s390/kexec_file: Add kexec_file_load system call
In-Reply-To: <CAOFm3uFfXZZuQ6cM=pi34ybxM37BQVz08ctJmh5LryVGVgEjjA@mail.gmail.com>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
        <20180212100754.55121-15-prudo@linux.vnet.ibm.com>
        <CAOFm3uFfXZZuQ6cM=pi34ybxM37BQVz08ctJmh5LryVGVgEjjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180212122940.2238fdd0@ThinkPad>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: kexec@lists.infradead.org, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 12 Feb 2018 11:56:25 +0100
Philippe Ombredanne <pombredanne@nexb.com> wrote:

> On Mon, Feb 12, 2018 at 11:07 AM, Philipp Rudo <prudo@linux.vnet.ibm.com> wrote:
> > This patch adds the kexec_file_load system call to s390 as well as the arch
> > specific functions common code requires to work. Loaders for the different
> > file types will be added later.
> >
> > Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>  
> 
> <snip>
> 
> > --- /dev/null
> > +++ b/arch/s390/kernel/machine_kexec_file.c
> > @@ -0,0 +1,174 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */  
> 
> I know this may sound weird but in .c files this should be instead:
> 
> // SPDX-License-Identifier: GPL-2.0
> 
> See Documentation/process/license-rules.rst for why.

Oups, you are right. I fixed it locally for all files.

Thanks for pointing this out
Philipp
