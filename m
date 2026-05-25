Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DC8405E7;
	Mon, 25 May 2026 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724115; cv=none; b=UhGYoo19gOYLsLpN2HNiHBRy98dWg5iY5VXl7JnFxEsTYN/oRpCakZPTc16XyME6puhY+CQZvjz7wySMo4uSZiWu2hnpVWoOGJVu5Qrjiv/zuSVrjCluOf/UJSuB3FoMqMPZcoT8OxXuZLzAFRQzjGFav+j/hKHi1vQLZEIoa7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724115; c=relaxed/simple;
	bh=f882XrKvM09N7CRjBJtApWaYaJjhkjDUely+o87lB90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxmPBLiI8iFElQNIc2SAOcgli9mh3yx+ItdN5ElXaFULBAy4fVN1g7rkiW/hGNCjSGKoSVDsYAkMpXsLm52dwN45plrbmXE8rLyqSTLv+/q6qNGrxgvrj7+gEc/VTHtbGk9vTL3gS9h5ggLYtGTpyN5WYmcoxTRS5CJNr8LB7Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKmWQezL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKmWQezL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D031F00A3D;
	Mon, 25 May 2026 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779724114;
	bh=oebx5jVTWzlAdeowK/9f21mNYv0EhBbhUPOCHZE9q/c=;
	h=From:To:Cc:Subject:Date;
	b=UKmWQezLhzUGzskNztQQ5ffqnihBCJkW05NPbv557X+gk7bAG4zxFmwZ48ebjKlLb
	 g5OYAAJIjG2W25ABEPdfFxjTJ1BNvcrvrrWrMsv14K8JdZXGmJO9ELveXPLt88OTgK
	 tnNCiRj+D21kPiKV8FSnK62qzHM09RzMTKgmi0wf+Tj2D028Znxt31QPvV+pC0CJDE
	 XFAtBqEg1uiJzZa2xuAwn75EELsO+eYFvjhwsBZC1YR/Xwd/x5f2xmNypEbCGZEotR
	 J3TRlG+Qy7AQ/0C3737tYG1s+I5MEvl4F1ZZfhvFuzbF8tFkKfEDqD3ssNLyVlyyRc
	 xBUFIlz3KnzMg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH v5 0/5] Add iommufd ioctls to support TSM operations
Date: Mon, 25 May 2026 21:18:11 +0530
Message-ID: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds iommufd ioctl support for TSM-related operations.
These ioctls allow VMMs to perform TSM management tasks such as bind and
unbind operations, and to handle guest requests.

Changes from v4:
https://lore.kernel.org/all/20260427061005.901854-1-aneesh.kumar@kernel.org
* Switch VFIO/iommufd to use struct file *kvm_file instead of relying on
  kvm->users_count references.
* Define TSM request scope values globally in iommufd.
* Rename the ioctl to IOMMU_VDEVICE_TSM_REQ.
* Address other review feedback.

Changes from v2:
https://lore.kernel.org/all/20260309111704.2330479-1-aneesh.kumar@kernel.org
* Bump the series revision to v4 to keep it in sync with the dependent CCA DA
  patchsets. There was no v3 posting.
* Drop [PATCH v2 1/3] iommufd/viommu: Allow associating a KVM VM fd with a
  vIOMMU
* Add two new patches to associate a struct kvm * with iommufd objects:
  iommufd/device: Associate a kvm pointer to iommufd_device
  iommufd/viommu: Associate a kvm pointer to iommufd_viommu
* Address review feedback

Changes from v1:
https://lore.kernel.org/all/20250728135216.48084-8-aneesh.kumar@kernel.org
* Rebase onto the latest kernel
* Address review feedback
* Drop the TSM map ioctl; the KVM prefault patch will be used instead to
  ensure that private memory is preallocated

Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Herne <jjherne@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Holger Dengler <dengler@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org

Aneesh Kumar K.V (Arm) (3):
  vfio: cache KVM VM file references instead of raw struct kvm pointers
  iommufd/tsm: add vdevice TSM bind/unbind ioctl
  iommufd/vdevice: add TSM request ioctl

Nicolin Chen (1):
  iommufd/viommu: Keep a reference to the KVM file

Shameer Kolothum (1):
  iommufd/device: Associate KVM file pointer with iommufd_device

 drivers/iommu/iommufd/Makefile          |   2 +
 drivers/iommu/iommufd/device.c          |   7 +-
 drivers/iommu/iommufd/iommufd_private.h |  16 +++
 drivers/iommu/iommufd/main.c            |   6 ++
 drivers/iommu/iommufd/selftest.c        |   2 +-
 drivers/iommu/iommufd/tsm.c             | 130 ++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c          |   9 ++
 drivers/s390/crypto/vfio_ap_ops.c       |   5 +-
 drivers/vfio/device_cdev.c              |  10 +-
 drivers/vfio/group.c                    |  14 ++-
 drivers/vfio/iommufd.c                  |   3 +-
 drivers/vfio/pci/vfio_pci_zdev.c        |   7 +-
 drivers/vfio/vfio.h                     |  16 ++-
 drivers/vfio/vfio_main.c                |  81 ++++++++-------
 drivers/virt/coco/tsm-core.c            |  58 +++++++++++
 include/linux/iommufd.h                 |   5 +-
 include/linux/kvm_host.h                |   3 +
 include/linux/pci-tsm.h                 |   9 +-
 include/linux/tsm.h                     |  42 ++++++++
 include/linux/vfio.h                    |  17 +++-
 include/uapi/linux/iommufd.h            | 106 +++++++++++++++++++
 virt/kvm/kvm_main.c                     |   2 +
 22 files changed, 478 insertions(+), 72 deletions(-)
 create mode 100644 drivers/iommu/iommufd/tsm.c


base-commit: 50897c955902c93ae71c38698abb910525ebdc89
-- 
2.43.0

