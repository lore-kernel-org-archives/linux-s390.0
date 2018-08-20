From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 13/22] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
Date: Mon, 20 Aug 2018 16:08:02 +0200
Message-ID: <20180820160802.1fe8f704.cohuck@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-14-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534196899-16987-14-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 13 Aug 2018 17:48:10 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Provides a sysfs interface to view the AP matrix configured for the
> mediated matrix device.
> 
> The relevant sysfs structures are:
> 
> /sys/devices/vfio_ap/matrix/
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ...............[$uuid]
> .................. matrix
> 
> To view the matrix configured for the mediated matrix device,
> print the matrix file:
> 
> 	cat matrix
> 
> Below are examples of the output from the above command:
> 
> Example 1: Adapters and domains assigned
> 	Assignments:
> 		Adapters 5 and 6
> 		Domains 4 and 71 (0x47)
> 
> 	Output
> 		05.0004
> 		05.0047
> 		06.0004
> 	06.0047
> 
> Examples 2: Only adapters assigned
> 	Assignments:
> 		Adapters 5 and 6
> 
> 	Output:
> 		05.
> 		06.
> 
> Examples 3: Only domains assigned
> 	Assignments:
> 		Domains 4 and 71 (0x47)
> 
> 	Output:
> 		.0004
> 		.0047

I find this output to be a bit confusing; but OTOH, I'm probably not
the person to parse it :) Still, some comments.

From previous discussions, ISTR that this is mainly supposed to be a
debugging/administration aid. Of course, this generates some questions:
- Should this be in sysfs (sysfs attributes are supposed to follow the
  "one value per file" rule, at least for the most part), or would
  debugfs be a better fit?
- Should userspace code be able to introspect the current
  configuration? If yes, it might be better to have some
  not-so-nice-but-easily-parsable output, possibly one attribute for
  the assigned adapters and one for the assigned domains, and a tool
  which distills that into a nice "matrix" with labeled rows and
  columns for human consumption.

That said, I don't really have major objections to that interface.

> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c |   52 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 52 insertions(+), 0 deletions(-)
