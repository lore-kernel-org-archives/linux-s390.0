From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH v6 00/21] ILP32 for ARM64
Date: Wed, 25 May 2016 19:41:32 +0300
Message-ID: <20160525164132.GB4595@yury-N73SV>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
 <5745817C.1070406@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5745817C.1070406@arm.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, nd@arm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 25, 2016 at 11:42:04AM +0100, Szabolcs Nagy wrote:
> On 24/05/16 01:04, Yury Norov wrote:
> > This version is based on kernel v4.6.
> > It works with glibc-2.23, and tested with LTP.
> > 
> ...
> > ILP32 glibc branch is available here:
> > https://github.com/norov/glibc/tree/ilp32-2.23
> > 
> > It is tested with this series with no major downsides. I will send it to 
> > glibc-alpha soon, after final revise. Please review and comment it as well.
> 
> i spotted one __ilp32__ vs __ILP32__ typo in the glibc code,

Yes, I also found it. Thank you.

> i can review it in detail when there is a cleaned up patch set.
> 
> in general the approach seems ok, the ugly part is when lp64
> and ilp32 share code, but ilp32 needs some tweaks compared to
> the current code (e.g. x vs w regs in asm, long changed to
> long long in syscalls, different relocations etc) those will
> be hard to review. the naming is sometimes _be_ilp32 sometimes
> ilp32_be, but let's hope there will be no new abi variant to
> confuse this further.

I think I shared the link too soon, and patches should be revised 
again. So I continue the work on it. If you curious, find it here.
https://github.com/norov/glibc/tree/ilp32-dev
(I don't promise I'll keep it stable, or will avoid using things like
fast-forward. It's just a branch for my experiments.)

For now, it has fixed:
 - __ilp32__ mess (by introducing DELOUSE() macro);
 - few unneeded patches dropped;
 - 32-bit off_t turned to 64-bit.

With all changes, LPT fail list grows:
peio_3                       FAIL       5    
pipeio_6                       FAIL       1    
abort01                        FAIL       2    
clone02                        FAIL       4    
fcntl11                        FAIL       1    
fcntl14                        FAIL       1    
fcntl17                        FAIL       1    
fcntl19                        FAIL       1    
fcntl20                        FAIL       1    
fcntl21                        FAIL       1    
fpathconf01                    FAIL       1    
ftruncate04                    FAIL       1    
kill11                         FAIL       2    
mmap16                         FAIL       6    
open12                         FAIL       2    
pread01                        FAIL       2    
pread02                        FAIL       2    
pread03                        FAIL       2    
preadv01                       FAIL       6    
preadv02                       FAIL       6    
pwrite01                       FAIL       2    
pwrite02                       FAIL       2    
pwrite04                       FAIL       6    
pwrite02_64                    FAIL       1    
pwritev01                      FAIL       2    
pwritev02                      FAIL       2    
rename11                       FAIL       2    
rmdir02                        FAIL       2    
umount2_01                     FAIL       2    
umount2_02                     FAIL       2    
umount2_03                     FAIL       2    
utime06                        FAIL       2    
mtest01                        FAIL       1    
mtest01w                       FAIL       1    
mtest06                        FAIL       11   
gf01                           FAIL       1    
gf02                           FAIL       1    
gf07                           FAIL       1    
gf10                           FAIL       1    
gf11                           FAIL       1    
gf15                           FAIL       1    
gf18                           FAIL       1    
gf19                           FAIL       1    

Yury
