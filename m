From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2 02/15] virtio: unify config_changed handling
Date: Mon, 6 Oct 2014 17:16:14 +0200
Message-ID: <20141006171614.376ba255.cornelia.huck@de.ibm.com>
References: <1412608214-31944-1-git-send-email-mst@redhat.com>
	<1412608214-31944-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412608214-31944-3-git-send-email-mst@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sudeep Dutt <sudeep.dutt@intel.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Siva Yerramreddy <yshivakrishna@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 6 Oct 2014 18:10:44 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Replace duplicated code in all transports with a single wrapper in
> virtio.c.
> 
> The only functional change is in virtio_mmio.c: if a buggy device sends
> us an interrupt before driver is set, we previously returned IRQ_NONE,
> now we return IRQ_HANDLED.
> 
> As this must not happen in practice, this does not look like a big deal.
> 
> See also commit 3fff0179e33cd7d0a688dab65700c46ad089e934
> 	virtio-pci: do not oops on config change if driver not loaded.
> for the original motivation behind the driver check.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio.h             | 2 ++
>  drivers/misc/mic/card/mic_virtio.c | 6 +-----
>  drivers/s390/kvm/kvm_virtio.c      | 9 +--------
>  drivers/s390/kvm/virtio_ccw.c      | 6 +-----
>  drivers/virtio/virtio.c            | 9 +++++++++
>  drivers/virtio/virtio_mmio.c       | 7 ++-----
>  drivers/virtio/virtio_pci.c        | 6 +-----
>  7 files changed, 17 insertions(+), 28 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
