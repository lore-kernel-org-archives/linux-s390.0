Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-5-arnd@arndb.de>
 <8875e0b6-00b4-884d-fd6a-a5a144543559@linux.ibm.com> <20190410175946.0e6d2b00@mschwideX1>
In-Reply-To: <20190410175946.0e6d2b00@mschwideX1>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Apr 2019 20:57:21 +0200
Message-ID: <CAK8P3a1-1axfWq5Y1pK9XORMdsbmZyq75p+V5Do71hNRowct+g@mail.gmail.com>
Subject: Re: [PATCH 05/12] s390: zcrypt: initialize variables before_use
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>, Ingo Franzki <ifranzki@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 10, 2019 at 5:59 PM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> On Tue, 9 Apr 2019 11:54:30 +0200 Harald Freudenberger <freude@linux.ibm.com> wrote:
> > On 08.04.19 23:26, Arnd Bergmann wrote:
> > >             }
> > Thanks Arnd, but as Nathan already wrote, I'd prefer to have the
> > variable initialized with 0 instead of -1.
> > If you agree with this, I'll rewrite the patch and apply it to our
> > internal git and it will appear at kernel org with the next s390 code merge then.
>
> Do we agreement on func_coed=0 for this one ?

Yes, I think that was the consensus.

       Arnd
