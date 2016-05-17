From: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Date: Tue, 17 May 2016 15:45:11 +0000
Message-ID: <alpine.DEB.2.20.1605171542340.24255@digraph.polyomino.org.uk>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com> <573B0A4D.4090704@arm.com> <4173531.IRSphtVpg9@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <4173531.IRSphtVpg9@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>, Yury Norov <ynorov@caviumnetworks.com>, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nd@arm.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, broonie@kernel.org, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, agraf@suse.de, klimov.linux@gmail.com, bamvor.zhangjian@huawei.com, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, christoph.muellner@theobroma-systems.com, GNU C Library <libc-alpha@sourceware.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 17 May 2016, Arnd Bergmann wrote:

> I think it has become easier to override now and we just need to
> update sysdeps/unix/sysv/linux/generic/bits/typesizes.h to set
> 
> #define __INO64_T_TYPE          __UQUAD_TYPE
> #define __OFF64_T_TYPE          __UQUAD_TYPE
> #define __OFF_T_MATCHES_OFF64_T        1
> #define __INO_T_MATCHES_INO64_T        1
> 
> for new architectures (obviously not the ones that already use the
> 32-bit types). I haven't tries this, so there may be other things
> that are required.

I think more than that would be needed to get struct stat to match and get 
things aliased for that (which is presumably desirable).

-- 
Joseph S. Myers
joseph@codesourcery.com
