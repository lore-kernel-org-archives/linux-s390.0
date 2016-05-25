From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Wed, 25 May 2016 13:50:39 -0700 (PDT)
Message-ID: <20160525.135039.244098606649448826.davem@davemloft.net>
References: <20160525200327.GA22395@yury-N73SV>
	<20160525.132145.1271448744307448631.davem@davemloft.net>
	<6293194.tGy03QJ9ME@wuerfel>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <6293194.tGy03QJ9ME@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de
Cc: ynorov@caviumnetworks.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 25 May 2016 22:47:33 +0200

> If we use the normal calling conventions, we could remove these overrides
> along with the respective special-case handling in glibc. None of them
> look particularly performance-sensitive, but I could be wrong there.

You could set the lowest bit in the system call entry pointer to indicate
the upper-half clears should be elided.
