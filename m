From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] virtio-net: 64 bit features,
	event index
Date: Thu, 5 May 2011 00:20:01 +0300
Message-ID: <20110504212001.GA21421@redhat.com>
References: <cover.1304542880.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <cover.1304542880.git.mst@redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, habanero@linux.vnet.ibm.com, Rusty Russell <rusty@rustcorp.com.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 05, 2011 at 12:01:48AM +0300, Michael S. Tsirkin wrote:
> OK, here's a patch that implements the virtio spec update that I
> sent earlier. It supercedes the PUBLISH_USED_IDX patches
> I sent out earlier.


Sorry, forgot to mention this is on top of qemu-kvm d16e0f0 .

Copy is here:
git://git.kernel.org/pub/scm/linux/kernel/git/mst/qemu-kvm.git virtio-net-event-idx-v1

Relevant kernel bits are here:
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost-net-next-event-idx-v1

-- 
MST
