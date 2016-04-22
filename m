From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 19/25] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
Date: Fri, 22 Apr 2016 18:10:09 +0100
Message-ID: <20160422171009.GR2998@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-20-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459894127-17698-20-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, broonie@kernel.org, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, agraf@suse.de, klimov.linux@gmail.com, bamvor.zhangjian@huawei.com, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 06, 2016 at 01:08:41AM +0300, Yury Norov wrote:
> Here new aarch32 ptrace syscall handler is introsuced to avoid run-time
> detection of the task type.

The reason for this patch isn't clear to me. What's wrong with the
run-time detection? It's not some performance critical code.

-- 
Catalin
