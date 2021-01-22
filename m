Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726247AbhAVI0y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 22 Jan 2021 03:26:54 -0500
Subject: Re: [PATCH v5] s390/vfio-ap: clean up vfio_ap resources when KVM
 pointer invalidated
References: <20201223012013.5418-1-akrowiak@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <0649ba1e-ecd3-890a-72b5-a8ff54417faf@de.ibm.com>
Date: Fri, 22 Jan 2021 09:26:06 +0100
MIME-Version: 1.0
In-Reply-To: <20201223012013.5418-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: stable@vger.kernel.org, cohuck@redhat.com, kwankhede@nvidia.com, pbonzini@redhat.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com, Halil Pasic <pasic@linux.ibm.com>

On 23.12.20 02:20, Tony Krowiak wrote:
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


Just to keep you up2date why this patch is still waiting in our queue. This triggered
a lockdep splat in the CI which we want to fix first.
