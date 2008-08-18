Date: Mon, 18 Aug 2008 11:21:05 -0400
From: Christof Schmitt <christof.schmitt@de.ibm.com>
Subject: Re: [PATCH] Remove duplicated unlikely() in IS_ERR()
Message-ID: <20080818152105.GA8883@schmichrtp.de.ibm.com>
References: <48A52D69.1040501@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48A52D69.1040501@miraclelinux.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linux-mtd/>
To: Hirofumi Nakagawa <hnakagawa@miraclelinux.com>
Cc: yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 15, 2008 at 04:16:57PM +0900, Hirofumi Nakagawa wrote:
> Hi
> Some drivers have duplicated unlikely() macros.
> IS_ERR() already has unlikely() in itself.
> This patch cleans up such pointless codes although there is no real
> effect on the kernel's behaviour.
> 
> Thanks,
> Hirofumi Nakagawa
> 
> Signed-off-by: Hirofumi Nakagawa <hnakagawa@miraclelinux.com>
> ---
>  drivers/s390/scsi/zfcp_fsf.c |   32 ++++++++++++++++----------------
>  fs/ubifs/find.c              |    4 ++--
>  fs/ubifs/gc.c                |    8 ++++----
>  fs/ubifs/tnc.c               |    4 ++--
>  fs/ubifs/xattr.c             |    2 +-
>  net/ipv6/af_inet6.c          |    2 +-
>  6 files changed, 26 insertions(+), 26 deletions(-)

Thanks for spotting and fixing this. Could you split the zfcp changes
in a seperate patch? I will pick up the zfcp patch for a series of
fixes that i have pending here.

Christof
