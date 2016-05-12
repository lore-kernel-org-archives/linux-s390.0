From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table (in entry.S) to use it
Date: Thu, 12 May 2016 11:21:42 +0200
Message-ID: <2733875.IzutTZKHMc@wuerfel>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com> <4989778.Fs81NJurjH@wuerfel> <20160512091758.GB11226@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20160512091758.GB11226@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, heiko.carstens@de.ibm.com, Yury Norov <ynorov@caviumnetworks.com>, Hanjun Guo <guohanjun@huawei.com>, joseph@codesourcery.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "jijun (D)" <jijun2@huawei.com>, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de, pinskia@gmail.com, klimov.linux@gmail.com, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kernel@lists.infradead.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Thursday 12 May 2016 10:17:58 Catalin Marinas wrote:
> On Wed, May 11, 2016 at 09:30:07PM +0200, Arnd Bergmann wrote:
> > On Wednesday 11 May 2016 17:59:01 Catalin Marinas wrote:
> > 
> > I don't think the shifts are a problem, the main downside would be
> > the limit to 44 bits of file offsets (16TB files), but it's also
> > unclear if that is a practical problem at all. If it is, we run
> > into the same problem on all other 32-bit architectures too.
> 
> I hope people are seriously thinking of moving to an LP64 ABI if they
> have such large file offset needs.

Good point. 44 bits of file size is certainly enough for mmap()
on a 32-bit task: you would only be able to map a very small fraction
of the file anyway, and if you want to map larger files, and should
move to 64-bit tasks long before this becomes a limitation.

	Arnd
