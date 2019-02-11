From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/6] vfio-ccw: support hsch/csch (kernel
 part)
Date: Mon, 11 Feb 2019 17:13:54 +0100
Message-ID: <20190211171354.40be0856.cohuck@redhat.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190206150016.6fdfaf8f.cohuck@redhat.com>
	<1981d9bc-e950-62ef-d2d2-66a17771c8f4@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <1981d9bc-e950-62ef-d2d2-66a17771c8f4@linux.ibm.com>
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

On Fri, 8 Feb 2019 16:19:58 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 02/06/2019 09:00 AM, Cornelia Huck wrote:
> > On Wed, 30 Jan 2019 14:22:06 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> >> [This is the Linux kernel part, git tree is available at
> >> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-eagain-caps-v3  
> > 
> > I've pushed out the changes I've made so far (patch 1) to
> > vfio-ccw-eagain-caps-v3.5. I'll wait a bit for more comments before
> > sending a new version.
> >   
> 
> Thanks for that branch...  For patch 1 in v3.5:
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>

Thanks!

> 
> >>
> >> The companion QEMU patches are available at
> >> https://github.com/cohuck/qemu vfio-ccw-caps
> >> This is the previously posted v2 version, which should continue to work.]  
> > 
> > I would not mind if somebody looked at those as well :)  
> 
> Not precluding anyone else from doing so :) ... I'd planned on looking 
> at them as I get into the meat of patches 4-6 on the kernel side, where 
> the overlap occurs.  I'm getting close.  :)

Cool :) I'll wait a bit more before resending, then. (I'll probably
rebase the QEMU side as well when I do resend.)

> 
> FWIW, I've been running with both series for the last week or two, along 
> with some host kernel traces to prove things got executed the way I 
> thought, and it's seemed to be working well.  So that makes me 
> optimistic for the later patches.

That's good news, thanks for testing. Do you have a special test load
that you run in the guest that you can share?
