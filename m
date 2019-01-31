From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 1/6] vfio-ccw: make it safe to access
 channel programs
Date: Thu, 31 Jan 2019 12:52:20 +0100
Message-ID: <20190131125220.285a4bc8.cohuck@redhat.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-2-cohuck@redhat.com>
	<20190130195127.5ff3c849@oc2783563651>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190130195127.5ff3c849@oc2783563651>
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
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 30 Jan 2019 19:51:27 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 30 Jan 2019 14:22:07 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > When we get a solicited interrupt, the start function may have
> > been cleared by a csch, but we still have a channel program
> > structure allocated. Make it safe to call the cp accessors in
> > any case, so we can call them unconditionally.  
> 
> I read this like it is supposed to be safe regardless of
> parallelism and threads. However I don't see any explicit
> synchronization done for cp->initialized.
> 
> I've managed to figure out how is that supposed to be safe
> for the cp_free() (which is probably our main concern) in
> vfio_ccw_sch_io_todo(), but if fail when it comes to the one
> in vfio_ccw_mdev_notifier().
> 
> Can you explain us how does the synchronization work?

You read that wrong, I don't add synchronization, I just add a check.
