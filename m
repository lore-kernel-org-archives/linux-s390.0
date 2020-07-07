Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgGGIpF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jul 2020 04:45:05 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v4 0/2] s390: virtio: let arch validate VIRTIO features
Date: Tue,  7 Jul 2020 10:44:35 +0200
Message-Id: <1594111477-15401-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

Hi all,

I changed the patch subject to reflect the content, becoming more
general.

1) I removed the ack from Christian and Jason even far as
   I understand they gave it for the functionality more than for the
   implementation.
   @Jason, @Christian, please can I get back your acked-by with these changes?

2) previous patch had another name:
   [PATCH v3 0/1] s390: virtio: let arch choose to accept devices without IOMMU feature
   id: Message-Id: <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>

3) The new version generalize the validation of the features by the
   architecture, making it not IOMMU_PLATFORM specific anymore inside
   virtio.c

   The architecture specific code for s390 is now testing the virtio
   features.

4) Since I reworked the patch I also moved the arch specific code
   from arch/s390/mm/init.c to arch/s390/kernel/to uv.c

5) Finaly, I splitted the patch into generic virtio and arch
   specific code.

Regards,
Pierre

Pierre Morel (2):
  virtio: let arch validate VIRTIO features
  s390: virtio: PV needs VIRTIO I/O device protection

 arch/s390/kernel/uv.c         | 25 +++++++++++++++++++++++++
 drivers/virtio/virtio.c       | 19 +++++++++++++++++++
 include/linux/virtio_config.h |  1 +
 3 files changed, 45 insertions(+)

-- 
2.25.1

Changelog

to v4:

- separate virtio and arch code
  (Pierre)

- moved code from arch/s390/mm/init.c to arch/s390/kernel/uv.c
  (Heiko)

- moved validation inside the arch code
  (Connie)

- moved the call to arch validation before VIRTIO_F_1 test
  (Michael)

to v3:

- add warning
  (Connie, Christian)

- add comment
  (Connie)

- change hook name
  (Halil, Connie)

to v2:

- put the test in virtio_finalize_features()
  (Connie)

- put the test inside VIRTIO core
  (Jason)

- pass a virtio device as parameter
  (Halil)
