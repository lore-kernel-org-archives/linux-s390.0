From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/2] virtio/s390: fix some races in virtio-ccw
Date: Mon, 24 Sep 2018 13:52:58 +0200
Message-ID: <0aab1e39-ead5-4f16-5cc5-8ff2b514fb3a@de.ibm.com>
References: <20180921124621.43649-1-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180921124621.43649-1-pasic@linux.ibm.com>
Content-Language: en-US
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
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: Colin Ian King <colin.king@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

Can you consider adding stable tags to the (final version of the) fixes?

On 09/21/2018 02:46 PM, Halil Pasic wrote:
> The trigger for the series is this bug report:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1788432
> 
> Changelog:
> RFC -> v1:
> * do mutual exclusion on a per device basis in ccw_io_helper() 
> 
> Halil Pasic (2):
>   virtio/s390: avoid race on vcdev->config
>   virtio/s390: fix race in ccw_io_helper()
> 
>  drivers/s390/virtio/virtio_ccw.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
