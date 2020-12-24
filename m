Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 24 Dec 2020 06:03:25 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v5] s390/vfio-ap: clean up vfio_ap resources when KVM
 pointer invalidated
Message-ID: <20201224060325.2170d7e9.pasic@linux.ibm.com>
In-Reply-To: <20201223012013.5418-1-akrowiak@linux.ibm.com>
References: <20201223012013.5418-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, pbonzini@redhat.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com

On Tue, 22 Dec 2020 20:20:13 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

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
> 4. Sets the masks in the KVM guest's CRYCB to pass AP resources through to
>    the guest.
> 
> In order to avoid memory leaks, when the notifier is called to receive
> notification that the KVM pointer has been set to NULL, the vfio_ap device
> driver should reverse the actions taken when the KVM pointer was set.
> 
> Fixes: 258287c994de ("s390: vfio-ap: implement mediated device open callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

LGTM.

Christian, you wanted to pick this yourself directly, or? I think we are
good to go!
