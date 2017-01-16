From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PULL 0/5] virtio/s390 patches for -next
Date: Mon, 16 Jan 2017 16:15:57 +0200
Message-ID: <20170116161544-mutt-send-email-mst@kernel.org>
References: <20170116140433.21301-1-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170116140433.21301-1-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 16, 2017 at 03:04:28PM +0100, Cornelia Huck wrote:
> Michael,
> 
> the following patches have all been posted in the past. I've
> collected them on top of your vhost branch -- please let me
> know whether this works for you.

Sure, thanks!

> The following changes since commit 6bdf1e0efb04a1716373646cb6f35b73addca492:
> 
>   Makefile: drop -D__CHECK_ENDIAN__ from cflags (2016-12-16 00:13:43 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/virtio-s390-20170116
> 
> for you to fetch changes up to 364cf19a474501cf157f1d09895ebab71e603c77:
> 
>   virtio/s390: virtio: constify virtio_config_ops structures (2017-01-16 12:26:07 +0100)
> 
> ----------------------------------------------------------------
> - ringtest fixes to make it work on s390
> - support new READ_STATUS command
> - minor cleanups
> 
> ----------------------------------------------------------------
> 
> Bhumika Goyal (1):
>   virtio/s390: virtio: constify virtio_config_ops structures
> 
> Colin Ian King (1):
>   virtio/s390: add missing \n to end of dev_err message
> 
> Halil Pasic (2):
>   tools/virtio/ringtest: fix run-on-all.sh for offline cpus
>   tools/virtio/ringtest: tweaks for s390
> 
> Pierre Morel (1):
>   virtio/s390: support READ_STATUS command for virtio-ccw
> 
>  drivers/s390/virtio/virtio_ccw.c    | 29 +++++++++++++++++++++++++++--
>  tools/virtio/ringtest/main.h        | 12 ++++++++++++
>  tools/virtio/ringtest/run-on-all.sh |  5 +++--
>  3 files changed, 42 insertions(+), 4 deletions(-)
> 
> -- 
> 2.11.0
