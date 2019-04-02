From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/2] vfio-ccw: support hsch/csch (QEMU
 part)
Date: Tue, 2 Apr 2019 15:44:37 +0200
Message-ID: <20190402154437.6cb10f0d.cohuck@redhat.com>
References: <20190301093949.27955-1-cohuck@redhat.com>
	<7c196819-c0b1-9c8d-b43d-786189c82cac@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <7c196819-c0b1-9c8d-b43d-786189c82cac@linux.ibm.com>
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
To: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 21 Mar 2019 21:49:54 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 3/1/19 4:39 AM, Cornelia Huck wrote:
> > 
> > [I'm not quite happy with how this async processing hooks up in css.c;
> > ideas welcome.]  
> 
> I guess I'm not unhappy with it, but it does look a little odd.  Not 
> sure I have a better idea right now...  Will ponder that for a while.

If we don't come up with something better right now, we can still change
this later, I think.
