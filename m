Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-4-arnd@arndb.de>
 <20190408221632.GB18333@archlinux-i9>
In-Reply-To: <20190408221632.GB18333@archlinux-i9>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 9 Apr 2019 08:44:56 +0200
Message-ID: <CAK8P3a1GugkfpM7az6JDs4hQh-7CFz4VjykGspVD=-VSFgAX0Q@mail.gmail.com>
Subject: Re: [PATCH 04/12] s390: qeth: address type mismatch warning
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, linux-s390 <linux-s390@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 9, 2019 at 12:16 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Apr 08, 2019 at 11:26:17PM +0200, Arnd Bergmann wrote:
> > clang produces a harmless warning for each use for the qeth_adp_supported
> > macro:
> >
> > drivers/s390/net/qeth_l2_main.c:559:31: warning: implicit conversion from enumeration type 'enum qeth_ipa_setadp_cmd' to
> >       different enumeration type 'enum qeth_ipa_funcs' [-Wenum-conversion]
> >         if (qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
> >             ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/s390/net/qeth_core.h:179:41: note: expanded from macro 'qeth_adp_supported'
> >         qeth_is_ipa_supported(&c->options.adp, f)
> >         ~~~~~~~~~~~~~~~~~~~~~                  ^
> >
> > Add a version of this macro that uses the correct types, and
> > remove the unused qeth_adp_enabled() macro that has the same
> > problem.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I wonder if it is better to just change the func parameter to type long.
> I guess it's better to keep the type safety to make sure values aren't
> unintentionally mixed but the body of the functions is the same so does
> the type actually matter?

I think using the right enum type makes most sense here, as this seems
to be something that is easy to confuse.

      Arnd
