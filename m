Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730429AbgLLKtd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 12 Dec 2020 05:49:33 -0500
Date: Sat, 12 Dec 2020 09:20:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] s390/vfio-ap: reverse group notifier actions when
 KVM pointer invalidated
Message-ID: <X9R9XK38vP/fAfdu@kroah.com>
References: <20201211222211.20869-1-akrowiak@linux.ibm.com>
 <20201211222211.20869-3-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211222211.20869-3-akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org, sashal@kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, pbonzini@redhat.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com

On Fri, Dec 11, 2020 at 05:22:11PM -0500, Tony Krowiak wrote:
> The vfio_ap device driver registers a group notifier with VFIO when the
> file descriptor for a VFIO mediated device for a KVM guest is opened to
> receive notification that the KVM pointer is set (VFIO_GROUP_NOTIFY_SET_KVM
> event). When the KVM pointer is set, the vfio_ap driver takes the
> following actions:
> 1. Stashes the KVM pointer in the vfio_ap_mdev struct that holds the state
>    of the mediated device.
> 2. Calls the kvm_get_kvm() function to increment its reference counter.
> 3. Sets the function pointer to the function that handles interception of
>    the instruction that enables/disables interrupt processing.
> 
> When the notifier is called to make notification that the KVM pointer has
> been set to NULL, the driver should reverse the actions taken when the
> KVM pointer was set as well as unplugging the AP devices passed through
> to the KVM guest.
> 
> Fixes: 258287c994de ("s390: vfio-ap: implement mediated device open callback")
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 40 ++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 16 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
