From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 24/25] arm64:ilp32: add vdso-ilp32 and use for signal return
Date: Fri, 29 Apr 2016 19:30:19 +0200
Message-ID: <1554541.oDP7Ro5zB2@wuerfel>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com> <1459894127-17698-25-git-send-email-ynorov@caviumnetworks.com> <20160429160154.GC30316@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160429160154.GC30316@e104818-lin.cambridge.arm.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, broonie@kernel.org, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, agraf@suse.de, klimov.linux@gmail.com, bamvor.zhangjian@huawei.com, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Friday 29 April 2016 17:01:55 Catalin Marinas wrote:
> On Wed, Apr 06, 2016 at 01:08:46AM +0300, Yury Norov wrote:
> > ILP32 VDSO exports next symbols:
> >  __kernel_rt_sigreturn;
> >  __kernel_gettimeofday;
> >  __kernel_clock_gettime;
> >  __kernel_clock_getres;
> 
> [...]
> 
> > +$(obj)/gettimeofday-ilp32.o: $(src)/../vdso/gettimeofday.S
> > +	$(call if_changed_dep,vdso-ilp32as)
> 
> Are struct timeval and timespec the same between ILP32 and LP64? For
> example, __kernel_gettimeofday() assumes TVAL_TV_SEC offset defined in
> asm-offsets.c based on the LP64 timeval.

No, ilp32 uses the generic 32-bit data structures, which have a 32-bit
time_t. I guess that means it can work for little-endian but not
big-endian, right?

	Arnd
