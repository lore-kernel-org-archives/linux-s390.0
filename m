From: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Date: Tue, 17 May 2016 15:40:47 +0000
Message-ID: <alpine.DEB.2.20.1605171538040.24255@digraph.polyomino.org.uk>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com> <573B0A4D.4090704@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <573B0A4D.4090704@arm.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nd@arm.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, broonie@kernel.org, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, agraf@suse.de, klimov.linux@gmail.com, bamvor.zhangjian@huawei.com, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, christoph.muellner@theobroma-systems.com, GNU C Library <libc-alpha@sourceware.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 17 May 2016, Szabolcs Nagy wrote:

> i think even legacy software should be able to deal with 64bit off_t,
> so we could avoid having two sets of filesystem apis or is 64bit-only
> off_t more work to do in linux/glibc?

wordsize-64 directories generally expect 64-bit interfaces.  wordsize-32 
directories generally expect that there are two sets of filesystem APIs 
which are not aliased (at the userspace level - the versions for the 
generic syscall API deal with setting EOVERFLOW in userspace as needed).

The "wordsize" concept is not wonderfully well-defined and could do with 
being split up into multiple better-defined concepts, but that's obvious 
something pretty tricky to get right, involving a very careful analysis of 
the existing code.

-- 
Joseph S. Myers
joseph@codesourcery.com
