From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PULL 0/2] virtio-ccw fixes
Date: Thu, 29 Nov 2018 15:56:48 +0100
Message-ID: <20181129155648.440743bb.cohuck@redhat.com>
References: <20180926164830.8435-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180926164830.8435-1-cohuck@redhat.com>
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
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 26 Sep 2018 18:48:28 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit 8c0f9f5b309d627182d5da72a69246f58bde1026:
> 
>   Revert "uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name" (2018-09-25 13:28:58 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/virtio-ccw-20180926
> 
> for you to fetch changes up to 1fd7ccf82385b3b14e4b3f009a82ada17ddc1e6f:
> 
>   virtio/s390: fix race in ccw_io_helper() (2018-09-25 15:29:10 +0200)
> 
> ----------------------------------------------------------------
> Two patches fixing races in the virtio-ccw driver.
> 
> ----------------------------------------------------------------
> 
> Halil Pasic (2):
>   virtio/s390: avoid race on vcdev->config
>   virtio/s390: fix race in ccw_io_helper()
> 
>  drivers/s390/virtio/virtio_ccw.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 

Ping. I don't see these patches in master :(
