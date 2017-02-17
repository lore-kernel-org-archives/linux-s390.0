From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC v2 03/12] s390x/css: add s390-map-css
 machine option
Date: Fri, 17 Feb 2017 10:08:15 +0800
Message-ID: <24276.2170536027$1505297607@news.gmane.org>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
	<20170112072513.98411-4-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <20170112072513.98411-4-bjsdjshi@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com, kvm@vger.kernel.org, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, alex.williamson@redhat.com, renxiaof@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, agraf@suse.com
List-ID: <linux-s390.vger.kernel.org>

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-01-12 08:25:04 +0100]:

> From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> 
> We want to support real (i.e. not virtual) channel devices
> even for guests that do not support MCSS-E (where guests may
> see devices from any channel subsystem image at once). As all
> virtio-ccw devices are in css 0xfe (and show up in the default
> css 0 for guests not activating MCSS-E), we need an option to
> map e.g. passed-through subchannels from their real css (0-3,
> or 0 for hosts not activating MCSS-E) into the default css.
> This will be exploited in a later patch.

After some brainstorming, we decided to change this interface a bit.

The first thing is that, we agreed that "s390-squash-mcss" is a better
name than "s390-map-css". The new name denotes that it is trying to
accommodate the devices from multiple channel subsystems into a
non-mcsse-e system, and the word "suqash" is more accurate about what
is happening internally.

The second thing is, we should never map/squash a vfio-ccw device into
css 0xfe, which is reserved for virtio device only. So when squashing,
we need to do it the other way around (i.e. have virtio devices at
0.x.xxxx instead of fe.x.xxxx to accommodate non-mcsse-e).

> 
> Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
[...]

-- 
Dong Jia
