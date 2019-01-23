From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [qemu-s390x] [PATCH v2 3/5] vfio-ccw: add
 capabilities chain
Date: Wed, 23 Jan 2019 16:57:17 +0100
Message-ID: <20190123165717.5e580021@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-4-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190121110354.2247-4-cohuck@redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 21 Jan 2019 12:03:52 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Allow to extend the regions used by vfio-ccw. The first user will be
> handling of halt and clear subchannel.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Looks OK to me, but I did not look to hard. I'm likely to invest more
when v3 comes along.

Regards,
Halil
