Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90]:23777 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfFECiF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jun 2019 22:38:05 -0400
MIME-Version: 1.0
References: <20190604101409.2078-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190604101409.2078-1-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 5 Jun 2019 11:37:21 +0900
Message-ID: <CAK7LNAQ50Lnz+1hjHg2PK_h7DyfNkY7D1XGL5_VPDe5xLgx2Kw@mail.gmail.com>
Subject: Re: [PATCH 00/15] kbuild: refactor headers_install and support
 compile-test of UAPI headers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Song Liu <songliubraving@fb.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Palmer Dabbelt <palmer@sifive.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Yonghong Song <yhs@fb.com>, arcml <linux-snps-arc@lists.infradead.org>, Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, Jani Nikula <jani.nikula@intel.com>, Greentime Hu <green.hu@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Michal Marek <michal.lkml@markovi.net>, linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin KaFai Lau <kafai@fb.com>

On Tue, Jun 4, 2019 at 7:15 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
>
> Multiple people have suggested to compile-test UAPI headers.
>
> Currently, Kbuild provides simple sanity checks by headers_check
> but they are not enough to catch bugs.
>
> The most recent patch I know is David Howells' work:
> https://patchwork.kernel.org/patch/10590203/
>
> I agree that we need better tests for UAPI headers,
> but I want to integrate it in a clean way.
>
> The idea that has been in my mind is to compile each header
> to make sure the selfcontainedness.


For convenience, I pushed this series at

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
uapi-header-test-v1

(13/15 was replaced with v2)


If you want to test it quickly, please check-out it, then

  $ make -j8 allmodconfig usr/

(As I noted in the commit log, you need to use
a compiler that provides <stdlib.h>, <sys/time.h>, etc.)


-- 
Best Regards
Masahiro Yamada
