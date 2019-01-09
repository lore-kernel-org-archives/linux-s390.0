From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio-ccw: wire up ->bus_name callback
Date: Wed, 9 Jan 2019 19:39:42 +0100
Message-ID: <20190109193942.10a875de.cohuck@redhat.com>
References: <20190103141145.14554-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190103141145.14554-1-cohuck@redhat.com>
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
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Thu,  3 Jan 2019 15:11:45 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Return the bus id of the ccw proxy device. This makes 'ethtool -i'
> show a more useful value than 'virtio' in the bus-info field.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Queued.
