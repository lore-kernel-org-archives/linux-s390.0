Return-Path: <heiko.carstens@de.ibm.com>
Date: Fri, 20 Sep 2013 16:39:32 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] Fixed typo on word accounting in kprobes.c in mutliple
 architectures
Message-ID: <20130920143932.GA4017@osiris>
References: <20130918210351.GA13811@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130918210351.GA13811@gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Anoop Thomas Mathew <atm@profoundis.com>
Cc: linux-s390@vger.kernel.org, tony.luck@intel.com, linux-ia64@vger.kernel.org, vgupta@synopsys.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Jiri Kosina <trivial@kernel.org>, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-ID: <linux-s390.vger.kernel.org>

On Thu, Sep 19, 2013 at 02:33:58AM +0530, Anoop Thomas Mathew wrote:
> Signed-off-by: Anoop Thomas Mathew <atm@profoundis.com>
> ---
>  arch/arc/kernel/kprobes.c     |    2 +-
>  arch/ia64/kernel/kprobes.c    |    2 +-
>  arch/powerpc/kernel/kprobes.c |    2 +-
>  arch/s390/kernel/kprobes.c    |    2 +-
>  arch/sparc/kernel/kprobes.c   |    2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Please send trivial typo fixes to Jiri Kosina <trivial@kernel.org>.
See "TRIVIAL PATCHES" in MAINTAINERS. Thanks!
