From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 01 Nov 2018 10:00:58 +0000
Subject: Re: [PATCH] s390/mm: Fix ERROR: "__node_distance" undefined!
Message-Id: <20181101100058.GA5757@osiris>
In-Reply-To: <20181031180203.27256-1-jforbes@fedoraproject.org>
References: <20181031180203.27256-1-jforbes@fedoraproject.org>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 31, 2018 at 01:02:03PM -0500, Justin M. Forbes wrote:
> Fixes:
> ERROR: "__node_distance" [drivers/nvme/host/nvme-core.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
> make: *** [Makefile:1275: modules] Error 2
> + exit 1
> 
> Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> ---
>  arch/s390/numa/numa.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.
