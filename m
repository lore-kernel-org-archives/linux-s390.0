From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
Date: Tue, 3 Jul 2018 01:10:34 +0200
Message-ID: <753c5e17-c241-580d-6e3a-a3c3159d44a8@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 06/29/2018 11:11 PM, Tony Krowiak wrote:
> This patch provides documentation describing the AP architecture and
> design concepts behind the virtualization of AP devices. It also
> includes an example of how to configure AP devices for exclusive
> use of KVM guests.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

I don't like the design of external interfaces except for:
* cpu model features, and
* reset handling.

In particular:

1) The architecture is such that authorizing access (via APM, AQM and ADM)
to an AP queue that is currently not configured (e.g. the card not physically
plugged, or just configured off). That seems to be a perfectly normal use
case.

Your assign operations however enforce that the resource is bound to your
driver, and thus the existence of the resource in the host.

It is clear: we need to avoid passing trough resources to guests that are not
dedicated for this purpose (e.g. a queue utilized by zcrypt). But IMHO
we need a different mechanism.

2) I see no benefit in deferring the exclusivity check to vfio_ap_mdev_open().
The downside is however pretty obvious: management software is notified about
a 'bad configuration' only at an attempted guest start-up. And your current QEMU
patches are not very helpful in conveying this piece of information.

I've talked with Boris, and AFAIR he said this is not acceptable to him (@Boris
can you confirm).

3) We indicate the reason for failure due to a configuration problem (exclusivity
or resource allocation) via pr_err() that is  via kernel messages. I don't think
this is very tooling/management software friendly, and I hope we don't expect admins
to work with the sysfs interface long term. I mean the effects of the admin actions
are not very persistent. Thus if the interface is a painful one, we are talking
about potentially frequent pain.

4) If I were to act out the role of the administrator, I would prefer to think of
specifying or changing the access controls of a guest in respect to AP (that is
setting the AP matrix) as a single atomic operation -- which either succeeds or fails.

The operation should succeed for any valid configuration, and fail for any invalid
on.

The current piecemeal approach seems even less fitting if we consider changing the
access controls of a running guest. AFAIK changing access controls for a running
guest is possible, and I don't see a reason why should we artificially prohibit this.

I think the current sysfs interface for manipulating the matrix is good for
manual playing around, but I would prefer having an interface that is better
suited for programs (e.g. ioctl).

Regards,
Halil
