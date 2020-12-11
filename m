Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387557AbgLKWXX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Dec 2020 17:23:23 -0500
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 0/2] Clean up vfio_ap resources when KVM pointer invalidated
Date: Fri, 11 Dec 2020 17:22:09 -0500
Message-Id: <20201211222211.20869-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, pbonzini@redhat.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

The vfio_ap device driver registers a group notifier with VFIO when the
file descriptor for a VFIO mediated device attached to a KVM guest is
opened. The group notifier is registered to receive notification that the
KVM pointer for the guest is set (VFIO_GROUP_NOTIFY_SET_KVM event). When
the KVM pointer is set to a non-NULL value, the vfio_ap driver takes the
following actions:
1. Stashes the KVM pointer in the vfio_ap_mdev struct that holds the state
   of the mediated device.
2. Calls the kvm_get_kvm() function to increment its reference counter.
3. Sets the function pointer to the function that handles interception of
   the instruction that enables/disables interrupt processing for the
   KVM guest.
4. Plugs the AP devices assigned to the mediated device into the KVM
   guest.

These actions are reversed by the release callback which is invoked when
userspace closes the mediated device's file descriptor. In this case, the
group notifier does not get called to invalidate the KVM pointer because
the notifier is unregistered by the release callback; however, there are no
guarantees that userspace will do the right thing before shutting down.
To ensure that there are no resource leaks should the group notifier get
called to set the KVM pointer to NULL, the notifier should also reverse
the actions taken when it was called to set the pointer. This patch series
ensures proper clean up is done via the group notifier.

Tony Krowiak (2):
  s390/vfio-ap: No need to disable IRQ after queue reset
  s390/vfio-ap: reverse group notifier actions when KVM pointer
    invalidated

 drivers/s390/crypto/vfio_ap_drv.c     |  1 -
 drivers/s390/crypto/vfio_ap_ops.c     | 80 +++++++++++++++++----------
 drivers/s390/crypto/vfio_ap_private.h |  1 -
 3 files changed, 50 insertions(+), 32 deletions(-)

-- 
2.21.1
