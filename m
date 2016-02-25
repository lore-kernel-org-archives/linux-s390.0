Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 25 Feb 2016 09:52:27 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 4/5] all: s390: move compat_wrappers.c from
 arch/s390/kernel to kernel/
Message-ID: <20160225085227.GD3980@osiris>
References: <1456338854-14901-1-git-send-email-ynorov@caviumnetworks.com>
 <1456338854-14901-5-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456338854-14901-5-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160225085227.nsamepb6Yl6XvLsVRtltlvyh2pXR9iPWoSA4bcom5aw@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Prasun.Kapoor@caviumnetworks.com, pinskia@gmail.com, agraf@suse.de, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, Nathan_Lynch@mentor.com, klimov.linux@gmail.com, bamvor.zhangjian@huawei.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, Feb 24, 2016 at 09:34:13PM +0300, Yury Norov wrote:
> Some syscalls are declared conditionally, so corresponding wrappers
> are conditional accordingly.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  arch/s390/kernel/Makefile         |   2 +-
>  arch/s390/kernel/compat_wrapper.c | 129 -----------------------------
>  kernel/Makefile                   |   1 +
>  kernel/compat_wrapper.c           | 170 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 172 insertions(+), 130 deletions(-)
>  delete mode 100644 arch/s390/kernel/compat_wrapper.c
>  create mode 100644 kernel/compat_wrapper.c

Generated code looks identical on s390 and of course still works!
