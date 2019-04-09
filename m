Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-5-arnd@arndb.de>
 <8875e0b6-00b4-884d-fd6a-a5a144543559@linux.ibm.com>
In-Reply-To: <8875e0b6-00b4-884d-fd6a-a5a144543559@linux.ibm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 9 Apr 2019 12:13:52 +0200
Message-ID: <CAK8P3a1Ckp+RMCUzB+KoUUSL9ExRc5TkU7qC8hcscm9yLnGcxg@mail.gmail.com>
Subject: Re: [PATCH 05/12] s390: zcrypt: initialize variables before_use
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>, Ingo Franzki <ifranzki@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 9, 2019 at 11:54 AM Harald Freudenberger
<freude@linux.ibm.com> wrote:
> On 08.04.19 23:26, Arnd Bergmann wrote:

> Thanks Arnd, but as Nathan already wrote, I'd prefer to have the
> variable initialized with 0 instead of -1.
> If you agree with this, I'll rewrite the patch and apply it to our
> internal git and it will appear at kernel org with the next s390 code merge then.

That's fine with me, I don't care about the specific value that gets
assigned here.

Thanks,

      Arnd
