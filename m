From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: virtio-s390: document GPR4/GPR2 cookie values
Date: Fri, 8 Mar 2013 08:55:48 +0100
Message-ID: <20130308085548.5bba025d@gondolin>
References: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
	<20130226110421.GB10915@redhat.com>
	<20130226111812.GA11111@redhat.com>
	<20130307180221.GA30580@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130307180221.GA30580@redhat.com>
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
Cc: Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 7 Mar 2013 20:02:21 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtio-s390 on kvm can use a cookie value passed to guest

s/virtio-s390/virtio-ccw/ (to avoid confusion with s390-virtio, which
was never specced)

> to optimize channel/VQ lookups.
> Document this.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Otherwise:
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Rusty, could you please apply?

> 
> ---
> diff --git a/virtio-spec.lyx b/virtio-spec.lyx
> index 72d956c..91aed06 100644
> --- a/virtio-spec.lyx
> +++ b/virtio-spec.lyx
> @@ -10627,7 +10626,252 @@ Guest->Host Notification
>  For notifying the host of virtqueue buffers, the guest unfortunately can't
>   use a channel command (the asynchronous characteristics of channel I/O
>   interact badly with the host block I/O backend).
> - Instead, it uses a diagnose 0x500 call with subcode 3 specifying the queue.
> + Instead, it uses a diagnose 0x500 call with subcode 3 specifying the queue
> +\change_inserted 1986246365 1362677938
> +, as follows:
> +\end_layout
> +
> +\begin_layout Standard
> +
> +\change_inserted 1986246365 1362677973
> +\begin_inset Tabular
> +<lyxtabular version="3" rows="5" columns="3">
> +<features tabularvalignment="middle">
> +<column alignment="center" valignment="top" width="0">
> +<column alignment="center" valignment="top" width="0">
> +<column alignment="center" valignment="top" width="0">
> +<row>
> +<cell alignment="center" valignment="top" topline="true" bottomline="true" leftline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362677978
> +GPR
> +\change_unchanged
> +
> +\end_layout
> +
> +\end_inset
> +</cell>
> +<cell alignment="center" valignment="top" topline="true" bottomline="true" leftline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362678629
> +Input Value
> +\change_unchanged
> +
> +\end_layout
> +
> +\end_inset
> +</cell>
> +<cell alignment="center" valignment="top" topline="true" bottomline="true" leftline="true" rightline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362678627
> +Output Value
> +\end_layout
> +
> +\end_inset
> +</cell>
> +</row>
> +<row>
> +<cell alignment="center" valignment="top" topline="true" leftline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362677991
> +1
> +\change_unchanged
> +
> +\end_layout
> +
> +\end_inset
> +</cell>
> +<cell alignment="center" valignment="top" topline="true" leftline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362678208
> +0x3
> +\change_unchanged
> +
> +\end_layout
> +
> +\end_inset
> +</cell>
> +<cell alignment="center" valignment="top" topline="true" leftline="true" rightline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362678620
> +
> +\end_layout
> +
> +\end_inset
> +</cell>
> +</row>
> +<row>
> +<cell alignment="center" valignment="top" topline="true" leftline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362678226
> +2
> +\change_unchanged
> +
> +\end_layout
> +
> +\end_inset
> +</cell>
> +<cell alignment="center" valignment="top" topline="true" leftline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362678498
> +Subchannel ID
> +\change_unchanged
> +
> +\end_layout
> +
> +\end_inset
> +</cell>
> +<cell alignment="center" valignment="top" topline="true" leftline="true" rightline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362678642
> +Host Cookie
> +\end_layout
> +
> +\end_inset
> +</cell>
> +</row>
> +<row>
> +<cell alignment="center" valignment="top" topline="true" leftline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362678500
> +3
> +\change_unchanged
> +
> +\end_layout
> +
> +\end_inset
> +</cell>
> +<cell alignment="center" valignment="top" topline="true" leftline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362678540
> +Virtqueue number
> +\change_unchanged
> +
> +\end_layout
> +
> +\end_inset
> +</cell>
> +<cell alignment="center" valignment="top" topline="true" leftline="true" rightline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362678620
> +
> +\end_layout
> +
> +\end_inset
> +</cell>
> +</row>
> +<row>
> +<cell alignment="center" valignment="top" topline="true" bottomline="true" leftline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362678529
> +4
> +\change_unchanged
> +
> +\end_layout
> +
> +\end_inset
> +</cell>
> +<cell alignment="center" valignment="top" topline="true" bottomline="true" leftline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362678644
> +Host Cookie
> +\change_unchanged
> +
> +\end_layout
> +
> +\end_inset
> +</cell>
> +<cell alignment="center" valignment="top" topline="true" bottomline="true" leftline="true" rightline="true" usebox="none">
> +\begin_inset Text
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362678620
> +
> +\end_layout
> +
> +\end_inset
> +</cell>
> +</row>
> +</lyxtabular>
> +
> +\end_inset
> +
> +
> +\change_deleted 1986246365 1362677938
> +.
> +\change_inserted 1986246365 1362678646
> +
> +\end_layout
> +
> +\begin_layout Standard
> +
> +\change_inserted 1986246365 1362679010
> +Host cookie is an optional per-virtqueue 64 bit value that can be used by
> + the hypervisor to speed up the notification execution.
> + For each notification, the output value is returned in GPR2 and should
> + be passed in GPR4 for the next notification:
> +\end_layout
> +
> +\begin_layout LyX-Code
> +
> +\change_inserted 1986246365 1362679011
> +\begin_inset listings
> +inline false
> +status open
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1986246365 1362679033
> +
> +info->cookie = do_notify(schid, virtqueue_get_queue_index(vq), info->cookie);
> +\end_layout
> +
> +\end_inset
> +
> +
>  \end_layout
> 
>  \begin_layout Subsubsection*
> 
