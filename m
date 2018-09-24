From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 08/26] s390: vfio-ap: sysfs interfaces to configure
 control domains
Date: Mon, 24 Sep 2018 12:57:56 +0200
Message-ID: <20180924125756.1ea6c31a.cohuck@redhat.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1536781396-13601-9-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536781396-13601-9-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 12 Sep 2018 15:42:58 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Provides the sysfs interfaces for:
> 
> 1. Assigning AP control domains to the mediated matrix device
> 
> 2. Unassigning AP control domains from a mediated matrix device
> 
> 3. Displaying the control domains assigned to a mediated matrix
>    device
> 
> The IDs of the AP control domains assigned to the mediated matrix
> device are stored in an AP domain mask (ADM). The bits in the ADM,
> from most significant to least significant bit, correspond to
> AP domain numbers 0 to 255. On some systems, the maximum allowable
> domain number may be less than 255 - depending upon the host's
> AP configuration - and assignment may be rejected if the input
> domain ID exceeds the limit.
> 
> When a control domain is assigned, the bit corresponding its domain
> ID will be set in the ADM. Likewise, when a domain is unassigned,
> the bit corresponding to its domain ID will be cleared in the ADM.
> 
> The relevant sysfs structures are:
> 
> /sys/devices/vfio_ap/matrix/
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ...............[$uuid]
> .................. assign_control_domain
> .................. unassign_control_domain
> 
> To assign a control domain to the $uuid mediated matrix device's
> ADM, write its domain number to the assign_control_domain file.
> To unassign a domain, write its domain number to the
> unassign_control_domain file. The domain number is specified
> using conventional semantics: If it begins with 0x the number
> will be parsed as a hexadecimal (case insensitive) number;
> if it begins with 0, it is parsed as an octal number;
> otherwise, it will be parsed as a decimal number.
> 
> For example, to assign control domain 173 (0xad) to the mediated
> matrix device $uuid:
> 
> 	echo 173 > assign_control_domain
> 
> 	or
> 
> 	echo 0255 > assign_control_domain
> 
> 	or
> 
> 	echo 0xad > assign_control_domain
> 
> To unassign control domain 173 (0xad):
> 
> 	echo 173 > unassign_control_domain
> 
> 	or
> 
> 	echo 0255 > unassign_control_domain
> 
> 	or
> 
> 	echo 0xad > unassign_control_domain
> 
> The assignment will be rejected if the APQI exceeds the maximum
> value for an AP domain:
>   * If the AP Extended Addressing (APXA) facility is installed,
>     the max value is 255
>   * Else the max value is 15
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c |  112 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 112 insertions(+), 0 deletions(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
