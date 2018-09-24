From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/2] virtio/s390: avoid race on vcdev->config
Date: Mon, 24 Sep 2018 14:55:54 +0200
Message-ID: <20180924145554.712f4cf4.cohuck@redhat.com>
References: <20180921124621.43649-1-pasic@linux.ibm.com>
	<20180921124621.43649-2-pasic@linux.ibm.com>
	<20180921151433.519b6687.cohuck@redhat.com>
	<d05aa6cb-d344-37dd-f1eb-55c28fcb9c62@linux.ibm.com>
	<80a80dc6-ccb1-f245-b367-c2f9345ca151@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <80a80dc6-ccb1-f245-b367-c2f9345ca151@linux.ibm.com>
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
To: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 21 Sep 2018 17:47:47 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 09/21/2018 09:28 AM, Halil Pasic wrote:

> > Anyway I'm fine with swapping the old out and your new version in,
> > if you prefer it that way.
> > 
> > If you do, would you like to have a respin?

Just send me a respin with something that you find useful :) (maybe a
mashup of our descriptions) (while at it, you could also add the
cc:stable, which I agree make sense)

> > 
> > Regards,
> > Halil
> >   
> 
> I had been looking into this code recently, and shouldn't vcdev->status 
> (function get/set_status functions) also have a lock around it? Or is it 
> not possible to have a race condition on vcdev->status?

I don't think so, as status is only a byte.

> 
> Thanks
> Farhan
> 
> 
> >>>
> >>> Let us protect the shared state using vcdev->lock.
> >>>
> >>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >>> ---
> >>>   drivers/s390/virtio/virtio_ccw.c | 10 ++++++++--
> >>>   1 file changed, 8 insertions(+), 2 deletions(-)  
> >>  
> > 
> >   
> 
