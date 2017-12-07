From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] virtio/s390: implement PM operations for virtio_ccw
Date: Thu, 7 Dec 2017 15:32:42 +0100
Message-ID: <20171207153242.0490a77f.cohuck@redhat.com>
References: <20171207141102.70190-1-borntraeger@de.ibm.com>
	<20171207141102.70190-2-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171207141102.70190-2-borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Thu,  7 Dec 2017 15:11:02 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Suspend/Resume to/from disk currently fails. Let us wire
> up the necessary callbacks. This is mostly just forwarding
> the requests to the virtio drivers. The only thing that
> has to be done in virtio_ccw itself is to re-set the
> virtio revision.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Less work than I had expected :)

This looks complete: The only thing we do in our online function not
directly triggered by registering the virtio device is setting the
revision.

Will apply, but would not mind some R-bs/acks.
