From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 19/25] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
Date: Mon, 25 Apr 2016 17:57:21 +0100
Message-ID: <20160425165721.GH9614@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-20-git-send-email-ynorov@caviumnetworks.com>
 <20160422171009.GR2998@e104818-lin.cambridge.arm.com>
 <20160422214013.GA2234@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160422214013.GA2234@yury-N73SV>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, joseph@codesourcery.com, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Sat, Apr 23, 2016 at 12:40:13AM +0300, Yury Norov wrote:
> On Fri, Apr 22, 2016 at 06:10:09PM +0100, Catalin Marinas wrote:
> > On Wed, Apr 06, 2016 at 01:08:41AM +0300, Yury Norov wrote:
> > > Here new aarch32 ptrace syscall handler is introsuced to avoid run-time
> > > detection of the task type.
> > 
> > The reason for this patch isn't clear to me. What's wrong with the
> > run-time detection? It's not some performance critical code.
> 
> It was requested by Arnd, It's not 'new' syscall basically, just an
> attempt to avoid run-time detection of things that may be detected an
> compile-time.

OK. I noticed that it touches core files and wondering whether it was
necessary but I'm fine with this approach.

-- 
Catalin
