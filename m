From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 07/26] s390: vfio-ap: sysfs interfaces to configure
 domains
Date: Mon, 24 Sep 2018 12:45:30 +0200
Message-ID: <20180924124530.0efe5f37.cohuck@redhat.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1536781396-13601-8-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536781396-13601-8-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 12 Sep 2018 15:42:57 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces two new sysfs attributes for the VFIO mediated
> matrix device for assigning AP domains to and unassigning
> AP domains from a mediated matrix device. The IDs of the
> AP domains assigned to the mediated matrix device will be
> stored in an AP queue mask (AQM).
> 
> The bits in the AQM, from most significant to least
> significant bit, correspond to AP queue index (APQI) 0 to
> 255 (note that an APQI is synonymous with with a domain ID).
> On some systems, the maximum allowable domain number may be
> less than 255 - depending upon the host's AP configuration -
> and assignment may be rejected if the input domain ID exceeds
> the limit.
> 
> When a domain is assigned, the bit corresponding to the APQI
> will be set in the AQM. Likewise, when a domain is unassigned,
> the bit corresponding to the APQI will be cleared from the AQM.
> 
> In order to successfully assign a domain, the APQNs derived from
> the domain ID being assigned and the adapter numbers of all
> adapters previously assigned:
> 
> 1. Must be bound to the vfio_ap device driver.
> 
> 2. Must not be assigned to any other mediated matrix device.
> 
> If there are no adapters assigned to the mdev, then there must
> be an AP queue bound to the vfio_ap device driver with an
> APQN containing the domain ID (i.e., APQI), otherwise all
> adapters subsequently assigned will fail because there will be no
> AP queues bound with an APQN containing the APQI.
> 
> Assigning or un-assigning an AP domain will also be rejected if
> a guest using the mediated matrix device is running.
> 
> The relevant sysfs structures are:
> 
> /sys/devices/vfio_ap/matrix/
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ...............[$uuid]
> .................. assign_domain
> .................. unassign_domain
> 
> To assign a domain to the $uuid mediated matrix device,
> write the domain's ID to the assign_domain file. To
> unassign a domain, write the domain's ID to the
> unassign_domain file. The ID is specified using
> conventional semantics: If it begins with 0x, the number
> will be parsed as a hexadecimal (case insensitive) number;
> if it begins with 0, it will be parsed as an octal number;
> otherwise, it will be parsed as a decimal number.
> 
> For example, to assign domain 173 (0xad) to the mediated matrix
> device $uuid:
> 
> 	echo 173 > assign_domain
> 
> 	or
> 
> 	echo 0255 > assign_domain
> 
> 	or
> 
> 	echo 0xad > assign_domain
> 
> To unassign domain 173 (0xad):
> 
> 	echo 173 > unassign_domain
> 
> 	or
> 
> 	echo 0255 > unassign_domain
> 
> 	or
> 
> 	echo 0xad > unassign_domain
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c |  138 ++++++++++++++++++++++++++++++++++++-
>  1 files changed, 137 insertions(+), 1 deletions(-)

Might have been good to add some documentation for the new attributes
in the sysfs API directory, but as that one seems to be rather
hit-and-miss anyway (and you provide a documentation file for the whole
thing),

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
